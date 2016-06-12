require './spec/spec_helper'
require './lib/omnifocus_importer'

describe OmnifocusImporter do
  let(:file) { './spec/fixtures/task_list.csv' }

  context "#initialize" do
    it "is initialized with a filepath" do
      expect { described_class.new(file) }.not_to raise_error
    end

    it "raises a SomethingSomething error for nonexistent files" do
      file = './spec/fixtures/skat_list.csv'
      expect {
        described_class.new(file)
      }.to raise_error described_class::FileNotFound
    end
  end

  context "#import_to_active_record" do
    it "creates the tasks in the fixture" do
      importer = described_class.new(file)
      expect(Task.count).to be 0
      importer.import_to_active_record
      expect(Task.count).to be > 30
    end

    it "only imports 'Action' tasks"
    it "does not create tasks which already exist"
  end
end
