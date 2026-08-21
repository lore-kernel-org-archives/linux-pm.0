Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54D3750DB
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326937; cv=none; b=rrfDXG9eorRICm/VaArG3F0+oIXuXfEpNDYFgJQjQD8CQVekI990y3P6paAMFPzUay0yvy2P6CbIR91y+Xrx4bqBI4SYoDKhlGSOPS7OnPDjgiKNHIu4Av3OGrAM89iskCks9bwO1QI3o6iMZTwlNGspziNNRi8ZXGH/zKjRCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326937; c=relaxed/simple;
	bh=tl8CA4rO92JFIY1onO2td0Y/lwEd1GFGGF+FJg0LZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQFy/uBmBtk8z3KNSWJoGrULfGmCvva691USihmm8oj28y9KTMOFTT4LhWRYoptTUE86iJKum20bZF0hxczde6Q+TlnFGNCzpD7SYhuo1eUlYD5rDqX8rkEWRlUHPQyotUCxG2TpfYlDx2bwPagpk0rqVsrD5//exVflnWEf39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUdno89Z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUdno89Z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1424090a91.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326936; x=1787931736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WL9wBLDLyR3Kmyj4eYH49sAL8oSps6Ww6VMxUCrieY=;
        b=ZUdno89Z0Mx1jozhvrp+opkWT3J+9EVlf9iTlU6thcG29Od+LiLH0Wvy+Df5YcLEu8
         odElmPglDW2SdbIVcpyCifTBd7swLKsl/PohjRr3VGZ/57nXSHXjsBx2UDFbp8Mgjoxa
         ouxPdtnf5AeU1TNlr87LUiQHWJ31k2XrRFR5z1MQCVyxdmK36W0obEGdn/F2rblRkd8W
         Rjd75t6M2R9E0n9U/sCg5qzeapDnKLBBVY8RDxHTNdr6Sh+tsLz1NWpL8huIG7rNgLNZ
         3xUjxjBAf31uFC+WSceJgohYXSG8eJyiWj0Hfhp0haus0bGiOWivRSRT2gkKFof8hikm
         7fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326936; x=1787931736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WL9wBLDLyR3Kmyj4eYH49sAL8oSps6Ww6VMxUCrieY=;
        b=NdpBNkCq01OlqP9XeEBqe9Zdl7miluKDyRG5Y/7NZYVViXE1L+NtWfi/rgCjZAZzUn
         9drRlInTWVqH7a3eDraTPSfJk4/jUxtBfi57jG5HGuo0xD9W4B/qxUjLUG71dWsOhP2m
         xFTHI0AucMEER3L7gqP1NwrONKx2p0XpaZ1i53h7K0m2vvD8RASICfibmjbgJiCFQyb7
         jZJ766utGSnHAh2fRbHHfESxlzotM3rrOGfSMk6JNctHKmdYmX+OltyuaS6aBwCfGKRL
         9SUyo1OsJS9JzRY643Jqffsvj00fgezuaT2DQ8kABkE+dDyZM4yFh/PLOKEEYcLq+uXb
         3bSg==
X-Forwarded-Encrypted: i=1; AHgh+RoxAEd7DViMqEEzWoql/5tJfXUEtjYZzVLyzX93Z1eOiA+Cez2gSvhYdUkLEcI9LDWaZwEKbpVPLw==@vger.kernel.org
X-Gm-Message-State: AFuF++lrNY49Finzj4h7950eyl7bkYlkXknVe2yTmjKmz7sAQHamvnOi
	g4b6XsVlGVivuLIt21X6qm+E1zJOwMrVroYRkLNXJhGU2m4+nfZXiKhu
X-Gm-Gg: AR+sD12K+upSgzywuviF1KZ8CVZ7yyiWkWYPHjAxB6ntjeUfyqOdLdyx4g6CIzf+EJ0
	Lc6SDHC50/eYW+23oFDAYsWt/+TBMLinC2isd68LnPh8vlhw8kqxUrhVa5hukRrFUt69Lmq2MWk
	dZ7ffpYlJTgQ2HfYgBiamuOwhXhIDNGNtWeraz4+G09ol6PjQT+9cHOmalxmbN6RQfPwmkeyRgS
	9ZJ0ZLhoozG1E0grUJLUcF6cHRBs3urow2oJ1XCqHHbQ58lh0JrxewaC3UQDDeOWZHIp4hroavq
	mMh8QFqy9LXEAukHDp0QHIPkG4zMeEIxxIGgUioUrbtVm3eDOfBrJFp4Ed4urcpLKSxId5IB2F+
	3movk3mP0vh5Bsl/Br8y9wchkBdIOvfzWlx6CC1YTPsX5HULTUwljNgkZI4QOoWEn7Wv5R0Ev4l
	jCG3R/Az8tKqnODDVWRNynzXuACvAt1eTmdmBjr3uGxrCCVx0tFyuFtslXf7ads+4PWglDMp6Ni
	wbEbqB5NWBk
X-Received: by 2002:a17:90b:5347:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-395c3a4bd22mr14090197a91.14.1787326934261;
        Fri, 21 Aug 2026 08:42:14 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:42:13 -0700 (PDT)
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
Subject: [PATCH v4 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains for SM7250
Date: Fri, 21 Aug 2026 15:40:25 +0000
Message-ID: <20260821154030.2514-9-sreeshankar0910@gmail.com>
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

