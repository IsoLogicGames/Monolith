--- Tests for the List interface.
--
-- @version 0.1.0, 2020-12-04
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local List = require(module:WaitForChild("List"))

	describe("List", function()
		it("should be able to be instantiated", function()
			local list = List.new()
			expect(list).to.be.ok()
		end)

		it("should have an Enumerator method", function()
			local list = List.new()
			expect(list.Enumerator).to.be.a("function")
		end)

		it("should error when Enumerator is not overridden", function()
			local list = List.new()
			expect(function() list.Enumerator() end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Contains method", function()
			local list = List.new()
			expect(list.Enumerator).to.be.a("function")
		end)

		it("should error when Contains is not overridden", function()
			local list = List.new()
			expect(function() list.Contains() end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a ContainsAll method", function()
			local list = List.new()
			expect(list.ContainsAll).to.be.a("function")
		end)

		it("should error when ContainsAll is not overridden", function()
			local list = List.new()
			expect(function() list.ContainsAll() end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a ContainsAny method", function()
			local list = List.new()
			expect(list.ContainsAny).to.be.a("function")
		end)

		it("should error when ContainsAny is not overridden", function()
			local list = List.new()
			expect(function() list.ContainsAny() end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Count method", function()
			local list = List.new()
			expect(list.Count).to.be.a("function")
		end)

		it("should error when Count is not overridden", function()
			local list = List.new()
			expect(function() list.Count() end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Empty method", function()
			local list = List.new()
			expect(list.Empty).to.be.a("function")
		end)

		it("should error when Empty is not overridden", function()
			local list = List.new()
			expect(function() list.Empty() end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a ToArray method", function()
			local list = List.new()
			expect(list.ToArray).to.be.a("function")
		end)

		it("should error when ToArray is not overridden", function()
			local list = List.new()
			expect(function() list.ToArray() end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a ToTable method", function()
			local list = List.new()
			expect(list.ToTable).to.be.a("function")
		end)

		it("should error when ToTable is not overridden", function()
			local list = List.new()
			expect(function() list.ToTable() end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have an Add method", function()
			local list = List.new()
			expect(list.Add).to.be.a("function")
		end)

		it("should error when Add is not overridden", function()
			local list = List.new()
			expect(function() list.Add() end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have an AddAll method", function()
			local list = List.new()
			expect(list.AddAll).to.be.a("function")
		end)

		it("should error when AddAll is not overridden", function()
			local list = List.new()
			expect(function() list.AddAll() end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Clear method", function()
			local list = List.new()
			expect(list.Clear).to.be.a("function")
		end)

		it("should error when Clear is not overridden", function()
			local list = List.new()
			expect(function() list.Clear() end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Remove method", function()
			local list = List.new()
			expect(list.Remove).to.be.a("function")
		end)

		it("should error when Remove is not overridden", function()
			local list = List.new()
			expect(function() list.Remove() end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a RemoveAll method", function()
			local list = List.new()
			expect(list.RemoveAll).to.be.a("function")
		end)

		it("should error when RemoveAll is not overridden", function()
			local list = List.new()
			expect(function() list.RemoveAll() end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a RetainAll method", function()
			local list = List.new()
			expect(list.RetainAll).to.be.a("function")
		end)

		it("should error when RetainAll is not overridden", function()
			local list = List.new()
			expect(function() list.RetainAll() end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a First method", function()
			local list = List.new()
			expect(list.First).to.be.a("function")
		end)

		it("should error when First is not overridden", function()
			local list = List.new()
			expect(function() list.First() end).to.throw(
				"Abstract method First must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Get method", function()
			local list = List.new()
			expect(list.Get).to.be.a("function")
		end)

		it("should error when Get is not overridden", function()
			local list = List.new()
			expect(function() list.Get() end).to.throw(
				"Abstract method Get must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a IndexOf method", function()
			local list = List.new()
			expect(list.IndexOf).to.be.a("function")
		end)

		it("should error when IndexOf is not overridden", function()
			local list = List.new()
			expect(function() list.IndexOf() end).to.throw(
				"Abstract method IndexOf must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Last method", function()
			local list = List.new()
			expect(list.Last).to.be.a("function")
		end)

		it("should error when Last is not overridden", function()
			local list = List.new()
			expect(function() list.Last() end).to.throw(
				"Abstract method Last must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a LastIndexOf method", function()
			local list = List.new()
			expect(list.LastIndexOf).to.be.a("function")
		end)

		it("should error when LastIndexOf is not overridden", function()
			local list = List.new()
			expect(function() list.LastIndexOf() end).to.throw(
				"Abstract method LastIndexOf must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Sub method", function()
			local list = List.new()
			expect(list.Sub).to.be.a("function")
		end)

		it("should error when Sub is not overridden", function()
			local list = List.new()
			expect(function() list.Sub() end).to.throw(
				"Abstract method Sub must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Delete method", function()
			local list = List.new()
			expect(list.Delete).to.be.a("function")
		end)

		it("should error when Delete is not overridden", function()
			local list = List.new()
			expect(function() list.Delete() end).to.throw(
				"Abstract method Delete must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Insert method", function()
			local list = List.new()
			expect(list.Insert).to.be.a("function")
		end)

		it("should error when Insert is not overridden", function()
			local list = List.new()
			expect(function() list.Insert() end).to.throw(
				"Abstract method Insert must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a InsertAll method", function()
			local list = List.new()
			expect(list.RetainAll).to.be.a("function")
		end)

		it("should error when InsertAll is not overridden", function()
			local list = List.new()
			expect(function() list.InsertAll() end).to.throw(
				"Abstract method InsertAll must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Pop method", function()
			local list = List.new()
			expect(list.Pop).to.be.a("function")
		end)

		it("should error when Pop is not overridden", function()
			local list = List.new()
			expect(function() list.Pop() end).to.throw(
				"Abstract method Pop must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Push method", function()
			local list = List.new()
			expect(list.Push).to.be.a("function")
		end)

		it("should error when Push is not overridden", function()
			local list = List.new()
			expect(function() list.Push() end).to.throw(
				"Abstract method Push must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Set method", function()
			local list = List.new()
			expect(list.Set).to.be.a("function")
		end)

		it("should error when Set is not overridden", function()
			local list = List.new()
			expect(function() list.Set() end).to.throw(
				"Abstract method Set must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Shift method", function()
			local list = List.new()
			expect(list.Shift).to.be.a("function")
		end)

		it("should error when Shift is not overridden", function()
			local list = List.new()
			expect(function() list.Shift() end).to.throw(
				"Abstract method Shift must be overridden in first concrete subclass. Called directly from List.")
		end)

		it("should have a Unshift method", function()
			local list = List.new()
			expect(list.Unshift).to.be.a("function")
		end)

		it("should error when Unshift is not overridden", function()
			local list = List.new()
			expect(function() list.Unshift() end).to.throw(
				"Abstract method Unshift must be overridden in first concrete subclass. Called directly from List.")
		end)
	end)
end