Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E83939D2
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013011; cv=none; b=pTWb9lMRcj5w79iQph4GkRvf59W/R65Y2y9uwYUpT4051Zz5O2OCCd0fK/G50uyTdvCAEmSxt3LA5LtILLLrb99cEAstYyO7TI1M8/va0G7PkNCyxvbT9W4XC2GWcj8OAOzDkkhndNSToQ0NbOZz8Vqk64oZQWAAruRru52LB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013011; c=relaxed/simple;
	bh=4XRogWbUwnMMW58xPAwqSHxbZIm9D6UtzQbPKUc/5/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHE1VqV7ofHgjsbA7iZfD1g7xjZVvLMlpnNQmpUg85G+tmaDHVh2t4L4QjsH9w1bM9TTV83sv4cv+Tkwp4ZgWSejeyJJMNCP2CZW0xXNhMtX/Lhy2SsbYWiaVrq5NJV9PaJ9gawPv7kO3Mw5g+HWn+psCYQuYraPOBLTGFX8378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NyUEmLvL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RajpfXAD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NyUEmLvL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RajpfXAD"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3IIH670795
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 17:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iiWBTOq8xJran9EHKj4g0Jlob/kaoBLgUmDiRd3IN7Y=; b=NyUEmLvLyZVGeDPO
	HQVE/vfZ/IKlZ/4jFz1vtw8lYvCe3EJOhE4bTBY5+cEKyA+AatL7BJPI+UlsByTz
	meSHTbCDdMfDgh5l9+i0jIFIzXXUWg34BPkRvRwUZRqxM7TXHSpom0w74z4h2Beo
	LNpH9IygPsVU3zNnJr5cR2B4Dd61E2WsR7kU4vhT402zpKsUc4Vg+ogejjPoBn8/
	MOsqje5ngz/8qxqzOHHUW3D9lEcGxUjroqhYRVksYGoWpFs5XSkcOXbfr3IbNE6x
	ny5sBoL+aRCLYBFjAV99Bq1d1Y2qtQjMZKGEVMpm99x5fSIv4j0YvdrC8wnUQocf
	A56H6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7nb3m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 17:23:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so2631510a12.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783013004; x=1783617804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiWBTOq8xJran9EHKj4g0Jlob/kaoBLgUmDiRd3IN7Y=;
        b=RajpfXADOjS1U9M8tKmTXyJPt/ox1VtmwJrIyd0o8PstfY1A1Eck8QIFSeHW4rv0/C
         B+UxpiG6hB+IqFuzxUlPaBVVmXejX1XC864M8VYwjGZ0icCVVCWN6MA7AO3eswjg6T4E
         BrT0exe9KKwG2YyXwiLrvU439aIUNKIeN3PZs4FBHFT27W5vpqOz0EPPgZVNKek1aylI
         MbwZYWXM/l4HyUxKwEx2YOD1G2EuGvwBA/rm776EDSGCxdNlZ9+1v4cd/ms2nR/qiA2B
         l9Lcm4nnd+lXN38pYJyFcMbzC9dxef7DRsdRloORK3A+/Dp2qR8DAeCjeS+FnQGToBYs
         pMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013004; x=1783617804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiWBTOq8xJran9EHKj4g0Jlob/kaoBLgUmDiRd3IN7Y=;
        b=qkL9VqdGq7eifR69ewpTfEEmo0gcbvL3BMmO3quRYIqE+t4qEIw9toAvelAlB2sIuh
         GOwSzGlxXax0TGUKyav2HQ3Ann/xqX4W/LYiiJ2BkMlw0jsnKO3wYgBShaOWPnUCiQ3N
         DcZ9GzmkddOsanu8YEpkLwdJYARStlL1zmBI5g+a5dNZKWHcfvJrzr2q3EtxzmMJiuJh
         ftEgzZR5+NAW5k/GwsfF9XVKX62wR8Pr9eM3EypeMHTVT9CkeLraf25hYb2f2meV+82/
         vTkltRSc01WtjHUBGeTnNVxartSVvJ7JTd4cLyIzu2j9HH5p/ULdzvcgNSKeoRKR2ev+
         RkHA==
X-Forwarded-Encrypted: i=1; AFNElJ8a4VNikxLUlbGCNRqwom0ZHc7sPpb3aB/+rJlLFs13fV5vkCreEtY3xNLHoHexcoxTdw17utbiaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNDwzV2DamaONjlab5rS5oq1ow6m1w8MAwDnzsMLKcOGkQaS/
	Mwdj7gLmTvPPXmRjxCXCKijjvt7Dh3MeFRtfW5t+YxrDa55yr7I49ByOjvnFUzF/sM4ibdkA03L
	1/OhJq5xhQwMjOd2SE6/eEOnvox92wrWfXwEn9ug8aRT7boKSSHyaR7Yc0HtbGQ==
