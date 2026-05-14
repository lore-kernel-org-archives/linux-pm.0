Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4E304972
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731558; cv=none; b=brbbyDD3povSeJrXtznJAdoELpO2+JTjWHlCG+dZTD4/eecQIwPrrq5npINYFGKXwE+JKEajzQ2nm6i/w3uOo75e9Hv+MlBRIzgRTjXxflh4RXN8s/F387EV92pPM3RjBDQnjG655E44rmC5MU35LlHmS8Y6xG7wtG4cIutnViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731558; c=relaxed/simple;
	bh=ijZovknDajNxIxg3LTmBGvrM7bkdi8po4qJvt9/oouQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrTTqU0wG6YiP3PqYSh4POnHQj2nxsV4Cdh05o5y6e5v0xiKTbXIQENUy5NnBTFG4RzXjDl2lNsbLvsvDUul0vjV3qDOlRZ6BFOeqaQjLAfYs8HTuD9vM2ZTo/kY5OZwH8TJCTFlNRb7VL/Ri6jpgG0oYMNh1MTFShOjGZktrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAp1mbwE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVfLj5Rd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAp1mbwE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVfLj5Rd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E2Aq9O2524633
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OzTMMQJ8CnCSK3AwZf65cTeHKEgDkdb1Z3INqfD4ySA=; b=dAp1mbwEC3EFPfqr
	eTjQBm7VyktFRR6h06BkmCD86yqDPZwknTdbkeAMueEbrDpUIDaFXetwHZhvttHz
	sTs9aNbT28JKZhh4aiYUG51Ik25ea8E4svCSTF+jd6RW0mQ5UCwjLEEKaECmN467
	FfxEHu9L5yyH1pS1AOzgTaYvWEjWVL3TJ5jpSGJxxVdp/0yBT5HptsPBF28k+Z9z
	CZHZRsypaRqcJ2kFOs5X0cmFkTddR3BX9noyvBNxwh4QzhfjCtD+Y45sSDs4gHEg
	2EVe2Y/7i42anjAPGKM4ZEzqtdOy+8jv8MDmlLKb1jozNULfJvbvG980I8ASz/tS
	F550xg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjj7qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 04:05:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso81314795ad.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778731554; x=1779336354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzTMMQJ8CnCSK3AwZf65cTeHKEgDkdb1Z3INqfD4ySA=;
        b=iVfLj5RduAhh78X8vyqptxV1KULmMoyvQTJuVfEeM/98LpOKiGzjbBjlyjttCiUq1l
         33Vij90p9hM2xQZqiECvEEqKjmgCPjLAmXmHJ6fna9L/pBkTS4157qSw6YsQVAbJ0/Y+
         AxHm8BSAbuMBA1dV2eZKEWQ+NfpjgHSMe4q1pdMhPzHktA30b8eXPEjzzxiysxx0Qtap
         eYUHmzOLPNaie6XYH4XKplUnkFBCOrnaIvmqlU59R111gkh6nbUn3W2B43ERtNRx0kJ+
         AxKPwrx7+AwGXRJKDNYUZfFMYR9qtaoZTeFEbmSAqIRUK9Ag128KTuzVisuFg38JvJ0h
         t76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731554; x=1779336354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OzTMMQJ8CnCSK3AwZf65cTeHKEgDkdb1Z3INqfD4ySA=;
        b=GFdAKLVhcE1lxaUzdj3E4bBseQe47qdPV2cSt0ofTHxbvEGBJ+CB3BaBrBKkMHsG2v
         g3gM7zWBsEeW1bprN1oxskrw9VQ1g1ys1dj1PYnRpEbJqizk/rJMU5enpC5Hrgrfpv08
         rPO1Dsju1WSn0tcJkgLJbXlLDdNklLZh50iYF5dBr3/6w/gFG3rtCmLfvXMiSEUMBPCv
         uH+Hkn/fGDKIzV3RDFdDzxopdap0M72d6klG3WWY6NbYrQ9joQLpE6gL6evHHAgZWcb8
         rqh8TULaAfcOBCL7FyVmQ3dT9vGi6QMrgdeyn6z5vrjKH2bc927xUHsv4w8acp4iq+Gu
         D2Dg==
X-Forwarded-Encrypted: i=1; AFNElJ93g4lEnai4ce2hNefPMArRSYEctYjQmyxXiFhyFaQfLWGc2JufdHiRX8/lcXu1z80rXjUEd13JQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGXM0uKbPacKdG/wPuLDtH1k5F2pOpyEN9sO3yzl/P6Dwh1T9
	lZH1R8oayb7iR0Om60Fxx5n8hZUFCuYANvQQquBf1HYV3Upq9gQei3ovZ3h24/JftKHCgpsR+NP
	q1su+ebb2oINjCe9DSzGBE17CSys+aXzOFMElE7dbZo/i3J+8ufHaXeRUi+oEcQVEMzWLHw==
