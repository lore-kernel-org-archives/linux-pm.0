Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C67370AFB
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055073; cv=none; b=SEzLQS9q3ZiZ0NjfFnVnMdXBH2D2RYlcR8OU6cC7Iy+nRYCGDqf8N9cQmOFz4/8/uYIH/hGx+86Xxn+XYbrW+l+cnyRFW1mx6rdBMJCzoD3//KpSIn2fYvdlCx4xP4mimteZgtStVBWFPnBhnnwoRYymZdQD2QwFwr8W95BqTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055073; c=relaxed/simple;
	bh=mw2xywDtGE86eMiTObjMgtV9IqdLC+USGzaPZvRA/pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Akp78TFP7w7TXYvdWh8N6YDNNTHmyHxlWygJvC9ga61/DqcOCzlzkegfzP+0FWoy1M7WqSDOdGU3cqILmBoIaF0wppXfujKcnKQPDqB04drpNoHQdfCKDiyWIPLLe84UsbsdLMIN9wo8IzAyP1X1/N7LqmDxnq+hXzp9YLunmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7ybRX7o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U0RwNDdS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7ybRX7o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0RwNDdS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342fdc2777606
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 05:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	md8wWc6/cgAOJXI2yDz++qo+slmTKVQf5dEfPIb96Jk=; b=j7ybRX7o89rK6kKu
	/G3+cqhxVEaf/oFTjSHPoCgSuQuP/4WzvDXZCeYbKKYKHUoVp1U9aAvX9xzWQSo0
	oud29xUyfv0iTHdkzbIKklSIsErlht4XidYcnKrunC5z4A3dT1A9rdbSvpC6gUa0
	EWUJpcZs09+hGYc/hSK5f8RWdhUzilHjEFoiQGybOKeCmKTCLCsrlSK286SE3js7
	7OaZLixqFcogRYT49HMkCB3W51uTTvg9Hj9ZDIlTx6t6DZ52hCNM982dFEo6NbjS
	spTT/RPehHg+zb5DvIcaOTBjshwU6/G6JSZwuz3iY4Nj6HWL/khgVDHWohJrQhOo
	ZswItg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s2536th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:04:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so210797a12.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055055; x=1783659855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md8wWc6/cgAOJXI2yDz++qo+slmTKVQf5dEfPIb96Jk=;
        b=U0RwNDdSfbMXx084KS9S/y7u6A2YJmxu091bVSO234Rf6pcusQWpwAXXNwzAiO2MmM
         I/iUwiwTbnnioza9nEX0bd1eIh2DLgrI39/B/ggsC452JcSqhC6qL3UD4+uJ7xMpzJj0
         XIbEVm0N/oveB9Optfytk9VER6dlmUPQG+6jJ+KEXVqmcAZQErAYAbNL7mfGyXRroC34
         Zompz0btS0R3assV3qKY9YMzsGHg8XhG1dHVjfbn9/M3jbfvk54hmbdJ8N2sH8tRjE2F
         nfAJe2Lky93pM5dai2fbeQJfYVoWaTOm9GPsXz4xMWxokdjCSWsFIICo29nEZ6pSt+4c
         GAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055055; x=1783659855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=md8wWc6/cgAOJXI2yDz++qo+slmTKVQf5dEfPIb96Jk=;
        b=lPgx2jmPuH7Atw2rVlaWUL/no82C/8OD1MraNiETjjy6iJt0zMHBcxhKuQscVMcB86
         /kvlfSlK0JIRA5HBUOPRhohvttzRnto45C/ZvMEjuDcXho/4dk2pRrtoNeuZ7/qCXT/H
         jJvJASvZziTZE8CMpLALEZusElavcG4g0Ymz0SqfTC1VqBnfaE1U/Ubu/JcFC+Sgc9Q9
         bDcdWiFJt7wyjRe+zGU1t5WXn9umS1XNBFqmPpfvU9nl0vclgIS4/39nIhJ3w+qV00mX
         Z9sGeYIRC9E5qEq/enxsK3sSdXwrO/4kLNQZrpsGUxIa542Z1Cz6t4hXzOmba3QlZ7Rr
         kOUA==
