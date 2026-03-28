Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649A33BBA2
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774662047; cv=none; b=JfSUE+C6/6MXkPkA38foJ7irbTC5IJgv4/Vg47Wk390E8wp/8kRqpkUG2sDIFxZ9r5NzQRyWlePzxTQjDvlEVM/vDPLC9Wh3wFAVnLMaGJvbvuybTZGy8AO45EiK7j5weyxJIhRTHAk1aVz6GJPUrS9h168uoLo2/3Ec13JpjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774662047; c=relaxed/simple;
	bh=P+sgtflT7HpNTLl3SREork3SLX9AzxBIvEm30I4maL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCfAdFghzZwyfyQuxYJKcr6OjqO1XW1+lQlhgdpYH90Gnh1e9uYMgA4pd3WCPJWYLcWqo+hGSSgT/ymrDKZ1R7mcvBQHFvotlgPTddJHIJe5jym65a4bueoSr29cdPN9pMTaezl/UgKpV8ngIjJ1q72Ez+adDkDYMQXqmaAJFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfFo7Euy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfFo7Euy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509134ab2d2so22789121cf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774662045; x=1775266845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBBLWCcZ87q82/idzSnceVUwnwhBcq1HPoO/59tEn18=;
        b=hfFo7EuytdGqbNdcKUUaCWOL6owG+TacYy4CGxjTdHxmJxm3UyigIEZeVO7/k/7EgI
         ovJVRrf+GQHDvpTlvcGyHbFWW4OhJGqKSPrEMIewBqZ49nDgkiQuFf/nHc1vQh36ua+I
         LuiBXHUcrQCNgO2oPVBeGJys9j9yPzKje88ZS8VmgWi2QztNppCoizdNtXb1XbCcg9UM
         pKKABGczJsZb4GZarBN76ZxQ/uIkDWok3nRoUTEB6xhekTKz/lKufpuMna0KPiBBkWgm
         Xy1KvNIxRcdyJqtBh3xD/TtSdZk2DxcO8hYsT6Ce0wEJpFaS6rknf6Xs4/zpgb2KslJo
         SnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774662045; x=1775266845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBBLWCcZ87q82/idzSnceVUwnwhBcq1HPoO/59tEn18=;
        b=sj1cwGnzqpk36wNQh7cSnJTx6E6Coj4RyMbLEvJUEzDWpDFobAhXNzQ+Sx0uosi1zt
         CorhF3ACa+lBnR4Bi0x+et5o/TCJ42uWRBKXGYLWkJLeROqxjp8gVjd2+yxEU+9W6VKk
         LkbIxwWCRc3ExpUa7T+qxdKJ+JWhJ0pFm15cr4bov0iXvSeelR9WHfOw4Ofk/Y3BUq0j
         /S/60tJe0R0popzrLKB8A5gemSSfcNZFAIPjXnpUJSGGF8N9Jq1gBAiGziIYMTNGLuWy
         hOReKKHtWPYRg0ZZYQArgWnUX4w9TTSPmdQHiu7VM6nOekhKLItI9k319R5GA3iUosep
         SHYw==
X-Forwarded-Encrypted: i=1; AJvYcCVi/3Ih2+FoUOWkzHGuTEbP100JduxuACstx7y+MwFyyaaf67b5Sg5H8c/nT2PzNYxe4uV+plrjxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSFYPpDY2Mjr1Ms8LhsChEC5ruUaHclolv57gHWBtegqKcYRsy
	JRiWaUjFHGdGHmcj/jURNrbD/BHnD6X4Dtjng89tEEIftTWbNEuXuAuk
X-Gm-Gg: ATEYQzw67lMnAz2vjbfxVhcKnGRKP4Nmp1MNDcefJToBYotbkV1pnt1mpqhfOusoVVc
	rUsfTLRRMpVcKufR1TJ3wcDM2nTDS85R5lf0XLxdd9t/8tqQz0OZCDStbhy0R/ltBNVg7o8GURd
	lJ+jcC1/8AGGPtxbQQpJmpd/c7TItBHqplQROOQtMDjthE7kpjHeMz3WPZGIpbzEzwYMmqwdVab
	lmi5mLn7z2faevu5y64zC1n4eID1+IlZqCQKfcuaeQg4K7gZ9JmLjcV4dPeIp2DW/oDFOQUn4Oy
	f6tFo5lzQxS6d13fKXN/fBAsfc2JmqFHmOv4oCpq/KrU2Ft2iVO7vU7GDMrmwr2SMvyUoOGzyiP
	F6s9yM5EbjzgwgNtcRsyU7+ei00P5ISKWGVXYcK5EktbGK4yj6YeXb8/Y0QbHVEtqRRGfPZ8xw3
	Wq5kCg0OC5wys8W+sL4JHEtD4k+w==
