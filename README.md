# AdPulse — Digital Marketing Campaign Performance Audit
 
![Tool Badge](https://img.shields.io/badge/Tool-SQL%20Server-blue) ![Tool Badge](https://img.shields.io/badge/Tool-Power%20BI-yellow) ![Tool Badge](https://img.shields.io/badge/Tool-DAX-orange) ![Tool Badge](https://img.shields.io/badge/Records-200K-green)
 
---
 
## 📌 Project Overview
 
AdPulse Media is a mid-sized digital marketing agency managing campaigns for multiple clients across various industries. The Head of Strategy raised concerns that marketing spend was not being allocated efficiently — some channels were consuming large budgets with poor returns while others were underperforming despite strong potential.
 
As the appointed Data Analyst, I conducted a full performance audit of 200,000 campaigns across 11 months, analyzing channel efficiency, segment targeting, geographic performance, and audience behavior to deliver clear, actionable budget reallocation recommendations.
 
---
 
## 🎯 Business Questions Answered
 
- Which channels deliver the strongest ROI relative to acquisition cost?
- Which campaign type and customer segment combinations perform best?
- Which locations are over or underinvested relative to their returns?
- When during the year should budget be increased or reduced?
- Which audience groups convert best and through which channels?
 
---
 
## 📁 Dataset
 
| Detail | Info |
|---|---|
| **Source** | Kaggle — Marketing Campaign Performance Dataset |
| **Records** | 200,000 campaigns |
| **Time Period** | 11 Months |
| **Companies** | 5 |
| **Channels** | 6 (Facebook, Email, Google Ads, Instagram, Website, YouTube) |
| **Campaign Types** | 5 (Display, Email, Influencer, Search, Social Media) |
| **Locations** | 5 US Cities |
| **Data Quality** | No nulls | No duplicates | All values within normal range |
 
---
 
## 🔧 Tools & Techniques Used
 
- **SQL Server** — Data exploration, quality checks, and multi-dimensional analysis
- **Power BI & DAX** — Interactive dashboard creation, KPI measures, conditional formatting
- **Power Query** — Data transformation and modeling
- **Techniques** — CTR calculation, ROI benchmarking, cross-dimensional analysis, trend analysis
 
---
 
## 🔍 Key Findings
 
### Finding 1 — Channel Performance
**Facebook** delivers the strongest ROI at moderate cost — the most efficient channel. **Website** achieves the best CTR at lower acquisition cost than Email. **Email** has the highest acquisition cost but near-equal ROI to Facebook — a candidate for partial budget reallocation rather than full defunding.
 
### Finding 2 — Campaign Type & Segment Performance
**Influencer + Tech Enthusiasts** is the star combination with the highest ROI at 5.03. **Email + Outdoor Adventurers** is the weakest pairing at 4.96 — however this is not a segment problem. Outdoor Adventurers respond strongly to Display campaigns at 5.02, revealing a **channel-segment mismatch** rather than a weak audience.
 
### Finding 3 — Geographic Performance
**Houston** is the most cost-efficient location — strong ROI at the lowest acquisition cost. **New York** is the weakest value proposition — high cost, lowest ROI across all locations. **Miami** justifies its premium cost with the strongest ROI. **Chicago** maintains a healthy cost-to-return balance.
 
### Finding 4 — Monthly Trends
**May and October** are peak ROI months. **February** is the most cost-efficient month — lowest spend, competitive returns. **August** represents the biggest budget waste — highest spend but poor ROI. CTR remains stable at ~10% year-round, confirming performance gaps are **spend-driven not audience-driven.**
 
### Finding 5 — Target Audience Performance
**Men 25-34 via Facebook** deliver the strongest ROI at the lowest acquisition cost — the star audience-channel combination. **Women 35-44** are an underinvested hidden gem — strong ROI at minimal spend. **Men 18-24** represent the biggest budget problem — highest spend, lowest ROI across Instagram and Email.
 
---
 
## 💡 Recommendations
 
1. **Reallocate Email budget** partially to Facebook and Website — better ROI per dollar spent
2. **Shift Outdoor Adventurers** campaigns from Email to Display — channel mismatch not audience weakness
3. **Reallocate New York budget** to Houston — highest cost, lowest ROI vs most efficient location
4. **Reduce August spend**, increase investment in May and October campaigns
5. **Increase Men 25-34 investment** via Facebook, grow Women 35-44 presence — both deliver strong ROI at low cost
6. **Significantly reduce Men 18-24** spend on Instagram and Email — highest cost, weakest returns
 
---
 
## 📊 Dashboard Preview
 
### Page 1 — Executive Overview
<img width="687" height="386" alt="Dashboard_Page1" src="https://github.com/user-attachments/assets/83ba5872-bc28-4acd-a8ef-62363c07d195" />

 
### Page 2 — Campaign Deep Dive
<img width="686" height="386" alt="Dashboard_Page2" src="https://github.com/user-attachments/assets/cd7220df-5f8a-4722-8cde-7ebc61eb9f45" />

 
---
 
## 📂 Files in This Repository
 
| File | Description |
|---|---|
| `AdPulse_SQL_Analysis.sql` | Complete SQL script — data exploration, quality checks, and all 5 analyses |
| `AdPulse_Report.pbix` | Power BI dashboard file — Executive Overview & Campaign Deep Dive |
| `Dashboard_Page1.png` | Screenshot — Executive Overview page |
| `Dashboard_Page2.png` | Screenshot — Campaign Deep Dive page |
| `README.md` | Project documentation |
 
---
 
## 👤 Author
 
**Mustapha Ambali** — Data Analyst
📍 Lagos, Nigeria | Open to Remote Roles Worldwide
 
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/mustapha-ambali)
[![Portfolio](https://img.shields.io/badge/Portfolio-View-black)](https://www.datascienceportfol.io/ambalimustapha6)
