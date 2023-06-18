## テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| name               | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| profile_picture    | string |                          |
| test_attempts      | integer|                          |
| average_score      | integer|                          |
| birthday           | date   | null: false              |
| admin              | boolean| default: false           |

### Association

- has_many :test_results

## questions テーブル

| Column         | Type      | Options     |
| -------------- | --------- | ----------- |
| question_text  | string    | null: false |
| correct_answer | string    | null: false |

### Association

- has_many :test_results

## test_results テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | -----------------------------  |
| user_answer     | string     | null: false                    |
| is_correct      | boolean    |                                |
| user            | references | null: false, foreign_key: true |
| question        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :question