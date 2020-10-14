defmodule Mobilizador.SettingTest do
  use Mobilizador.DataCase

  alias Mobilizador.Setting

  describe "topics" do
    alias Mobilizador.Setting.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Setting.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Setting.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Setting.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Setting.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Setting.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Setting.update_topic(topic, @update_attrs)
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Setting.update_topic(topic, @invalid_attrs)
      assert topic == Setting.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Setting.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Setting.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Setting.change_topic(topic)
    end
  end

  describe "materials" do
    alias Mobilizador.Setting.Material

    @valid_attrs %{description: "some description", file: "some file", name: "some name"}
    @update_attrs %{description: "some updated description", file: "some updated file", name: "some updated name"}
    @invalid_attrs %{description: nil, file: nil, name: nil}

    def material_fixture(attrs \\ %{}) do
      {:ok, material} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Setting.create_material()

      material
    end

    test "list_materials/0 returns all materials" do
      material = material_fixture()
      assert Setting.list_materials() == [material]
    end

    test "get_material!/1 returns the material with given id" do
      material = material_fixture()
      assert Setting.get_material!(material.id) == material
    end

    test "create_material/1 with valid data creates a material" do
      assert {:ok, %Material{} = material} = Setting.create_material(@valid_attrs)
      assert material.description == "some description"
      assert material.file == "some file"
      assert material.name == "some name"
    end

    test "create_material/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Setting.create_material(@invalid_attrs)
    end

    test "update_material/2 with valid data updates the material" do
      material = material_fixture()
      assert {:ok, %Material{} = material} = Setting.update_material(material, @update_attrs)
      assert material.description == "some updated description"
      assert material.file == "some updated file"
      assert material.name == "some updated name"
    end

    test "update_material/2 with invalid data returns error changeset" do
      material = material_fixture()
      assert {:error, %Ecto.Changeset{}} = Setting.update_material(material, @invalid_attrs)
      assert material == Setting.get_material!(material.id)
    end

    test "delete_material/1 deletes the material" do
      material = material_fixture()
      assert {:ok, %Material{}} = Setting.delete_material(material)
      assert_raise Ecto.NoResultsError, fn -> Setting.get_material!(material.id) end
    end

    test "change_material/1 returns a material changeset" do
      material = material_fixture()
      assert %Ecto.Changeset{} = Setting.change_material(material)
    end
  end
end
