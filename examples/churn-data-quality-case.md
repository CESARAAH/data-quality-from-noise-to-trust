# Case Study: Data Quality in Churn Analytics

## Context

Churn analytics is one of the most important use cases in telecom, subscription, and digital service businesses. Organizations use churn models to identify customers with a high probability of leaving, prioritize retention actions, and protect revenue.

However, churn models are only as reliable as the data that feeds them.

A technically strong model can still fail if the underlying data is incomplete, inconsistent, duplicated, outdated, or incorrectly labeled.

---

## Business Scenario

A company wants to build a churn model using customer behavior, billing information, service usage, campaign interactions, and customer profile data.

The expected objective is to identify customers at risk and activate retention strategies before they cancel or become inactive.

Key datasets include:

- Customer master data
- Billing and payment history
- Product and service usage
- Customer support interactions
- Campaign response history
- Churn label or cancellation status

---

## Typical Data Quality Issues

### 1. Missing Customer Attributes

Some records have missing demographic, contract, or product information.

**Example impact:** Customer segmentation becomes incomplete and model performance decreases.

---

### 2. Inconsistent Churn Definition

Different teams may define churn in different ways:

- Cancellation request submitted
- Service disconnected
- No activity for 30 days
- No activity for 60 days
- Payment overdue for a defined period

**Example impact:** Marketing, finance, and analytics teams may report different churn rates.

---

### 3. Duplicate Customer Records

The same customer may appear multiple times due to different account IDs, phone numbers, or source systems.

**Example impact:** Churn rate, active customer base, and retention campaign sizing can be inflated or distorted.

---

### 4. Outdated Behavioral Data

Usage data may not be refreshed on time.

**Example impact:** The model predicts churn based on old behavior and misses recent changes in customer activity.

---

### 5. Invalid or Extreme Values

Some fields may contain impossible or suspicious values.

Examples:

- Negative tenure
- Negative revenue
- Invalid contract status
- Usage values far outside expected ranges

**Example impact:** Model training becomes biased and operational dashboards lose credibility.

---

## Data Quality Framework Applied to Churn

### Step 1: Identify Critical Data Elements

Critical data elements for churn analytics may include:

- Customer ID
- Churn flag
- Tenure
- Monthly revenue
- Product type
- Usage volume
- Payment behavior
- Campaign response
- Customer status

---

### Step 2: Define Data Quality Rules

Examples of rules:

- Customer ID must not be null.
- Churn flag must be either 0 or 1.
- Monthly revenue must be greater than or equal to 0.
- Tenure must be greater than or equal to 0.
- Customer status must belong to an approved catalog.
- Each customer must have a unique active record.

---

### Step 3: Monitor Data Quality Metrics

Recommended metrics:

- Null rate by critical field
- Duplicate customer count
- Invalid churn flag percentage
- Data freshness by source
- Percentage of records with invalid revenue or tenure
- Number of orphan records across customer and billing datasets

---

### Step 4: Assign Ownership

A data quality process requires clear ownership.

Examples:

- Data Owner: responsible for the business definition of churn.
- Data Steward: responsible for monitoring quality and coordinating fixes.
- Data Engineer: responsible for pipeline validation and technical controls.
- Analytics Lead: responsible for ensuring model readiness and interpretation.

---

### Step 5: Improve Continuously

Data quality is not a one-time cleaning exercise. It must be embedded into the data lifecycle.

Recommended practices:

- Automated validation checks in pipelines
- Quality dashboards for critical datasets
- Business glossary for churn definitions
- Root cause analysis for recurring issues
- Periodic review with business and data teams

---

## Expected Outcomes

A company that improves data quality in churn analytics can achieve:

- More reliable churn prediction
- Better targeting of retention campaigns
- Reduced waste in marketing actions
- Higher trust in analytics outputs
- Stronger alignment between business and technical teams

---

## Key Insight

In churn analytics, the model is not the starting point.

The starting point is trusted data.

Without data quality, advanced analytics becomes a sophisticated way to make unreliable decisions.
