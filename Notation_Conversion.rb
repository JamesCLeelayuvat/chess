module Notation_Conversion
#converts algebraic notation into indices
  def get_indices_from_notation(selection)
    index_array = [0, 1, 2, 3, 4, 5, 6, 7]
    alphabet_array = ["a", "b", "c", "d", "e", "f", "g", "h"]
    selection = selection.split("")
    if selection[0].nil? || selection[1].nil?
      return nil
    end
    selection[0] = index_array[alphabet_array.index(selection[0])]
    selection[1] = selection[1].to_i - 1
    selection
  end
end
