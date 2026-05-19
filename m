Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E053233E8
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211703; cv=none; b=q222w9au6msDlzbvH4QK1Oafh95r+bvbCYEteOgMZGhT1tYdbPC38wGQuM+5AZF92KkuLJEQpmXDypjvAinTOVBL7tPl7BZXn+Wwya8mQcsrygzTy6IEV3WYSnYTVytVTeUl9aiaoE5KDXS2WJb5XQQ5PqbGMtCsj4cRhogxw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211703; c=relaxed/simple;
	bh=1yBdAUWZ2RKuPPPpZ3gE4i9xp5AOnwnF0bUiJcBHalI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUzTjA5Wx20dKgFH3YjR+A6AHCMfx7VsM186Au6enFX7KZygB7WSPon7LlSCtZKYHz4kyjQMhsq4Fbcv9N3lGXaOokUiH4GWoqFA+rXJ+EuX/CBY5On67mGhmEMUB/PDwdtmiDaBlIhV43PxdHHGpCaaMcWtZGlYYTfpZIStOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPFZkqCw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8rJvkWp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPFZkqCw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8rJvkWp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEwhkM1725496
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GrWsRhIhWGS4C7EWlb51bAL+FOwhlqUbVF9HoNyoqTI=; b=hPFZkqCw0kP5NAaf
	7/QFkxjxfOPU+uD8g3UrqL+MIBuhZ5egE3o0A7I7g/vYCkYbO/viUo5C49fYhmgM
	52+/8JpWiobFd8WerHpJOhSAFnZAHMUzgTQA8aIhtMZJakyyVw+tX25AkQmpIerT
	2RZAXuWy/olqo2kyuc41hQ7yKs6jW6c5A+1yQ51aS63/prO8ho8aZsBNajptMDMF
	rjELEjGFzLzConxefD5Vcj6fRCNfMT6MKbg4iXLQSm46pxGVgXty9Hjd/8HEFzlq
	YjQBA8aAl/godj39tIzS8PYhp86L3MOESCk6gry2HaUSxMTPSi3H8upPslF3ZbUE
	peD1lA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qgq0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd00a65673so27910855ad.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779211700; x=1779816500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrWsRhIhWGS4C7EWlb51bAL+FOwhlqUbVF9HoNyoqTI=;
        b=g8rJvkWp6Np4cLHyL2WLYNVLUdjRANUaqyjnn6b91gzZf69t9yR7xclzxCBXxL62RS
         L7lxKV01xTi1XG+rKgaohbuF7hB2aJQLxcRzENpTd+gXdhoiJ9ReDczaGRBwgbAlqKSR
         94XxrPHAwJ+rzqQis3vN5OmguSNKoVhr5ExAwJtU0Kot3Kc8SR7DsnfRjprJioVqP39j
         OZpS5qAM43ykR+szLGNhmLZMqSq8wPWuJDyTBxM5uwf2kgarvl5akmcBlI6hQnxZbgXX
         VPBUPgbQYDDJYcW8PqDj5bKefNxDJrWV+bfueKmKmS0a7/HmEhDaXw5LyWh48STvgq4d
         g1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211700; x=1779816500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrWsRhIhWGS4C7EWlb51bAL+FOwhlqUbVF9HoNyoqTI=;
        b=cLZj26rUD8heYb4wl9SrOz5vEKChT0dwteRA1yZ3iBUPqZEXaVYUjQp8Y3flSpXlfV
         TIjuEoRE0amf39fgy8Z2AxMo5DuJQmkJ6DLtmCl9rVxz8gA5Zp1UTJ5xWf9o6IJKdrYm
         oDLJ2OLUVrg65nYD0yCpLLKEUdJ4rNVNFmPBlTmWYwqIM6I7yLEOOujSw3jYy5sNWSa5
         oE3M7Lu7NHELnF2JAu5+7aNE1VogDAI2XLlFh+/sGKlbztwbWs19uEOfEedLLUquZ+Il
         JeUNnCkgmTnu/ulMxCOaN2dsq/6wHxK+udtI7yqFRk0BKEyXQuZgrqW9x6emRG76mZL7
         +S7g==
