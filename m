Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56A420479
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576787; cv=none; b=btlrAln/xFii5Ll6uJAHHh8zgcCPoarxvQ97lZ9WvgYp3FDapzrA87CX45+ZrQ+1C/q544LiVBtKHFOU+2fh4XgrczYm90OHjIaspL2BSBZmLn1S+WQe11IBlzJe8cahNyKD8C11/kesqMxl/z48312l0Vbb2e+BntDeiSIhBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576787; c=relaxed/simple;
	bh=9Rs+ll41NKEFlOm3FoL6ceFLLpdJXgRekcTbFNLh3NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAn8MfaG+WmPRkqpUpA6hewbYz0hTbXBvZkqbmKsyNqs3qlhZw8I/o4yqj1/SYVdwnShIeKun6P9LfId5z0UEXn7i3SHQWp/AHOmKNY7RLmdbANf1e4oK24ebN8r6U71pbIWQTf00a9UELClU6VNh7qvnjZ1C2kUFIWefD2yI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qum1La/7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qum1La/7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so27771715ad.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576785; x=1788181585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=leXltbiOaTHy4a8AzjEvY38i+F2Jzsbl2HWjNkp0y+k=;
        b=qum1La/7h9/4tapE+kuH/r/Yo0F1th/ZMtHB6IzU7oEXgLm+xDhlmHShgbzIm+hjV0
         SBCSEhtR7mvxnJMCtDq6d+QVbnmoIKUyCbiu/NZC26DvBZThkqM5KEUaRQ3RFo74PG3H
         7jUJxtxYdbTjqc+GyKI6ve9bZd68/OYLm3QwSnlW1WO6tVFUko4i7PNG+kjcqUW5EVYJ
         Y9/Ck/rZqxwPc4vybvAGG5UCMUahIh05QDbTwFjwgL6Idlf769q66eKg/ZsUjhnkca/8
         tFGDnZ26H/MxzoaigCUAj/VxtPEQbnPzFh0DW0mf8XesmMbPp44x2Rxb3QFyC/52wLZP
         cU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576785; x=1788181585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=leXltbiOaTHy4a8AzjEvY38i+F2Jzsbl2HWjNkp0y+k=;
        b=mkBybxSg4ZCEChg5VdHz0RQ3rNFvusUIkb/WPFM2/leHceBtCXUlMAeoALvfEOf1eb
         GFw7/OQC6EpN347HlSlhfqZsKW3uIpa/WIc3qQOivR+AuBUX8Cw2t+buD4u5GwE+Hvc2
         JysWh70NiO9wyWzIVLnnhKy/QsdH7vKAA1+W34hKi7nLDl1K9npCwHbeK24PyMNtSz9F
         SE0USJhBBxKZj50YqQi6HNJlR5onytUmra1oh5vkLKUCcNdky1aHxAZkDon7G24J635h
         gC69U58Vb8M+daSdHS8mp6ZMrB6G2IdwSDXuh6sGjvCwfwdBKP4zCFeAro7/nwSVrCqy
         nstQ==
X-Forwarded-Encrypted: i=1; AHgh+RodJGCMhsnuW1EpH3kMeK7UySoy5+HSUMT38c3MRb3XBTDqECdsBRfl18JkY1VJ9XLO1SZjcqS86A==@vger.kernel.org
X-Gm-Message-State: AFuF++m2viykairsqyIFqF7OfwTVAb0+jU2oha0w3EblptPH8p9AUxHC
	qHm2ZX5c5dJIiGRqG0aBLL8grzO8g3vg8sq449nIDhUUIb8Dt7i4/hZm
X-Gm-Gg: AR+sD13PTvvj0doZZ1oXr8qGbLH+XVJnbXRRByvUzQxSMskThTBddz6PTene/9S2sNV
	Uan/tXB4gQfmFoasg71NAyMUzDklZ6EhiM7JjuLPfj1ERZMAa8RcMxHW1kBZeSJmb7eADeEG0pO
	psDbkA6VZg8I/nPrgeweLmdVrdcmGZhbCN7R02foSwhbUSLWJuYeIChwhfTPva47HjD1xKsf3uu
	j4anG6eo7R8moCdaIH6X+W+HNMeHAPg98ts/aB4dN2QAxQsVTo87eiGJxDJhHn8Rpii0TiF1LWn
	uXxXLAd9JKPpE4BDtVxVX4UuPIR0BNebBTOAl7cAI94TkfuB2xAJCbTzOv1uw8+hpmjboj+4nrM
	KKr7A0jG8C4ytCmRerL90b57VGgNCky1IMhOruZIA44ExF2bsf0nsFdYtO4sxeZxqng9OqE1uxQ
	r3xIMp/N13MTD0EX1WBnkS0V7LsdAsxfORbdwncRMrO4+KNm+Wle/WujVuDVu/JIIGQidSrU6Az
	3JO643M4My5
X-Received: by 2002:a17:903:2ec8:b0:2ca:e62c:9e96 with SMTP id d9443c01a7336-2d670b9ba58mr347409935ad.5.1787576785252;
        Mon, 24 Aug 2026 06:06:25 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:06:24 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v5 08/13] pmdomain: qcom: rpmhpd: Add RPMh power domains for SM7250
Date: Mon, 24 Aug 2026 13:04:32 +0000
Message-ID: <20260824130437.2771-9-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824130437.2771-1-sreeshankar0910@gmail.com>
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RPMh power domains for SM7250 SoC.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5..70d0ff5cc 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -490,6 +490,24 @@ static const struct rpmhpd_desc sm7150_desc = {
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
@@ -910,6 +928,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm4450-rpmhpd", .data = &sm4450_desc },
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
+	{ .compatible = "qcom,sm7250-rpmhpd", .data = &sm7250_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
-- 
2.43.0

