require 'rails_helper'

RSpec.describe Notification, :type => :model do
  subject { create(:notification) }

  it "has a valid factory" do
    expect(build(:notification)).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).touch }
    it { should belong_to(:actor).optional }
    it { should belong_to(:target).optional }
    it { should belong_to(:second_target).optional }
    it { should belong_to(:third_target).optional }
  end

  describe "Validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notify_type) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
      expect(subject.is_opened).to eq false
      expect(subject.is_sent).to eq false
    end

    it "is not valid without a user" do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a notify_type" do
      subject.notify_type = nil
      expect(subject).to_not be_valid
    end
  end

  context "callbacks" do
    it { expect(subject).to callback(:publish_create_event).after(:commit) }
    it { expect(subject).to callback(:publish_save_event).after(:commit) }
  end

  describe "#read" do
    it "reads notifications" do
      subject.read
      expect(subject.is_opened).to eq true
      expect(subject.opened_at).to_not be nil
    end
  end

  describe "#unread" do
    it "unreads notifications" do
      notification = create(:read_notification)
      notification.unread
      expect(subject.is_opened).to eq false
      expect(subject.opened_at).to be nil
    end
  end

  context "Testing callback functions" do
    let(:notification) do
      create(:notification)
    end

    describe "#publish_create_event" do
      it "publishes a create event on create" do
        expect { notification.send(:publish_create_event) }.to broadcast(:notification_created)
      end
    end

    describe "#publish_save_event" do
      it "publishes a save event on save" do
        expect { notification.send(:publish_save_event) }.to broadcast(:notification_saved)
      end
    end
  end
end
