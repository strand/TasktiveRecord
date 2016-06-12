require './lib/omnifocus_importer'

describe OmnifocusImporter do
  context "#initialize" do
    it "is initialized with a filepath" do
      file = './spec/fixtures/task_list.csv'
      expect { described_class.new(file) }.not_to raise_error
    end
  end
end