X-Forwarded-Encrypted: i=1; AHgh+RqpsJN498kfT5kZDVNYUnk19FKRoydz8V9pl0xAPZ7ZYMsv+FKtI2wT8d7bT5+n/3biY3uOU5wdUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUu8nPYtrGnK2RsEHF8hNKHi+jiDXETJxc1jJlw7AixhhEdiO+
	jtfAiz6QrfZdgYMMnAxoniuOl8aQYoDFeB1fofh4nV3skovMMmE2GHcCo9p5/BQkSz+RBPa2bgr
	r5fD95EJ/ahEZW9J8aLGXDv4aQfS+Vmg+TQeOZATEfmheC5DswP9CvywI6j+y6w==
X-Gm-Gg: AfdE7clWKwS/aWSkJN90AkVYid8pV8LEDky8XZ8hJdXzJlu1eb6RyT4IF8lH5is75HL
	y0DXzUCodLmolh/kAmGsLzrZ6a5jPjsiY7/4hvdTLIXX5gCdIywpklMWw5f6LPRQe9F6CfHzLxi
	U9cDisLw2NBeYHjtfGDYJwsA8oSv8raNlHP6UnOGlRoh0GwzuCKa9GHm9mf+HwpLDolK5bjVXaM
	noi2I3hirOvs+qgip3g1w7hpu7HNbiT1J+j8QsG9teLzedJkco5/HC4nVpAChhOFTfYCj5AKA7j
	DXYgPsbBr5Ja1nUDVsR9fFGJw8e1K5uwP6jOthUvxP+eR2xmOJDKkk15+5nrOHJXvlF5JrNY/Al
	coDSyLSvIS3Ju4ftpyz4OYAl5iGMj50MenWrFHlYs
X-Received: by 2002:a17:90b:3811:b0:381:5ede:1296 with SMTP id 98e67ed59e1d1-3815ede1635mr77855a91.11.1783055054645;
        Thu, 02 Jul 2026 22:04:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3811:b0:381:5ede:1296 with SMTP id 98e67ed59e1d1-3815ede1635mr77838a91.11.1783055054031;
        Thu, 02 Jul 2026 22:04:14 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:04:13 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:08 +0530
Subject: [PATCH v4 05/10] remoteproc: qcom_q6v5_pas: enable QMI TMD cooling
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qmi-tmd-v4-5-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=3860;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=mw2xywDtGE86eMiTObjMgtV9IqdLC+USGzaPZvRA/pk=;
 b=ikEWVDd9kQOc9aRYdLrIQRqy20EpLvW9r6pThjNeNOGwddivHx9OZ/0ZkxdGjXxxIaCKgSOFX
 LOXWhMa5YioCLK3ChMQTtJcVx8h012+foUjbvpUg3oqYjlxd7w6lT7E
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a4742cf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=j6jQExit_mXiN_RbaP8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: FFIpgWqwW6u9mgaqPDdsu5ygh6LzCSsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX9M60KGPqBdwi
 WDPLsUwBTFwron6ExmKl36BvFphLVIQJF7CkdQvVPWwMNtjf9bQWc3sjipe3RoHZToZFAwyZ1C3
 DR7BflTAX1l1pfQ8VEgAaTGocDfRYoUujByfM4YMJbe8XlKbRdzj7nC7NcbPwnjaAenTuyCTh2A
 KeDfVGUvnj7Z/rvhbnya2l7hTV1IjJw6a8J5+G6jsp9/NoabVwKa1+KnG77Yy5JiJsv/AgiIFtd
 ArrD4FfCQ4MFy0g4oho4qVHM0UMntBeAnVgh1NDCodrQJgqIdjehcm9TNyLg47NUborc+5LPQe/
 XqkLmeGRD2M1Y19HE6SMCl0IbVc7t/1Dkxqu4dtPPchPZW3onY0heREvzfrAbZlJ1sa3nXPLVgo
 KkyZr9LBcinQpbmsuTe2IQw3RhQL0/MLG1/W254M4d6Hcsu3ctJgvptKR20XzIJIttl3WFgkSkq
 7I3m6mIOqPgi7xL4DwA==
