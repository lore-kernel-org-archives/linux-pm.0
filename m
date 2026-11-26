Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690844;
	b=pyK/MaExmoOk8wCjh/MtU3PYbzaJ6SbiQM8v/YWVY8J7NpxtL7AqcYB9JJtS0vrm4e4P
	 kdujwPlA/P2qwwom0m7b7DZLs4nmHdyXo6+G5bspWVvtaPOAXJWW8yibmI2KzMMNIktiy
	 yz1g5MnstiPjAdYSXProi765710uxdul9YzJfhhcHpg0iRwIMW+53ZjLKJ9t/+QSXezW0
	 VP/k93+65GInzsOHdMjJVhd7dbgOcdvfLF4TsMRfz/v/f7r2ibLkFFQ3V/musyC7J/vxC
	 rVC4hfNs7ejB1oeJpkYXY4BBQpe25evzVk11UVBceF3TEZijOfHf8LuT54vOHpDs48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690844;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hC5j3yYvZkzOJ/ykWx13Jh1oYG73M5th0dRp0/OdTG4=;
	b=Ch500l55w40tr0UByzItMa9hTgTH0gS2v0mtXXM964FEK3G0sMa9H78obo1QeZKjnopl
	 qFPkLqwwYDZGeTYTtjirQO41QkQCIDoDdeVwiYhezxGsl9SlgoyXfJ9P03qwjfQysExvD
	 rCp2tXCQ9c8iOBBnoOfCW6MJRpxszzzpwdgNLZPzaZhqjTR2Gnm7h4z4t0dNmaKMarjqj
	 lcin/EK4/xLXl3YZx9G4MXv3eorTFsEhInZ1PM1oOrESWjFKbsOthmqNW5/9ebwctNmNj
	 sii0yLN+9wmkNCugrDDlwfNsS0AxZdHOI9LPCivtbF0NR65enT81jNz+6oXQ1ksiL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPbrRJfZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="clM/IN1P";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24776606A327
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24776606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPbrRJfZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=clM/IN1P
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQAXLkV2629930
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hC5j3yYvZkzOJ/ykWx13Jh1oYG73M5th0dRp0/OdTG4=; b=LPbrRJfZmxMqjRMn
	iT8voFheCmgXsimEqV19td+gL71gziOjwUYwt7a0mpvbo7sjdzZYCPNBtoUYjvzG
	pmFcqcrF+MG/74Xc6VAI1O8c7EfyYif0c0xSjjssz98Rpvlgriu9FNjKB/5Lj5LR
	ukf50trjAs7pDAOw9EFNiSe46VTRJ6f4PD+4RpnubYStPV5f/4mZ+sx748VydBxy
	OqFomyW9uvsnZsq1fJJtk/oH5ioZ4L9E2RR9PHGirqjN5dTQg6BDRn0cHzqpsJkr
	EcSNP3IVArAd4+rYERGdq/osA6NptzXh2Ho1xZoCuYs90h93Hdty6lIp7RhSNyTA
	5wixJA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahv45p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:00:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f02c63901aso62308825ad.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795690842; x=1796295642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hC5j3yYvZkzOJ/ykWx13Jh1oYG73M5th0dRp0/OdTG4=;
        b=clM/IN1PR3OQqcLJowc3C6DqdNKJ0/L5k3aIEDzkj33LDepXt6Gps4DjpnID/irD5Y
         aKhAlD/KfJ7mq8U51oQfHojAZ4WD6jUpIPfq+Eufz90U5UkB+BIUU4ZFe2Sh9yKpSxBn
         SwR/7VH/8wLptxWzfvViNR8tBBTyiag86deKyU6vOn4/RvQKumQl6nzh7RPSaL9Fj1gH
         cesBeHXhKBsre7fclbVvmMPCKudMVXWA9QG4ix7F+6kc3vAKStfjD6sWrpfk4FUVyQPv
         u0O1hzDWF+mrAxQcpVVKTYrMPmA52Iuc801mUFJFJgyZds1oNFxUDeEUk6kHcymCYuG1
         ONGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690842; x=1796295642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hC5j3yYvZkzOJ/ykWx13Jh1oYG73M5th0dRp0/OdTG4=;
        b=lMBz1gTt+o0j7kEEvNUWE11SYgfCx643YMeDcMdlkx1tfcMmxJesVJc67oGczy/ant
         W/W3hYgpq6+vrCetsZdJerzcc9F34SE9QIOqnz0Mjcx8o2ZAW3+Sx6CBmIPDR0Fek8BP
         aMtSTdhTzMIl7cYyvmKzBHDTw/x7sCjE9329Yz4lqMGLBBSfnSWj4Lm/w9mjHVnxZYC0
         /eUQ1l4q+eInT7N7aDl4/EnNF+6g7md3eJcqGdKzXxC8Mvki9zVFZ/OWItDBSwKYfbjM
         492pAV8pNXDBsIybylEt3gFbpMaDVPR79e8z5cVpJh7GqHa3FTVmq8Key67IL7uN8I+j
         jYcA==
X-Gm-Message-State: APuU4Z9jWak3/ymXSEDmmj7voprUO+RmbTVNBz/NQsVCDLlvtZqtNJaE
	+3mMOk/N1EzYqUE+KnnOcjNm9cRwNpsDHPvtVvnPLVHnKGPjdJx87whX1i7hKxzIOejYvO1w0KD
	/Awh6L/P0JX0WknRVPv8vRpwPLfUoYZ3DtyNwU/lS2mZjjT+eTNuPYI+QbL91rA==
X-Gm-Gg: AZFdTZeCGDAGGU3tNRFUDHDawIRrzbdIyixPVC/CBC78oO8CYlqUVL4njk/kYFB5pFp
	Y5kg3UfOWbn+nr1VUxYIFgTAiJs23FGLuFfbVWOv+kXKEAZ9CDn7ITc5oOubIsIb5chsAUyzect
	xFLINDlmBZtfVeyvO/VylZIVqAbOyPFRLrxSCLM87A+K/xMxErwudluX3eHARpHQmZRGdgIQc2x
	aNEe3OGE1C2IhU4k+NK5KaUf2q1VUp+66CqzKbwGybDt5riZ6oe2090FNcgkRvgRb8WvAUNxe5d
	4ss2S/24UlJZSmJMjbxkn7rkWQ+uxWNxag8+OycqbE0aXtR+j9Xvr59NM1eV50kfGWnBYvDHay8
	wZnibzECB4hc/oMz8tKQMqTukJ5G8Q/9WGyIV5ouxgrOx5QtdcSP7rTP7hmbAAcAkYInBmKaIxK
	A=
X-Received: by 2002:a17:903:1ce:b0:2ef:d157:e128 with SMTP id d9443c01a7336-2f03f1e8493mr208584845ad.52.1795690840579;
        Thu, 26 Nov 2026 03:00:40 -0800 (PST)
X-Received: by 2002:a17:903:1ce:b0:2ef:d157:e128 with SMTP id d9443c01a7336-2f03f1e8493mr208583965ad.52.1795690839505;
        Thu, 26 Nov 2026 03:00:39 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm101400615ad.17.2026.11.26.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:00:39 -0800 (PST)
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:30:18 +0530
Subject: [PATCH v2 2/2] power: supply: qcom_smbx: Add PM4125 SMBLite
 charger support
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-smblite-charger-for-pm4125-v2-2-20656509518b@oss.qualcomm.com>
References: <20261126-smblite-charger-for-pm4125-v2-0-20656509518b@oss.qualcomm.com>
In-Reply-To: <20261126-smblite-charger-for-pm4125-v2-0-20656509518b@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mfd@lists.linux.dev, Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raj Aryan <raj.aryan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795690821; l=48274;
 i=raj.aryan@oss.qualcomm.com; s=20260507; h=from:subject:message-id;
 bh=04VGS5Sx+/PT8SunGep3AxVtq6D+DJ1DnMjUq62QFyU=;
 b=tfKZVREQbRraN2F8lquJ34q+JzeyDAd4/OrSEgg/3Ff3l5VxL53LRd8uanEKR5yk5YAYQFujm
 qYp4a2AmJ2YCvThzhjIDTy/7VMv+UztdtKgHnAMP1A0yzjTgV3I0eE9
X-Developer-Key: i=raj.aryan@oss.qualcomm.com; a=ed25519;
 pk=NMkZ/eGFLSObYX6FfysQiuEElPoUYghk7+2Jtc4VEBQ=
