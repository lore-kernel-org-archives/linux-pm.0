Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE32E11C7
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372396; cv=none; b=Dqg6pzzFjPllAG7ioDLX0dbdzbbXnGwXcZY8y3WWMOZTRafCaiyxUeQaxYN21VRnl0KUddFoRROo+m4UoZVQuwEr+OlIujXuZsYqRghigcHGFd9RVT9YbS1AvpBgAGF2Y9JuNWNDncq4GX75C7/ki0ZG9LgciUihx7r0jy3qXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372396; c=relaxed/simple;
	bh=2fruTuJGgso+AVSjN86SFOWYtIxEi2oXmlzdSiu8LiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWTYRcNCB46HB8Ftlvrd/6RzTtrTaOfeDBdTY6+lPL0/8EyVpP56gg6Pwj4vZdQcJiq7UhBqJjjMGzBCW0Zj4qTFqhbRdDF15jP3l0DMpHAdYJ6b+TneSL7BvldEO4lpyxWZk8Ux+nIWTB6dPujC3Wjj2EN3WRamr1lZbv3OyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZb3c1U4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDQ08mDe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZb3c1U4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDQ08mDe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99kID3343474
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c4wgPZzl341OGf2dUgGOsYttbVFxmjqeXYFCtkA02/8=; b=DZb3c1U4hANrkUez
	MWm5LxJ7zfcX6bniI46n54ufgbPmzvvoR52OhokQlOP1Qkq2MIcvAg/j4b3itzPS
	d7YoJmcMb/RvrRwDWtAmIcrOCRiNB/ehC/1zaHlXQa0tA0498pLdSr/jOhpiLzWo
	+sz9PLV9/43EZ0TUq1csNxUlbhcPdOSbK2ejTnDyTOq+2Fh6KnqHjiA/SjQ7H/mb
	6nCu1bhl+S+RVkw1fFGJhqbPYgtGmdyUrYcH1ycoh1GgaQUkx1HyLOh/3atyDztN
	bMtkzAbvEfGVqWs7AYpbSsfFtbRZpvS8Eau2IfPSmsxN+zoszwbz4RxfKepZGhlD
	CeGkxg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahsnx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:06:32 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7c027fb7a62so61763257b3.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372392; x=1779977192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4wgPZzl341OGf2dUgGOsYttbVFxmjqeXYFCtkA02/8=;
        b=XDQ08mDesHFURKb/KLTJw9D0fsLKcheWKC5NCgUzswOJX7PB7offQsmhUDWF2hOdkg
         zZoLHifLXPCUJaNDuzCn94Mqjw4FOmovzBxcnwe0iIn2zMDthNK33sRi/EjPdyDyGinT
         NsFuXuTZYN+RcExp89J5TQz3pQWEX09q4a1ZlKmRX3udispAV+Uguo7qaPmZU7duunAL
         yhOuqGrSfWWycdIwTspCAKtKoll7S5sLkGYJoekkY+CvwINq67KYzxMszE6dS3nUgd2k
         mxRRKT0u6hhWEhzpeh7OP6kXp/LmXeBccD8hKgW+JigNhYCATqve+37lHn9zuh0bfeqt
         vMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372392; x=1779977192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4wgPZzl341OGf2dUgGOsYttbVFxmjqeXYFCtkA02/8=;
        b=lcS0fpVKOUAjPNkeorOzQ60R5B20EztvwdrlVt++CNi1Bki3GVZb6eL4pocS+Qia9q
         kARe1WZkJqpjpIDsMxYRBdGCu5HuujSwBtGqSXcw1G8LS6VtmsGUc0Yn5oe8gtGYs9Dr
         33Y9zo1Ig2dvaBqrfXGYTpvHcyb4bm8tILwBHXoWtoX8uTak3SJr1yyhD9AVz50UjE3e
         bDCme7bXAttvWAkkUUXFE5vy+d6726l/hd7c2SSiEdTA73O+RQO25UPdSCU2NU3FsgIg
         rl04aP9VZDHZWxaSlEegxqYU5MobRidFS7X2asSfc7R1uuaURyKGn0ab5VKVvMGFGWUA
         DYcg==
X-Forwarded-Encrypted: i=1; AFNElJ9dPgzngP8Z4uhWQqkrpWhPWzIaIv711WKl0GofSNOexyIAdiw0o9Le2EGiNCjgc9565FtzJYXb/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMlgGsoY0TJHLDYAOjcYjsJYLqXXdq8axuhunjRW/nrCrsErl
	KiofbjSknmatsW5KwFvKd3mSIcDcC0ybiGHFxx86yybTP0y9YD/RU32zCtlRARvLl9UuB3ADVqO
	5x2KCNCyiZ/l7XFaBRWvDXuzK/7NBiEbIvpI/5nmRf/uX7LVtnCGn1QGiEVLBAw==
X-Gm-Gg: Acq92OH1qou5zFPsP0WSdC2ZyMsoSUnUwEwZuSrE2bKZ5D2q/sJun9hwg/TTbPAPAeh
	k69hNfImFOq1BLEaVZNheJ7J2gFRg5s09fOqebTrc7P+BXcAg5qzNz7cBPF+QB1TzeScQRCDDjS
	9QAwJnV3gaNNyD2A2BSwQbXWuKinL5GUyZmivCbWXTgHTRUvgD7UHl7zqHiFgOVqXQWTPkmohbs
	0HAxTlBNgMUDiH/kENDyiy9D8Tgcbgb6+GI4YoypOoaAsg4jHeaFClA4YBdVWKN71ZLarQT14++
	XqlsrA/AfByKV9HFhLWFsywGHqCtaiDFA8hGZ7+2PPntIIDyPUafCqU2/8yjyVjy+kPuAgW5B8s
	vJ2sAmKqkK/6UyQJTLnpoBlrZNAmCJxjypU/JXOL59rwwyNgea+wl
