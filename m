Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221340B375
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615391; cv=none; b=EErEylHyZ1+h/lbZiwacv2nxiO7SBwD/zU2iwY5gU8QhR5R19ezcVj0NQTxyEvMg4Quxu9vxKzRWn6XkndFZd+57NPGANjoGANRuyFjy2SM+RPm7yJ8OiRcG44g1nRRHRCv+toehflh3xdgbZqVwFILaAP/IV1AnRPUtqoYqbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615391; c=relaxed/simple;
	bh=GONTJSYcNvJs7QEMLgaR+oUX4qDBOmqUBB2BocJpUds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPh4UBzidzaehHYAyNhvrTnZDpG9Ed+1/8BcSILtUIxYIBm9h/l7NCsYHivNiVg7AZ75GxZMI/9sAhFSzVIw9yndlooeX5oZvypMMkuJGcAXNUjBeSO/ymmvBl4AESXx8yNhGM5O9Hv4Ujw7+X+IYz1W4uU3LgbnDpBpLdt7oYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxGbqdaZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EM5NFBvT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxGbqdaZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EM5NFBvT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L4T1GP527891
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cDFJuefHfzoEFQ+pZuZu+bCX06c3eux2xACecFGf1A=; b=GxGbqdaZ/olVd+em
	7zZlkM/L3gam7eL4iXvXk5ztYsycsw+NCwPM8Ta3BQgsqKLsO7hWJpCkMNV8ld7i
	7ApX3NBSnkOilXfYSfUc4wJziHRwKo3b1434j94LC3Ly/eaGt52WQyI/FH/yYrbY
	Gcb0LmyIpvQ5GYg+hWULDT7OGIcdyidvVCJdCGgf4XFogrUULi4NZneMH2Q0Vo+z
	/pVSBmXC+JesHFa88OCLoVLOQL8dMrvzOvjtTO0pbwhPqOEgg3AbVZEOWAJim2nT
	GTIeS52CHBvtHxhYKbFh7arGK+cQGcQFvA69qSA3PoNBif7Z3M9vx/RJwZ5Xa5N5
	5M+v9w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se0dgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so39161345ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615387; x=1785220187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cDFJuefHfzoEFQ+pZuZu+bCX06c3eux2xACecFGf1A=;
        b=EM5NFBvTTihb8h4e5+WeyUqYwcJqh21hqtBfQwTsEGNbttMYZme8vqgP4ZZci6wxjm
         fThrTe7BT9d4sR0QYQBtcMoH1A7ioygC5jA7igHRwfWKEJftex4AsjPuLToDdUNzdmWY
         MIfYKvfQDpMMS5hvDOTjP8oUkqMtln9c7R5pdodaERIXIFZYmKFCFNeMeAqWWdqFcY0R
         DT/r82oaeTOpsetLfRz2JBxjc6nru0x+9v0AaRlUNn4NV6TmmrE+5l/UDax0fH94qjFM
         I1hC2TCwNKI+K1KM/Cdf1xAQqYUpgz8YKg6QedxMi31Efti3uPxaq0CDzmrs/iB1YZOV
         9VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615387; x=1785220187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cDFJuefHfzoEFQ+pZuZu+bCX06c3eux2xACecFGf1A=;
        b=hkMDMIZxwcIsbZ5EBIqnwrsve7O1t4Ll0RXsHVWwo21WNch9u1n6MIm9eBDqxkASSP
         sDBQZ4oxeE8Ayn1uoIPd6M/ZYFaMeRYyGvxdSG7BHV+xitOZDVwUJvXi8e1J6tSPfzqI
         jhVPeIm5SM+vppYWKBbxNQMaNDY2LZhI7m35ll/HCqNqBI96R95aAHaFPXWHmmaW73Ff
         BpSP76rk0qO07YkkEkEulSvKG/mqxibroF6pIo8zetnlsmNAiDlBWAsftfoaOxV7zswA
         +cPdm3BkIs6AS/xWj4R8+G9gQ9QkYXgQ8/YjlVgs7eeC5ebf/6ghYbirZ5j0pPOHnlIp
         JSiw==
X-Forwarded-Encrypted: i=1; AHgh+RpuMgOKbj3LuAjYR977vdYz9SLqav/YZ7BXi36hknMf9O4D73GZ6JpnPxay5SHLhbpuVAVbF7SN3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwinxRn2+ebaDMVs7ejn9qdFATs+AuuqD4p7mAwr74fmVfMdFCM
	920hnjCUA4uoVIchwLHPPYGpPEU0uHfXTfkC+CpC5R58oGvCXyDjYQbM6Poy9cWst0MmScRN5NJ
	Sf2ZJqGncNFMRF/JzSW3FOqP0kjmQgsjr7mQqzVqBKriw2AeZxkd/Ym9Ua6f/BQ==