X-Proofpoint-GUID: X-Pi0s6ZaNEX7CGKaxeLceauQhlEGnbY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfXwbPP6TcYNh/w
 zj+KehqXBm6RKD2zl81ZPHZ4V+3XYt1hwBh2XSjrIpkeuwZTGak9YIv73Wwk0WIdNTPOL2jZt93
 8IJgxoqsYZoZtDGKe9vTAsQWrtld/is=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX8U9bEXhs803k
 OcXaqEVA1dN4my4vLlPf/VAXcFvXi0VUVsQ9+8xfsyUI8Zpo2nUYN3362h+m1q0Sye1jD40qMtI
 fWwyTFglqVzu5sSnYqVMLSdnqs/Fj+VAas3Guo/3bonpWg/2w1TBB6k+8OgnKVGF7LxVMPag71L
 9s1qr6Dc2hg2jJJUVsYMxRQqD8zW3S1Eg9sqVxlHJr0G5pZ4tFfLmTuo3CPFRF6ULSY7njTRwj7
 YMIkiNVrTGHGNer5P3lw8ZHKVmCaaDJkv7t8BkdkeuPyCHGKJHrvhi/ZINhHRSwoajaqZmBLE0G
 XdNoDi5UZOLgN/dXWhsQRPmezAoExXaINw/jpu3M95ndAg6vixkwl1EplFm5iZNVbSPgcS0dTfH
 F1vgG8tTcmmViMy9iQ52WIFS+LzsLAFBi0tmBpFA0wGkcp6LEenTyniomswJTXAeB/m8+fcjlV2
 fuNNkArfzCIpGomMWgQ==
X-Proofpoint-ORIG-GUID: X-Pi0s6ZaNEX7CGKaxeLceauQhlEGnbY
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b08115a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ZtA6beOwL2YdRPoJx1oA:9
 a=XOvi_61WkF7neQbg:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260042

PM4125 uses the SMBLite charger IP, a reduced-feature variant of SMB2.
While both use the same SPMI bus and driver model, they differ in register
layout, status reporting, recharge mode and JEITA configuration. Extend
qcom_smbx to handle these differences so PM4125 can use the existing
charger driver. Select register bases and handling based on chip->type,
allowing SMB2 and SMBLite to share one driver and power-supply class
device.

Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 drivers/power/supply/qcom_smbx.c | 1081 ++++++++++++++++++++++++++++++++++----
 1 file changed, 969 insertions(+), 112 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index c6188c915703..d23e5ec85858 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -4,8 +4,9 @@
  * Copyright (c) 2023, Linaro Ltd.
  * Author: Casey Connolly <casey.connolly@linaro.org>
  *
- * This driver is for the switch-mode battery charger and boost
- * hardware found in pmi8998 and related PMICs.
+ * This driver supports the switch-mode battery charger found in:
+ *   - PMI8998 / PM660  (SMB2 IP)
+ *   - PM4125           (SMBLite IP)
  */
 
 #include <linux/bits.h>
@@ -20,8 +21,16 @@
 #include <linux/of.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/pm_wakeup.h>
+
+/* PMIC IP types */
+enum smb_type {
+	SMB2,		/* PMI8998, PM660 - SMB2 IP */
+	SMBLITE,	/* PM4125 - SMBLite IP */
+};
 
 /* clang-format off */
 #define BATTERY_CHARGER_STATUS_1			0x06
@@ -355,6 +364,118 @@
 #define SMB2_FLOAT_VOLTAGE_MIN_UV			3487500
 #define SMB2_FLOAT_VOLTAGE_MAX_UV			4920000
 #define SMB2_FLOAT_VOLTAGE_STEP_UV			7500
