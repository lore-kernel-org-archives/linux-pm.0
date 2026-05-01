Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E2363085
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619768; cv=none; b=AWa4B+QkEjHThrbr/5aO7g2/1z9wjOoAovLp6g5lJ7/CHtnZOjxc3LobMBq8J4ghpNRwg6og3szr5Z64RnrnIFDpoAuvg9JYyzGp3Gso57WdS73aMc9jisk8p+0tD39SaKllzBTnyaqQ7Npp2L3KqqTsxLihGCjXkLhvQvoll8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619768; c=relaxed/simple;
	bh=kDzLYQaS1lbA/xiRLBr0uQnb3mDzyWDtiYndf5iUEbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rl7SCV7xsHVwOv/39yCT06Z5XBWfN0gz8/KQS8irBWg454eMiS6M5jwFi7Oz3Y1HAQ4xcjdkovqkUFZ2ETo0P4VIT7hL8j2fFSmd9Aj/Yc+5jAavkTtnmBDFJUzAbSSD6YTfn07NGO0rGs4GGBIQD8L0GUQcnAMJv1VS4+0TG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGEEzQEZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bAk3hBZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGEEzQEZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bAk3hBZQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6415L72V2480929
	for <linux-pm@vger.kernel.org>; Fri, 1 May 2026 07:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cF+BfuuIzuIarcJk8/M1mL+ZvYdCHrSlHXbiPBeKvng=; b=hGEEzQEZsF7tJV0J
	TpzoClldad5wUNHsYLGi1/h57L9lhU90o5tu2wnQTngW+8zJhTHbzlvvngJhJEIX
	RuxBMVl7Y3xu6eFlRpUvqRtu4EPDrYsndINB/4pniCsicc4fI3FCiHn39u/xlcv/
	qvKBuYJ1y/BK4KTKJaHHndoGxSFRIoPs/yC7U8TQ9XCTMomHaWpz/YlG6cdmx7hO
	9T7cCRDGMe2at1/VZBRT7Gx2LJlc8qaik1hmiUZz/CAICkFUfGur49j9EDQOlfCS
	gTyWHB7ulhlQR3ge6E3AFdizEK3d7s1sxdKZEHXp2SOQJyxOVJK4A/j9PxB/fhC+
	ZhetPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6kdv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 07:16:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so2203735a91.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777619766; x=1778224566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cF+BfuuIzuIarcJk8/M1mL+ZvYdCHrSlHXbiPBeKvng=;
        b=bAk3hBZQ/YfGh0UGSHDZNo+TkRfNM5xPwpn84KNoCgGLZZPWDOflsGCU42LZforh6D
         /4NQQdOqikP6cukOOoIGTxsEjAswSvSZPnw3z4MUaiQ68HA4tlSYMkV5jF63FCY2F/Na
         Eo7fJOeeoHR3wJrZcU9cPsDiDm/tMy+HVNKwktdIbgNl8tW8aNLfmixUJvgmPxrRzIvi
         ge8YJlW+Y4A1olOxBTURAET4D5Evm7Zay4ZF126LecZNSH1PSVs08zybYxhVYwXhBdAT
         lfaxNTqf7b1hpb8mG69TGFZlMl3jnhuEnoBlIpFSTGYoNpBHqe2t2bXxqyJA9pjI3DN5
         SZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777619766; x=1778224566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cF+BfuuIzuIarcJk8/M1mL+ZvYdCHrSlHXbiPBeKvng=;
        b=BlGklZeeIqUorfYobIUEXwRu+w1otUs1jnpZwt4gxeCugXBZlJ0EtbpEtbQ352z4Bm
         qlshRi5+yjT5iyMNfDMFE5QWpHdFYYvYLw1Og6KXz4JGsjKDM1LjsxChqWydykFfFADE
         xd+gg0buDMCfT7F3wvQ1T5EWJzH2A/YVv4O4RBUOKmR95loIFsqs6DHGWmhdLIn02BeN
         U7+mUU+dSrX78abx1JdRfeNyIbBt0SeKSbX0UjgvsHu1JNuZaBRo1aoBq2TAprmmpKaO
         5zeqDBjKp0C55P/Qwc+pY7AETEH18xPW4yagXWOVpmDLZBkevMDM7nAf7QSe5+G44krX
         DnfQ==