X-Gm-Gg: Acq92OEE0Mk5mleF1Y/N48EIWHVk9FnUz24Kp2HjqAAReijpJDx+oeDMhOdxzM+XwQ9
	ANYxBqEkmKFAGu/1OX/ZJTpfXx5f8gmmUhFEZx2hbHBzSi3lkb47c5S5D+/k6infdlQFUGiaG8M
	5PWYT8M/kx5BkoBWaAbTBYb0jCMgQ3emK8B4iVaKQ8dKJ7KDH5zYf64HsckpLuw0vkFerRA7vxa
	KQXiq1s3mXp1PFhHA5drkdvBd5+JsB9Vw6EIswlGXzcIz9HI9I11wkidMXbP8PbIVIngIQ9OxJi
	41GuExCF0OwQ1vvcII8glh79D+10K1uONZSxGdh7ldEhG2Qbhpnoq46fK7MfFFyjJTXU3GRxcS+
	x+76+804rvxlQvW26E3wVF47SP6zG51XqXyAcHh0kL/BlOQJaDli5AWZ8uVXV2kY17vSQt/lEEZ
	adtOJwR63Urv7AEPuKtRTxpnVTdU2N/fxQcYqy9WyP7vYsg6W5bcw9C70gGSZnSg==
X-Received: by 2002:a17:903:38cf:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2bd2f70f1b2mr60080445ad.18.1778731553903;
        Wed, 13 May 2026 21:05:53 -0700 (PDT)
X-Received: by 2002:a17:903:38cf:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2bd2f70f1b2mr60080045ad.18.1778731553200;
        Wed, 13 May 2026 21:05:53 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8698sm8035145ad.40.2026.05.13.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 21:05:52 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 14 May 2026 09:35:36 +0530
Subject: [PATCH 2/3] clk: qcom: ipq5210: Use icc-clk for enabling NoC
 related clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
References: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
In-Reply-To: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: bUNrA6qQMMMK75vW52wmcl85ncqzOD_1
X-Proofpoint-ORIG-GUID: bUNrA6qQMMMK75vW52wmcl85ncqzOD_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzNyBTYWx0ZWRfX6xwi2rspNZHE
 xYEDOT7RV/lY35sebueQAUfX69hFi7vZ9LHOrqkAK3jiLDTLv2qvo9jNWUM28Lt/yiyYUOwAFnn
 8RXfjJzNjebxPi575H4D685e1I73ZkripT76KtCBz56CuxQ1xR1neDnhm+LIEvqnfM3rO4cdfdX
 2L6O5fl2gEhnmXg+ZzeDITtO4ZWzPeZYMB9kArUQyrgIxieo/nC6zvkr4tPut8H6L6L8SvGyref
 nLK8N+8+UC8D5vUX4EaCMFfTATVnx5l4IFbiIEy60ht93IgMfxla8mUdvkWvIur0clk8WDU9M75
 eYIlDXwhH8+fDqdEwcw0Q7p1w27jJltwCrml9C8x7ywtkCLtO7go+q881A2+Hflu8lWdYOWE7kW
 Qaz80TgBUM9ZGGabJNnonn8zrltZHu7fIFFynjCBUcRn3P4vVzXlJ3Fx1m+LdqQqiOfkUUPdAZ7
 t230MwIP1ToBRtRq5Jw==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a054a23 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2vMkRBvVivtXAe3DWLoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140037

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-ipq5210.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5210.c b/drivers/clk/qcom/gcc-ipq5210.c
index 3a786a21bdff..1111da24b512 100644
--- a/drivers/clk/qcom/gcc-ipq5210.c
+++ b/drivers/clk/qcom/gcc-ipq5210.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5210.h>
 #include <dt-bindings/reset/qcom,ipq5210-gcc.h>
 
 #include "clk-alpha-pll.h"
@@ -2602,6 +2604,16 @@ static const struct qcom_reset_map gcc_ipq5210_resets[] = {
 	[GCC_QDSS_BCR] = { 0x2d000 },
 };
 
+#define IPQ_APPS_ID			5210	/* some unique value */
+
+static const struct qcom_icc_hws_data icc_ipq5210_hws[] = {
+	{ MASTER_CNOC_PCIE0, SLAVE_CNOC_PCIE0, GCC_CNOC_PCIE0_1LANE_S_CLK },
+	{ MASTER_CNOC_PCIE1, SLAVE_CNOC_PCIE1, GCC_CNOC_PCIE1_2LANE_S_CLK },
+	{ MASTER_SNOC_PCIE0, SLAVE_SNOC_PCIE0, GCC_SNOC_PCIE0_AXI_M_CLK },
+	{ MASTER_SNOC_PCIE1, SLAVE_SNOC_PCIE1, GCC_SNOC_PCIE1_AXI_M_CLK },
+	{ MASTER_USB, SLAVE_USB, GCC_CNOC_USB_CLK },
+};
+
 static const struct of_device_id gcc_ipq5210_match_table[] = {
 	{ .compatible = "qcom,ipq5210-gcc" },
 	{ }
@@ -2630,6 +2642,9 @@ static const struct qcom_cc_desc gcc_ipq5210_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5210_resets),
 	.clk_hws = gcc_ipq5210_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5210_hws),
+	.icc_hws = icc_ipq5210_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5210_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5210_probe(struct platform_device *pdev)
@@ -2642,6 +2657,7 @@ static struct platform_driver gcc_ipq5210_driver = {
 	.driver = {
 		.name   = "qcom,gcc-ipq5210",
 		.of_match_table = gcc_ipq5210_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 

-- 
2.34.1