X-Proofpoint-GUID: FFIpgWqwW6u9mgaqPDdsu5ygh6LzCSsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX9B/vvnJt7zis
 JesKCwSMT9h2ngOBHfx8L5lm0WL4LFusULLFHYw1OCMs0Bu/i9LRccBA/Lioy3NsSk9qaqtedjP
 3R56VQ9u4ZdfKI9PQzphM5JbLVvlTXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030045

Enable Thermal Mitigation Device (TMD) support for PAS-managed CDSP and
modem remote processors on platforms that expose the QMI TMD service.

This adds per-platform TMD configuration in qcom_q6v5_pas for:
- Hamoa (X1E80100) CDSP
- Kodiak CDSP and modem
- Lemans (SA8775P) CDSP
- Talos CDSP
- Monaco CDSP

For each remoteproc, the configured TMD QMI instance ID is used to bind to
the TMD service running on that subsystem (e.g. CDSP: 0x43, modem: 0x0).
The driver then uses the corresponding TMD endpoint names ("cdsp_sw",
"pa", "modem") for cooling-device registration.

QMI TMD identifies mitigation endpoints by name, while DT thermal bindings
reference cooling devices by id. This change provides the mapping
between DT cooling indices and QMI TMD names, allowing remoteproc nodes
with #cooling-cells to act as cooling devices in the thermal framework.

With this in place, thermal policies can request mitigation from CDSP and
modem subsystems via QMI under thermal pressure.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ab5bcccc91a6..974526195e97 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -987,6 +987,15 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	device_init_wakeup(pas->dev, false);
 }
 
+static const struct tmd_name cdsp_tmd_name[] = {
+	{ .name = "cdsp_sw", .id = QCOM_CDSP_TMD_CDSP_SW },
+};
+
+static const struct tmd_name modem_tmd_name[] = {
+	{ .name = "pa", .id = QCOM_MODEM_TMD_PA },
+	{ .name = "modem", .id = QCOM_MODEM_TMD_MODEM },
+};
+
 static const struct qcom_pas_data adsp_resource_init = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
@@ -1144,6 +1153,9 @@ static const struct qcom_pas_data sa8775p_cdsp0_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sa8775p_cdsp1_resource = {
@@ -1162,6 +1174,9 @@ static const struct qcom_pas_data sa8775p_cdsp1_resource = {
 	.ssr_name = "cdsp1",
 	.sysmon_name = "cdsp1",
 	.ssctl_id = 0x20,
+	.tmd_instance_id = 0x44,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sdm845_cdsp_resource_init = {
@@ -1189,6 +1204,9 @@ static const struct qcom_pas_data sm6350_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8150_cdsp_resource = {
@@ -1204,6 +1222,9 @@ static const struct qcom_pas_data sm8150_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8250_cdsp_resource = {
@@ -1288,6 +1309,9 @@ static const struct qcom_pas_data x1e80100_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8350_cdsp_resource = {
@@ -1356,6 +1380,9 @@ static const struct qcom_pas_data mpss_resource_init = {
 	.ssr_name = "mpss",
 	.sysmon_name = "modem",
 	.ssctl_id = 0x12,
+	.tmd_instance_id = 0x0,
+	.tmd_name = modem_tmd_name,
+	.num_tmd = ARRAY_SIZE(modem_tmd_name),
 };
 
 static const struct qcom_pas_data sc8180x_mpss_resource = {

-- 
2.34.1