X-Forwarded-Encrypted: i=1; AFNElJ96Hb6wzZBv20p0++k/N44T9ZgTVXE862IXtv2yxFzhPjn6ANaxCPr7iqPESRijf58IpUHvxgAHiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1Odkk8K5TKNoMiZHPOga/1ghMGVzqq5GtngFyBlRMis1I2ry
	yvV6wlbsf4ZV+CaFqYYsSFJH/LIKRmHdTih0/GkpFWAWAf6YmL2062yBuETHkUR7bymnEonbo26
	5tI+99MLAfk33c40gYxhUd0EAtZl2k2pXfIFaZk0+oQQgh66mfD2L2PCKWvqzyw==
X-Gm-Gg: AeBDieu99lyqleEBFEqQ5Xn6bBk4AwcCmFW2qf+WyvyHYtIYOh3BH4zTfYGbTNtTJXq
	mvpLm22xwIJOs5fio86kHX7PVvXvwRYGLwnIYJUTUCGY4C6gfJFiTHEsuyn0mKk4r4SJtXt3I1I
	cPIAvJWk0Xchbm8eNVoQMfuVuG18O8Y8YxmC8QnZASftdgYdJQ4rD6/7roeBMkBDkOt8SYMin6T
	AaPQyYubBSwuC+nvfHzr6QfvEJjzV7N6jJdGFbokrmWYBCzOuIrWu4n+i8Am5ifn+MyDMq5SU3w
	AxPaC55qx/kx5OfDhZeDbtU/4x+r2+/cbIy0CSNS+FFJf295Paa+q7HKuKApLCX3ON/8Dw3nRCz
	eqp3TN1Ffh2zUUsv4LEEX2yHCreuh+4gYnm/cid50rJExqtW9Tw/8OurpaDgwnkQ=
X-Received: by 2002:a17:90b:288d:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-364c49c723amr4874908a91.13.1777619765845;
        Fri, 01 May 2026 00:16:05 -0700 (PDT)
X-Received: by 2002:a17:90b:288d:b0:35f:b4c1:91ea with SMTP id 98e67ed59e1d1-364c49c723amr4874845a91.13.1777619765241;
        Fri, 01 May 2026 00:16:05 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00b094sm1424265a91.9.2026.05.01.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:16:04 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 01 May 2026 12:45:45 +0530
Subject: [PATCH 2/2] cpufreq: qcom: Add cpufreq scaling support for
 Qualcomm Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-shikra-cpufreq-scaling-v1-2-c78b95f53b91@oss.qualcomm.com>
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
In-Reply-To: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: VkA40wU4Uw_r2_Jtjs7VZuIbhRW43jT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA2NyBTYWx0ZWRfX54NaF0lPB9Yr
 4qhVq+FTnuoO77W8Z5LffpgnyCLK/my7wemKMgsEwNFau7X4IoN6wCJXd/6EmqXckhMTZUUhgxM
 vEI7NtQUxMn2f/uVZXIQtPhLUM1gGcvtdn1rVpOC27FyYy3Gpvrtm/dYyX0bYHpEz94XKkBN3Jk
 QvQcw9wS3Sdp796b63rmjLz77rLSZO2kV83MLE8XJUhodySxbUCQNAyz20AffkHFLXZaSsWMG3E
 tduDQajZTYHEaO1/oLCdVlaZCXQq+zNKmW5iiCj3cdF+cThyOMyvRV67sI804o/DTvetGLVlDYT
 xqvJu3TAwe13jyGMQRIcabE5lEwI2k+P2rhHHIlwCRIRilRb9nM46MRxbe9eb0z3U6IpDKvYhZx
 nr2WkwVS5G9VmFIAVJeHTE5AfftoliZDQkLB8dCJN33QynOJU/y13vXW4vOpsJtFH96orXviHo9
 Wpj+ioP5RSaCakGaDMg==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f45336 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ho_ns56EN5Ux2FGuUoIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VkA40wU4Uw_r2_Jtjs7VZuIbhRW43jT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010067

From: Taniya Das <taniya.das@oss.qualcomm.com>

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Hence,
add epss_lite_soc_data that reuses EPSS configuration with the appropriate
LUT entries limit.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8fdceb9341ee53e5fa27b7a6d92483..92e1256c6457046927625136077c69f8d56644aa 100644
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
+static const struct qcom_cpufreq_soc_data epss_lite_soc_data = {
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
+	{ .compatible = "qcom,cpufreq-epss-lite", .data = &epss_lite_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);

-- 
2.34.1