X-Gm-Gg: AfdE7ck8Zd2VQxRwntn0VobcyZP08lVXLm6GtjNvOV1qF7Z8QmJeZ3PnwSIceRjnEuv
	ciaOfpJwuGEChEP2J+rpvRfQ2MH3FYVRyzM3yOSBbPGSVgPqxhk4Jx82ijKORsb1gX75VrbORuP
	M2lpgF6rSilLlzVGlF53Eoy5HQORyCi5FyL/fo4azdFTCWt6ZgUl9nAVCDESlZrIEEsIw6xfROJ
	7rfJABqL6mFO3zif69XMtlj1Ek7/zFvyRBHvFShrRFbb081fzF+cuCbIOzP4J3i+3kJvcJGH8wx
	Gjrw1zpUQmTYVoyPkS7yLipc6hCF1ljZhZtyHEvTJMzixhrRAJvPpZ4ma6BHAfulnoDOhzYd7HE
	mt8Ty3HNrE71DxI42vQcamIXFeJuWYCUrWjyy8AvLs9JKtQ==
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr9158740637.19.1783013003375;
        Thu, 02 Jul 2026 10:23:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:4688:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3bfed2721b3mr9158664637.19.1783013002615;
        Thu, 02 Jul 2026 10:23:22 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm10564289c88.8.2026.07.02.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:23:22 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 22:52:56 +0530
Subject: [PATCH v3 3/4] powercap: qcom: Add SPEL powercap driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qcom_spel_driver_upstream-v3-3-434d50f0c5b0@oss.qualcomm.com>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783012984; l=24084;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=4XRogWbUwnMMW58xPAwqSHxbZIm9D6UtzQbPKUc/5/A=;
 b=VMeo6D3U2CrdZJw9v9FTJSlQGwkJY+vKPL1CzYA8hssgo2hQ0oclLdlVev4/qbhJHXGNnimzK
 g/9QomVV+lXBZKq4U5wvO4Q5fXxvYY5HIIgT357UwZ2w8S8xIHhgd5P
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX3H93bkc6HnHA
 X7a3nsFGEZub198VmkCAchjijKe4NKqqRokxBXQyovCSUMAZQRFAPeOKPpLmk9Od0dYi/2to4qQ
 vnWxtqj+yf9aoF9bb0Jn/DXaT5rFoTLbuRSJa2yznyGzO0U34edvYiGpoH/FzwOJ6q0ADXbtXMJ
 wk2K984mhirLqLi/AIYBJpFjVlzxYHvbN8OB9yw5iaxvuXdzk+FBRWML6o+/Ia347ZV3ODg02od
 yI35B3QWHUhp5h3hviQntbODHYwL9dc6/x0M1hJzY5Lw133n2BxaasfKTqwcxNMjqqbGK2YF4zw
 fPm4x/e/p34AHrB/NmNTjwK8b5sjOYXJubkVuRE3czdS1WCTSCUBk0MbF3cON6dQc1obeufKKZi
 aoNxnyDuR5Rz9rrSm0R2CLpkYrgGh6rPe8BwbaX8aLcatXN0jktdSeUw/Rx7kyngJJFOy9co+0o
 0bp6YSlBaYNC7b8jXBg==
X-Proofpoint-ORIG-GUID: fbHdTw9n2D5c_9XqizAD6wtaVD_k-XHp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfXwE6wTh+LmMay
 /Etj7GIa0UUnax4haL0++2HzzbPvt0IQezJVDvKTmOs21wb354KjLyQ5DoY8HtuXXtrqE45lGtB
 cIzQE/2JZVSKkcpY4nYpb0rudH+rLEU=
X-Proofpoint-GUID: fbHdTw9n2D5c_9XqizAD6wtaVD_k-XHp
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a469e8c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=zsYhbmp5XtfrNIia-74A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020183

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various power
domains including System, SoC, CPU clusters, GPU, and various other
subsystems.

The driver integrates with the Linux powercap framework, exposing SPEL
capabilities through powercap sysfs interfaces.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 MAINTAINERS                  |   1 +
 drivers/powercap/Kconfig     |  13 +
 drivers/powercap/Makefile    |   1 +
 drivers/powercap/qcom_spel.c | 803 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 818 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44e90b2d5e85..5e716662782c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22374,6 +22374,7 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml
 F:	Documentation/devicetree/bindings/power/limits/qcom,glymur-spel.yaml
+F:	drivers/powercap/qcom_spel.c
 
 QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 03c4c796d993..e3a47c653499 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -93,4 +93,17 @@ config DTPM_DEVFREQ
 	help
 	  This enables support for device power limitation based on
 	  energy model.
