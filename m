Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2141F35C
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326917; cv=none; b=aYvJ2TBWF7JcpEGeOdVXbN3kfX+nqyIVxtQh2ZDftn4i/LFN0Y94Oj2IQSkz+GZ4uyFHdESKhNzMJrk54hScJBlaWQzfo6wkQKz6q6V7vKRoVSadWPgUiVIkf2qz9yM8yw15QcdiocF8o8sHuTlnpWeAcyPtVe9rpB+UBrK0bMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326917; c=relaxed/simple;
	bh=r2L4kMqfhwIbUzsmf8wdDtYuSEy+RrrvfwHFtyC9iAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUUBTJtuee8TvQVwunjA7rf4ccqDHjMK+bOIGoKj/AFFCzsclHtbLfMV/8ej/DRcCvwK6L/ngpbDxWTVD+Arx/OPVdg4Xf5Lx0S2WdrY97f87FpxdaaKqNm1Xyl2DNoZCICke06YahcZ5mafxB2hbs0hOq7vvLEPMwWYEtUjAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da4IX5jg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da4IX5jg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so1502624a91.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326915; x=1787931715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnjRied0UBQQezXmJ0yRlrcVs3eu3/u9Ou72/egKxFo=;
        b=da4IX5jg2ICPv4tKlrTWsXqUHy8yHMc0e4Af4iphB9Ox8tEyok/nvowc9Mh3wbbvzD
         1rEu5Kn43sFQO2za76nrneXizcaqfcNgZyWNhvE4+L3nZ2byxDQEA3YTV7hNQtSIbZZ4
         BLCfd6yJ1zEORopGns+6GJQFpVFDld/4oJ30+Pq1t9iV1fQg35F3dHSy5EddRkd0E2bo
         jux0Cu6d9ML/6cVLEvWKnTUGkFydObNuFsKlrBB/o33FCRr3Ntu8zhhOZzgDToV88/CX
         GOr3nusxu+WaE6V6psgtCyJFUHUl3Q9b0kBfht3cVe7VxmvWTTe19IJc4+/gb4drmoNw
         +57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326915; x=1787931715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bnjRied0UBQQezXmJ0yRlrcVs3eu3/u9Ou72/egKxFo=;
        b=M84NmXsJPm7OPSZzBj++WGrVm5Sa5+ErLact3fcE+p35zlclUGIwnX7Bikai9iTjzG
         39VVg7vpzat4GiOKD3HaeAQgOAzBjCeRsmaGgMIErszhG1nsu5yCMEMPJwvtsDbFKtov
         vg9zAWa93A7tayhxyJ7xsh6w+UpDlqDZim+b7x6bjHU2IMQ6PoqQc9e22uGjDPbg+64d
         FPihK7RqUXDeQ/0Ffi7i3keWAfOiwj0OB3fErlTW/VBY6dasqCjANAxlziyY41kFFCly
         oFfuPoe9wvpkaUd59jrGmi4y5sD8o8n5o19yLrjg4UTqx7iKbXgb7yTrGBXJo8clkA1N
         B9qg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9pQvf3Ee26mgv3q/IHWXrbJgnFxZQ8Jfy5OgsRiJYm6nWhxh9AmFXsxyj4xZSV0PWu9KC5ksMEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kYMjEkdXFSifIgfM1mbTw1spSfkIh0b6UCUuAvUVHACaE2lrBN
	am6YSFa5+6B3qPKEBxThA12jkmCe98HuBUZKguxcQRp5dppgoWjU0nag
X-Gm-Gg: AR+sD1308Ae/Wg/a6d7SjgdKdMlEdBn3F0R+zApxPHPzx/4GvgDDtUcunI6wkqzhGyi
	yk4hy/l0RJiN6K6xDFxbtUyvh1iVoDMcNob9T+GG6AxnXyrAeui/qIUV1VTKJnmhsAUrZ46IIFb
	/jNjjzLQJNBGHRwfnPlBp8y2vZP/0ClD9c1CPAtgnAURbP4qdtzJ/ny3I/Akm7hWEdCTb9m6J7k
	QXIM4fmEdXQSNcCEavX0TzlESeM9eDPHvp5VEcf6G1SclnaL6vo/W0ONcjqa7isDiQfkGec2Rny
	CdMr5k8ShNGuUK4ps4SPeIRK1jreVIqbfgtX5+a/VNX14MTQfmYOrC1Q53kniPPHcfTZvSUU7fE
	CaG/2s3zIlafQ62hBfMwErKs2SjpoARQTmcTJpMvroqV5rF+kbzXlgzbN1DK760SEtxCY1bvEKn
	R+6BVgEeNBDBTusDfYEZRKrwXARFfP6Drm1P4CnLprsF5unWsq6IHpAJrZ9MJsnX5ZYdbSCYJ8a
	H8DEKODf+n1
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-395c3718ee4mr14838683a91.8.1787326914537;
        Fri, 21 Aug 2026 08:41:54 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:41:54 -0700 (PDT)
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
Subject: [PATCH v4 06/13] clk: qcom: rpmh: Add SM7250 rpmh clocks
Date: Fri, 21 Aug 2026 15:40:23 +0000
Message-ID: <20260821154030.2514-7-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
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