+
+/* ================================================================
+ * SMBLite specific registers and base addresses
+ * Source: downstream smblite-reg.h (qpnp-smblite driver)
+ * ================================================================
+ */
+/* SMBLite peripheral base addresses (PM4125) */
+#define SMBLITE_CHGR_BASE			0x1000
+#define SMBLITE_DCDC_BASE			0x1100
+#define SMBLITE_BATIF_BASE			0x1200
+#define SMBLITE_USBIN_BASE			0x1300
+/* 0x1500 (typec) belongs to the qcom,pm4125-typec peripheral, not this driver */
+#define SMBLITE_MISC_BASE			0x1600
+
+/* ---- SMBLITE CHGR registers (chg_base offsets) ---- */
+
+#define SMBLITE_BATTERY_CHARGER_STATUS_1	0x06
+#define SMBLITE_CHARGER_VBAT_STATUS		0x08
+#define SMBLITE_BAT_OV_BIT			BIT(7)
+
+#define SMBLITE_CHARGING_ENABLE_CMD		0x46
+#define SMBLITE_CHARGING_ENABLE_CMD_BIT		BIT(0)
+
+#define SMBLITE_CHGR_FAST_CHARGE_CURRENT_CFG	0x54
+#define SMBLITE_CHGR_FLOAT_VOLTAGE_CFG		0x58
+/*
+ * chg_base + 0x60 = CHGR_TERM_CFG_REG (termination current config).
+ * SMBLite has NO pre-charge current register at this offset.
+ * Do NOT write pre-charge current to 0x60.
+ */
+#define SMBLITE_CHGR_CHG_TERM_CFG		0x60
+
+#define SMBLITE_CHGR_RECHG_CFG			0x70
+#define SMBLITE_RECHG_MASK			GENMASK(7, 6)
+#define SMBLITE_CHGR_RECHG_SOC_THD_CFG		0x74
+#define SMBLITE_CHGR_CHG_INHIBIT_CFG		0x78
+
+/*
+ * ---- SMBLite DCDC registers (dcdc_base offsets) ----
+ * This peripheral also holds the OTG/VBUS enable registers (0x50/0x52/0x56),
+ * which belong to the qcom,pm4125-vbus-reg peripheral and are intentionally
+ * not touched here. The three below are status/config registers with no
+ * other home, so they are read directly by this driver.
+ */
+#define SMBLITE_ICL_STATUS			0x09
+
+#define SMBLITE_POWER_PATH_STATUS		0x0B
+#define SMBLITE_VALID_INPUT_POWER_SOURCE_BIT	BIT(7)
+#define SMBLITE_USE_USBIN_BIT			BIT(5)
+
+#define SMBLITE_DCDC_LDO_CFG			0x70
+#define SMBLITE_LDO_MODE_BIT			BIT(0)
+
+#define SMBLITE_BATIF_BPD_CFG			0x60
+
+#define SMBLITE_BATIF_JEITA_COMP_STATUS		0x0C
+#define SMBLITE_JEITA_ADC_THOT_AFP_BIT		BIT(5)
+#define SMBLITE_JEITA_ADC_THOT_BIT		BIT(4)
+#define SMBLITE_JEITA_ADC_WARM_BIT		BIT(3)
+#define SMBLITE_JEITA_ADC_COOL_BIT		BIT(2)
+#define SMBLITE_JEITA_ADC_TCOLD_BIT		BIT(1)
+#define SMBLITE_JEITA_ADC_TCOLD_AFP_BIT		BIT(0)
+
+#define SMBLITE_JEITA_HOT_THRESHOLD_CFG		0x84
+#define SMBLITE_JEITA_WARM_THRESHOLD_CFG	0x86
+#define SMBLITE_JEITA_COOL_THRESHOLD_CFG	0x88
+#define SMBLITE_JEITA_COLD_THRESHOLD_CFG	0x8A
+
+#define SMBLITE_APSD_STATUS			0x0A
+#define SMBLITE_APSD_RESULT_STATUS		0x0B
+#define SMBLITE_CMD_APSD			0x45
+#define SMBLITE_USB_APSD_EN			0x44
+#define SMBLITE_USB_APSD_CFG			0x46
+#define SMBLITE_USBIN_QC23_EN			0x48
+#define SMBLITE_HVDCP_EN_BIT			BIT(2)
+
+#define SMBLITE_USBIN_ICL_OPTIONS		0x50
+#define SMBLITE_USBIN_MODE_CHG_BIT		BIT(2)
+#define SMBLITE_USB51_MODE_BIT			BIT(1)
+
+#define SMBLITE_USBIN_CURRENT_LIMIT_CFG		0x52
+#define SMBLITE_USBIN_INPUT_SUSPEND		0x54
+#define SMBLITE_SUSPEND_ON_COLLAPSE_USBIN_BIT	BIT(7)
+
+#define SMBLITE_USBIN_AICL_OPTIONS_CFG		0x60
+#define SMBLITE_USBIN_AICL_EN_BIT		BIT(7)
+#define SMBLITE_USBIN_AICL_START_AT_MAX		BIT(4)
+
+#define SMBLITE_MISC_AICL_RERUN_CFG		0x54
+#define SMBLITE_USBIN_AICL_PERIODIC_RERUN_EN_BIT BIT(5)
+#define SMBLITE_USBIN_AICL_RERUN_TIME_MASK	GENMASK(1, 0)
+#define SMBLITE_AICL_RERUN_TIME_12S_VAL		0x01
+
+#define SMBLITE_WD_CFG				0x58
+#define SMBLITE_BITE_WDOG_DISABLE_CHARGING_CFG_BIT BIT(7)
+#define SMBLITE_BARK_WDOG_INT_EN_BIT		BIT(4)
+#define SMBLITE_WDOG_TIMER_EN_ON_PLUGIN_BIT	BIT(1)
+#define SMBLITE_WDOG_TIMER_EN_BIT		BIT(0)
+#define SMBLITE_SNARL_BARK_BITE_WD_CFG		0x59
+#define SMBLITE_BARK_BITE_WDOG_PET		0x5A
+#define SMBLITE_BARK_WDOG_TIMEOUT_MASK		GENMASK(5, 4)	/* 0x30 */
+#define SMBLITE_BITE_WDOG_TIMEOUT_MASK		GENMASK(7, 6)	/* 0xC0 */
+#define SMBLITE_BITE_WDOG_TIMEOUT_8S		0x3
+#define SMBLITE_BITE_WDOG_TIMEOUT_SHIFT		6
+
+#define SMBLITE_ICL_STEP_UA			100000
+#define SMBLITE_FCC_STEP_UA			100000
+#define SMBLITE_ICL_MAX_UA			2000000
+#define SMBLITE_FV_STEP_UV			20000
+#define SMBLITE_FV_MIN_UV			3600000
+#define SMBLITE_FV_MAX_UV			4600000
+
 /* clang-format on */
 
 enum charger_status {
@@ -368,6 +489,17 @@ enum charger_status {
 	DISABLE_CHARGE,
 };
 
+enum smblite_charger_status {
+	SMBLITE_INHIBIT_CHARGE = 0,
+	SMBLITE_TRICKLE_CHARGE,
+	SMBLITE_PRE_CHARGE,
+	SMBLITE_FULLON_CHARGE,
+	SMBLITE_TAPER_CHARGE,
+	SMBLITE_TERMINATE_CHARGE,
+	SMBLITE_CHARGING_PAUSED,
+	SMBLITE_CHARGING_DISABLED,
+};
+
 struct smb_init_register {
 	u16 addr;
 	u8 mask;
@@ -377,6 +509,7 @@ struct smb_init_register {
 /**
  * struct smb_chip - smb chip structure
  * @dev:		Device reference for power_supply
+ * @type: PMIC IP type (SMB2 or SMBLITE)
  * @name:		The platform device name
  * @base:		Base address for smb registers
  * @regmap:		Register map
@@ -384,13 +517,19 @@ struct smb_init_register {
  * @initial_charge_enable: Charging enable state before hardware setup
  * @status_change_work: Worker to handle plug/unplug events
  * @cable_irq:		USB plugin IRQ
+ * @wdog_irq:		Watchdog bark IRQ
  * @wakeup_enabled:	If the cable IRQ will cause a wakeup
  * @usb_in_i_chan:	USB_IN current measurement channel
  * @usb_in_v_chan:	USB_IN voltage measurement channel
  * @chg_psy:		Charger power supply instance
+ * @ldo_mode: True if operating in LDO mode (SMBLITE only)
+ * @icl_step_ua: ICL step size in uA
+ * @icl_max_ua: Maximum ICL in uA
+ * @charge_status: Cached POWER_SUPPLY_STATUS_* value
  */
 struct smb_chip {
 	struct device *dev;
+	enum smb_type type;
 	const char *name;
 	unsigned int base;
 	struct regmap *regmap;
@@ -399,12 +538,17 @@ struct smb_chip {
 
 	struct delayed_work status_change_work;
 	int cable_irq;
+	int wdog_irq;
 	bool wakeup_enabled;
 
 	struct iio_channel *usb_in_i_chan;
 	struct iio_channel *usb_in_v_chan;
 
 	struct power_supply *chg_psy;
+	bool ldo_mode;
+	unsigned int icl_step_ua;
+	unsigned int icl_max_ua;
+	int charge_status;
 };
 
 static enum power_supply_property smb_properties[] = {
@@ -419,19 +563,49 @@ static enum power_supply_property smb_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
+static enum power_supply_property smblite_properties[] = {
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+/*
+ * smb_get_prop_usb_online - check whether a valid USB input is present.
+ *
+ * SMB2  (0x60B): P_PATH_USE_USBIN BIT(4) && VALID_INPUT BIT(0)
+ * SMBLite (dcdc_base + 0x0B = 0x110B):
+ *   VALID_INPUT_POWER_SOURCE_STS BIT(7) && USE_USBIN BIT(5)
+ */
 static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
 {
 	unsigned int stat;
+	u16 reg;
 	int rc;
 
-	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS, &stat);
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_DCDC_BASE + SMBLITE_POWER_PATH_STATUS;
+	else
+		reg = chip->base + POWER_PATH_STATUS;
+
+	rc = regmap_read(chip->regmap, reg, &stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Couldn't read power path status: %d\n", rc);
 		return rc;
 	}
 
-	*val = (stat & P_PATH_USE_USBIN_BIT) &&
-	       (stat & P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT);
+	if (chip->type == SMBLITE)
+		*val = (stat & SMBLITE_VALID_INPUT_POWER_SOURCE_BIT) &&
+		       (stat & SMBLITE_USE_USBIN_BIT);
+	else
+		*val = (stat & P_PATH_USE_USBIN_BIT) &&
+		       (stat & P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT);
+
 	return 0;
 }
 
@@ -442,6 +616,7 @@ static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
 static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 {
 	unsigned int apsd_stat, stat;
+	u16 apsd_reg, result_reg;
 	int usb_online = 0;
 	int rc;
 
@@ -451,7 +626,15 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 		return rc;
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + APSD_STATUS, &apsd_stat);
+	if (chip->type == SMBLITE) {
+		apsd_reg   = SMBLITE_USBIN_BASE + SMBLITE_APSD_STATUS;
+		result_reg = SMBLITE_USBIN_BASE + SMBLITE_APSD_RESULT_STATUS;
+	} else {
+		apsd_reg   = chip->base + APSD_STATUS;
+		result_reg = chip->base + APSD_RESULT_STATUS;
+	}
+
+	rc = regmap_read(chip->regmap, apsd_reg, &apsd_stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Failed to read apsd status, rc = %d", rc);
 		return rc;
@@ -461,7 +644,7 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 		return -EAGAIN;
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + APSD_RESULT_STATUS, &stat);
+	rc = regmap_read(chip->regmap, result_reg, &stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Failed to read apsd result, rc = %d", rc);
 		return rc;
@@ -479,11 +662,33 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 	return 0;
 }
 
+static unsigned int smb_usb_type_current_ua(enum power_supply_usb_type usb_type)
+{
+	switch (usb_type) {
+	case POWER_SUPPLY_USB_TYPE_CDP:
+		return CDP_CURRENT_UA;
+	case POWER_SUPPLY_USB_TYPE_DCP:
+		return DCP_CURRENT_UA;
+	case POWER_SUPPLY_USB_TYPE_SDP:
+	default:
+		return SDP_CURRENT_UA;
+	}
+}
+
+/*
+ * smb_get_prop_status - report POWER_SUPPLY_STATUS_* for the battery.
+ *
+ * BAT_OV detection:
+ *   SMB2:    BATTERY_CHARGER_STATUS_2 (chip->base + 0x07), BIT(5)
+ *   SMBLite: CHARGER_VBAT_STATUS_REG (chg_base + 0x08 = 0x1008), BIT(7)
+ *
+ * Charger status enum differs between IPs -- handled by dedicated branches.
+ */
 static int smb_get_prop_status(struct smb_chip *chip, int *val)
 {
-	unsigned char stat[2];
-	int usb_online = 0;
-	int rc;
+	unsigned int chg_status, stat_batov;
+	u16 chg_status_reg, reg_batov;
+	int usb_online = 0, rc;
 
 	rc = smb_get_prop_usb_online(chip, &usb_online);
 	if (!usb_online) {
@@ -491,65 +696,132 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
 		return rc;
 	}
 
-	rc = regmap_bulk_read(chip->regmap,
-			      chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
+	if (chip->type == SMBLITE) {
+		chg_status_reg = SMBLITE_CHGR_BASE + SMBLITE_BATTERY_CHARGER_STATUS_1;
+		reg_batov = SMBLITE_CHGR_BASE + SMBLITE_CHARGER_VBAT_STATUS;
+	} else {
+		chg_status_reg = chip->base + BATTERY_CHARGER_STATUS_1;
+		reg_batov = chip->base + BATTERY_CHARGER_STATUS_2;
+	}
+
+	rc = regmap_read(chip->regmap, reg_batov, &stat_batov);
 	if (rc < 0) {
-		dev_err(chip->dev, "Failed to read charging status ret=%d\n",
-			rc);
+		dev_err(chip->dev, "Failed to read bat-ov status ret=%d\n", rc);
 		return rc;
 	}
 
-	if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
-		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		return 0;
+	/* Check BAT_OV -- different register/bit per IP */
+	if (chip->type == SMBLITE) {
+		if (stat_batov & SMBLITE_BAT_OV_BIT) {
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			return 0;
+		}
+	} else {
+		if (stat_batov & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			return 0;
+		}
 	}
 
-	stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
-
-	switch (stat[0]) {
-	case TRICKLE_CHARGE:
-	case PRE_CHARGE:
-	case FAST_CHARGE:
-	case FULLON_CHARGE:
-	case TAPER_CHARGE:
-		*val = POWER_SUPPLY_STATUS_CHARGING;
-		return rc;
-	case DISABLE_CHARGE:
-		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		return rc;
-	case TERMINATE_CHARGE:
-	case INHIBIT_CHARGE:
-		*val = POWER_SUPPLY_STATUS_FULL;
-		return rc;
-	default:
-		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	rc = regmap_read(chip->regmap, chg_status_reg, &chg_status);
+	if (rc < 0) {
+		dev_err(chip->dev, "Failed to read charging status ret=%d\n", rc);
 		return rc;
 	}
+
+	chg_status &= BATTERY_CHARGER_STATUS_MASK;
+
+	if (chip->type == SMBLITE) {
+		switch (chg_status) {
+		case SMBLITE_TRICKLE_CHARGE:
+		case SMBLITE_PRE_CHARGE:
+		case SMBLITE_FULLON_CHARGE:
+		case SMBLITE_TAPER_CHARGE:
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+		case SMBLITE_TERMINATE_CHARGE:
+			*val = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_status = POWER_SUPPLY_STATUS_FULL;
+			break;
+		case SMBLITE_INHIBIT_CHARGE:
+		case SMBLITE_CHARGING_PAUSED:
+		case SMBLITE_CHARGING_DISABLED:
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		default:
+			*val = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+	} else {
+		switch (chg_status) {
+		case TRICKLE_CHARGE:
+		case PRE_CHARGE:
+		case FAST_CHARGE:
+		case FULLON_CHARGE:
+		case TAPER_CHARGE:
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+		case DISABLE_CHARGE:
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		case TERMINATE_CHARGE:
+		case INHIBIT_CHARGE:
+			*val = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_status = POWER_SUPPLY_STATUS_FULL;
+			break;
+		default:
+			*val = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+	}
+
+	return 0;
 }
 
 static inline int smb_get_current_limit(struct smb_chip *chip,
 					 unsigned int *val)
 {
-	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
+	u16 reg;
+	int rc;
+
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_DCDC_BASE + SMBLITE_ICL_STATUS;
+	else
+		reg = chip->base + ICL_STATUS;
 
+	rc = regmap_read(chip->regmap, reg, val);
 	if (rc >= 0)
-		*val *= CURRENT_SCALE_FACTOR;
+		*val *= chip->icl_step_ua;
 	return rc;
 }
 
 static int smb_set_current_limit(struct smb_chip *chip, unsigned int val)
 {
 	unsigned char val_raw;
+	u16 reg;
 
-	if (val > 4800000) {
-		dev_err(chip->dev,
-			"Can't set current limit higher than 4800000uA");
+	if (val > chip->icl_max_ua) {
+		dev_err(chip->dev, "Can't set current limit higher than %duA",
+			chip->icl_max_ua);
 		return -EINVAL;
 	}
-	val_raw = val / CURRENT_SCALE_FACTOR;
 
-	return regmap_write(chip->regmap, chip->base + USBIN_CURRENT_LIMIT_CFG,
-			    val_raw);
+	val_raw = val / chip->icl_step_ua;
+
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_USBIN_BASE + SMBLITE_USBIN_CURRENT_LIMIT_CFG;
+	else
+		reg = chip->base + USBIN_CURRENT_LIMIT_CFG;
+
+	return regmap_write(chip->regmap, reg, val_raw);
 }
 
 static void smb_status_change_work(struct work_struct *work)
@@ -579,27 +851,20 @@ static void smb_status_change_work(struct work_struct *work)
 	}
 
 	if (rc < 0) {
-		rc = regmap_update_bits(chip->regmap, chip->base + CMD_APSD,
-					APSD_RERUN_BIT, APSD_RERUN_BIT);
+		if (chip->type == SMBLITE)
+			rc = regmap_update_bits(chip->regmap,
+						SMBLITE_USBIN_BASE + SMBLITE_CMD_APSD,
+						APSD_RERUN_BIT, APSD_RERUN_BIT);
+		else
+			rc = regmap_update_bits(chip->regmap, chip->base + CMD_APSD,
+						APSD_RERUN_BIT, APSD_RERUN_BIT);
 		schedule_delayed_work(&chip->status_change_work,
 				      msecs_to_jiffies(1000));
 		dev_dbg(chip->dev, "get charger type failed, rerun apsd\n");
 		return;
 	}
 
-	switch (charger_type) {
-	case POWER_SUPPLY_USB_TYPE_CDP:
-		current_ua = CDP_CURRENT_UA;
-		break;
-	case POWER_SUPPLY_USB_TYPE_DCP:
-		current_ua = DCP_CURRENT_UA;
-		break;
-	case POWER_SUPPLY_USB_TYPE_SDP:
-	default:
-		current_ua = SDP_CURRENT_UA;
-		break;
-	}
-
+	current_ua = smb_usb_type_current_ua(charger_type);
 	smb_set_current_limit(chip, current_ua);
 	power_supply_changed(chip->chg_psy);
 }
@@ -623,11 +888,61 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
 	return iio_read_channel_processed(chan, val);
 }
 
+/*
+ * smb_get_prop_health - battery health based on temperature status.
+ *
+ * SMBLite: BATTERY_TEMP_STATUS_REG = batif_base + 0x0C (smblite-reg.h)
+ * SMB2:    BATTERY_CHARGER_STATUS_2 = chip->base + 0x07
+ */
 static int smb_get_prop_health(struct smb_chip *chip, int *val)
 {
 	int rc;
 	unsigned int stat;
 
+	if (chip->type == SMBLITE) {
+		rc = regmap_read(chip->regmap,
+				 SMBLITE_CHGR_BASE + SMBLITE_CHARGER_VBAT_STATUS,
+				 &stat);
+		if (rc < 0) {
+			dev_err(chip->dev,
+				"Couldn't read SMBLITE vbat status rc=%d\n", rc);
+			return rc;
+		}
+		if (stat & SMBLITE_BAT_OV_BIT) {
+			*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+			return 0;
+		}
+
+		rc = regmap_read(chip->regmap,
+				 SMBLITE_BATIF_BASE + SMBLITE_BATIF_JEITA_COMP_STATUS,
+				 &stat);
+		if (rc < 0) {
+			dev_err(chip->dev,
+				"Couldn't read SMBLITE JEITA status rc=%d\n", rc);
+			return rc;
+		}
+		if (stat & (SMBLITE_JEITA_ADC_THOT_AFP_BIT |
+			    SMBLITE_JEITA_ADC_THOT_BIT)) {
+			*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+			return 0;
+		}
+		if (stat & (SMBLITE_JEITA_ADC_TCOLD_AFP_BIT |
+			    SMBLITE_JEITA_ADC_TCOLD_BIT)) {
+			*val = POWER_SUPPLY_HEALTH_COLD;
+			return 0;
+		}
+		if (stat & SMBLITE_JEITA_ADC_WARM_BIT) {
+			*val = POWER_SUPPLY_HEALTH_WARM;
+			return 0;
+		}
+		if (stat & SMBLITE_JEITA_ADC_COOL_BIT) {
+			*val = POWER_SUPPLY_HEALTH_COOL;
+			return 0;
+		}
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		return 0;
+	}
+
 	rc = regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_2,
 			 &stat);
 	if (rc < 0) {
@@ -667,6 +982,8 @@ static int smb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_get_current_limit(chip, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (chip->type == SMBLITE)
+			return -EOPNOTSUPP;
 		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
 					 &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -680,6 +997,30 @@ static int smb_get_property(struct power_supply *psy,
 		return smb_get_prop_health(chip, &val->intval);
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return smb_apsd_get_charger_type(chip, &val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE: {
+		int status, rc;
+
+		if (chip->type != SMBLITE)
+			return -EOPNOTSUPP;
+
+		rc = smb_get_prop_status(chip, &status);
+		if (rc < 0)
+			return rc;
+
+		switch (status) {
+		case POWER_SUPPLY_STATUS_FULL:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+			break;
+		case POWER_SUPPLY_STATUS_CHARGING:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+			break;
+		default:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+			break;
+		}
+
+		return 0;
+	}
 	default:
 		dev_err(chip->dev, "invalid property: %d\n", psp);
 		return -EINVAL;
@@ -694,6 +1035,8 @@ static int smb_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		if (chip->type == SMBLITE)
+			return -EINVAL;
 		return regmap_update_bits(chip->regmap, chip->base + USBIN_CMD_IL,
 					  USBIN_SUSPEND_BIT, !val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
@@ -707,8 +1050,11 @@ static int smb_set_property(struct power_supply *psy,
 static int smb_property_is_writable(struct power_supply *psy,
 				     enum power_supply_property psp)
 {
+	struct smb_chip *chip = power_supply_get_drvdata(psy);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		return chip->type != SMBLITE;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return 1;
 	default:
@@ -716,35 +1062,94 @@ static int smb_property_is_writable(struct power_supply *psy,
 	}
 }
 
+/*
+ * smb_handle_batt_overvoltage - IRQ handler for battery overvoltage.
+ *
+ * SMB2:    chip->base + BATTERY_CHARGER_STATUS_2 (offset 0x07), BIT(5)
+ * SMBLite: SMBLITE_CHGR_BASE + SMBLITE_CHARGER_VBAT_STATUS (0x1008), BIT(7)
+ */
 static irqreturn_t smb_handle_batt_overvoltage(int irq, void *data)
 {
 	struct smb_chip *chip = data;
 	unsigned int status;
+	u16 reg;
+	u8 bit;
 	int rc;
 
-	rc = regmap_read(chip->regmap,
-			 chip->base + BATTERY_CHARGER_STATUS_2, &status);
+	if (chip->type == SMBLITE) {
+		reg = SMBLITE_CHGR_BASE + SMBLITE_CHARGER_VBAT_STATUS;
+		bit = SMBLITE_BAT_OV_BIT;
+	} else {
+		reg = chip->base + BATTERY_CHARGER_STATUS_2;
+		bit = CHARGER_ERROR_STATUS_BAT_OV_BIT;
+	}
+
+	rc = regmap_read(chip->regmap, reg, &status);
 	if (rc < 0) {
 		dev_err(chip->dev, "Couldn't read charger status: %d\n", rc);
 		return IRQ_HANDLED;
 	}
 
-	if (status & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
-		/* The hardware stops charging automatically */
+	if (status & bit)
 		dev_err(chip->dev, "battery overvoltage detected\n");
-	}
 
 	power_supply_changed(chip->chg_psy);
 
 	return IRQ_HANDLED;
 }
 
+/*
+ * smb_handle_usb_plugin - IRQ handler for USB plug/unplug events.
+ *
+ * SMBLite: if the charger shows INHIBIT_CHARGE (0x00) right after plug,
+ * toggle the charging enable bit (chg_base + 0x46) to kick-start charging.
+ * SMB2: simply schedules the status work.
+ */
 static irqreturn_t smb_handle_usb_plugin(int irq, void *data)
 {
 	struct smb_chip *chip = data;
+	int usb_online = 0;
+	int rc;
 
 	power_supply_changed(chip->chg_psy);
+	smb_get_prop_usb_online(chip, &usb_online);
 
+	if (!usb_online)
+		goto schedule_work;
+
+	if (chip->type == SMBLITE) {
+		unsigned int chgr_status;
+		u16 chgr_reg  = SMBLITE_CHGR_BASE + SMBLITE_BATTERY_CHARGER_STATUS_1;
+		u16 chgen_reg = SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD;
+
+		rc = regmap_read(chip->regmap, chgr_reg, &chgr_status);
+		if (rc < 0) {
+			dev_err(chip->dev,
+				"Couldn't read charger status: %d\n", rc);
+			goto schedule_work;
+		}
+
+		if ((chgr_status & BATTERY_CHARGER_STATUS_MASK) ==
+		    SMBLITE_INHIBIT_CHARGE) {
+			rc = regmap_update_bits(chip->regmap, chgen_reg,
+						SMBLITE_CHARGING_ENABLE_CMD_BIT, 0);
+			if (rc < 0) {
+				dev_err(chip->dev,
+					"Couldn't disable charging: %d\n", rc);
+				goto schedule_work;
+			}
+
+			usleep_range(10000, 10100);
+			rc = regmap_update_bits(chip->regmap, chgen_reg,
+						SMBLITE_CHARGING_ENABLE_CMD_BIT,
+						SMBLITE_CHARGING_ENABLE_CMD_BIT);
+			if (rc < 0)
+				dev_err(chip->dev,
+					"Couldn't re-enable charging: %d\n", rc);
+		}
+	}
+
+schedule_work:
 	schedule_delayed_work(&chip->status_change_work,
 			      msecs_to_jiffies(1500));
 
@@ -769,21 +1174,176 @@ static irqreturn_t smb_handle_chg_state_change(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * smb_handle_wdog_bark - pet the watchdog after a bark interrupt.
+ *
+ * SMB2:    MISC base 0x600 + 0x43 = 0x643
+ * SMBLite: MISC base 0x1600 + 0x5A = 0x165A  (per smblite-reg.h)
+ *
+ * NOTE: downstream qpnp-smblite enables the watchdog (WD_CFG bits
+ * WDOG_TIMER_EN_ON_PLUGIN + BARK_WDOG_INT_EN + BITE_WDOG_DISABLE_CHARGING).
+ * The wdog-bark IRQ is registered here to pet it; the watchdog config itself
+ * is written in smblite_init_seq[].
+ */
 static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
 {
 	struct smb_chip *chip = data;
+	u16 reg;
 	int rc;
 
 	power_supply_changed(chip->chg_psy);
 
-	rc = regmap_write(chip->regmap, chip->base + BARK_BITE_WDOG_PET,
-			  BARK_BITE_WDOG_PET_BIT);
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_MISC_BASE + SMBLITE_BARK_BITE_WDOG_PET;
+	else
+		reg = chip->base + BARK_BITE_WDOG_PET;
+
+	rc = regmap_write(chip->regmap, reg, BARK_BITE_WDOG_PET_BIT);
 	if (rc < 0)
 		dev_err(chip->dev, "Couldn't pet the dog rc=%d\n", rc);
 
 	return IRQ_HANDLED;
 }
 
+/* ================================================================
+ * SMBLite-specific initialisation helpers
+ * ================================================================
+ */
+static int smblite_write_jeita_16(struct smb_chip *chip, u16 addr, u16 val)
+{
+	u8 buf[2];
+
+	buf[0] = (val >> 8) & 0xff;
+	buf[1] = val & 0xff;
+	return regmap_bulk_write(chip->regmap, addr, buf, 2);
+}
+
+static int smblite_program_jeita_thresholds(struct smb_chip *chip)
+{
+	u32 soft[2], hard[2];
+	struct device_node *np = chip->dev->of_node;
+	bool soft_present, hard_present;
+	int rc;
+
+	if (chip->type != SMBLITE || !np)
+		return 0;
+
+	soft_present = of_find_property(np, "qcom,jeita-soft-thresholds", NULL);
+	hard_present = of_find_property(np, "qcom,jeita-hard-thresholds", NULL);
+	if (!soft_present && !hard_present)
+		return 0;
+	if (!soft_present || !hard_present)
+		return -EINVAL;
+
+	rc = of_property_read_u32_array(np,
+					"qcom,jeita-soft-thresholds",
+					soft, ARRAY_SIZE(soft));
+	if (rc)
+		return rc;
+
+	rc = of_property_read_u32_array(np,
+					"qcom,jeita-hard-thresholds",
+					hard, ARRAY_SIZE(hard));
+	if (rc)
+		return rc;
+
+	if (soft[0] > 0xffff || soft[1] > 0xffff ||
+	    hard[0] > 0xffff || hard[1] > 0xffff)
+		return -EINVAL;
+
+	rc = smblite_write_jeita_16(chip,
+			SMBLITE_BATIF_BASE + SMBLITE_JEITA_COOL_THRESHOLD_CFG, soft[0]);
+	if (rc < 0)
+		return rc;
+
+	rc = smblite_write_jeita_16(chip,
+			SMBLITE_BATIF_BASE + SMBLITE_JEITA_WARM_THRESHOLD_CFG, soft[1]);
+	if (rc < 0)
+		return rc;
+
+	rc = smblite_write_jeita_16(chip,
+			SMBLITE_BATIF_BASE + SMBLITE_JEITA_COLD_THRESHOLD_CFG, hard[0]);
+	if (rc < 0)
+		return rc;
+
+	rc = smblite_write_jeita_16(chip,
+			SMBLITE_BATIF_BASE + SMBLITE_JEITA_HOT_THRESHOLD_CFG, hard[1]);
+	if (rc < 0)
+		return rc;
+
+	dev_dbg(chip->dev,
+		"JEITA: COOL=0x%04x WARM=0x%04x COLD=0x%04x HOT=0x%04x\n",
+		soft[0] & 0xffff, soft[1] & 0xffff,
+		hard[0] & 0xffff, hard[1] & 0xffff);
+
+	return 0;
+}
+
+/*
+ * smblite_config_fast_charge_safety_timer - configure the fast-charge
+ * safety timer.
+ *
+ * Matches downstream smblite_init_hw()'s masked write on
+ * CHGR_FAST_CHARGE_SAFETY_TIMER_CFG_REG (chg_base + 0x90):
+ *   mask = FAST_CHARGE_SAFETY_TIMER_EN_BIT | FAST_CHARGE_SAFETY_TIMER_MASK (0x0B)
+ *   val  = FAST_CHARGE_SAFETY_TIMER_EN_BIT | FAST_CHARGE_SAFETY_TIMER_768_MIN (0x0A)
+ *
+ * This register has no relation to JEITA. The downstream qpnp-smblite
+ * driver never programs JEITA thresholds for SMBLite at all, so there
+ * is no downstream reference for an "enable JEITA" bit or register --
+ * smblite_program_jeita_thresholds() only writes the threshold
+ * comparator registers themselves.
+ */
+static int smblite_config_fast_charge_safety_timer(struct smb_chip *chip)
+{
+	if (chip->type != SMBLITE)
+		return 0;
+
+	return regmap_update_bits(chip->regmap,
+				  SMBLITE_CHGR_BASE + 0x90,
+				  0x0B, 0x0A);
+}
+
+static int smblite_write_init_reg(struct smb_chip *chip, u16 addr, u8 val,
+				  const char *name)
+{
+	int rc;
+
+	rc = regmap_write(chip->regmap, addr, val);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't configure %s\n", name);
+
+	return 0;
+}
+
+static int smblite_detect_ldo_mode(struct smb_chip *chip)
+{
+	unsigned int val;
+	int rc;
+
+	if (chip->type != SMBLITE)
+		return 0;
+
+	rc = regmap_read(chip->regmap,
+			 SMBLITE_DCDC_BASE + SMBLITE_DCDC_LDO_CFG, &val);
+	if (rc < 0)
+		return rc;
+
+	chip->ldo_mode = !!(val & SMBLITE_LDO_MODE_BIT);
+	dev_info(chip->dev, "Operating in %s mode\n",
+		 chip->ldo_mode ? "LDO" : "switching");
+	return 0;
+}
+
+static int smblite_init_hw_specific(struct smb_chip *chip)
+{
+	if (chip->type != SMBLITE)
+		return 0;
+
+	return smblite_detect_ldo_mode(chip);
+}
+
 static const struct power_supply_desc smb_psy_desc = {
 	.name = "pmi8998_charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -904,37 +1464,216 @@ static const struct smb_init_register smb_init_seq[] = {
 	  .val = 1000000 / CURRENT_SCALE_FACTOR },
 };
 
+/* ================================================================
+ * SMBLite init sequence (PM4125)
+ * All addresses are absolute (peripheral_base + offset).
+ *
+ * Modelled strictly after downstream smblite_init_hw() in qpnp-smblite.c.
+ * Key differences from SMB2:
+ *   - CHARGING_ENABLE_CMD is at chg_base + 0x46 (not 0x42)
+ *   - Watchdog IS enabled (downstream enables it with specific timeout bits)
+ *   - No pre-charge current register at 0x60 (that is CHGR_TERM_CFG_REG)
+ *   - AICL enable bit is BIT(7) in usbin_base + 0x60
+ *   - Suspend-on-collapse is in usbin_base + 0x54 BIT(7)
+ * ================================================================
+ */
+static const struct smb_init_register smblite_init_seq[] = {
+	/* AICL: periodic rerun every 12 s (misc_base + 0x54) */
+	{ .addr = SMBLITE_MISC_BASE + SMBLITE_MISC_AICL_RERUN_CFG,
+	  .mask = SMBLITE_USBIN_AICL_PERIODIC_RERUN_EN_BIT |
+		  SMBLITE_USBIN_AICL_RERUN_TIME_MASK,
+	  .val = SMBLITE_USBIN_AICL_PERIODIC_RERUN_EN_BIT |
+		  SMBLITE_AICL_RERUN_TIME_12S_VAL },
+	/* Enable AICL (usbin_base + 0x60) */
+	{ .addr = SMBLITE_USBIN_BASE + SMBLITE_USBIN_AICL_OPTIONS_CFG,
+	  .mask = SMBLITE_USBIN_AICL_EN_BIT | SMBLITE_USBIN_AICL_START_AT_MAX,
+	  .val = SMBLITE_USBIN_AICL_EN_BIT },
+	/* Suspend on collapse (usbin_base + 0x54 BIT(7)) */
+	{ .addr = SMBLITE_USBIN_BASE + SMBLITE_USBIN_INPUT_SUSPEND,
+	  .mask = SMBLITE_SUSPEND_ON_COLLAPSE_USBIN_BIT,
+	  .val = SMBLITE_SUSPEND_ON_COLLAPSE_USBIN_BIT },
+	/*
+	 * Watchdog config (misc_base + 0x59):
+	 * Bark timeout = 16 s (ilog2(16/16)=0 << shift), bite timeout = 8 s.
+	 * Matches downstream DEFAULT_WD_BARK_TIME=16.
+	 */
+	{ .addr = SMBLITE_MISC_BASE + SMBLITE_SNARL_BARK_BITE_WD_CFG,
+	  .mask = SMBLITE_BARK_WDOG_TIMEOUT_MASK | SMBLITE_BITE_WDOG_TIMEOUT_MASK, /* 0xF0 */
+	  .val = (SMBLITE_BITE_WDOG_TIMEOUT_8S << SMBLITE_BITE_WDOG_TIMEOUT_SHIFT) }, /* 0xC0 */
+	/*
+	 * Enable watchdog: WDOG_TIMER_EN_ON_PLUGIN + BARK_WDOG_INT_EN
+	 * + BITE_WDOG_DISABLE_CHARGING (misc_base + 0x58)
+	 * Matches downstream WD_CFG_REG enable sequence.
+	 */
+	{ .addr = SMBLITE_MISC_BASE + SMBLITE_WD_CFG,
+	  .mask = SMBLITE_WDOG_TIMER_EN_BIT | SMBLITE_WDOG_TIMER_EN_ON_PLUGIN_BIT |
+		  SMBLITE_BARK_WDOG_INT_EN_BIT |
+		  SMBLITE_BITE_WDOG_DISABLE_CHARGING_CFG_BIT,
+	  .val = SMBLITE_WDOG_TIMER_EN_ON_PLUGIN_BIT |
+		  SMBLITE_BARK_WDOG_INT_EN_BIT |
+		  SMBLITE_BITE_WDOG_DISABLE_CHARGING_CFG_BIT },
+	/* SDP: 500 mA USB 2.0 (usbin_base + 0x50) */
+	{ .addr = SMBLITE_USBIN_BASE + SMBLITE_USBIN_ICL_OPTIONS,
+	  .mask = SMBLITE_USB51_MODE_BIT | SMBLITE_USBIN_MODE_CHG_BIT,
+	  .val = SMBLITE_USB51_MODE_BIT },
+	/* Disable HVDCP (usbin_base + 0x48) */
+	{ .addr = SMBLITE_USBIN_BASE + SMBLITE_USBIN_QC23_EN,
+	  .mask = SMBLITE_HVDCP_EN_BIT,
+	  .val = 0 },
+	/* Fast-charge current 1.5 A (chg_base + 0x54) */
+	{ .addr = SMBLITE_CHGR_BASE + SMBLITE_CHGR_FAST_CHARGE_CURRENT_CFG,
+	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
+	  .val = 1500000 / SMBLITE_FCC_STEP_UA },
+};
+
 static int smb_init_hw(struct smb_chip *chip)
 {
-	int rc, i;
+	const struct smb_init_register *init_seq;
+	int seq_len, rc, i;
 
-	for (i = 0; i < ARRAY_SIZE(smb_init_seq); i++) {
-		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%02x\n", i,
-			smb_init_seq[i].val, smb_init_seq[i].addr);
-		rc = regmap_update_bits(chip->regmap,
-					chip->base + smb_init_seq[i].addr,
-					smb_init_seq[i].mask,
-					smb_init_seq[i].val);
+	rc = smblite_init_hw_specific(chip);
+	if (rc < 0)
+		return rc;
+
+	if (chip->type == SMBLITE) {
+		init_seq = smblite_init_seq;
+		seq_len  = ARRAY_SIZE(smblite_init_seq);
+	} else {
+		init_seq = smb_init_seq;
+		seq_len  = ARRAY_SIZE(smb_init_seq);
+	}
+
+	for (i = 0; i < seq_len; i++) {
+		/*
+		 * SMB2: addresses in smb_init_seq are relative offsets;
+		 *       prepend chip->base (read from DT "reg").
+		 * SMBLite: addresses in smblite_init_seq are already absolute.
+		 */
+		u32 addr = (chip->type == SMB2) ?
+				(chip->base + init_seq[i].addr) :
+				init_seq[i].addr;
+
+		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%04x\n", i,
+			init_seq[i].val, addr);
+
+		rc = regmap_update_bits(chip->regmap, addr,
+					init_seq[i].mask,
+					init_seq[i].val);
 		if (rc < 0)
 			return dev_err_probe(chip->dev, rc,
 					     "%s: init command %d failed\n",
 					     __func__, i);
 	}
 
+	/*
+	 * SMBLite vendor bring-up register writes.
+	 * These are undocumented initialisation values derived from the
+	 * downstream qpnp-smblite driver.  They are SMBLITE-only.
+	 *
+	 * Float voltage is NOT written here: smb_probe() programs it from
+	 * the battery-info (or leaves the hardware default untouched if no
+	 * battery info is available), so an unconditional write here would
+	 * clobber that "preserve hardware setting" fallback.
+	 *
+	 * Charging is NOT enabled here either: smb_probe() enables it only
+	 * after the float voltage step above has run, matching the
+	 * downstream qpnp-smblite ordering (fv_votable before clearing
+	 * chg_disable_votable).
+	 *
+	 * IBAT_STATUS/VFLT_STATUS (chg_base + 0x0A/0x0B) are read-only
+	 * hardware status registers downstream -- there is nothing to
+	 * configure there, so they are not written.
+	 */
+	if (chip->type == SMBLITE) {
+		rc = smblite_config_fast_charge_safety_timer(chip);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+				"Couldn't config fast charge safety timer\n");
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_BATIF_BASE +
+					    SMBLITE_BATIF_BPD_CFG, 0x00,
+					    "battery-present detection");
+		if (rc < 0)
+			return rc;
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_CHGR_BASE +
+					    SMBLITE_CHGR_CHG_INHIBIT_CFG,
+					    0x00, "charge inhibit");
+		if (rc < 0)
+			return rc;
+
+		/* SOC-based recharge, matching SMBLITE_CHGR_RECHG_SOC_THD_CFG below */
+		rc = regmap_update_bits(chip->regmap,
+					 SMBLITE_CHGR_BASE + SMBLITE_CHGR_RECHG_CFG,
+					 SMBLITE_RECHG_MASK, SMBLITE_RECHG_MASK);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+				"Couldn't configure recharge strategy\n");
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_CHGR_BASE +
+					    SMBLITE_CHGR_RECHG_SOC_THD_CFG,
+					    0xFA, "SOC recharge threshold");
+		if (rc < 0)
+			return rc;
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_CHGR_BASE +
+					    SMBLITE_CHGR_CHG_TERM_CFG,
+					    0x80, "charge termination");
+		if (rc < 0)
+			return rc;
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_USBIN_BASE +
+					    SMBLITE_USB_APSD_EN, 0x10,
+					    "APSD enable");
+		if (rc < 0)
+			return rc;
+
+		rc = smblite_write_init_reg(chip,
+					    SMBLITE_USBIN_BASE +
+					    SMBLITE_USB_APSD_CFG, 0x00,
+					    "APSD configuration");
+		if (rc < 0)
+			return rc;
+	}
+
 	return 0;
 }
 
-static void smb_restore_charge_enable(void *data)
+static void smb_restore_charge_state(void *data)
 {
 	struct smb_chip *chip = data;
+	u16 reg;
+	u8 charge_enable;
 	int rc;
 
-	rc = regmap_update_bits(chip->regmap,
-				chip->base + CHARGING_ENABLE_CMD,
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD;
+	else
+		reg = chip->base + CHARGING_ENABLE_CMD;
+
+	/* Keep SMBLite charging disabled if probe fails partway through setup. */
+	charge_enable = chip->type == SMBLITE ? 0 : chip->initial_charge_enable;
+	rc = regmap_update_bits(chip->regmap, reg,
 				CHARGING_ENABLE_CMD_BIT,
-				chip->initial_charge_enable);
+				charge_enable);
+	if (rc < 0)
+		dev_err(chip->dev, "Couldn't set probe-failure charging state: %d\n",
+			rc);
+}
+
+static void smb_disable_wdog_irq_wake(void *data)
+{
+	struct smb_chip *chip = data;
+	int rc;
+
+	rc = disable_irq_wake(chip->wdog_irq);
 	if (rc < 0)
-		dev_err(chip->dev, "Couldn't restore charging state: %d\n", rc);
+		dev_err(chip->dev, "Couldn't disable watchdog IRQ wake: %d\n", rc);
 }
 
 static int smb_init_irq(struct smb_chip *chip, int *irq, const char *name,
@@ -966,6 +1705,7 @@ static int smb_probe(struct platform_device *pdev)
 	unsigned int charge_enable;
 	unsigned int float_voltage_sel;
 	int float_voltage_uv;
+	const char *pmic_name;
 	int rc, irq;
 
 	chip = devm_kzalloc_obj(&pdev->dev, *chip);
@@ -973,45 +1713,89 @@ static int smb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip->dev = &pdev->dev;
-	chip->name = pdev->name;
+
+	pmic_name = device_get_match_data(&pdev->dev);
+	if (!pmic_name)
+		return -EINVAL;
+	chip->name = pmic_name;
+
+	if (strcmp(pmic_name, "pm4125") == 0) {
+		chip->type        = SMBLITE;
+		chip->icl_step_ua = SMBLITE_ICL_STEP_UA;
+		chip->icl_max_ua  = SMBLITE_ICL_MAX_UA;
+		/* Use the charger peripheral as the base for SMBLite accesses. */
+		chip->base = SMBLITE_CHGR_BASE;
+	} else {
+		/* SMB2: PMI8998, PM660 */
+		chip->type        = SMB2;
+		chip->icl_step_ua = CURRENT_SCALE_FACTOR;
+		chip->icl_max_ua  = 4800000;
+		rc = device_property_read_u32(chip->dev, "reg", &chip->base);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't read base address\n");
+	}
 
 	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!chip->regmap)
 		return dev_err_probe(chip->dev, -ENODEV,
 				     "failed to locate the regmap\n");
 
-	rc = device_property_read_u32(chip->dev, "reg", &chip->base);
-	if (rc < 0)
-		return dev_err_probe(chip->dev, rc,
-				     "Couldn't read base address\n");
-
+	/*
+	 * IIO channels:
+	 *   usbin_v  -- voltage, supported by both SMB2 and SMBLite
+	 *   usbin_i  -- current, SMB2 only (not in downstream smblite)
+	 */
 	chip->usb_in_v_chan = devm_iio_channel_get(chip->dev, "usbin_v");
 	if (IS_ERR(chip->usb_in_v_chan))
 		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_v_chan),
 				     "Couldn't get usbin_v IIO channel\n");
 
-	chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
-	if (IS_ERR(chip->usb_in_i_chan)) {
-		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
-				     "Couldn't get usbin_i IIO channel\n");
+	if (chip->type != SMBLITE) {
+		chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
+		if (IS_ERR(chip->usb_in_i_chan))
+			return dev_err_probe(chip->dev,
+					     PTR_ERR(chip->usb_in_i_chan),
+					     "Couldn't get usbin_i IIO channel\n");
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + CHARGING_ENABLE_CMD,
-			 &charge_enable);
+	if (chip->type == SMBLITE)
+		rc = regmap_read(chip->regmap,
+				 SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD,
+				 &charge_enable);
+	else
+		rc = regmap_read(chip->regmap, chip->base + CHARGING_ENABLE_CMD,
+				 &charge_enable);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc,
 				     "Couldn't read charging state\n");
 
 	chip->initial_charge_enable = charge_enable & CHARGING_ENABLE_CMD_BIT;
-	rc = devm_add_action_or_reset(chip->dev, smb_restore_charge_enable, chip);
+	rc = devm_add_action_or_reset(chip->dev, smb_restore_charge_state, chip);
 	if (rc)
 		return dev_err_probe(chip->dev, rc,
 				     "Couldn't register charging state rollback\n");
 
+	if (chip->type == SMBLITE) {
+		rc = regmap_update_bits(chip->regmap,
+					 SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD,
+					 SMBLITE_CHARGING_ENABLE_CMD_BIT, 0);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't disable charging for setup\n");
+	}
+
 	rc = smb_init_hw(chip);
 	if (rc < 0)
 		return rc;
 
+	if (chip->type == SMBLITE) {
+		rc = smblite_program_jeita_thresholds(chip);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't program JEITA thresholds\n");
+	}
+
 	supply_config.drv_data = chip;
 	supply_config.fwnode = dev_fwnode(&pdev->dev);
 
@@ -1019,6 +1803,12 @@ static int smb_probe(struct platform_device *pdev)
 	if (!desc)
 		return -ENOMEM;
 	memcpy(desc, &smb_psy_desc, sizeof(smb_psy_desc));
+
+	if (chip->type == SMBLITE) {
+		desc->properties     = smblite_properties;
+		desc->num_properties = ARRAY_SIZE(smblite_properties);
+	}
+
 	desc->name =
 		devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
 			       (const char *)device_get_match_data(chip->dev));
@@ -1032,9 +1822,18 @@ static int smb_probe(struct platform_device *pdev)
 				     "failed to register power supply\n");
 
 	rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
-	if (rc)
+	if (rc && (chip->type == SMB2 || rc != -ENOENT))
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to get battery info\n");
+	if (!chip->batt_info) {
+		if (chip->type == SMB2)
+			return dev_err_probe(chip->dev, -ENODATA,
+					     "Failed to get battery info\n");
+
+		dev_warn(chip->dev,
+			 "No battery info, skipping float voltage configuration\n");
+		chip->batt_info = NULL;
+	}
 
 	rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
 					  smb_status_change_work);
