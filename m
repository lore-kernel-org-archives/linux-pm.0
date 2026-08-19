Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E8480DC3
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153237; cv=none; b=dJaxk6ntj9DUMprfudgR5c5RxgDDAUpyt4TnUHOOcH5PXjyI3dqOhPo+MR1igUWSJO2Ub4NEaV2lSKFVz1riSUwCwg8ZQk7TvSuC91ah5pyRUzle6niQfTYhQKbELu1IIov6SWm1nQ6Bon+cIWQdU7pT7jDEVw4h/+IcGbLHWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153237; c=relaxed/simple;
	bh=r2L4kMqfhwIbUzsmf8wdDtYuSEy+RrrvfwHFtyC9iAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhWHAXdE7OB7YIJ+nfS2S86ZDmF1PwQgZXLbw9O+4Pj1bcrB/HJmul4ao3E22jwp1acULtNm4GLxUu1aSlJLDn6v5td+vvqxin2zOaUhx1teTvJ5yXDXOBYiO2feLzXNfDeBr/hiVqQHGh1Mzm96Tc3lar8bZBJvQLQICN3P5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCFBLsi8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCFBLsi8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso13473915ad.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153235; x=1787758035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnjRied0UBQQezXmJ0yRlrcVs3eu3/u9Ou72/egKxFo=;
        b=PCFBLsi8awi6Q8j44NLojEz4aVqQD88/ZtO0jSHG0DerV8n4qT/SmRYISk/KmwybZc
         EANW5HV1jwHUi8238ne/cXMQiOW4XjPa2mkcIfZ0mToNXaYWXin5PiikRYIxit9flOlz
         ftmdzXiGWeN/tkigKbxaRLkmSlCFdB3hkc3AilxriJTiD2RJJ5dpHyucFN2Z9pVNuMk5
         d2jByGd/kjfwRooDjYxWPqOQwWXAGygIYNBJ54IPQ3qC1oXkkAx3GZaMvWtA75k5sVWV
         2Vws1jsaaH/jtQXEVkRrjy16EORdoqXLP9YZWaF5OsGc/LJhm1cyZxhgbtIfUDIy3NuF
         8a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153235; x=1787758035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bnjRied0UBQQezXmJ0yRlrcVs3eu3/u9Ou72/egKxFo=;
        b=IeXMrUfFbFoeiFq1x9tqW+JlDXFKFFbWjhKZlLwzvUHsnYv3pbLHh4kBT5EyP/OrOc
         0s51wPFOeTUxaFO4pm2WNWN2lm0NEPz3PZAKPSiP7CDlX9TRAg07pJwdgrPFpaCM8JlH
         fjXC5WzNeCWNtw+yFYMhqVXMDCk7+UvTQ5K1EzyCn91n0ektiV7pdkzWuuhHoHCGgH+d
         /jiK39wNLe+NY7bDlOjvzVlnF4gA/lpVCJTMGClHkeqxIoVXB1la72wy4HTqCu3QJTYv
         Uxa/FuHzmgvwbrt23I9cATrmdYXr0ezpeO+aGi77r33VhSHIg+c6gaObHIQN7siyf7CG
         DnNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5J68hjgl2wzXKoO/uaCyU6dV7ZG4Z0bKiUsepTTSRq3uL2quXhejjn9DeAEmF5holdJQIwQ4mqg==@vger.kernel.org
X-Gm-Message-State: AFuF++kPCdgl9NIEqJ1sg8nvb3QkBoSBPKjgNJ3iVm6Aqs6sJsmpK4wK
	efXsaLq1kXGolm8atUk51tMxHI/WNDm1AA+8Oxwp0JX+yKgDvLH5wWbu
X-Gm-Gg: AR+sD10yYLDf9+fKbLJWdiBvb4m3Y0gwmwhWPlr3UUvtM5dLk7oMmsqdN+lZ9c2babw
	JwW9G3N1bglzlxGfZ0cY+sLQNpTA7mrqvLpatE2LLOKhsY4rwWn+YDgyAkxXM+jhdDOC8MnQu3p
	uzPLmRZLXQR3qp6aTtcGRdAANVz9lasImFrt4kOpWFb+ceM3q3dFI8VzsyYsfSwqKiJuuNG9tLB
	LbD26Q0BSta4XFkmzPESKLEtHC5KWAQHR0etkTcfJ7wEf8JIvqPR92cy1+RxNKqh7XLDPizDRXA
	ZKjm7VmtyQj4bnN7Vw6VIjv3SDbKzqsp/aWsCfKqFXrZav6QHRBA6MzeBlncmZ5Fzk7EMblcMLV
	yKtdrn++qMdHRTvrV/o2yRqeutPyw2pLqWcJNkAVqKfltMGHDWmkjtrfrD3KQlKBJJ8gf2RHBDY
	krUmKxJhiwIBNxq5HLTLr/xw4F+0qutd0xBLXlDojg3HDhsYRnOhtObJnRfZip+EItB6QtNgm8F
	IAmoXfdzn8=
X-Received: by 2002:a17:903:2f92:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2d5fd59f9e4mr96094215ad.3.1787153235048;
        Wed, 19 Aug 2026 08:27:15 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:27:14 -0700 (PDT)
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
	quic_tdas@quicinc.com,
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 06/13] clk: qcom: rpmh: Add SM7250 rpmh clocks
Date: Wed, 19 Aug 2026 15:25:35 +0000
Message-ID: <20260819152545.3934-7-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819152545.3934-1-sreeshankar0910@gmail.com>
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
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