X-Gm-Gg: AR+sD1080KJBmOQd0kkYJusvfsMQ8ssnecP97zbNNF71YyWHVOWeFYx5iEVLl5C0umH
	AOrPg7j+3RmRW7PL9F38Sh/Cnx1yuUWrZHBysG1697l8+2TwLtqygOk0XUd88IlIAOytrTTz8a3
	0VkXamiR7zx7JV/2jnTUKYyOlhOIBHLVcMWoaMA89G7mzHK9gJ7wFfI4DpWlZVwk/jGMpekrIFM
	kdOJbapSjhQxRUKJH9b6a74v90Umm6R6h+JjupFSm8i6ixqaoqG3Zm7u/rXUV7gUTzkloqZWt7j
	RIsrbSUUYnjvExAwrBy2ZKQQgzDp9mZd+6OknFjubO67EKTRrBYqofggPj1ooJWf5588X7kJymu
	cUEqnsW+MrxtZExYj5BZrpwh9pODlIA==
X-Received: by 2002:a17:902:dace:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2cf349776aemr186656705ad.11.1784615387484;
        Mon, 20 Jul 2026 23:29:47 -0700 (PDT)
X-Received: by 2002:a17:902:dace:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2cf349776aemr186656425ad.11.1784615387041;
        Mon, 20 Jul 2026 23:29:47 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:29:46 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:59:01 +0530
Subject: [PATCH v5 4/9] remoteproc: qcom_q6v5_pas: enable QMI TMD cooling
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-b4-qmi-tmd-v5-4-99620e07f505@oss.qualcomm.com>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
In-Reply-To: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=3908;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=GONTJSYcNvJs7QEMLgaR+oUX4qDBOmqUBB2BocJpUds=;
 b=BwrCwaSCqBPUWGlnTL2wsEEb+Jau6H/89XXTF3ADd5CjoiwlARMFX7VspHoYS97DU8RHHTXSR
 dqTcROa0xcgBm6MNvhG5KHElrRJHgOTVv1vnuU2fICDU1zNKzKcB4n5
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: _YBAOBnyUjmVbkj2XAQcCE7Y3-CRXa1a
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f11dc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=j6jQExit_mXiN_RbaP8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfXzaeGEkJ5BB1C
 7aGr8IuA1RuaeH2z+9oMlWcTBY2HvwrWxxfZcbZQAroAQ68iK3xD8c80Lg2jYwid43F+4iaACqy
 drc1V7wsLm7OIs5JpuYQJ/Y+JafsHNQ=
X-Proofpoint-GUID: _YBAOBnyUjmVbkj2XAQcCE7Y3-CRXa1a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX1qaW2w08P+aG
 F7HhK/etT9sAVrOy7xoidvAVmFfbdNxh709uYXNEUVMxzEYytmyMAMn/h8O1CdxSqE9iTpIH4GL
 CNfWeK/7bK1MW9yyoyqW7jxElhMVYhFDvYta6KJe3s1v3P7GrtavXc5k7P1Do2WUB2/e8c3e3Ir
 xVyj0wQk4dbwRKMUp72WQo8MzhmjDqzAicCBYj/aS40QH6WCQGtxBLnaZFgUES4hWxxzpl4+XvU
 4zdn4TQobewEFPYVz/yN0PxPAJxek6/jzSIKDh9pB9IjZy7AYlY0fF3CLtbMDFHvdGfzMDKcrao
 S5ryGiJsOrLDTEdjzInY/2G7sq1m8yytqrBRDkATvs2fB1D84gYun4GnN7WzjFn7DG2vjAURPDW
 mMw0d5O4jh8LxY3TWVDJz4cFuVZY7JXsqobd8fBtK1EDZc6Jyno9ywG5Wk6VECNc0Ydfkv4DeJS
 Q5T+paIuuR5vtWMO6mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210065

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

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index dc5be2c030cf..b7fb4326ada8 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1061,6 +1061,15 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	device_init_wakeup(pas->dev, false);
 }
 
+static const struct tmd_name cdsp_tmd_name[] = {
+	{ .name = "cdsp_sw", .id = QCOM_TMD_CDSP_SW },
+};
+
+static const struct tmd_name modem_tmd_name[] = {
+	{ .name = "pa", .id = QCOM_TMD_PA },
+	{ .name = "modem", .id = QCOM_TMD_MODEM },
+};
+
 static const struct qcom_pas_data adsp_resource_init = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
@@ -1218,6 +1227,9 @@ static const struct qcom_pas_data sa8775p_cdsp0_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sa8775p_cdsp1_resource = {
@@ -1236,6 +1248,9 @@ static const struct qcom_pas_data sa8775p_cdsp1_resource = {
 	.ssr_name = "cdsp1",
 	.sysmon_name = "cdsp1",
 	.ssctl_id = 0x20,
+	.tmd_instance_id = 0x44,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sdm845_cdsp_resource_init = {
@@ -1263,6 +1278,9 @@ static const struct qcom_pas_data sm6350_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8150_cdsp_resource = {
@@ -1278,6 +1296,9 @@ static const struct qcom_pas_data sm8150_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8250_cdsp_resource = {
@@ -1362,6 +1383,9 @@ static const struct qcom_pas_data x1e80100_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8350_cdsp_resource = {
@@ -1430,6 +1454,9 @@ static const struct qcom_pas_data mpss_resource_init = {
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