@@ -1042,6 +1841,9 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to init status change work\n");
 
+	if (!chip->batt_info)
+		goto init_irqs;
+
 	if (power_supply_battery_info_has_prop(chip->batt_info,
 					       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX)) {
 		float_voltage_uv =
@@ -1050,27 +1852,67 @@ static int smb_probe(struct platform_device *pdev)
 					      POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN)) {
 		float_voltage_uv = chip->batt_info->voltage_max_design_uv;
 	} else {
-		dev_warn(chip->dev, "No battery float voltage; preserving hardware setting\n");
-		goto skip_float_voltage;
+		dev_warn(chip->dev,
+			 "No battery float voltage; preserving hardware setting\n");
+		goto init_irqs;
+	}
+
+	if (chip->type == SMBLITE) {
+		if (float_voltage_uv < SMBLITE_FV_MIN_UV ||
+		    float_voltage_uv > SMBLITE_FV_MAX_UV)
+			return dev_err_probe(chip->dev, -EINVAL,
+					     "float voltage %d uV outside %d-%d uV\n",
+					     float_voltage_uv, SMBLITE_FV_MIN_UV,
+					     SMBLITE_FV_MAX_UV);
+
+		float_voltage_sel = (float_voltage_uv - SMBLITE_FV_MIN_UV) /
+				     SMBLITE_FV_STEP_UV;
+
+		rc = regmap_write(chip->regmap,
+				  SMBLITE_CHGR_BASE +
+				  SMBLITE_CHGR_FLOAT_VOLTAGE_CFG,
+				  float_voltage_sel);
+	} else {
+		if (float_voltage_uv < SMB2_FLOAT_VOLTAGE_MIN_UV ||
+		    float_voltage_uv > SMB2_FLOAT_VOLTAGE_MAX_UV)
+			return dev_err_probe(chip->dev, -EINVAL,
+					     "float voltage %d uV outside %d-%d uV\n",
+					     float_voltage_uv,
+					     SMB2_FLOAT_VOLTAGE_MIN_UV,
+					     SMB2_FLOAT_VOLTAGE_MAX_UV);
+
+		float_voltage_sel =
+			(float_voltage_uv - SMB2_FLOAT_VOLTAGE_MIN_UV) /
+			SMB2_FLOAT_VOLTAGE_STEP_UV;
+
+		rc = regmap_update_bits(chip->regmap,
+					chip->base + FLOAT_VOLTAGE_CFG,
+					FLOAT_VOLTAGE_SETTING_MASK,
+					float_voltage_sel);
 	}
 