X-Received: by 2002:a05:690c:6213:b0:7cf:d9bc:808b with SMTP id 00721157ae682-7d20c940a74mr29415897b3.23.1779372391665;
        Thu, 21 May 2026 07:06:31 -0700 (PDT)
X-Received: by 2002:a05:690c:6213:b0:7cf:d9bc:808b with SMTP id 00721157ae682-7d20c940a74mr29415057b3.23.1779372391070;
        Thu, 21 May 2026 07:06:31 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2cab7a5f9sm2920677b3.39.2026.05.21.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:06:30 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:36:05 +0530
Subject: [PATCH v3 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-shikra-cpufreq-scaling-v3-2-883c13d1e514@oss.qualcomm.com>
References: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
In-Reply-To: <20260521-shikra-cpufreq-scaling-v3-0-883c13d1e514@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfX8B21QigwtgEa
 YqDd7tZQkTAMR677c/ZVsxygR8AamQS1JjnyLbhvKB+9Fk1WPlHj8g0ulzC4xqhDC8sF6Z4cKhb
 Usu97vO4g01Q2Yy6aTfWLy67tHumE44Ycayajv5EPkhOYvf+HOrSKs2E5Dvfa3n/d0Sov0wUxXQ
 e9ggrzoXbiRsyzn8UwwBHmojWfjAqIc+BHgXXI9Q2ZeWoCExBPqm4Sw9mRVRV5wZamUkYf54L/F
 kmsfqN0STdiyQYCCPDkj/OHlYYg+V0rLzsE8S40MPfvrUJ7H4ANlpxkEDnYZS7jpXMJnCLm42P5
 4aYuiQJ5tpRQ6/Gzd0mLz4bWFY01XtqF0htCqHEWC5hMn62P1XI7OMAgrjYZ6OIRCjNcT/Xi/qB
 DC4K7kvzs6c4Uh42+7+pDmeL6RsoV2C6+QuvvXWBjsZC5xOOCRUMW8xwEDJ/nUuI9aKRtZNLQ4t
 hFHlKf4aU9QnLRXiLSQ==
X-Proofpoint-ORIG-GUID: pg78WcSEveTUfv5E_3vmy6dr-_yP7Iwo
X-Proofpoint-GUID: pg78WcSEveTUfv5E_3vmy6dr-_yP7Iwo
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f1168 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=8xPgF8R1Jm-cxLKBqHoA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210142

From: Taniya Das <taniya.das@oss.qualcomm.com>

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. When all
12 entries are populated, the existing repetitive LUT entry check may read
beyond valid entries and expose incorrect frequencies. Hence, introduce
shikra_epss_soc_data that reuses EPSS configuration with appropriate LUT
entries limit.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8fdceb9341ee53e5fa27b7a6d92483..3d5a865fb8a35e112cb4d040fb519e2c122a91dc 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bitfield.h>
@@ -40,6 +41,7 @@ struct qcom_cpufreq_soc_data {
 	u32 reg_intr_clr;
 	u32 reg_current_vote;
 	u32 reg_perf_state;
+	u32 lut_max_entries;
 	u8 lut_row_size;
 };
 
@@ -156,7 +158,7 @@ static unsigned int qcom_cpufreq_get_freq(struct cpufreq_policy *policy)
 	soc_data = qcom_cpufreq.soc_data;
 
 	index = readl_relaxed(data->base + soc_data->reg_perf_state);
-	index = min(index, LUT_MAX_ENTRIES - 1);
+	index = min(index, soc_data->lut_max_entries - 1);
 
 	return policy->freq_table[index].frequency;
 }
@@ -211,7 +213,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	struct qcom_cpufreq_data *drv_data = policy->driver_data;
 	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 
-	table = kzalloc_objs(*table, LUT_MAX_ENTRIES + 1);
+	table = kzalloc_objs(*table, soc_data->lut_max_entries + 1);
 	if (!table)
 		return -ENOMEM;
 
@@ -236,7 +238,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 		icc_scaling_enabled = false;
 	}
 
-	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+	for (i = 0; i < soc_data->lut_max_entries; i++) {
 		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
 				      i * soc_data->lut_row_size);
 		src = FIELD_GET(LUT_SRC, data);
@@ -405,6 +407,7 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_current_vote = 0x704,
 	.reg_perf_state = 0x920,
 	.lut_row_size = 32,
+	.lut_max_entries = LUT_MAX_ENTRIES,
 };
 
 static const struct qcom_cpufreq_soc_data epss_soc_data = {
@@ -416,11 +419,25 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
 	.reg_intr_clr = 0x308,
 	.reg_perf_state = 0x320,
 	.lut_row_size = 4,
+	.lut_max_entries = LUT_MAX_ENTRIES,
+};
+
+static const struct qcom_cpufreq_soc_data shikra_epss_soc_data = {
+	.reg_enable = 0x0,
+	.reg_domain_state = 0x20,
+	.reg_dcvs_ctrl = 0xb0,
+	.reg_freq_lut = 0x100,
+	.reg_volt_lut = 0x200,
+	.reg_intr_clr = 0x308,
+	.reg_perf_state = 0x320,
+	.lut_row_size = 4,
+	.lut_max_entries = 12,
 };
 
 static const struct of_device_id qcom_cpufreq_hw_match[] = {
 	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
 	{ .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
+	{ .compatible = "qcom,shikra-epss", .data = &shikra_epss_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);

-- 
2.34.1

