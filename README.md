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
| e-mail             | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| date_of_birth      | date   | null: false               |

## products テーブル

| Column                        | Type       | Options                        |
| ----------------------------- | ---------- | ------------------------------ |
| image                         | string     | null: false                    |
| name                          | string     | null: false, unique: true      |
| description                   | text       | null: false                    |
| category                      | integer    | null: false                    |
| status                        | integer    | null: false                    |
| days_until_shipping           | integer    | null: false                    |
| shipping_cost_responsibility  | integer    | null: false                    |
| price                         | decimal    | null: false                    |
| user                          | references | null: false, foreign_key: true |

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

## addresses テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| postcode         | string | null: false |
| prefectures      | string | null: false |
| municipalities   | string | null: false |
| street_address   | string | null: false |
| telephone_number | string | null: false |
| Building _name   | string | null: true  |