+
+config QCOM_SPEL
+	tristate "Qualcomm SPEL Powercap driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  This enables support for the Qualcomm SoC Power and Electrical
+	  Limits (SPEL) hardware, which allows power limits to be
+	  enforced and monitored on Qualcomm SoCs.
+
+	  SPEL provides energy monitoring and power capping for multiple
+	  domains including system, SoC, CPU clusters, GPU, and various
+	  other subsystems.
+
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 5ab0dce565b9..8235fb9d3df6 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
 obj-$(CONFIG_INTEL_RAPL_TPMI) += intel_rapl_tpmi.o
 obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
 obj-$(CONFIG_ARM_SCMI_POWERCAP) += arm_scmi_powercap.o
+obj-$(CONFIG_QCOM_SPEL) += qcom_spel.o
diff --git a/drivers/powercap/qcom_spel.c b/drivers/powercap/qcom_spel.c
new file mode 100644
index 000000000000..e4ddf7390391
--- /dev/null
+++ b/drivers/powercap/qcom_spel.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm SPEL (SoC Power and Electrical Limits) Driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/powercap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/* SPEL register bitmasks */
+#define ENERGY_STATUS_MASK		GENMASK(31, 0)
+
+#define POWER_LIMIT_MASK		GENMASK(14, 0)
+#define POWER_LIMIT_ENABLE		BIT(31)
+
+#define TIME_WINDOW_MASK_L		GENMASK(14, 0)
+#define TIME_WINDOW_MASK_H		GENMASK(22, 16)
+#define TIME_WINDOW_MAX			((FIELD_MAX(TIME_WINDOW_MASK_H) << 15) | \
+					 FIELD_MAX(TIME_WINDOW_MASK_L))
+
+#define ENERGY_UNIT_MASK		GENMASK(19, 16)
+#define TIME_UNIT_MASK			GENMASK(11, 8)
+#define POWER_UNIT_MASK			GENMASK(2, 0)
+
+#define LIMITS_CAPABILITY_OFFSET	0x20
+#define ENERGY_RPT_UNIT_OFFSET		0x04
+
+#define ENERGY_UNIT_SCALE		1000
+
+#define SPEL_DOMAIN_NAME_LENGTH		16
+
+/* Domain types */
+enum spel_domain_type {
+	SPEL_DOMAIN_SYS,
+	SPEL_DOMAIN_SOC,
+	SPEL_DOMAIN_CL0,
+	SPEL_DOMAIN_CL1,
+	SPEL_DOMAIN_CL2,
+	SPEL_DOMAIN_IGPU,
+	SPEL_DOMAIN_DGPU,
+	SPEL_DOMAIN_NSP,
+	SPEL_DOMAIN_MMCX,
+	SPEL_DOMAIN_INFRA,
+	SPEL_DOMAIN_DRAM,
+	SPEL_DOMAIN_MDM,
+	SPEL_DOMAIN_WLAN,
+	SPEL_DOMAIN_USB1,
+	SPEL_DOMAIN_USB2,
+	SPEL_DOMAIN_USB3,
+	SPEL_DOMAIN_MAX,
+};
+
+/* Power limit IDs */
+enum spel_power_limit_id {
+	POWER_LIMIT1,
+	POWER_LIMIT2,
+	POWER_LIMIT3,
+	POWER_LIMIT4,
+	POWER_LIMITS_MAX,
+};
+
+/* Unit types for conversion */
+enum unit_type {
+	POWER_UNIT,
+	ENERGY_UNIT,
+	TIME_UNIT,
+};
+
+/* Power limit operation types */
+enum pl_ops_type {
+	PL_LIMIT,
+	PL_TIME_WINDOW,
+};
+
+static const char * const pl_names[] = {
+	[POWER_LIMIT1] = "pl1",
+	[POWER_LIMIT2] = "pl2",
+	[POWER_LIMIT3] = "pl3",
+	[POWER_LIMIT4] = "pl4",
+};
+
+/* Common domain names (can be shared across SoCs) */
+static const char * const spel_domain_names[SPEL_DOMAIN_MAX] = {
+	[SPEL_DOMAIN_SYS]	= "sys",
+	[SPEL_DOMAIN_SOC]	= "soc",
+	[SPEL_DOMAIN_CL0]	= "cl0",
+	[SPEL_DOMAIN_CL1]	= "cl1",
+	[SPEL_DOMAIN_CL2]	= "cl2",
+	[SPEL_DOMAIN_IGPU]	= "igpu",
+	[SPEL_DOMAIN_DGPU]	= "dgpu",
+	[SPEL_DOMAIN_NSP]	= "nsp",
+	[SPEL_DOMAIN_MMCX]	= "mmcx",
+	[SPEL_DOMAIN_INFRA]	= "infra",
+	[SPEL_DOMAIN_DRAM]	= "dram",
+	[SPEL_DOMAIN_MDM]	= "mdm",
+	[SPEL_DOMAIN_WLAN]	= "wlan",
+	[SPEL_DOMAIN_USB1]	= "usb1",
+	[SPEL_DOMAIN_USB2]	= "usb2",
+	[SPEL_DOMAIN_USB3]	= "usb3",
+};
+
+/* Glymur-specific domain register offsets */
+static const u32 glymur_domain_offsets[SPEL_DOMAIN_MAX] = {
+	[SPEL_DOMAIN_SYS]	= 0x40,
+	[SPEL_DOMAIN_SOC]	= 0x00,
+	[SPEL_DOMAIN_CL0]	= 0x5c,
+	[SPEL_DOMAIN_CL1]	= 0x60,
+	[SPEL_DOMAIN_CL2]	= 0x64,
+	[SPEL_DOMAIN_IGPU]	= 0x08,
+	[SPEL_DOMAIN_DGPU]	= 0x44,
+	[SPEL_DOMAIN_NSP]	= 0x0c,
+	[SPEL_DOMAIN_MMCX]	= 0x10,
+	[SPEL_DOMAIN_INFRA]	= 0x18,
+	[SPEL_DOMAIN_DRAM]	= 0x1c,
+	[SPEL_DOMAIN_MDM]	= 0x48,
+	[SPEL_DOMAIN_WLAN]	= 0x4c,
+	[SPEL_DOMAIN_USB1]	= 0x50,
+	[SPEL_DOMAIN_USB2]	= 0x54,
+	[SPEL_DOMAIN_USB3]	= 0x58,
+};
+
+/**
+ * struct spel_constraint_info - Power limit constraint information
+ * @limit_offset:	Register offset for power limit value
+ * @time_window_offset:	Register offset for time window
+ * @supported_mask:	Bit mask in capability register
+ * @domain_id:		Domain this constraint applies to
+ * @pl_id:		Power limit ID (PL1, PL2, etc.)
+ */
+struct spel_constraint_info {
+	u32 limit_offset;
+	u32 time_window_offset;
+	u32 supported_mask;
+	enum spel_domain_type domain_id;
+	int pl_id;
+};
+
+/* Constraint configuration */
+static const struct spel_constraint_info constraints[] = {
+	/* SYS domain constraints */
+	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
+	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
+	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
+	{ 0x1c, 0x7c, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
+	/* SoC domain constraints */
+	{ 0x00, 0x60, BIT(4), SPEL_DOMAIN_SOC, POWER_LIMIT1 },
+	{ 0x04, 0x64, BIT(5), SPEL_DOMAIN_SOC, POWER_LIMIT2 },
+	{ 0x08, 0x68, BIT(6), SPEL_DOMAIN_SOC, POWER_LIMIT3 },
+	{ 0x0c, 0x6c, BIT(7), SPEL_DOMAIN_SOC, POWER_LIMIT4 },
+};
+
+/**
+ * struct spel_domain - SPEL power domain
+ * @power_zone:		Powercap zone
+ * @lock:		Mutex protecting register access
+ * @sp:			Parent sys domain
+ * @status_reg:		Energy counter register
+ * @name:		Domain name
+ * @id:			Domain type ID
+ */
+struct spel_domain {
+	struct powercap_zone power_zone;
+	struct mutex lock; /* Protects register read/write operations */
+	void *sp;
+	void __iomem *status_reg;
+	char name[SPEL_DOMAIN_NAME_LENGTH];
+	enum spel_domain_type id;
+};
+
+/**
+ * struct spel_system - SPEL system
+ * @domains:		Array of domains
+ * @power_zone:		Parent powercap zone
+ * @node_base:		Base address for node registers
+ * @constraint_base:	Base address for constraint registers
+ * @config_base:	Base address for config registers
+ * @control_type:	Powercap control type
+ * @dev:		Device pointer for logging
+ * @limits:		Supported power limits per domain
+ * @power_unit:		Power unit in microWatts (common for all domains)
+ * @energy_unit:	Energy unit in nanoJoules (common for all domains)
+ * @time_unit:		Time unit in microseconds (common for all domains)
+ */
+struct spel_system {
+	struct spel_domain *domains;
+	struct powercap_zone *power_zone;
+	void __iomem *node_base;
+	void __iomem *constraint_base;
+	void __iomem *config_base;
+	struct powercap_control_type *control_type;
+	struct device *dev;
+	int limits[SPEL_DOMAIN_MAX];
+	unsigned int power_unit;
+	unsigned int energy_unit;
+	unsigned int time_unit;
+};
+
+#define power_zone_to_spel_domain(_zone) \
+	container_of(_zone, struct spel_domain, power_zone)
+
+static bool is_pl_valid(struct spel_domain *sd, int pl)
+{
+	struct spel_system *sp = sd->sp;
+
+	return !!(sp->limits[sd->id] & BIT(pl));
+}
+
+static int get_pl_ops_offset(struct spel_domain *sd, int pl, enum pl_ops_type pl_op)
+{
+	for (int i = 0; i < ARRAY_SIZE(constraints); i++) {
+		const struct spel_constraint_info *ci = &constraints[i];
+
+		if (ci->domain_id == sd->id && ci->pl_id == pl) {
+			switch (pl_op) {
+			case PL_LIMIT:
+				return ci->limit_offset;
+			case PL_TIME_WINDOW:
+				return ci->time_window_offset;
+			default:
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static u64 spel_unit_xlate(struct spel_domain *sd, enum unit_type type,
+			   u64 value, int to_raw)
+{
+	struct spel_system *sp = sd->sp;
+	u64 units, scale;
+
+	switch (type) {
+	case POWER_UNIT:
+		units = sp->power_unit;
+		scale = 1;
+		break;
+	case ENERGY_UNIT:
+		units = sp->energy_unit;
+		scale = ENERGY_UNIT_SCALE;
+		break;
+	case TIME_UNIT:
+		units = sp->time_unit;
+		scale = 1;
+		break;
+	default:
+		return value;
+	}
+
+	if (to_raw)
+		return DIV_ROUND_CLOSEST_ULL(value * scale, units);
+
+	value *= units;
+	return div64_u64(value, scale);
+}
+
+static int spel_read_pl_data(struct spel_domain *sd, int pl,
+			     enum pl_ops_type pl_op, bool xlate, u64 *data)
+{
+	struct spel_system *sp = sd->sp;
+	void __iomem *reg_addr;
+	u64 value;
+	int offset;
+
+	if (!is_pl_valid(sd, pl))
+		return -EINVAL;
+
+	offset = get_pl_ops_offset(sd, pl, pl_op);
+	if (offset < 0)
+		return offset;
+
+	guard(mutex)(&sd->lock);
+
+	reg_addr = sp->constraint_base + offset;
+	value = readl(reg_addr);
+
+	switch (pl_op) {
+	case PL_LIMIT:
+		value = FIELD_GET(POWER_LIMIT_MASK, value);
+		if (xlate)
+			*data = spel_unit_xlate(sd, POWER_UNIT, value, 0);
+		else
+			*data = value;
+		break;
+	case PL_TIME_WINDOW:
+		/* Decode time window: bits [22:16] are upper 7 bits, [14:0] are lower 15 bits */
+		value = (FIELD_GET(TIME_WINDOW_MASK_H, value) << 15) |
+			FIELD_GET(TIME_WINDOW_MASK_L, value);
+		if (xlate)
+			*data = spel_unit_xlate(sd, TIME_UNIT, value, 0);
+		else
+			*data = value;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spel_write_pl_data(struct spel_domain *sd, int pl,
+			      enum pl_ops_type pl_op, unsigned long long value)
+{
+	struct spel_system *sp = sd->sp;
+	void __iomem *reg_addr;
+	u64 reg_val, new_val;
+	int offset;
+
+	if (!is_pl_valid(sd, pl))
+		return -EINVAL;
+
+	offset = get_pl_ops_offset(sd, pl, pl_op);
+	if (offset < 0)
+		return offset;
+
+	guard(mutex)(&sd->lock);
+
+	reg_addr = sp->constraint_base + offset;
+	reg_val = readl(reg_addr);
+
+	switch (pl_op) {
+	case PL_LIMIT:
+		new_val = spel_unit_xlate(sd, POWER_UNIT, value, 1);
+		if (new_val > FIELD_MAX(POWER_LIMIT_MASK))
+			return -EINVAL;
+
+		FIELD_MODIFY(POWER_LIMIT_MASK, &reg_val, new_val);
+
+		/*
+		 * Enable/Disable PL based on the value:
+		 * - If value is 0, disable the PL (clear enable bit)
+		 * - If value is non-zero, enable the PL (set enable bit)
+		 */
+		FIELD_MODIFY(POWER_LIMIT_ENABLE, &reg_val, new_val ? 1 : 0);
+
+		writel(reg_val, reg_addr);
+		return 0;
+
+	case PL_TIME_WINDOW:
+		/*
+		 * Encode time window: upper 7 bits to [22:16], lower 15 bits to [14:0]
+		 */
+		new_val = spel_unit_xlate(sd, TIME_UNIT, value, 1);
+		if (new_val > TIME_WINDOW_MAX)
+			return -EINVAL;
+
+		/* Read-modify-write to preserve other bits */
+		FIELD_MODIFY(TIME_WINDOW_MASK_H, &reg_val, new_val >> 15);
+		FIELD_MODIFY(TIME_WINDOW_MASK_L, &reg_val, new_val & FIELD_MAX(TIME_WINDOW_MASK_L));
+		writel(reg_val, reg_addr);
+
+		/*
+		 * Time window register update doesn't trigger firmware interrupt.
+		 * Write to the PL register with current value to trigger the interrupt.
+		 */
+		offset = get_pl_ops_offset(sd, pl, PL_LIMIT);
+		if (offset >= 0) {
+			reg_addr = sp->constraint_base + offset;
+			reg_val = readl(reg_addr);
+			writel(reg_val, reg_addr);
+		}
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int spel_get_energy_counter(struct powercap_zone *power_zone, u64 *energy_raw)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	u64 value;
+
+	value = readl(sd->status_reg);
+
+	*energy_raw = spel_unit_xlate(sd, ENERGY_UNIT, value, 0);
+
+	return 0;
+}
+
+static int spel_get_max_energy_counter(struct powercap_zone *pcd_dev, u64 *energy)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(pcd_dev);
+
+	*energy = spel_unit_xlate(sd, ENERGY_UNIT, ENERGY_STATUS_MASK, 0);
+
+	return 0;
+}
+
+static int spel_release_zone(struct powercap_zone *power_zone)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+
+	/*
+	 * Free the domains array when the last zone (SYS domain) is released.
+	 * This ensures proper cleanup even if sysfs files are held open during unbind.
+	 */
+	if (sd->id == SPEL_DOMAIN_SYS) {
+		struct spel_domain *domains = sd;
+
+		/* Destroy all mutexes before freeing the domains array */
+		for (int i = 0; i < ARRAY_SIZE(spel_domain_names); i++)
+			mutex_destroy(&domains[i].lock);
+
+		kfree(domains);
+	}
+
+	return 0;
+}
+
+static int spel_find_nr_power_limit(struct spel_domain *sd)
+{
+	int nr_pl = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(pl_names); i++) {
+		if (is_pl_valid(sd, i))
+			nr_pl++;
+	}
+
+	return nr_pl;
+}
+
+static const struct powercap_zone_ops zone_ops = {
+	.get_energy_uj = spel_get_energy_counter,
+	.get_max_energy_range_uj = spel_get_max_energy_counter,
+	.release = spel_release_zone,
+};
+
+static int spel_constraint_to_pl(struct spel_domain *sd, int cid)
+{
+	int id = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(pl_names); i++) {
+		if (is_pl_valid(sd, i) && id++ == cid)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int spel_set_power_limit(struct powercap_zone *power_zone, int cid,
+				u64 power_limit)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	int id;
+
+	id = spel_constraint_to_pl(sd, cid);
+	if (id < 0)
+		return id;
+
+	return spel_write_pl_data(sd, id, PL_LIMIT, power_limit);
+}
+
+static int spel_get_power_limit(struct powercap_zone *power_zone, int cid,
+				u64 *data)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	u64 val;
+	int ret, id;
+
+	id = spel_constraint_to_pl(sd, cid);
+	if (id < 0)
+		return id;
+
+	ret = spel_read_pl_data(sd, id, PL_LIMIT, true, &val);
+	if (!ret)
+		*data = val;
+
+	return ret;
+}
+
+static int spel_set_time_window(struct powercap_zone *power_zone, int cid,
+				u64 window)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	int id;
+
+	id = spel_constraint_to_pl(sd, cid);
+	if (id < 0)
+		return id;
+
+	return spel_write_pl_data(sd, id, PL_TIME_WINDOW, window);
+}
+
+static int spel_get_time_window(struct powercap_zone *power_zone, int cid,
+				u64 *data)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	u64 val;
+	int ret, id;
+
+	id = spel_constraint_to_pl(sd, cid);
+	if (id < 0)
+		return id;
+
+	ret = spel_read_pl_data(sd, id, PL_TIME_WINDOW, true, &val);
+	if (!ret)
+		*data = val;
+
+	return ret;
+}
+
+static const char *spel_get_constraint_name(struct powercap_zone *power_zone,
+					    int cid)
+{
+	struct spel_domain *sd = power_zone_to_spel_domain(power_zone);
+	int id;
+
+	id = spel_constraint_to_pl(sd, cid);
+	if (id >= 0 && id < ARRAY_SIZE(pl_names))
+		return pl_names[id];
+
+	return NULL;
+}
+
+static const struct powercap_zone_constraint_ops constraint_ops = {
+	.set_power_limit_uw = spel_set_power_limit,
+	.get_power_limit_uw = spel_get_power_limit,
+	.set_time_window_us = spel_set_time_window,
+	.get_time_window_us = spel_get_time_window,
+	.get_name = spel_get_constraint_name,
+};
+
+static void spel_init_domains(struct spel_system *sp)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(spel_domain_names); i++) {
+		struct spel_domain *sd = &sp->domains[i];
+
+		sd->sp = sp;
+		snprintf(sd->name, SPEL_DOMAIN_NAME_LENGTH, "%s",
+			 spel_domain_names[i]);
+		sd->id = i;
+		sd->status_reg = sp->node_base + glymur_domain_offsets[i];
+
+		/* PL1 is always supported (required for powercap registration) */
+		sp->limits[i] = BIT(POWER_LIMIT1);
+	}
+}
+
+static void spel_update_unit(struct spel_system *sp)
+{
+	u32 value, shift;
+
+	/* Read power_unit and time_unit from offset 0x0 */
+	value = readl(sp->config_base);
+
+	/*
+	 * Unit calculation: 1 / (2^shift)
+	 * Masks limit: TIME_UNIT (4 bits, max 15), POWER_UNIT (3 bits, max 7).
+	 */
+	shift = FIELD_GET(POWER_UNIT_MASK, value);
+	sp->power_unit = 1000000 / (1 << shift);
+
+	shift = FIELD_GET(TIME_UNIT_MASK, value);
+	/*
+	 * Convert to microseconds: base unit is 1ms, divided by 2^shift.
+	 */
+	sp->time_unit = 1000 / (1 << shift);
+
+	/* Read energy_unit from ENERGY_RPT_UNIT_OFFSET */
+	value = readl(sp->config_base + ENERGY_RPT_UNIT_OFFSET);
+
+	/*
+	 * Unit calculation: 1 / (2^shift)
+	 * Masks limit: ENERGY_UNIT (4 bits, max 15).
+	 */
+	shift = FIELD_GET(ENERGY_UNIT_MASK, value);
+	sp->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << shift);
+
+	dev_dbg(sp->dev, "Units: energy=%dnJ, time=%dus, power=%duW\n",
+		sp->energy_unit, sp->time_unit, sp->power_unit);
+}
+
+static void spel_detect_powerlimit(struct spel_domain *sd)
+{
+	struct spel_system *sp = sd->sp;
+	u32 capabilities;
+
+	capabilities = readl(sp->config_base + LIMITS_CAPABILITY_OFFSET);
+
+	/*
+	 * Detect power limits from hardware capabilities.
+	 * Start from index 1 (POWER_LIMIT2) since PL1 is always enabled in spel_init_domains().
+	 */
+	for (int i = 1; i < ARRAY_SIZE(pl_names); i++) {
+		for (int j = 0; j < ARRAY_SIZE(constraints); j++) {
+			const struct spel_constraint_info *ci = &constraints[j];
+
+			if (ci->domain_id == sd->id && ci->pl_id == i) {
+				if (capabilities & ci->supported_mask)
+					sp->limits[sd->id] |= BIT(i);
+				break;
+			}
+		}
+	}
+}
+
+static int spel_init_system(struct spel_system *sp, struct device *dev)
+{
+	/* Read unit configuration (common for all domains) */
+	spel_update_unit(sp);
+
+	sp->domains = kcalloc(ARRAY_SIZE(spel_domain_names),
+			      sizeof(struct spel_domain), GFP_KERNEL);
+	if (!sp->domains)
+		return -ENOMEM;
+
+	spel_init_domains(sp);
+
+	for (int i = 0; i < ARRAY_SIZE(spel_domain_names); i++) {
+		struct spel_domain *sd = &sp->domains[i];
+
+		mutex_init(&sd->lock);
+		spel_detect_powerlimit(sd);
+	}
+
+	return 0;
+}
+
+static int spel_register_powercap(struct spel_system *sp)
+{
+	struct spel_domain *sd;
+	struct powercap_zone *power_zone;
+	int nr_pl, ret;
+
+	/* Register SYS domain as parent zone */
+	sd = &sp->domains[SPEL_DOMAIN_SYS];
+	nr_pl = spel_find_nr_power_limit(sd);
+
+	power_zone = powercap_register_zone(&sd->power_zone,
+					    sp->control_type, sd->name,
+					    NULL, &zone_ops, nr_pl,
+					    &constraint_ops);
+	if (IS_ERR(power_zone)) {
+		dev_err(sp->dev, "Failed to register power zone %s\n",
+			sd->name);
+		return PTR_ERR(power_zone);
+	}
+	sp->power_zone = power_zone;
+
+	/* Register other domains as children */
+	for (int i = 0; i < ARRAY_SIZE(spel_domain_names); i++) {
+		struct powercap_zone *parent;
+
+		if (i == SPEL_DOMAIN_SYS)
+			continue;
+
+		sd = &sp->domains[i];
+
+		/* SOC is child of SYS, others are children of SOC */
+		if (i == SPEL_DOMAIN_SOC)
+			parent = sp->power_zone;
+		else
+			parent = &sp->domains[SPEL_DOMAIN_SOC].power_zone;
+
+		nr_pl = spel_find_nr_power_limit(sd);
+		power_zone = powercap_register_zone(&sd->power_zone,
+						    sp->control_type,
+						    sd->name, parent,
+						    &zone_ops, nr_pl,
+						    &constraint_ops);
+
+		if (IS_ERR(power_zone)) {
+			dev_err(sp->dev, "Failed to register power_zone %s\n",
+				sd->name);
+			ret = PTR_ERR(power_zone);
+			/* Unregister in reverse order: children first, then SOC, then SYS */
+			for (int j = i - 1; j >= 0; j--)
+				powercap_unregister_zone(sp->control_type,
+							 &sp->domains[j].power_zone);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int spel_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct powercap_control_type *ct;
+	struct spel_system *sp;
+	int ret;
+
+	sp = kzalloc_obj(struct spel_system);
+	if (!sp)
+		return -ENOMEM;
+
+	sp->dev = dev;
+
+	/* Map config registers (units, capabilities) */
+	sp->config_base = devm_platform_ioremap_resource_byname(pdev, "config");
+	if (IS_ERR(sp->config_base)) {
+		ret = PTR_ERR(sp->config_base);
+		goto err_free_sp;
+	}
+
+	/* Map constraint registers (power limits) */
+	sp->constraint_base = devm_platform_ioremap_resource_byname(pdev, "constraints");
+	if (IS_ERR(sp->constraint_base)) {
+		ret = PTR_ERR(sp->constraint_base);
+		goto err_free_sp;
+	}
+
+	/* Map spel domain registers (energy counters) */
+	sp->node_base = devm_platform_ioremap_resource_byname(pdev, "nodes");
+	if (IS_ERR(sp->node_base)) {
+		ret = PTR_ERR(sp->node_base);
+		goto err_free_sp;
+	}
+
+	sp->control_type = powercap_register_control_type(NULL, "qcom-spel",
+							  NULL);
+	if (IS_ERR(sp->control_type)) {
+		dev_err(dev, "Failed to register control type\n");
+		ret = PTR_ERR(sp->control_type);
+		goto err_free_sp;
+	}
+
+	/* Save control_type before it might be freed by spel_release_zone() */
+	ct = sp->control_type;
+
+	/* Initialize system and domains */
+	ret = spel_init_system(sp, dev);
+	if (ret) {
+		dev_err(dev, "Failed to initialize system\n");
+		goto err_unregister_control;
+	}
+
+	ret = spel_register_powercap(sp);
+	if (ret) {
+		dev_err(dev, "Failed to register powercap zones\n");
+		/*
+		 * If SYS zone was registered, err_cleanup inside spel_register_powercap
+		 * already unregistered all zones and spel_release_zone freed sp->domains.
+		 * If SYS was never registered (sp->power_zone == NULL), free manually.
+		 */
+		if (!sp->power_zone)
+			kfree(sp->domains);
+		kfree(sp);
+		powercap_unregister_control_type(ct);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, sp);
+
+	return 0;
+
+err_unregister_control:
+	powercap_unregister_control_type(ct);
+err_free_sp:
+	kfree(sp);
+	return ret;
+}
+
+static void spel_remove(struct platform_device *pdev)
+{
+	struct spel_system *sp = platform_get_drvdata(pdev);
+	struct powercap_control_type *ct = sp->control_type;
+
+	/*
+	 * Unregister in reverse order: children first, then SOC, then SYS.
+	 */
+	for (int i = ARRAY_SIZE(spel_domain_names) - 1; i >= 0; i--)
+		powercap_unregister_zone(ct, &sp->domains[i].power_zone);
+
+	powercap_unregister_control_type(ct);
+
+	kfree(sp);
+}
+
+static const struct of_device_id spel_of_match[] = {
+	{ .compatible = "qcom,glymur-spel" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spel_of_match);
+
+static struct platform_driver spel_driver = {
+	.probe = spel_probe,
+	.remove = spel_remove,
+	.driver = {
+		.name = "qcom_spel",
+		.of_match_table = spel_of_match,
+	},
+};
+
+module_platform_driver(spel_driver);
+
+MODULE_DESCRIPTION("Qualcomm SPEL Powercap Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

