From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for
 Exynos5433
Date: Thu, 23 Jul 2015 10:57:18 +0900
Message-ID: <1437616639-7448-2-git-send-email-cw00.choi@samsung.com>
References: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48940 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbGWB5Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 21:57:24 -0400
In-reply-to: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, cw00.choi@samsung.com, dan.carpenter@oracle.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds the support for PPMU (Platform Performance Monitoring Unit)
version 2.0 for Exynos5433 SoC. Exynos5433 SoC must need PPMUv2 which is
quite different from PPMUv1.1. The exynos-ppmu.c driver supports both PPMUv1.1
and PPMUv2.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 168 ++++++++++++++++++++++++++++++++++--
 drivers/devfreq/event/exynos-ppmu.h |  70 +++++++++++++++
 2 files changed, 231 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 7d99d13bacd8..6066dc18fc73 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -1,7 +1,7 @@
 /*
  * exynos_ppmu.c - EXYNOS PPMU (Platform Performance Monitoring Unit) support
  *
- * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
  * Author : Chanwoo Choi <cw00.choi@samsung.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -82,6 +82,15 @@ struct __exynos_ppmu_events {
 	PPMU_EVENT(mscl),
 	PPMU_EVENT(fimd0x),
 	PPMU_EVENT(fimd1x),
+
+	/* Only for Exynos5433 SoCs */
+	PPMU_EVENT(d0-cpu),
+	PPMU_EVENT(d0-general),
+	PPMU_EVENT(d0-rt),
+	PPMU_EVENT(d1-cpu),
+	PPMU_EVENT(d1-general),
+	PPMU_EVENT(d1-rt),
+
 	{ /* sentinel */ },
 };
 
@@ -96,6 +105,9 @@ static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
 	return -EINVAL;
 }
 
