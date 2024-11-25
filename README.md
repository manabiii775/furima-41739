# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| date_of_birth      | date   | null: false               |

### Association
- has_many :products
- has_many :orders

## products テーブル

| Column                           | Type       | Options                        |
| -------------------------------- | ---------- | ------------------------------ |
| name                             | string     | null: false                    |
| description                      | text       | null: false                    |
| category_id                      | integer    | null: false                    |
| status_id                        | integer    | null: false                    |
| days_until_shipping_id           | integer    | null: false                    |
| shipping_cost_responsibility_id  | integer    | null: false                    |
| prefectures_id                   | integer    | null: false                    |
| price                            | integer    | null: false                    |
| user                             | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :addresse

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :products
- belongs_to :addresses

## addresses テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| postcode         | string | null: false |
| prefectures_id   | string | null: false |
| municipalities   | string | null: false |
| street_address   | string | null: false |
| telephone_number | string | null: false |
| building _name   | string |             |

### Association
- belongs_to :orders
