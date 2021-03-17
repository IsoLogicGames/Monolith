--- Tests for the @{ArrayStack} interface.

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local ArrayStack = require(module:WaitForChild("ArrayStack"))

	describe("Constructor", function()
		it("should create an empty ArrayStack", function()
			local stack = ArrayStack.new()
			expect(stack:Empty()).to.equal(true)
		end)

		it("should create an ArrayStack from a table", function()
			local items = { 1, 2, 3, 4, 5 }
			local stack = ArrayStack.new(items)
			expect(stack:Count()).to.equal(#items)
			while stack:Count() > 0 do
				expect(stack:Pop()).to.equal(table.remove(items))
			end
		end)

		it("should create an ArrayStack from a Collection", function()
			local items = ArrayStack.new({ 1, 2, 3, 4, 5 })
			local stack = ArrayStack.new(items)
			expect(stack:Count()).to.equal(items:Count())
			while stack:Count() > 0 do
				local item = stack:Pop()
				local original = items:Pop()
				expect(item).to.equal(original)
			end
		end)

		it("should error when attempting to create a stack from a non-table", function()
			expect(function()
				ArrayStack.new(true)
			end).to.throw("Cannot construct ArrayStack from type boolean.")
			expect(function()
				ArrayStack.new(1)
			end).to.throw("Cannot construct ArrayStack from type number.")
			expect(function()
				ArrayStack.new("string")
			end).to.throw("Cannot construct ArrayStack from type string.")
			expect(function()
				ArrayStack.new(function()
				end)
			end).to.throw("Cannot construct ArrayStack from type function.")
			expect(function()
				ArrayStack.new(Instance.new("Folder"))
			end).to.throw("Cannot construct ArrayStack from type userdata.")
			expect(function()
				ArrayStack.new(coroutine.create(function()
				end))
			end).to.throw("Cannot construct ArrayStack from type thread.")
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should provide an iterator generator", function()
				local stack = ArrayStack.new()
				local generator = stack:Enumerator()
				expect(generator).to.be.a("function")
			end)

			it("should enumerate in a generic for loop", function()
				local stack = ArrayStack.new()
				local total = 10
				for i = 1, total do
					stack:Add(i)
				end

				local count = 0
				for i, v in stack:Enumerator() do
					count = count + 1
					expect(i).to.be.a("number")
					expect(v).to.be.a("number")
				end

				expect(count).to.equal(total)
			end)
		end)
	end)

	describe("Collection Interface", function()
		describe("Required Methods", function()
			describe("Contains", function()
				it("should not find an element when empty", function()
					local stack = ArrayStack.new()
					expect(stack:Contains(0)).to.equal(false)
				end)

				it("should find an element when the element exists", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Contains(1)).to.equal(true)
				end)

				it("should not find an element when the element does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Contains(0)).to.equal(false)
					stack:Add(0)
					expect(stack:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Contains(1)).to.equal(true)
					stack:Remove(1)
					expect(stack:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local stack = ArrayStack.new()
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all 0 elements when the provided collection is empty", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new()
					expect(stack:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when the elements exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAll(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 3 })
					expect(stack:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find a single element when it does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 4, 5 })
					local contained = ArrayStack.new({ 3 })
					expect(stack:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local stack = ArrayStack.new()
					local contained = ArrayStack.new({ 1, 2 })
					expect(stack:ContainsAll(contained)).to.equal(false)
					stack:Add(1)
					expect(stack:ContainsAll(contained)).to.equal(false)
					stack:Add(2)
					expect(stack:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAll(contained)).to.equal(true)
					stack:Remove(1)
					expect(stack:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local stack = ArrayStack.new()
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find anything when the provided collection is empty", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new()
					expect(stack:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAny(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 3 })
					expect(stack:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find some elements when one does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find a single element when it does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 4, 5 })
					local contained = ArrayStack.new({ 3 })
					expect(stack:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local stack = ArrayStack.new()
					local contained = ArrayStack.new({ 1, 2 })
					expect(stack:ContainsAny(contained)).to.equal(false)
					stack:Add(1)
					expect(stack:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local contained = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:ContainsAny(contained)).to.equal(true)
					stack:Remove(1)
					expect(stack:ContainsAny(contained)).to.equal(true)
					stack:Clear()
					expect(stack:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local stack = ArrayStack.new()
					expect(stack:Count()).to.equal(0)
				end)

				it("should count the number of elements in the stack", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Count()).to.equal(5)
				end)

				it("should count new elements as they are added", function()
					local stack = ArrayStack.new()
					local total = 10
					expect(stack:Count()).to.equal(0)
					for i = 1, total do
						stack:Add(i)
						expect(stack:Count()).to.equal(i)
					end
					expect(stack:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local count = stack:Count()
					expect(count).to.equal(5)
					while count > 0 do
						stack:Pop()
						local oldCount = count
						count = stack:Count()
						expect(count).to.equal(oldCount - 1)
					end
				end)

				it("should count zero after being cleared", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Count()).to.equal(5)
					stack:Clear()
					expect(stack:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local stack = ArrayStack.new()
					expect(stack:Empty()).to.equal(true)
				end)

				it("should not be empty with a single element", function()
					local stack = ArrayStack.new({ 1 })
					expect(stack:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local stack = ArrayStack.new()
					expect(stack:Empty()).to.equal(true)
					stack:Add(1)
					expect(stack:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					while stack:Count() > 0 do
						expect(stack:Empty()).to.equal(false)
						stack:Pop()
					end
					expect(stack:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Empty()).to.equal(false)
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local stack = ArrayStack.new()
					expect(stack:ToArray()).to.be.a("table")
				end)

				it("should create a table of size Count", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(#stack:ToArray()).to.equal(stack:Count())
				end)

				it("should create an empty table when empty", function()
					local stack = ArrayStack.new()
					expect(#stack:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local array = stack:ToArray()
					expect(#array).to.equal(stack:Count())
					while stack:Count() > 0 do
						expect(stack:Pop()).to.equal(table.remove(array))
					end
					expect(#array).to.equal(0)
				end)

				it("should provide only array indexable elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local array = stack:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should provide the same representation as ToArray", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local array = stack:ToArray()
					local table = stack:ToTable()
					expect(table).to.be.a("table")
					expect(#table).to.equal(#array)
					for i, v in pairs(table) do
						expect(v).to.equal(array[i])
					end
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Add", function()
				it("should add elements when empty", function()
					local stack = ArrayStack.new()
					stack:Add(1)
					expect(stack:Count()).to.equal(1)
				end)

				it("should add elements when not empty", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:Add(6)
					expect(stack:Count()).to.equal(6)
				end)

				it("should add elements to the end", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:Add(1)
					expect(stack:Last()).to.equal(1)
				end)

				it("should return true (per Collection)", function()
					local stack = ArrayStack.new()
					expect(stack:Add(1)).to.equal(true)
				end)

				it("should add duplicate elements", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					stack:Add(1)
					expect(stack:Count()).to.equal(6)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local stack = ArrayStack.new()
					local add = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(5)
				end)

				it("should add a single element when empty", function()
					local stack = ArrayStack.new()
					local add = ArrayStack.new({ 1 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local add = ArrayStack.new({ 6, 7, 8, 9, 0 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(10)
				end)

				it("should add a single element when not empty", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local add = ArrayStack.new({ 6 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(6)
				end)

				it("should add multiple elements to the end", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local add = ArrayStack.new({ 6, 7, 8, 9, 10 })
					stack:AddAll(add)
					expect(stack:Pop()).to.equal(10)
					expect(stack:Pop()).to.equal(9)
					expect(stack:Pop()).to.equal(8)
					expect(stack:Pop()).to.equal(7)
					expect(stack:Pop()).to.equal(6)
				end)

				it("should add a single element to the end", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local add = ArrayStack.new({ 6 })
					stack:AddAll(add)
					expect(stack:Last()).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local stack = ArrayStack.new()
					local add = ArrayStack.new({ 6, 7, 8, 9, 10 })
					expect(stack:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding a single element", function()
					local stack = ArrayStack.new()
					local add = ArrayStack.new({ 6 })
					expect(stack:AddAll(add)).to.equal(true)
				end)

				it("should add multiple duplicate elements", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local add = ArrayStack.new({ 1, 1, 1, 1, 1 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(10)
				end)

				it("should add a single duplicate element", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local add = ArrayStack.new({ 1 })
					stack:AddAll(add)
					expect(stack:Count()).to.equal(6)
				end)
			end)

			describe("Clear", function()
				it("should be able to clear all elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Empty()).to.equal(false)
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local stack = ArrayStack.new()
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)

				it("should clear with a single element", function()
					local stack = ArrayStack.new({ 1 })
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)

				it("should clear with duplicate elements", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					stack:Clear()
					expect(stack:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should successfully attempt to remove when empty", function()
					local stack = ArrayStack.new()
					expect(function()
						stack:Remove(1)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local stack = ArrayStack.new()
					expect(stack:Remove(1)).to.equal(false)
				end)

				it("should remove with single element", function()
					local stack = ArrayStack.new({ 1 })
					stack:Remove(1)
					expect(stack:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local stack = ArrayStack.new({ 1 })
					expect(stack:Remove(1)).to.equal(true)
				end)

				it("should find and remove an element", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:Remove(3)
					expect(stack:Count()).to.equal(4)
				end)

				it("should return true when finding and removing an element", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Remove(3)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:Remove(6)
					expect(stack:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:Remove(6)).to.equal(false)
				end)

				it("should only remove one element when there are duplicates", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					stack:Remove(1)
					expect(stack:Count()).to.equal(4)
				end)

				it("should return true when removing a duplicate", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					expect(stack:Remove(1)).to.equal(true)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local stack = ArrayStack.new()
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(function()
						stack:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local stack = ArrayStack.new()
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove with a single element", function()
					local stack = ArrayStack.new({ 1 })
					local remove = ArrayStack.new({ 1 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local stack = ArrayStack.new({ 1 })
					local remove = ArrayStack.new({ 1 })
					expect(stack:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove when there are excess elements to remove", function()
					local stack = ArrayStack.new({ 1 })
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(0)
				end)

				it("should return true when removing with excess", function()
					local stack = ArrayStack.new({ 1 })
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RemoveAll(remove)).to.equal(true)
				end)

				it("should find and remove a single element", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 1 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(4)
				end)

				it("should return true when removing a single element", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 1 })
					expect(stack:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 0 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 0 })
					expect(stack:RemoveAll(remove)).to.equal(false)
				end)

				it("should find and remove multiple elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local remove = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove only once for each occurrance of duplicates", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local remove = ArrayStack.new({ 1, 1, 1 })
					stack:RemoveAll(remove)
					expect(stack:Count()).to.equal(2)
				end)

				it("should return true when removing duplicates", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local remove = ArrayStack.new({ 1, 1, 1 })
					expect(stack:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local stack = ArrayStack.new()
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(function()
						stack:RetainAll(retain)
					end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local stack = ArrayStack.new()
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with a single element", function()
					local stack = ArrayStack.new({ 1 })
					local retain = ArrayStack.new({ 1 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(1)
				end)

				it("should return false when retaining with a single element", function()
					local stack = ArrayStack.new({ 1 })
					local retain = ArrayStack.new({ 1 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)

				it("should retain when there are excess elements to retain", function()
					local stack = ArrayStack.new({ 1 })
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements", function()
					local stack = ArrayStack.new({ 1 })
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)

				it(
					"should retain no elements when retaining a single element which does not match a single element",
					function()
						local stack = ArrayStack.new({ 1 })
						local retain = ArrayStack.new({ 0 })
						stack:RetainAll(retain)
						expect(stack:Count()).to.equal(0)
					end
				)

				it(
					"should return true when not retaining a single element which does not match a single element",
					function()
						local stack = ArrayStack.new({ 1 })
						local retain = ArrayStack.new({ 0 })
						expect(stack:RetainAll(retain)).to.equal(true)
					end
				)

				it("should retain a single element from many", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 3 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(1)
				end)

				it("should return true when retaining a single element from many", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 3 })
					expect(stack:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when a single element does not match", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 6 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(0)
				end)

				it("should return true when not retaining a single element which does not match", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 3 })
					expect(stack:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 1, 3, 5 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 1, 3, 5 })
					expect(stack:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 0, 1, 3 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 0, 1, 3 })
					expect(stack:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 1, 2, 3, 4, 5 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 0, 1, 2, 3, 4, 5 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
					local retain = ArrayStack.new({ 0, 1, 2, 3, 4, 5 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all duplicates", function()
					local stack = ArrayStack.new({ 1, 1, 2, 2, 3 })
					local retain = ArrayStack.new({ 1, 2 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(4)
				end)

				it("should return true when retaining duplicates and more exist", function()
					local stack = ArrayStack.new({ 1, 1, 2, 2, 3 })
					local retain = ArrayStack.new({ 1, 2 })
					expect(stack:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all duplicates when attemping to retain excess", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local retain = ArrayStack.new({ 1, 2 })
					stack:RetainAll(retain)
					expect(stack:Count()).to.equal(5)
				end)

				it("should return false when retaining all duplicates", function()
					local stack = ArrayStack.new({ 1, 1, 1, 1, 1 })
					local retain = ArrayStack.new({ 1 })
					expect(stack:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("ArrayStack Interface", function()
		describe("Last", function()
			it("should error when empty", function()
				local stack = ArrayStack.new()
				expect(function()
					stack:Last()
				end).to.throw("No last element exists.")
			end)

			it("should get the last element with only one element", function()
				local stack = ArrayStack.new({ 1 })
				expect(stack:Last()).to.equal(1)
			end)

			it("should get the last element with many elements", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				expect(stack:Last()).to.equal(5)
			end)

			it("should get the last element when elements are removed", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				stack:Pop()
				expect(stack:Last()).to.equal(4)
			end)

			it("should error when all elements have been removed", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				while stack:Count() > 0 do
					stack:Pop()
				end
				expect(function()
					stack:Last()
				end).to.throw("No last element exists.")
			end)
		end)

		describe("Push", function()
			it("should add an item to the end when empty", function()
				local stack = ArrayStack.new()
				stack:Push(1)
				expect(stack:Last()).to.equal(1)
				expect(stack:Count()).to.equal(1)
			end)

			it("should add an item to the end with a single element", function()
				local stack = ArrayStack.new({ 1 })
				stack:Push(2)
				expect(stack:Count()).to.equal(2)
				expect(stack:Last()).to.equal(2)
			end)

			it("should add an item to the end with many elements", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				stack:Push(6)
				expect(stack:Count()).to.equal(6)
				expect(stack:Last()).to.equal(6)
			end)

			it("should return true (per Stack)", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				expect(stack:Push(6)).to.equal(true)
			end)
		end)

		describe("Pop", function()
			it("should error when empty", function()
				local stack = ArrayStack.new()
				expect(function()
					stack:Pop()
				end).to.throw("No last element exists.")
			end)

			it("should remove an item from the end with a single element", function()
				local stack = ArrayStack.new({ 1 })
				stack:Pop()
				expect(stack:Count()).to.equal(0)
			end)

			it("should get the element when removing with a single element", function()
				local stack = ArrayStack.new({ 1 })
				expect(stack:Pop()).to.equal(1)
			end)

			it("should remove an item from the end with many elements", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				stack:Pop()
				expect(stack:Last()).to.equal(4)
				expect(stack:Count()).to.equal(4)
			end)

			it("should get the element when removing with many elements", function()
				local stack = ArrayStack.new({ 1, 2, 3, 4, 5 })
				expect(stack:Pop()).to.equal(5)
			end)
		end)
	end)
end