+/*
+ * The devfreq-event ops structure for PPMU v1.1
+ */
 static int exynos_ppmu_disable(struct devfreq_event_dev *edev)
 {
 	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
@@ -200,6 +212,153 @@ static const struct devfreq_event_ops exynos_ppmu_ops = {
 	.get_event = exynos_ppmu_get_event,
 };
 
+/*
+ * The devfreq-event ops structure for PPMU v2.0
+ */
+static int exynos_ppmu_v2_disable(struct devfreq_event_dev *edev)
+{
+	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
+	u32 pmnc, clear;
+
+	/* Disable all counters */
+	clear = (PPMU_CCNT_MASK | PPMU_PMCNT0_MASK | PPMU_PMCNT1_MASK
+		| PPMU_PMCNT2_MASK | PPMU_PMCNT3_MASK);
+
+	__raw_writel(clear, info->ppmu.base + PPMUv2_FLAG);
+	__raw_writel(clear, info->ppmu.base + PPMUv2_INTENC);
+	__raw_writel(clear, info->ppmu.base + PPMUv2_CNTENC);
+	__raw_writel(clear, info->ppmu.base + PPMUv2_CNT_RESET);
+
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CIG_CFG0);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CIG_CFG1);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CIG_CFG2);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CIG_RESULT);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CNT_AUTO);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CH_EV0_TYPE);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CH_EV1_TYPE);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CH_EV2_TYPE);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_CH_EV3_TYPE);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_SM_ID_V);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_SM_ID_A);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_SM_OTHERS_V);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_SM_OTHERS_A);
+	__raw_writel(0x0, info->ppmu.base + PPMUv2_INTERRUPT_RESET);
+
+	/* Disable PPMU */
+	pmnc = __raw_readl(info->ppmu.base + PPMUv2_PMNC);
+	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
+	__raw_writel(pmnc, info->ppmu.base + PPMUv2_PMNC);
+
+	return 0;
+}
+
+static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
+{
+	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
+	int id = exynos_ppmu_find_ppmu_id(edev);
+	u32 pmnc, cntens;
+
+	/* Enable all counters */
+	cntens = __raw_readl(info->ppmu.base + PPMUv2_CNTENS);
+	cntens |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
+	__raw_writel(cntens, info->ppmu.base + PPMUv2_CNTENS);
+
+	/* Set the event of Read/Write data count  */
+	switch (id) {
+	case PPMU_PMNCNT0:
+	case PPMU_PMNCNT1:
+	case PPMU_PMNCNT2:
+		__raw_writel(PPMUv2_RO_DATA_CNT | PPMUv2_WO_DATA_CNT,
+				info->ppmu.base + PPMUv2_CH_EVx_TYPE(id));
+		break;
+	case PPMU_PMNCNT3:
+		__raw_writel(PPMUv2_EVT3_RW_DATA_CNT,
+				info->ppmu.base + PPMUv2_CH_EVx_TYPE(id));
+		break;
+	}
+
+	/* Reset cycle counter/performance counter and enable PPMU */
+	pmnc = __raw_readl(info->ppmu.base + PPMUv2_PMNC);
+	pmnc &= ~(PPMU_PMNC_ENABLE_MASK
+			| PPMU_PMNC_COUNTER_RESET_MASK
+			| PPMU_PMNC_CC_RESET_MASK
+			| PPMU_PMNC_CC_DIVIDER_MASK
+			| PPMUv2_PMNC_START_MODE_MASK);
+	pmnc |= (PPMU_ENABLE << PPMU_PMNC_ENABLE_SHIFT);
+	pmnc |= (PPMU_ENABLE << PPMU_PMNC_COUNTER_RESET_SHIFT);
+	pmnc |= (PPMU_ENABLE << PPMU_PMNC_CC_RESET_SHIFT);
+	pmnc |= (PPMUv2_MODE_MANUAL << PPMUv2_PMNC_START_MODE_SHIFT);
+	__raw_writel(pmnc, info->ppmu.base + PPMUv2_PMNC);
+
+	return 0;
+}
+
+static int exynos_ppmu_v2_get_event(struct devfreq_event_dev *edev,
+				    struct devfreq_event_data *edata)
+{
+	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
+	int id = exynos_ppmu_find_ppmu_id(edev);
+	u32 pmnc, cntenc;
+	u32 pmcnt_high, pmcnt_low;
+	u64 load_count = 0;
+
+	/* Disable PPMU */
+	pmnc = __raw_readl(info->ppmu.base + PPMUv2_PMNC);
+	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
+	__raw_writel(pmnc, info->ppmu.base + PPMUv2_PMNC);
+
+	/* Read cycle count and performance count */
+	edata->total_count = __raw_readl(info->ppmu.base + PPMUv2_CCNT);
+
+	switch (id) {
+	case PPMU_PMNCNT0:
+	case PPMU_PMNCNT1:
+	case PPMU_PMNCNT2:
+		load_count = __raw_readl(info->ppmu.base + PPMUv2_PMNCT(id));
+		break;
+	case PPMU_PMNCNT3:
+		pmcnt_high = __raw_readl(info->ppmu.base + PPMUv2_PMCNT3_HIGH);
+		pmcnt_low = __raw_readl(info->ppmu.base + PPMUv2_PMCNT3_LOW);
+		load_count = (u64)((pmcnt_high & 0xff) << 32) + (u64)pmcnt_low;
+		break;
+	}
+	edata->load_count = load_count;
+
+	/* Disable all counters */
+	cntenc = __raw_readl(info->ppmu.base + PPMUv2_CNTENC);
+	cntenc |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
+	__raw_writel(cntenc, info->ppmu.base + PPMUv2_CNTENC);
+
+	dev_dbg(&edev->dev, "%25s (load: %ld / %ld)\n", edev->desc->name,
+					edata->load_count, edata->total_count);
+	return 0;
+}
+
+static struct devfreq_event_ops exynos_ppmu_v2_ops = {
+	.disable = exynos_ppmu_v2_disable,
+	.set_event = exynos_ppmu_v2_set_event,
+	.get_event = exynos_ppmu_v2_get_event,
+};
+
+static struct of_device_id exynos_ppmu_id_match[] = {
+	{
+		.compatible = "samsung,exynos-ppmu",
+		.data = (void *)&exynos_ppmu_ops,
+	}, {
+		.compatible = "samsung,exynos-ppmu-v2",
+		.data = (void *)&exynos_ppmu_v2_ops,
+	},
+	{ /* sentinel */ },
+};
+
+static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(exynos_ppmu_id_match, np);
+	return (struct devfreq_event_ops *)match->data;
+}
+
 static int of_get_devfreq_events(struct device_node *np,
 				 struct exynos_ppmu *info)
 {
@@ -238,7 +397,7 @@ static int of_get_devfreq_events(struct device_node *np,
 			continue;
 		}
 
-		desc[j].ops = &exynos_ppmu_ops;
+		desc[j].ops = exynos_bus_get_ops(np);
 		desc[j].driver_data = info;
 
 		of_property_read_string(node, "event-name", &desc[j].name);
@@ -354,11 +513,6 @@ static int exynos_ppmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id exynos_ppmu_id_match[] = {
-	{ .compatible = "samsung,exynos-ppmu", },
-	{ /* sentinel */ },
-};
-
 static struct platform_driver exynos_ppmu_driver = {
 	.probe	= exynos_ppmu_probe,
 	.remove	= exynos_ppmu_remove,
diff --git a/drivers/devfreq/event/exynos-ppmu.h b/drivers/devfreq/event/exynos-ppmu.h
index 4e831d48c138..9a7cf6394f37 100644
--- a/drivers/devfreq/event/exynos-ppmu.h
+++ b/drivers/devfreq/event/exynos-ppmu.h
@@ -26,6 +26,9 @@ enum ppmu_counter {
 	PPMU_PMNCNT_MAX,
 };
 
+/***
+ * PPMUv1.1 Definitions
+ */
 enum ppmu_event_type {
 	PPMU_RO_BUSY_CYCLE_CNT	= 0x0,
 	PPMU_WO_BUSY_CYCLE_CNT	= 0x1,
@@ -90,4 +93,71 @@ enum ppmu_reg {
 #define PPMU_PMNCT(x)			(PPMU_PMCNT0 + (0x10 * x))
 #define PPMU_BEVTxSEL(x)		(PPMU_BEVT0SEL + (0x100 * x))
 
+/***
+ * PPMUv2.0 definitions
+ */
+enum ppmuv2_mode {
+	PPMUv2_MODE_MANUAL = 0,
+	PPMUv2_MODE_AUTO = 1,
+	PPMUv2_MODE_CIG = 2,	/* CIG (Conditional Interrupt Generation) */
+};
+
+enum ppmuv2_event_type {
+	PPMUv2_RO_DATA_CNT	= 0x4,
+	PPMUv2_WO_DATA_CNT	= 0x5,
+
+	PPMUv2_EVT3_RW_DATA_CNT = 0x22,	/* Only for Event3 */
+};
+
+enum ppmuv2_reg {
+	/* PPC control register */
+	PPMUv2_PMNC		= 0x04,
+	PPMUv2_CNTENS		= 0x08,
+	PPMUv2_CNTENC		= 0x0c,
+	PPMUv2_INTENS		= 0x10,
+	PPMUv2_INTENC		= 0x14,
+	PPMUv2_FLAG		= 0x18,
+
+	/* Cycle Counter and Performance Event Counter Register */
+	PPMUv2_CCNT		= 0x48,
+	PPMUv2_PMCNT0		= 0x34,
+	PPMUv2_PMCNT1		= 0x38,
+	PPMUv2_PMCNT2		= 0x3c,
+	PPMUv2_PMCNT3_LOW	= 0x40,
+	PPMUv2_PMCNT3_HIGH	= 0x44,
+
+	/* Bus Event Generator */
+	PPMUv2_CIG_CFG0		= 0x1c,
+	PPMUv2_CIG_CFG1		= 0x20,
+	PPMUv2_CIG_CFG2		= 0x24,
+	PPMUv2_CIG_RESULT	= 0x28,
+	PPMUv2_CNT_RESET	= 0x2c,
+	PPMUv2_CNT_AUTO		= 0x30,
+	PPMUv2_CH_EV0_TYPE	= 0x200,
+	PPMUv2_CH_EV1_TYPE	= 0x204,
+	PPMUv2_CH_EV2_TYPE	= 0x208,
+	PPMUv2_CH_EV3_TYPE	= 0x20c,
+	PPMUv2_SM_ID_V		= 0x220,
+	PPMUv2_SM_ID_A		= 0x224,
+	PPMUv2_SM_OTHERS_V	= 0x228,
+	PPMUv2_SM_OTHERS_A	= 0x22c,
+	PPMUv2_INTERRUPT_RESET	= 0x260,
+};
+
+/* PMNC register */
+#define PPMUv2_PMNC_START_MODE_SHIFT	20
+#define PPMUv2_PMNC_START_MODE_MASK	(0x3 << PPMUv2_PMNC_START_MODE_SHIFT)
+
+#define PPMU_PMNC_CC_RESET_SHIFT	2
+#define PPMU_PMNC_COUNTER_RESET_SHIFT	1
+#define PPMU_PMNC_ENABLE_SHIFT		0
+#define PPMU_PMNC_START_MODE_MASK	BIT(16)
+#define PPMU_PMNC_CC_DIVIDER_MASK	BIT(3)
+#define PPMU_PMNC_CC_RESET_MASK		BIT(2)
+#define PPMU_PMNC_COUNTER_RESET_MASK	BIT(1)
+#define PPMU_PMNC_ENABLE_MASK		BIT(0)
+
+#define PPMUv2_PMNCT(x)			(PPMUv2_PMCNT0 + (0x4 * x))
+#define PPMUv2_CH_EVx_TYPE(x)		(PPMUv2_CH_EV0_TYPE + (0x4 * x))
+
 #endif /* __EXYNOS_PPMU_H__ */
-- 
1.8.5.5