-	if (float_voltage_uv < SMB2_FLOAT_VOLTAGE_MIN_UV ||
-	    float_voltage_uv > SMB2_FLOAT_VOLTAGE_MAX_UV)
-		return dev_err_probe(chip->dev, -EINVAL,
-				     "float voltage %d uV outside %d-%d uV\n",
-				     float_voltage_uv,
-				     SMB2_FLOAT_VOLTAGE_MIN_UV,
-				     SMB2_FLOAT_VOLTAGE_MAX_UV);
-
-	float_voltage_sel =
-		(float_voltage_uv - SMB2_FLOAT_VOLTAGE_MIN_UV) /
-		SMB2_FLOAT_VOLTAGE_STEP_UV;
-	rc = regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
-				FLOAT_VOLTAGE_SETTING_MASK, float_voltage_sel);
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
 
-skip_float_voltage:
+init_irqs:
+
+	/*
+	 * SMBLite: enable charging only after the float voltage has been
+	 * configured (or deliberately left at its hardware default, above),
+	 * matching the downstream qpnp-smblite ordering of applying fv
+	 * before clearing chg_disable_votable. SMB2 keeps its pre-existing
+	 * behaviour of enabling charging as part of smb_init_seq.
+	 */
+	if (chip->type == SMBLITE) {
+		rc = regmap_update_bits(chip->regmap,
+					 SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD,
+					 SMBLITE_CHARGING_ENABLE_CMD_BIT,
+					 SMBLITE_CHARGING_ENABLE_CMD_BIT);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't enable charging\n");
+	}
+
 	rc = smb_init_irq(chip, &irq, "bat-ov", smb_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;
@@ -1084,7 +1926,8 @@ static int smb_probe(struct platform_device *pdev)
 			   smb_handle_usb_icl_change);
 	if (rc < 0)
 		return rc;
