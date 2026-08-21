Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174642586F
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299999; cv=none; b=ZV/1BMHdPhjq5xpI4rcZ/e8S9IMvKfJT3oDaZLpf7h131CBeQsf28Emki+dEOiUB7QqKV3aMIjaYVoXkte/ZbWUVOdq6S9FWrHbylZHXJBirpmdIQwCNb9jW31DjAZ5Au819lJ5Ltl6izOsCsd12yKU1qv8f6uBq3injnvqr3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299999; c=relaxed/simple;
	bh=tl8CA4rO92JFIY1onO2td0Y/lwEd1GFGGF+FJg0LZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8X4AmcJtHgC+7FtsnoRNthNvgbiWgePXZZjGaafKC2ZSgwLC5NFkGE8t3eb5JioipyMSyQpxQKqgyUfaoea+M02Ffs70yaQoXFr5Jb+yFxaFQwrFeiANiRnDEUsgmvlelBrn/OetkmWc/CQg7+vk4A22kFhoUXF/d+2w3mdeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONySzn9Q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONySzn9Q"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso601673a91.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299998; x=1787904798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WL9wBLDLyR3Kmyj4eYH49sAL8oSps6Ww6VMxUCrieY=;
        b=ONySzn9Qoe/stJqsxPqed9cO5RnTwV19LT5SkLY1nBoX6n0xowFriYJDonjeuNkaZT
         nsSzPFxzYojg24SytFVcQainBFZoueX3KirlQ+lNKxFDYju1oxDa2GpFrZ2GULj9HbTh
         huGEXMInU1yAWELXesZWdw8LJUhC0ckDW+un7YBqWx8fj+Gg2v3GDs1WDM/rmTaWpPGK
         CLmqhnjVw4yrCK5XbY8OUWr/DaLHi2cAeMOshooiakEo87LexvSq0j7Oa2PR3E5wVG5O
         99Hg2JwnD6S26Y76GaXq70Lxui0WwxOZ1raaJLIN/cIJ0q11xtBZP9tlfUYnx787bTd2
         1uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299998; x=1787904798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WL9wBLDLyR3Kmyj4eYH49sAL8oSps6Ww6VMxUCrieY=;
        b=p0iolfMlxznlzx656CaqTBnoOg1mC+5KhwTjO3rSe6PvkCIGvwUs3VrDy6z7t7oxMn
         DTLJ3CrhqCFPjBkOXU5Ug2h1TM7uQunCLarWsINbQDgGjbR1k7hJq/5JQrsJNwiN/6be
         3It0yVXP94DpkMvu12ldhHdJ+y3XVLk2IJnz7yg0iQqBJCjbEIokfIIhhlRvAJXdjsB+
         hW9aEXSjsO9Dw9Q8Mtb5wV2gN+kAVsPiECT99o3V+Qlsyj78cYltNmStv77UQthdh9jK
         QWLkjRlgESAy74H84p+NMGmZd3N3tNQGPE+WGBYgPnVxHNhxRBOegbBXq7oXaF0xdxA4
         rL5w==
X-Forwarded-Encrypted: i=1; AHgh+Romz1IWHGHxdOSd3FGzw5FdsMqtY5O+K9hCd/uNnpxaCY72lgNOTSyjVcDE4nS51HJqE+lxrFd0DA==@vger.kernel.org
X-Gm-Message-State: AFuF++kKRK2ppk9y1m1V+QXVypstgAusiPfU8oLGEw5jpfVt/NM8rnZk
	JawP+HNGKVIMbvoJL9qJXjq3CJYcBbMwDw8WzKSuU1ugNIN4gHXJbWlN
X-Gm-Gg: AR+sD10ppiVkheCQRr/8h+sLCyvO+Nqdv1AV26Eo3qMorPuYitWCT8xYicddvTzqMvT
	dSn6eDenue8DiItlQYV7M1WTM3h+8A7VugKU3qp0yPyZzLOLfKh+fbkwMGfMiEk9l5mF5YHdiJ4
	x4hiZEPxVdy9dKsOeLBoQ2pHWn/DskBOLULL2S1ZGKopK/mwIVAZhF7gtx7/xlVbX8MP1DPjRbm
	qDkltaiQUCKPL0/aCUIjKDJfESC5YuJ/jIEvJy1qL3+5mueC1KWia5OCi5OjzmI1ZMVt84GL8Uv
	aKyaQk9T+Wy9foj4WETYo3FvAIfrJB4JBUuR/O7PyRWRI4+3d6wymFtYeDz2On4fPq0PjKZZlHq
	YXaH/eWI7v+kEVmWyMBqEtZb4aiiaJLaklVrQ4ykpCQY5DiqOZP4jYIaWjZN4RyNJAmiKGF3jrm
	J4o8veGcsAFmyFv5N62bnhFKhpZUfb7iM5+N1KVeuaK5FbfHj51yRnheeXUFMGkVEx+IGQDAbg/
	eqKFrE9Ftsv
X-Received: by 2002:a17:90b:384d:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395c386a056mr7511738a91.16.1787299998040;
        Fri, 21 Aug 2026 01:13:18 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:17 -0700 (PDT)
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
Subject: [PATCH v3 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains for SM7250
Date: Fri, 21 Aug 2026 08:11:20 +0000
Message-ID: <20260821081125.4522-9-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081125.4522-1-sreeshankar0910@gmail.com>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
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

