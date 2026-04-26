# Data Quality Dimensions

Data quality is the foundation for reliable analytics, trusted dashboards, and effective decision-making. A dataset can be available and technically accessible, but still be unusable if it is incomplete, inconsistent, outdated, duplicated, or inaccurate.

This document summarizes the main dimensions that should be evaluated when assessing data quality in analytics and business intelligence environments.

---

## 1. Completeness

**Question:** Is all required data available?

Completeness measures whether the required fields contain values and whether key records are present in the dataset.

### Examples

- Customer ID is missing.
- Email or phone number is empty.
- Churn label is null in a churn modeling dataset.
- Transaction records are missing for a specific period.

### Typical checks

- Percentage of null values by column.
- Required fields without values.
- Missing records by date, region, or source system.

### Business impact

Incomplete data can lead to incorrect segmentation, biased models, and poor operational decisions.

---

## 2. Consistency

**Question:** Is the data aligned across systems and business definitions?

Consistency evaluates whether the same concept has the same meaning, format, and value across datasets or systems.

### Examples

- One system defines churn as 30 days without activity, while another uses 60 days.
- Customer status appears as `ACTIVE`, `Active`, `A`, and `1`.
- Revenue values differ between finance and marketing reports.

### Typical checks

- Standardized categories and status values.
- Alignment of KPI definitions across teams.
- Cross-system reconciliation of key metrics.

### Business impact

Inconsistent data reduces trust and creates conflicting versions of the truth across teams.

---

## 3. Accuracy

**Question:** Does the data correctly represent the real-world event, customer, or transaction?

Accuracy measures whether values are correct and reflect reality.

### Examples

- A customer is marked as active but has not used the service for months.
- Age is negative or unrealistic.
- Revenue is assigned to the wrong customer.
- A churn flag is incorrect due to late data refresh.

### Typical checks

- Valid ranges for numeric fields.
- Reconciliation with source systems.
- Business rule validation.
- Sampling and manual review.

### Business impact

Inaccurate data can produce wrong insights, poor predictions, and misallocated resources.

---

## 4. Uniqueness

**Question:** Are records duplicated?

Uniqueness evaluates whether each real-world entity is represented once and only once when appropriate.

### Examples

- The same customer appears multiple times with different IDs.
- Duplicate transactions are loaded into a data warehouse.
- Multiple customer profiles exist for the same phone number.

### Typical checks

- Duplicate records by primary key.
- Duplicate customers by national ID, email, phone, or account number.
- Duplicate transactions by transaction ID and timestamp.

### Business impact

Duplicates inflate KPIs, distort customer counts, and affect marketing, billing, and analytics decisions.

---

## 5. Timeliness

**Question:** Is the data available and updated when needed?

Timeliness evaluates whether data is current enough to support the decision or process that depends on it.

### Examples

- Campaign dashboards update two days late.
- Churn prediction uses outdated customer behavior.
- Sales reports do not include the latest transactions.

### Typical checks

- Last update timestamp.
- Data freshness by source.
- Delay between event creation and data availability.

### Business impact

Outdated data can lead to delayed reactions, lost opportunities, and ineffective strategies.

---

## 6. Validity

**Question:** Does the data follow the expected format, type, and allowed values?

Validity evaluates whether values conform to predefined rules and constraints.

### Examples

- Email does not follow a valid email format.
- Date fields contain invalid dates.
- Customer status contains values outside the allowed catalog.
- Phone numbers do not match the expected length.

### Typical checks

- Format validation.
- Data type validation.
- Domain and catalog validation.
- Referential integrity checks.

### Business impact

Invalid values can break pipelines, distort reporting, and reduce confidence in downstream analytics.

---

## 7. Integrity

**Question:** Are relationships between datasets valid and reliable?

Integrity evaluates whether relationships among tables, systems, or entities are preserved.

### Examples

- A transaction references a customer that does not exist.
- A campaign response has no matching campaign ID.
- A product record appears in sales but not in the product catalog.

### Typical checks

- Foreign key validation.
- Orphan record detection.
- Referential checks across business domains.

### Business impact

Poor integrity creates gaps in analysis and makes it difficult to build reliable end-to-end views of the customer or business process.

---

## Practical Summary

| Dimension | Key Question | Example Metric |
|---|---|---|
| Completeness | Is required data present? | Null percentage |
| Consistency | Is data aligned across systems? | Mismatched KPI definitions |
| Accuracy | Does data reflect reality? | Error rate |
| Uniqueness | Are duplicates controlled? | Duplicate count |
| Timeliness | Is data fresh enough? | Data latency |
| Validity | Does data follow rules? | Invalid value percentage |
| Integrity | Are relationships valid? | Orphan records |

---

## Key Takeaway

Data quality is not only a technical concern. It directly affects trust, decision-making, analytics performance, and the credibility of data-driven strategies.

High-quality data enables organizations to move from reporting numbers to making confident decisions.