X-Received: by 2002:a05:622a:64b:b0:509:61:b22 with SMTP id d75a77b69052e-50ba39c17a1mr66304681cf.57.1774662045438;
        Fri, 27 Mar 2026 18:40:45 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67d1fsm8092411cf.1.2026.03.27.18.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 18:40:43 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 3/4] thermal/qcom/lmh: support SDM670 and its CPU clusters
Date: Fri, 27 Mar 2026 21:40:40 -0400
Message-ID: <20260328014041.83777-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328014041.83777-1-mailingradian@gmail.com>
References: <20260328014041.83777-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
some SoCs divide the CPUs into different sizes of clusters. In SDM670,
the first 6 CPUs are in the little cluster and the next 2 are in the big
cluster. Define the clusters in the match data and define the different
cluster configuration for SDM670.

Currently, this only supports 8 CPUs and tolerates linking to any CPU in
the cluster.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 3d072b7a4a6d..46c1e301f6c8 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -30,14 +30,17 @@
 
 #define LMH_REG_DCVS_INTR_CLR		0x8
 
-#define LMH_ENABLE_ALGOS		1
-
 struct lmh_hw_data {
 	void __iomem *base;
 	struct irq_domain *domain;
 	int irq;
 };
 
+struct lmh_soc_data {
+	bool enable_algos;
+	u32 node_ids[8];
+};
+
 static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
 {
 	struct lmh_hw_data *lmh_data = data;
@@ -100,8 +103,8 @@ static int lmh_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *cpu_node;
 	struct lmh_hw_data *lmh_data;
+	const struct lmh_soc_data *match_data;
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
-	unsigned int enable_alg;
 	u32 node_id;
 
 	if (!qcom_scm_is_available())
@@ -144,10 +147,9 @@ static int lmh_probe(struct platform_device *pdev)
 	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
 	 * of a dt match table.
 	 */
-	if (cpu_id == 0) {
-		node_id = LMH_CLUSTER0_NODE_ID;
-	} else if (cpu_id == 4) {
-		node_id = LMH_CLUSTER1_NODE_ID;
+	match_data = of_device_get_match_data(dev);
+	if (cpu_id >= 0 && cpu_id < 8) {
+		node_id = match_data->node_ids[cpu_id];
 	} else {
 		dev_err(dev, "Wrong CPU id associated with LMh node\n");
 		return -EINVAL;
@@ -156,9 +158,7 @@ static int lmh_probe(struct platform_device *pdev)
 	if (!qcom_scm_lmh_dcvsh_available())
 		return -EINVAL;
 
-	enable_alg = (uintptr_t)of_device_get_match_data(dev);
-
-	if (enable_alg) {
+	if (match_data->enable_algos) {
 		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
 					 LMH_NODE_DCVS, node_id, 0);
 		if (ret)
@@ -231,10 +231,53 @@ static int lmh_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct lmh_soc_data sdm670_lmh_data = {
+	.enable_algos = true,
+	.node_ids = {
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+	},
+};
+
+static const struct lmh_soc_data sdm845_lmh_data = {
+	.enable_algos = true,
+	.node_ids = {
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+	},
+};
+
+static const struct lmh_soc_data sm8150_lmh_data = {
+	.enable_algos = false,
+	.node_ids = {
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER0_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+		LMH_CLUSTER1_NODE_ID,
+	},
+};
+
 static const struct of_device_id lmh_table[] = {
-	{ .compatible = "qcom,sc8180x-lmh", },
-	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
-	{ .compatible = "qcom,sm8150-lmh", },
+	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_lmh_data },
+	{ .compatible = "qcom,sdm670-lmh", .data = &sdm670_lmh_data },
+	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_lmh_data },
+	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_lmh_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, lmh_table);
-- 
2.53.0