X-Forwarded-Encrypted: i=1; AFNElJ+SqUxQHnCp0RudtYr2+0cdyq/ue6ib76R//acGja7qyGdwLcoopimePCMlfRfTemry4BiRaXgliw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAaKTeE80dfOGl1q2wNhoOlfjRm34kq3oWjxwpMKRSddVekD8
	df2QUlxPumlQ/odg2tdyf51HMjUEXiJg1iutu1UFDcd5PhPcYPRGL5ybZ6YaF8cGMj4GU/VOngD
	y3S7yu9qdd5lcdsTcBCLcUrHPQ7psGJwiN82Ht0sQKgK/GIzJNqv9iVyVBOFjxg==
X-Gm-Gg: Acq92OFxfW3ak23SpQodKXRamKv6NPrNHt8qulehw2QxNp/UiSt8ClccoTXuj8EbVr8
	n3Fe9AHUbjeg2ZAyo25MOFg5PJZGPmImEJXcl8u1z7VrxLKGcneOKdBRbxPV5CarRPWtEV4fs5v
	KjJ5QeZkm6KwHRXaiPOhdmYMZZbqBrN56g9nj6xWvpoZXBU8pjToXW8gyeql/VZ8sKuKvSxd0ju
	O9k9BRJ6eUSd9y9RO+YJTby82Z8nmI6N0OyQ2O4Uc+Z7G9AfxwJbOXE7tfL5NMnp2+5fbU8/6J6
	ERoId9b6JQVSaKOTQIZClXWswT3lrFmpY5Y427oZwVZTDxU82dLfo1mEnP9sOw0TTvmklFA90v1
	zH5igfyY0N2/sv0szs/2Bl9b3KT1iwjAUaZ9uDrdUviOgsBTtSFP9
X-Received: by 2002:a17:902:d509:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2bd7e8288acmr184173525ad.6.1779211700447;
        Tue, 19 May 2026 10:28:20 -0700 (PDT)
X-Received: by 2002:a17:902:d509:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2bd7e8288acmr184173155ad.6.1779211699820;
        Tue, 19 May 2026 10:28:19 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d125159sm182248365ad.76.2026.05.19.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:28:19 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Tue, 19 May 2026 22:58:04 +0530
Subject: [PATCH v2 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-shikra-cpufreq-scaling-v2-2-2b09f0e1c9d8@oss.qualcomm.com>
References: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
In-Reply-To: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX7HJP4LUpoSiO
 Ok3N5PMMavK3QzWnUCLdYW9rAA5tHwB5cGBc9WAJwGVOVN+gwmZXOiDg2+8cNrU7choqGKRCwKB
 6UmX9xnHae+3/loJ+4ibEPItZ+y++JnlVtfx5CSStqUBD9TGKKwFzmdMhXb8lhIGHnS29vqJlOP
 AdbmMM10w+xoKLzqzr8zCTPnDg4lNyqgFcYaTaXPD6tO5tKQq4ZKcj2RVpKqmMC0L0mW1be6j0s
 W4rwmt1oqFktgxbxpglhz+TDEB5mIhDevDPXrOuBn9Q2PB3QUnbDq59rS6my9SUHIQ/I2a9Zcam
 ANa+v5I2R5GTly17rO8IRHb0GegflHAt9jSrVDV+rJl5B0UyKoHbFHefgOxkOW2dDTDbNiKrvkO
 fMP+sZo2Z/AiwmQfHPE1gcxPxByoXdeZ4zyh+2g4RM5QbyuNxmSxXyonOmBz5DWDcDf1FbzYaBs
 BeK4+oa3P5KEHxP2kdA==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0c9db5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9mH7G91LJRnKxjVXxHoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: d4RmkIsmhKxkjDo3hM_dSJthWxGJLsCR
X-Proofpoint-ORIG-GUID: d4RmkIsmhKxkjDo3hM_dSJthWxGJLsCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190174

From: Taniya Das <taniya.das@oss.qualcomm.com>

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Hence,
add shikra_epss_soc_data that reuses EPSS configuration with appropriate
LUT entries limit.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8fdceb9341ee53e5fa27b7a6d92483..d50b868dced309cceb7b49b69dff933e4bd9e357 100644
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
+	{ .compatible = "qcom,shikra-cpufreq-epss", .data = &shikra_epss_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);

-- 
2.34.1

