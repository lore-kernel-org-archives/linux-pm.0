Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978195;
	b=2p6QQ5B9Zd42AObGn5xb9Mlg/TtwnSjpx9ZKh4r1mhZMGvjpXFYLNdHWU1pmWmNcs9OF
	 xOCDxNSDsdCPAVsQnzefXGO/M7VPzGuTFGe6c+nk7c5UB2erVPUcvCeOhONe+RHyBDyW1
	 8eXQFPEGtQnqQBw3KQYOG7i4Z57x+dZRFMnhz8QLMo+VQLK+aRwGTfSyO3KUZalj5FL6/
	 SK9OZcN8I+8kLKn23pLWuc+eCAeznCdjG+Kf/oRgga/GAPgy5SrYYPCB4mA05kAs8dq6L
	 m3it2nmu2ZGd6ApLGaFiCF7WvJUfHbkFbg29V1EmhuVeS298m7GQZa3X9KJ4dCY9t5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=p0+vg0aeGV4J5pNv27qoTyKZdEzm1Xuk0hKJMzjj9w4=;
	b=djrQOvDRuyb4m+vVAnFKTzOk/8MORa/eTMPWBMNxuiNkovA77aEKEul+qm3m5nK3nC3M
	 vN5YB0LsjbSSt8xze7RZOTQEKHkVskyOba13QPhmAjujOiA45dbOjvAi3oIG5tSa8+0I/
	 nBfsjwM4AH2cKeRMCd4pa7LvTifvyiP/18Ij3ETMh+o8sMjpZRCeY/R7N3iseDpOPmC3s
	 Qhpt+o78dPaK2ULnvpclKJh0uddgMb4QOCbOVCf6Dn1JqCW3IndOiDguLCTv7CONhF3kv
	 ycjJObX9M54mYJleT3yt9dahdv7iRv4TwaqOHEKAy218fmA7gcgLa0Bjz8g5tbp15QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFbDAQl5;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA5606D814
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AA5606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFbDAQl5
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1091392eec.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978186; x=1794582986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0+vg0aeGV4J5pNv27qoTyKZdEzm1Xuk0hKJMzjj9w4=;
        b=CFbDAQl5Px6jJ4XZlFMEDPoI4ZftJaNbBTXENQXD397d5G0rLRfHNpO/GPvDacJHl4
         ejdGEOzZBustPJ+tgfBCzCFWs0gesOcaefjBsRHSbrJsGlPAzsw3qxEqMQmcZamoM26b
         ddDvxGSHByu02tUfR1WiQJrF/CGlz+Hyq5eZv9rvm+Dzh9r3PkzluFOq7M1XgKcG3smy
         rGQ8Scb2cqvB/t4IxkX5SSueomHoKFOc9Pn8wa6h0AUTetKtfmXkoNjTQFUnM+7R+X0+
         +eUvvp4EatjHX9EOyANLc7X05RI6D+VJ/jTz1UeTey4kv3ld5Ch8o1ewgqwyuLuz0AVa
         77ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978186; x=1794582986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0+vg0aeGV4J5pNv27qoTyKZdEzm1Xuk0hKJMzjj9w4=;
        b=zcBVzhnk7u1eIzQz1RtJz0Y2FCgEP0kXGyz3UI3bqjgwBf9d+OCfHeVbcDpoB6Ag1W
         ZfCLtNYvztO1NLBZJCcfNprBgwvj4JQh5v7f9shzahLq2XQRx/Ff9+/gXHv/4E23xYtI
         CvxKTh7w46Jml9vLftN5kKTU6yDq+53qCakZ10R2MekI1RteeJ2UBAQJphXAN57kGJc8
         bnoMkO3u52vWLqDwZ3WF1pm6AhW28/fLufny7LBsOe+Sno5qaNhU91ex4ERUzeNKknke
         GEiy5N5S5iUXvBFz2jT8G4ukyorNaHn2LAiSdVPl6m1itfeoXJGh3Djh7CY5IanlDtyZ
         0h7g==
X-Forwarded-Encrypted: i=1; AL+hErGKY+gkBbN/rZO0A8pFnALrph0ggxu7xEpF0NHEIkwMBNZoLpoOy7V0dK3Y1rf/9jTEKYdZbPXEkQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+RB8FiGpCT9aWDVAfNj3Lr/Rdqfe7J75/9HFPwzRzgv1f/8iIL
	t/pMBuaRP87igAQ9mrzeM2/g0kJ6oL0i7/3s0xFzOnH9dzABRC0lrimf
X-Gm-Gg: AYBFou2EzzvKGaCDqvnNwywivTlemVKjWce0RfA6qVxt4wiIjw6LfoRmTQUBegPgX9P
	8UtS/wMwtg6ZOq33KdDVPqnHVhQPwgBny8GlFv1+049/suB8kBJJuNZqINxFc1lp3sKifeL85my
	ViqxmEK6k2tSMB64Ysi/V1NA1bGF4dt/RR4S8Jk/BTbdqQqXT7sSCIZ6ACUHOy7X2ORbQVx1Cl7
	tJ2nHXu7bEmHO6eZujftyveNM+i/5AuZqmuVULrvAdF0T3zZl2Yd42ddmVu9E2lbSsRio5kRLbW
	8Od1Dun0oayTr3Mnv48Hp8/+kY43IXWGwwenH089dY6nZ2yOc5imU7dNWZH6jJCW4ZBfzw5eQO4
	GV61QAUTA6RTLOoObsYc1hEUrgUXuMbeG2CGkSZkOM2llcY2pQt/SA9z/AAwpRtWHqvb0KscCcO
	FajtpOXU8fPJ5lJDHLH1oq9rFfYqCBcIhsYkBqGY7kaxnGCTd2sUWkZzVeMz/7umxPZwlHPNrFG
	rqIBjo9DSdnXXLYIEZHiJXzEa7QiEl6UVow0eJjzFiJCIMVGD6n2acs6YNT/ZiynW5Xs66kXgOg
	wETpcdh6MgIUVf53jiVJcxaMjBcxkfKVsMki5kHBOn+Ra2Jjo+IOlDWxS8SrgNx1Fw5cnwCcUpo
	WgKwmRxkFUkrSEPPWZxHjqPfmxgHY
