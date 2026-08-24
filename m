Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78488400DFA
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583810; cv=none; b=Kj0NA/DB4AFVhOZurmEbd2PnHGO8pyOiFWwWhhd7gW9PsQE7dD2GZKC5LVfPrLXpcpT1KK5VQ5iHAi+LG67rZq2bZkBIKpn5XhQw3nr4UzHGde6b+XilzEyYd4CXUxVDrVToatz984JWn38biDuoIfhDQJPJFfKVbS3IbYGzHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583810; c=relaxed/simple;
	bh=TdJ1z9fnJv9Cwe2UxdX0lSqEP6tGIURNZuGinVjnLHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsPLeim2dYiO9F1O+ljuADwxdWh2ptibINr04szu2QND89hgMNBJQdIFB0p1Zkev7pCPjnH8n21HPXcxroe5g7w/aUuvdrztAGQHE3RaqUwrjNmS5d+6y/sjDRidkzexlX9wKec7itVhJV7pQJY7FkxNmnxUgEnqORA9SxSJu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABP83f9g; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABP83f9g"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-448b69cfc6dso3394624fac.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583807; x=1788188607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/T4NeVLI2Q/E0biNa8b/pafq7wYXWTnIin5DSqXZ6bs=;
        b=ABP83f9gL/fb/JtarmdO76pXmUpwzaW1UcotOQUWydJ06+WS8RcIy615OqDjYW5S6E
         CHZifXaCfmzAvi/zEbw8w7i+DK55nr0kaD8805zROuqyPb3Bnfk6432CQWRsOEzcw543
         2zF4FGNd9WlO/06vOJDlIOBvgRBlh7zowqAC1b1r2x8YZZ3wWzoq7R+4SyGXoUhx/NxV
         tlo44+99QMJ2t83vG+tVIpAYozmqXXfif9/OF2OAJDwMXvsEXcUtj19eycoLtoWx9wsM
         IBYj3mWba81KruDIUKkxfvYnqMIXaYIrPUCUPfLgDDL6+R6GCdu630lBl5059OfVeVcS
         4c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583807; x=1788188607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/T4NeVLI2Q/E0biNa8b/pafq7wYXWTnIin5DSqXZ6bs=;
        b=ROARhlnsq4/ObUwbEOC6m9wCcsxc0NZfsSrMHgnxhevBURL2HbHBliaUSakIzxDdbg
         kBoZdQL5EnHfYLAOkjG+vXw0Idy736QMyTZP+FRZNpDEV9ld8LQuSl9EjHfZ1aKZAZKE
         nu5fmxp8Ze/9udRdmhqgBEXqxRQNW9CnGBUF6J105LHDIOFIhPPuQK24H3DoX3nptH/m
         udzjnq0EI+d1WunQwtqVZ9huds2TBV3+zCUBk2xY6vzEsG19gPikFW8jAwiyS1coBWR3
         1N3eM084DrqgoLSOvHujnjexbGEE1dKeMApCkp3tCDPoLZxjzDWTro/yIFbeC5MzCkE+
         eI7A==
X-Forwarded-Encrypted: i=1; AHgh+RphVoNR2ReZEMNDFAfNLWTLRcbSwp4VkSotlVFVw+HTIG4yc+iuKvvfwPyF0uAMpn3CL8Soubqmiw==@vger.kernel.org
X-Gm-Message-State: AFuF++m0w1yCPKfJekWCAviUhPP4YBlIfh58rYKC0HPcqeNMTfipiUBl
	OVQWuRWDGgPkF70NFNFnAlBYqQr3fv7TExrZWXOuC6AXPtRPsRi5BDh8
X-Gm-Gg: AR+sD131SEErIJHe6ekVaf39eKt7WAhDdEmZSCg0jtrbfMVw67wrBwCFTD3ZafDlaR/
	ZY6rZUl8G4SKwEO8xlpvj1nogL/z3Tu6vwhtQbubwE4Nwzz+WWh2YOTGK3xeV69S0v/m3r9lmwQ
	y/UhYGoe9AArRHUagiJGlTfDSoEnhUgJ1XxLq4v/DphJZsfD7UnSUkT8QlVhY6063JzsdkCKx9Q
	bWrOsCiSFlB5zMqeO6Zhd8mGyWWa2o+B8m14+0mqRh3baL8334qSwBvfDjg36G2ckPvCeedqhwA
	eoC1j1EeORc6/9JdlSRMJJZYe4XcvC1KsNMI1rt7yzXNWuR7TPXUFq67LKZSpBQncqtnCNngOoh
	ruGbqTBbO5WKVL7qmzvOd4VIkf9AqeZWXCHWtV7uOcQQeiJt4TYib1zy0zEk2LHu9zeuOFGOFqH
	JS7Y+JJrvf7Rg9mb+Rb2vyqU/gf5uk+DjvzzNgVeR8xKdBDjcDPJdboV+zT4SPDQOQyLCsk0etN
	KuFIA6XyuVh
X-Received: by 2002:a05:6820:4c82:b0:6b1:3496:9ab with SMTP id 006d021491bc7-6b1591a0a16mr27505315eaf.2.1787583807237;
        Mon, 24 Aug 2026 08:03:27 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:03:26 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v6 06/13] clk: qcom: rpmh: Add SM7250 rpmh clocks
Date: Mon, 24 Aug 2026 15:01:49 +0000
Message-ID: <20260824150156.1310-7-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the RPMH clocks present in SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 6367b2a5a..f4cafa274 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -1011,6 +1011,29 @@ static const struct clk_rpmh_desc clk_rpmh_hawi = {
 	.num_clks = ARRAY_SIZE(hawi_rpmh_clocks),
 };
 
+static struct clk_hw *sm7250_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &clk_rpmh_ln_bb_clk2_a2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_ln_bb_clk2_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_ln_bb_clk3_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_ln_bb_clk3_a2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_d.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_d_ao.hw,
+	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_d.hw,
+	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_d_ao.hw,
+	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_d.hw,
+	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_d_ao.hw,
+	[RPMH_RF_CLK4]		= &clk_rpmh_rf_clk4_d.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_rf_clk4_d_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm7250 = {
+	.clks = sm7250_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm7250_rpmh_clocks),
+};
+
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -1120,6 +1143,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
 	{ .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
 	{ .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
+	{ .compatible = "qcom,sm7250-rpmh-clk", .data = &clk_rpmh_sm7250},
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
-- 
2.43.0

