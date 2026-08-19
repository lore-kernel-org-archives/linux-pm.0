Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359C480952
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153256; cv=none; b=MypisagI1ZY1TvE466Gc+8DqtQBIOmEgkT+8msKtPYjUdBBRAJJ3NCknFYX+JF5+Yv1u+Q50Tkz463EzEdL5wsGOymvd/XtB2H/lp4mEdy9mwyM3E5p9xxO2ao6mP5twIPu9/Y/85Svh4zCZpecP4m/kvSas4TMpWHGZ97GP4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153256; c=relaxed/simple;
	bh=bObMEgQbwlymBnP5r1sUX2Gi8xAR5lTxrs70cVwI4ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFb5xxsqi1It+o1bcKlAYaP9tapG5Yel70dG0Zbji7I8Nb7ug59cPu4CPsE9I3UGCY57Ga0Sf65FEtB3T0Hcgm4fXKqtErynenlWjGs2irgDsfBeQt9H6EEIFc1xoHN0+ZU1C16S5cyqo2DKDtfTsENZxhMcy1wWCCBMrLp9OxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao7OX9xu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao7OX9xu"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1555828a91.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153255; x=1787758055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vegrD4saB72brBgKM+q7YCK2Xn3FRCR7Y0DoP1meQyA=;
        b=ao7OX9xuA0alWXELa2DGCMDg1WlllKbYAiOe9bHjgMBV5/45OzDKhj2hTAXnN+b3de
         Tp2pTnDa4O8gsp8MkZE3OFDFmplYSA6heYBB+tcKijuKbYC5yAT/AfpJBS0JRDKe3n9s
         70pdEAyWYm50SDq/XfsEHxc0LGssDwUUrsnlpIvDPe4HAc2zxOerM2micufCxjwooTwq
         mEKPcS9pxR7TpkvpcuHiKnWktQNTPhehGONXMkoQta2l2KKsL+auzo6XJ8oOsQHoHvU1
         svM2F5UpX51Ku73lipe4LsXjCro+adOiUNfPF9OJFIJqZUN/mw97x+Xz2F73+lv4cOMp
         DmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153255; x=1787758055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vegrD4saB72brBgKM+q7YCK2Xn3FRCR7Y0DoP1meQyA=;
        b=PHOSIR/1YP99BzwB42InNQch4Lh8sgLUipcJefgbyDIMGTW3oYxYveXzUfsGXswwVJ
         ymt66cv8mVGMv805qweeED3QPWl03bNKBuMyd4kOv5ur4VzSuRkFcLI1DFqaEYL+OFht
         C437X2xeIRQRRPmlm+/rXXYCraW0FRKedjRgcBVY0p9w2AkN8S3j4DZSGavcT8QB7QGd
         7YmPfvLMYbPOK9czoEHnCczXfCzn0tit/i4eJyoaPR5yx7a4zz5TtDxhWayzMPv/LGuP
         36FxVPfqrB3o9la5Fa/Wh3yHU+j3gOTekLi9mMPXP3ASLT0HxY7++O3HAc9usPfAZ/Hr
         O8mg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8UFQubswHhEkT8B7VKdBuSR/bz9SclmhVg5OraS+tpy7eOixkU3CfxwEq3H0OgWPu9W8CS+jCHw==@vger.kernel.org
X-Gm-Message-State: AFuF++m72RZJ0SRF08Rn5zw3GqOPrOqpg04rK7J6m9kLntAjoGVxa++j
	5L/BGaa7SuTRz2S4wUDtEKz7UoJSviIeJyKzqN/v+exKxStIYKek9oW3
X-Gm-Gg: AR+sD11wwKJW9WxHGVY/aMPKLF7hlCEO73zKAFiu8vJUBa0Ri2gQYRpdwRgHy2jFFp4
	xN9yCj61JIia8xqePVUTkJtkydUPSU/7O2YyCaPj6k9fAPt7LMlV3biVPB3o2q5xUJOPbXPO9b0
	80ROtOTtfTNKRHZK2viT1qyfGgdb2oWfaSP+l3vUZnziq4PRtvq8wGp37ZkF7COlWrShadhsk21
	VgSUxGGvSwPq0LiGjBVUrQnT8wyFHaiVqRJP/qQQnjGppagnchcMGPXHasmgMKjIG1b7wGRHzoC
	1pY4fFKLKHKqaNnuDIukK+45PAbokPulgfna3rK5Bnsfn9Pjy+o3Xu1/mvmMe5h70YlYMFV2hlF
	AsFBBXrhG1sbk2FXCpMjMx9daRwIKtTY+V3+k7qngVVKycN0nlhWon8lVkqa9fZpEJpoxgsbOuu
	9uVUzWmjaRLkbYBDWjrOlCMlf8ggZqLYyiR5uasNKcUR+l9YNDft8yIYxwIrLXRy14tKTtBxOxR
	jDu60fKfKw=
X-Received: by 2002:a17:90b:2d8d:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-39581252d0fmr10279183a91.13.1787153254754;
        Wed, 19 Aug 2026 08:27:34 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:27:34 -0700 (PDT)
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
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v2 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains for SM7250
Date: Wed, 19 Aug 2026 15:25:37 +0000
Message-ID: <20260819152545.3934-9-sreeshankar0910@gmail.com>
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

Add RMPh power domains for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index ffc46de8d..6f4bd6b53 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -494,6 +494,24 @@ static const struct rpmhpd_desc sm7150_desc = {
 	.num_pds = ARRAY_SIZE(sm7150_rpmhpds),
 };
 
+/* SM7250 RPMH powerdomains */
+static struct rpmhpd *sm7250_rpmhpds[] = {
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+};
+
+static const struct rpmhpd_desc sm7250_desc = {
+	.rpmhpds = sm7250_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm7250_rpmhpds),
+};
+
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
 	[SM8150_CX] = &cx_w_mx_parent,
@@ -914,6 +932,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm4450-rpmhpd", .data = &sm4450_desc },
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
+	{ .compatible = "qcom,sm7250-rpmhpd", .data = &sm7250_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
-- 
2.43.0