X-Received: by 2002:a05:7300:b0aa:b0:36f:4d62:2884 with SMTP id 5a478bee46e88-36f7691a412mr3600161eec.30.1793978185868;
        Fri, 06 Nov 2026 07:16:25 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.221.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9ed126csm7581500eec.18.2026.11.06.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:24 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 06 Nov 2026 15:15:38 +0000
Subject: [PATCH v14 3/8] thermal/qcom/lmh: Switch to match data for SoC
 CPU-to-node mappings
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sm7250-v14-3-7d167e993f9c@gmail.com>
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Sreeshankar K <sreeshankar0910@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793978147; l=4409;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=nwH0k71RDFHMH21LAx9GvawuLoxMvflAeMTqII5xMG4=;
 b=9GEg6sCjo+Fw5z+URS3OWyPStxL54iUQB9zxVL+ED7z7plk4poxuPjsJg0fe2SUj1WrtGGXPB
 evpAQlKueAoDYKBDSbEHFGkU8bbJI8v1oalpbyXhlQL0bxSilhSdRJS
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

lmh_probe() hardcodes the mapping of logical CPU IDs to LMh
hardware cluster node IDs: CPU 0 maps to LMH_CLUSTER0_NODE_ID, and CPU 4
maps to LMH_CLUSTER1_NODE_ID.

This assumption only holds true for 4+4 big.LITTLE architectures like
SDM845 and SM8150. On platforms with asymmetric cluster layouts, such as
the 6+2 topology on SM7250 where the big cluster starts at logical CPU 6,
lmh_probe() fails with -EINVAL. Consequently, the second LMh node does
not register its interrupt domain, which in turn causes dependent drivers
like qcom-cpufreq-hw to fail or indefinitely defer probing via fw_devlink.

Address this by introducing a SoC descriptor structure (struct qcom_lmh_soc_data)
and an explicit mapping table (struct qcom_lmh_node_map) associated with of_device_id
match data. This encapsulates both the algorithm enable flags and the CPU-to-node
mappings per compatible string.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 73 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 99396b93e..e160ac477 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -94,19 +94,61 @@ static const struct irq_domain_ops lmh_irq_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+struct lmh_soc_map {
+	int cpu_id;
+	u32 node_id;
+};
+
+struct lmh_soc_data {
+	uintptr_t flags;
+	const struct lmh_soc_map *map;
+	size_t num_nodes;
+};
+
+static const struct lmh_soc_map sdm845_map[] = {
+	{ .cpu_id = 0, .node_id = LMH_CLUSTER0_NODE_ID },
+	{ .cpu_id = 4, .node_id = LMH_CLUSTER1_NODE_ID },
+};
+
+static const struct lmh_soc_data sdm845_data = {
+	.map = sdm845_map,
+	.num_nodes = ARRAY_SIZE(sdm845_map),
+	.flags = LMH_ENABLE_ALGOS,
+};
+
+static const struct lmh_soc_data sm8150_data = {
+	.map = sdm845_map,
+	.num_nodes = ARRAY_SIZE(sdm845_map),
+};
+
+static const struct of_device_id lmh_table[] = {
+	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_data },
+	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_data },
+	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lmh_table);
+
 static int lmh_probe(struct platform_device *pdev)
 {
+	const struct lmh_soc_data *soc_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *cpu_node;
 	struct lmh_hw_data *lmh_data;
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
 	unsigned int enable_alg;
+	bool found = false;
 	u32 node_id;
+	int i;
 
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	soc_data = of_device_get_match_data(dev);
+	if (!soc_data)
+		return -EINVAL;
+
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
 	if (!lmh_data)
 		return -ENOMEM;
@@ -139,24 +181,23 @@ static int lmh_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
-	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
-	 * of a dt match table.
-	 */
-	if (cpu_id == 0) {
-		node_id = LMH_CLUSTER0_NODE_ID;
-	} else if (cpu_id == 4) {
-		node_id = LMH_CLUSTER1_NODE_ID;
-	} else {
-		dev_err(dev, "Wrong CPU id associated with LMh node\n");
+	for (i = 0; i < soc_data->num_nodes; i++) {
+		if (cpu_id == soc_data->map[i].cpu_id) {
+			node_id = soc_data->map[i].node_id;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(dev, "Wrong CPU id %d associated with LMh node\n", cpu_id);
 		return -EINVAL;
 	}
 
 	if (!qcom_scm_lmh_dcvsh_available())
 		return -EINVAL;
 
-	enable_alg = (uintptr_t)of_device_get_match_data(dev);
+	enable_alg = soc_data->flags;
 
 	if (enable_alg) {
 		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
@@ -230,14 +271,6 @@ static int lmh_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id lmh_table[] = {
-	{ .compatible = "qcom,sc8180x-lmh", },
-	{ .compatible = "qcom,sdm845-lmh", .data = (void *)LMH_ENABLE_ALGOS},
-	{ .compatible = "qcom,sm8150-lmh", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, lmh_table);
-
 static struct platform_driver lmh_driver = {
 	.probe = lmh_probe,
 	.driver = {

-- 
2.43.0