-	rc = smb_init_irq(chip, &irq, "wdog-bark", smb_handle_wdog_bark);
+	rc = smb_init_irq(chip, &chip->wdog_irq, "wdog-bark",
+			  smb_handle_wdog_bark);
 	if (rc < 0)
 		return rc;
 
@@ -1109,7 +1952,20 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
-	devm_remove_action(chip->dev, smb_restore_charge_enable, chip);
+	if (chip->type == SMBLITE) {
+		rc = enable_irq_wake(chip->wdog_irq);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't enable watchdog IRQ wake\n");
+
+		rc = devm_add_action_or_reset(chip->dev,
+					      smb_disable_wdog_irq_wake, chip);
+		if (rc)
+			return dev_err_probe(chip->dev, rc,
+					     "Couldn't register watchdog IRQ wake cleanup\n");
+	}
+
+	devm_remove_action(chip->dev, smb_restore_charge_state, chip);
 
 	platform_set_drvdata(pdev, chip);
 
@@ -1122,6 +1978,7 @@ static int smb_probe(struct platform_device *pdev)
 static const struct of_device_id smb_match_id_table[] = {
 	{ .compatible = "qcom,pmi8998-charger", .data = "pmi8998" },
 	{ .compatible = "qcom,pm660-charger", .data = "pm660" },
+	{ .compatible = "qcom,pm4125-charger", .data = "pm4125" },
 	{ /* sentinal */ }
 };
 MODULE_DEVICE_TABLE(of, smb_match_id_table);
@@ -1137,6 +1994,6 @@ static struct platform_driver qcom_spmi_smb = {
 module_platform_driver(qcom_spmi_smb);
 
 MODULE_AUTHOR("Casey Connolly <casey.connolly@linaro.org>");
-MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
+MODULE_DESCRIPTION("Qualcomm SMB2/SMBLite charger driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_CONSUMER");

-- 
2.34.1

