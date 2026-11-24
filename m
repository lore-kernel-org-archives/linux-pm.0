Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511774;
	b=oXZj4pSLb9VHXIHXTEEpXJfjWD7ihAV/WLsdHMutsJiCyOEIB5OhK0VODpGoGSzYtSxX
	 yk/c4JaIDxx1RcXF5o5BsPHcuiIuZNXogJcxdew5TpAW2estz2adE8wy3CACqS/rowRjN
	 gDwTbCpXZ/pHnC8ZhNGQD3v598SBr5FSsMiL32wXWWhC3fKjTr6TS2m5+vmla2s9Gfj4e
	 oUz/gGaW0NlcSmrBcUT+QIrPxzVNgVSdKOoTzqt9CZE4MTomVCxX+grUqrmqDNsB/Oc/p
	 U0UUEq7mRppaHfcobgjxCw8TZVxiwToxxqtNkqR1wK0svp+EeDNHkodrv2ZxE2zw05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h8/581mILaxbIiSBIvnGXaJ/aDjZKToBQdJ4eMDKT8Y=;
	b=U8gm0fAQBTubslHWwUaenL00uhN32Tbbd4w99jGCc3FwfCo4socRlT9of/URyk7CCrV9
	 xlKmKgjHB+pBHd0nmQrBoudcUoc38iQUIEwUBg5JBCeE7yXc1KuXZbRcmRKLhaLqGJ0Ar
	 h8uBkg/Y/ZRrQEmnZrJ8skWSszc6EgSzwSvwO2YvFCK63UrIG8Ga3NR3lSyp5FZKaHEsm
	 22+5IG3Q1BuVwm4998cqQl4fOfbsFsYPWdZ8C2FtXfkX44lx/0L/XDfZd5WQcB0Sfm2MZ
	 BYyr3pfy27PjYN0K/EHb0ifHDTnyBmmoXY6cBDGj2JbFg3q6L8T/McBRAO4Pwvae+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9xXMAHF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K2NET1AX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BE606A336
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9BE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h9xXMAHF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K2NET1AX
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO5mD7U4136037
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h8/581mILaxbIiSBIvnGXaJ/aDjZKToBQdJ4eMDKT8Y=; b=h9xXMAHF19jL3Zcs
	5UUfxyikyLzQlW7r621uDFM9/H8v0d8rnlRvZDvwb/5H9ZnearrtFH18SVU2NTST
	QZny03KN5fz7sqX6X6xfj9ceN2Az/PjHl3vlHBdwWWQ5WzZbJVu2dV70+Okxig/X
	7APDW9LpoCbL+JgWKFXeIPNm5d+235UCDCj4eB8Qip+WAR4E2/Luy0rcmX92xokA
	8es84nCpGQrP82dcNn5g5wigONGlgjgNiX8WIAnrcXyeNU+xG1rBxuV+HiRzzndV
	fZcjBYlwZ7v/DiPdn//8ksA7iC/e8TO7fFpa7FDuAv9LOqcJqf89nqun6Cnir9zV
	5/b0Rw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpgucs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 09:16:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f040c6e0ceso41332575ad.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795511770; x=1796116570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8/581mILaxbIiSBIvnGXaJ/aDjZKToBQdJ4eMDKT8Y=;
        b=K2NET1AXPjgLMwORnU9fdz0/YgYXc1/5WDHdBCsZG0KrxXSjuoKfdPHIaMx3YarPBl
         KliY+giwgPCA1unqXMCC/vnEWmn77lfxLyXjsaFsY8br81Y6IxabzmwScYqqBgmNK+wu
         UxjwTVbdjOQ5+4dgL1pwPILpYeifr+/INVjASTXmd1N08FJ5ewYpAcfVZlG2cZVA/Dgd
         DjKVKuqSP+qju3lmLSPVS4JB33tumeWAYSnj/6PIRK3w+t/eTIRSeQps8+m/rixtso3O
         KttwdNW2J89te3cj3wZCvtKbCT1uwFeIKdTWtS4RARgrut2sYA3ybmaZHEpIzW7Jmtlh
         QYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511770; x=1796116570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8/581mILaxbIiSBIvnGXaJ/aDjZKToBQdJ4eMDKT8Y=;
        b=aeBeDlDep7h/8up4Yc5/OeHmn02PDS5iVUXGwHT4pr0mgzHLmcJKI8Bf1tvRglvK7Q
         uTof8+sCuU1MvMxzBN+79t//KivHOgruzvYvFNNC8q5Eb8aL+Xq+CQMtcQwIrMMsVgRj
         S6cunWaWWYMMho2tOEomK31uOJZ4TvYkRNxYX8z/jiOxM9ffktlP2R5yzlO9pgGF9Gri
         C/utZzIGEKigo53lMtNjJzlSsr2GmAzdxTp3Bztpw/9QJ7R5A17xg0GwBJH3Mht8VKkV
         IQtkBN5v2eiVEfcj+zhq4LCoSKYy6pzGY2r1r/XK9p4QzPOgXDw/9Le3dofkVnXQ7lxX
         Cs2g==
X-Gm-Message-State: APuU4Z+GA7D0DAKbqx02jF6PHBy/+gPRr+z7K34zqS+BCBnsa8M/HAfK
	4NxC5xqwObHwwnJ3cpMCp0iY9ffPaF8KMsHMjysGBtuQduVts4pcAInO1YolvrA7wTXnj0ITl8J
	xbAX28/CwtLS+JJTrhG52/oPcmGUgAGELK8psvnU0O04F5OIvv1Vg23lDGKlngg==
X-Gm-Gg: AZFdTZeXZc08+965LFDvr6YIiTx1BNhXewMo6oxk7l2DOXphwGPta6qmzzuWj8Txpzf
	VGfN5J63C4cyaNJqk9nhcAkbvDa14k9Q8UqG3dy/w1A513pazDOroQ7+wjMbR9g5ETcpanQ3CCn
	8P41vlVdLEwFNZmj8KuHXujxmDER65YDRhcZFCCHXugRxTroebzDZMhbpJAAs81rca68DX8wiJE
	vxZvzHLORET271Ado4uiRTtOT4QJZyd8uURV17BSqo+lXc0Xn+c5P030fhAMTAAe9x4FX2k4fvI
	JuyYe/yFpw2VO1EdcaHOQmWgi8dog5wuzDFCXP0geljJeApskt4VeBd0x8ohATAf2oywrRfE7ny
	nvHDqwLcM7p/XMc/zAwV592vlbXKf+/mEE3Pa3hJVjGgC0r34lRJGxf8tOReTNaOhhsQ2NylAtf
	s=
X-Received: by 2002:a17:902:db08:b0:2e9:7719:40fe with SMTP id d9443c01a7336-2f03ef597d7mr132882785ad.2.1795511769281;
        Tue, 24 Nov 2026 01:16:09 -0800 (PST)
X-Received: by 2002:a17:902:db08:b0:2e9:7719:40fe with SMTP id d9443c01a7336-2f03ef597d7mr132882355ad.2.1795511768493;
        Tue, 24 Nov 2026 01:16:08 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c72sm66371825ad.54.2026.11.24.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:16:08 -0800 (PST)
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 14:45:45 +0530
Subject: [PATCH 2/2] power: supply: qcom_smbx: Add SMBLite charger support
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
Message-Id: <20261124-smblite-charger-for-pm4125-v1-2-2132c9f0601f@oss.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
In-Reply-To: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raj Aryan <raj.aryan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795511753; l=48780;
 i=raj.aryan@oss.qualcomm.com; s=20260507; h=from:subject:message-id;
 bh=FlF7JnsIU45A9/f02Vg/bQ8NthBZ4FHLdppmltmjA6s=;
 b=yt9ZuFMzi0bfR4O0G6J7/eWJQHOAI7zNcLSDkGEA7VwLg3FzDFNQ3ZLir74MEAQBWTtjLi+JG
 R2SNK3h/eswCvovUDVC5aiE1tTE/tPVHY4Hoivrff+82LT25skQsMJp
X-Developer-Key: i=raj.aryan@oss.qualcomm.com; a=ed25519;
 pk=NMkZ/eGFLSObYX6FfysQiuEElPoUYghk7+2Jtc4VEBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfX7Vvh8U+MQj5v
 YgntJCZwlZQyRI1GGPk7nEIBHJFEYPxJY4si5co23/ZNQpcZ3blOQZ1TLuAu9wmUYiBVp/6VBw/
 ZfQPPXz7seY3RS0xBRAqgIO0vZd94tp3yAL3DrizJ26FYjl/gncG+Ow00pn2emi1+sba5CfaSC7
 8wyzyrq6MV2Li5f+6Sif9T2lelVts4bKujY+IhDGMIPzBH6J4JtAoG3fQjbjiO32C4266Y5bDqI
 2TLgURcrLqGR0YgvDmwFdtY9iUk2+qqkSUL2nqq6+3UCPd1wifyOVP7oMfsrZPKjdnma7bUkHcM
 nn0KQDuUTCQ6X09NoDzLPppTRZguQwbxzk8SeRwJcLjMvAXWSH/rAvHT2Cs7MUdHHjDqSltuKmn
 dKlyeDZod39TOoj5ekX0+qTmn7NWXxJ0I1BbBSvhyQpcRpQL22QfF8AjQkWcxv44i9DorstFUfW
 k41YWb6a2vaK0IT4Gdw==
X-Proofpoint-GUID: 9J6c19NItzUlEpEXgKQDF71ZMCFAGgdH
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b0555db cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=b815MoKpEfiViyZXDOAA:9
 a=wxoFcgGFO9OFbSno:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfXy3vNrjsSl41u
 zi1udaEbJfuD361JsJ9Xwv5afwMToqE4dUEvzB+1y+ET2ITDoZ7e6Kh5cJlogecjGL10noQ/JsC
 16tpLtEJYFRfavUxn6FPyPROKgEs57A=
X-Proofpoint-ORIG-GUID: 9J6c19NItzUlEpEXgKQDF71ZMCFAGgdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240035

Extend the qcom_smbx charger driver to support the SMBLite charger
IP found on the PM4125 PMIC while retaining full support for the
existing SMB2 hardware (PMI8998, PM660).

SMBLite differs from SMB2 in several ways, all handled via explicit
chip->type guards:

  - Five separate SPMI peripheral bases (CHGR, DCDC, USB, MISC,
    BATIF) instead of SMB2's single base with fixed offsets
  - Different BAT_OV, USB online, ICL and watchdog pet registers
  - SOC-based recharge instead of SMB2's VBAT-based recharge
  - A masked JEITA enable write matching downstream behaviour
  - No CURRENT_NOW support via usbin_i

Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 drivers/power/supply/qcom_smbx.c | 1094 ++++++++++++++++++++++++++++++++++----
 1 file changed, 981 insertions(+), 113 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 52bb5a6eb145..54b2942e2f5a 100644
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
@@ -20,8 +21,22 @@
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
+
+enum connector_type {
+	CONNECTOR_TYPE_UNKNOWN,
+	CONNECTOR_TYPE_TYPEC,
+	CONNECTOR_TYPE_MICRO_USB,
+};
 
 /* clang-format off */
 #define BATTERY_CHARGER_STATUS_1			0x06
@@ -355,6 +370,137 @@
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
+#define SMBLITE_TYPEC_BASE			0x1500
+#define SMBLITE_MISC_BASE			0x1600
+
+/* ---- SMBLITE CHGR registers (chg_base offsets) ---- */
+
+#define SMBLITE_BATTERY_CHARGER_STATUS_1	0x06
+#define SMBLITE_CHGR_IBAT_STATUS		0x0A
+#define SMBLITE_CHARGER_VBAT_STATUS		0x08
+#define SMBLITE_CHGR_VFLT_STATUS		0x0B
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
+#define SMBLITE_VBAT_BASED_RECHG_BIT		BIT(7)
+#define SMBLITE_CHGR_RECHG_SOC_THD_CFG		0x74
+#define SMBLITE_CHGR_CHG_INHIBIT_CFG		0x78
+
+#define SMBLITE_ICL_MAX_STATUS			0x06
+#define SMBLITE_ICL_STATUS			0x09
+
+#define SMBLITE_POWER_PATH_STATUS		0x0B
+#define SMBLITE_VALID_INPUT_POWER_SOURCE_BIT	BIT(7)
+#define SMBLITE_USE_USBIN_BIT			BIT(5)
+
+#define SMBLITE_DCDC_OTG_CFG			0x56
+#define SMBLITE_DCDC_OTG_EN_SRC_CFG_BIT		BIT(0)
+
+#define SMBLITE_DCDC_LDO_CFG			0x70
+#define SMBLITE_LDO_MODE_BIT			BIT(0)
+
+#define SMBLITE_BATIF_BPD_CFG			0x60
+#define SMBLITE_BATIF_JEITA_EN_CFG		0x7F
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
+#define SMBLITE_APSD_RESULT_STATUS_MASK		GENMASK(6, 0)
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
+#define SMBLITE_TYPEC_U_USB_CFG			0x70
+#define SMBLITE_EN_MICRO_USB_MODE_BIT		BIT(0)
+
+#define SMBLITE_LEGACY_CABLE_STATUS		0x0D
+#define SMBLITE_TYPEC_LEGACY_CABLE_STATUS_BIT	BIT(1)
+
+#define SMBLITE_TYPE_C_MODE_CFG			0x44
+#define SMBLITE_TYPE_C_EXIT_STATE_CFG		0x50
+
+#define EN_TRY_SNK_BIT				BIT(4)
+#define EN_TRY_SRC_BIT				BIT(3)
+#define EN_SRC_ONLY_BIT				BIT(2)
+#define EN_SNK_ONLY_BIT				BIT(1)
+#define SEL_SRC_UPPER_REF_BIT			BIT(2)
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
+#define SMBLITE_BARK_BITE_WDOG_PET_BIT		BIT(0)
+#define SMBLITE_BARK_WDOG_TIMEOUT_MASK		GENMASK(5, 4)	/* 0x30 */
+#define SMBLITE_BITE_WDOG_TIMEOUT_MASK		GENMASK(7, 6)	/* 0xC0 */
+#define SMBLITE_BITE_WDOG_TIMEOUT_8S		0x3
+#define SMBLITE_BITE_WDOG_TIMEOUT_SHIFT		6
+
+#define SMBLITE_ICL_STEP_UA			100000
+#define SMBLITE_FCC_STEP_UA			100000
+#define SMBLITE_ICL_MAX_UA			2000000
+#define SMBLITE_FCC_MAX_UA			2000000
+#define SMBLITE_FV_STEP_UV			20000
+#define SMBLITE_FV_MIN_UV			3600000
+#define SMBLITE_FV_MAX_UV			4600000
+
 /* clang-format on */
 
 enum charger_status {
@@ -368,6 +514,17 @@ enum charger_status {
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
@@ -377,6 +534,8 @@ struct smb_init_register {
 /**
  * struct smb_chip - smb chip structure
  * @dev:		Device reference for power_supply
+ * @type: PMIC IP type (SMB2 or SMBLITE)
+ * @connector_type: Connector type detected at probe (SMBLITE only)
  * @name:		The platform device name
  * @base:		Base address for smb registers
  * @regmap:		Register map
@@ -387,10 +546,23 @@ struct smb_init_register {
  * @wakeup_enabled:	If the cable IRQ will cause a wakeup
  * @usb_in_i_chan:	USB_IN current measurement channel
  * @usb_in_v_chan:	USB_IN voltage measurement channel
+ * @temp_chan: Charger temperature channel (optional)
  * @chg_psy:		Charger power supply instance
+ * @vbus_reg: Optional VBUS regulator
+ * @ldo_mode: True if operating in LDO mode (SMBLITE only)
+ * @icl_step_ua: ICL step size in uA
+ * @fcc_step_ua: FCC step size in uA
+ * @icl_max_ua: Maximum ICL in uA
+ * @fcc_max_ua: Maximum FCC in uA
+ * @charge_status: Cached POWER_SUPPLY_STATUS_* value
+ * @charge_done: True when charge has terminated
+ * @usb_type: USB type reported by external charger detection
+ * @usb_type_override: True when @usb_type should override APSD reporting
  */
 struct smb_chip {
 	struct device *dev;
+	enum smb_type type;
+	enum connector_type connector_type;
 	const char *name;
 	unsigned int base;
 	struct regmap *regmap;
@@ -403,8 +575,19 @@ struct smb_chip {
 
 	struct iio_channel *usb_in_i_chan;
 	struct iio_channel *usb_in_v_chan;
+	struct iio_channel *temp_chan;
 
 	struct power_supply *chg_psy;
+	struct regulator *vbus_reg;
+	bool ldo_mode;
+	unsigned int icl_step_ua;
+	unsigned int fcc_step_ua;
+	unsigned int icl_max_ua;
+	unsigned int fcc_max_ua;
+	int charge_status;
+	bool charge_done;
+	enum power_supply_usb_type usb_type;
+	bool usb_type_override;
 };
 
 static enum power_supply_property smb_properties[] = {
@@ -419,19 +602,49 @@ static enum power_supply_property smb_properties[] = {
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
 
@@ -442,6 +655,7 @@ static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
 static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 {
 	unsigned int apsd_stat, stat;
+	u16 apsd_reg, result_reg;
 	int usb_online = 0;
 	int rc;
 
@@ -451,7 +665,15 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 		return rc;
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + APSD_STATUS, &apsd_stat);
+	if (chip->type == SMBLITE) {
+		apsd_reg   = SMBLITE_USBIN_BASE + SMBLITE_APSD_STATUS;
+		result_reg = SMBLITE_USBIN_BASE + SMBLITE_APSD_RESULT_STATUS;
+	} else {
+		apsd_reg   = APSD_STATUS;
+		result_reg = APSD_RESULT_STATUS;
+	}
+
+	rc = regmap_read(chip->regmap, apsd_reg, &apsd_stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Failed to read apsd status, rc = %d", rc);
 		return rc;
@@ -461,7 +683,7 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 		return -EAGAIN;
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + APSD_RESULT_STATUS, &stat);
+	rc = regmap_read(chip->regmap, result_reg, &stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Failed to read apsd result, rc = %d", rc);
 		return rc;
@@ -479,11 +701,33 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
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
@@ -491,65 +735,142 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
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
+			chip->charge_done = false;
+			return 0;
+		}
+	} else {
+		if (stat_batov & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_done = false;
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
+			chip->charge_done = false;
+			break;
+		case SMBLITE_TERMINATE_CHARGE:
+			*val = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_status = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_done = true;
+			break;
+		case SMBLITE_INHIBIT_CHARGE:
+		case SMBLITE_CHARGING_PAUSED:
+		case SMBLITE_CHARGING_DISABLED:
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_done = false;
+			break;
+		default:
+			*val = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_done = false;
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
+			chip->charge_done = false;
+			break;
+		case DISABLE_CHARGE:
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			chip->charge_done = false;
+			break;
+		case TERMINATE_CHARGE:
+		case INHIBIT_CHARGE:
+			*val = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_status = POWER_SUPPLY_STATUS_FULL;
+			chip->charge_done = true;
+			break;
+		default:
+			*val = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
+			chip->charge_done = false;
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
@@ -562,8 +883,17 @@ static void smb_status_change_work(struct work_struct *work)
 	chip = container_of(work, struct smb_chip, status_change_work.work);
 
 	smb_get_prop_usb_online(chip, &usb_online);
-	if (!usb_online)
+	if (!usb_online) {
+		chip->usb_type_override = false;
+		chip->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
 		return;
+	}
+
+	if (chip->type == SMBLITE && chip->usb_type_override) {
+		smb_set_current_limit(chip, smb_usb_type_current_ua(chip->usb_type));
+		power_supply_changed(chip->chg_psy);
+		return;
+	}
 
 	for (count = 0; count < 3; count++) {
 		dev_dbg(chip->dev, "get charger type retry %d\n", count);
@@ -579,27 +909,16 @@ static void smb_status_change_work(struct work_struct *work)
 	}
 
 	if (rc < 0) {
-		rc = regmap_update_bits(chip->regmap, chip->base + CMD_APSD,
-					APSD_RERUN_BIT, APSD_RERUN_BIT);
+		if (chip->type != SMBLITE)
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
@@ -610,6 +929,11 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
 	int rc;
 	union power_supply_propval status;
 
+	if (!chan) {
+		*val = 0;
+		return 0;
+	}
+
 	rc = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_STATUS,
 				       &status);
 	if (rc < 0 || status.intval != POWER_SUPPLY_STATUS_CHARGING) {
@@ -625,11 +949,48 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
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
@@ -669,6 +1030,8 @@ static int smb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_get_current_limit(chip, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (chip->type == SMBLITE)
+			return -EOPNOTSUPP;
 		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
 					 &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -681,7 +1044,32 @@ static int smb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_HEALTH:
 		return smb_get_prop_health(chip, &val->intval);
 	case POWER_SUPPLY_PROP_USB_TYPE:
+		if (chip->type == SMBLITE && chip->usb_type_override) {
+			int usb_online = 0;
+
+			smb_get_prop_usb_online(chip, &usb_online);
+			if (usb_online) {
+				val->intval = chip->usb_type;
+				return 0;
+			}
+		}
 		return smb_apsd_get_charger_type(chip, &val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (chip->type != SMBLITE)
+			return -EOPNOTSUPP;
+		switch (chip->charge_status) {
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
 	default:
 		dev_err(chip->dev, "invalid property: %d\n", psp);
 		return -EINVAL;
@@ -696,10 +1084,34 @@ static int smb_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		if (chip->type == SMBLITE)
+			return -EINVAL;
 		return regmap_update_bits(chip->regmap, chip->base + USBIN_CMD_IL,
 					  USBIN_SUSPEND_BIT, !val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_set_current_limit(chip, val->intval);
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		if (chip->type != SMBLITE)
+			return -EOPNOTSUPP;
+		switch (val->intval) {
+		case POWER_SUPPLY_USB_TYPE_UNKNOWN:
+			chip->usb_type_override = false;
+			chip->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+			break;
+		case POWER_SUPPLY_USB_TYPE_SDP:
+		case POWER_SUPPLY_USB_TYPE_CDP:
+		case POWER_SUPPLY_USB_TYPE_DCP:
+			chip->usb_type = val->intval;
+			chip->usb_type_override = true;
+			smb_set_current_limit(chip,
+					      smb_usb_type_current_ua(chip->usb_type));
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		power_supply_changed(chip->chg_psy);
+		return 0;
 	default:
 		dev_err(chip->dev, "No setter for property: %d\n", psp);
 		return -EINVAL;
@@ -709,44 +1121,93 @@ static int smb_set_property(struct power_supply *psy,
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
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return chip->type == SMBLITE;
 	default:
 		return 0;
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
 
 	power_supply_changed(chip->chg_psy);
+	smb_get_prop_usb_online(chip, &usb_online);
 
+	if (!usb_online)
+		goto schedule_work;
+
+	if (chip->type == SMBLITE) {
+		unsigned int chgr_status = 0;
+		u16 chgr_reg  = SMBLITE_CHGR_BASE + SMBLITE_BATTERY_CHARGER_STATUS_1;
+		u16 chgen_reg = SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD;
+
+		regmap_read(chip->regmap, chgr_reg, &chgr_status);
+
+		if ((chgr_status & BATTERY_CHARGER_STATUS_MASK) ==
+		    SMBLITE_INHIBIT_CHARGE) {
+			regmap_update_bits(chip->regmap, chgen_reg,
+					   SMBLITE_CHARGING_ENABLE_CMD_BIT, 0);
+			usleep_range(10000, 10100);
+			regmap_update_bits(chip->regmap, chgen_reg,
+					   SMBLITE_CHARGING_ENABLE_CMD_BIT,
+					   SMBLITE_CHARGING_ENABLE_CMD_BIT);
+		}
+	}
+
+schedule_work:
 	schedule_delayed_work(&chip->status_change_work,
 			      msecs_to_jiffies(1500));
 
@@ -762,21 +1223,205 @@ static irqreturn_t smb_handle_usb_icl_change(int irq, void *data)
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
+static int smblite_detect_connector_type(struct smb_chip *chip)
+{
+	unsigned int val;
+	int rc;
+
+	if (chip->type != SMBLITE)
+		return 0;
+
+	rc = regmap_read(chip->regmap,
+			 SMBLITE_TYPEC_BASE + SMBLITE_TYPEC_U_USB_CFG, &val);
+	if (rc < 0) {
+		dev_err(chip->dev, "Failed to read connector type: %d\n", rc);
+		return rc;
+	}
+
+	chip->connector_type = (val & SMBLITE_EN_MICRO_USB_MODE_BIT) ?
+			       CONNECTOR_TYPE_MICRO_USB : CONNECTOR_TYPE_TYPEC;
+	dev_info(chip->dev, "%s connector detected\n",
+		 chip->connector_type == CONNECTOR_TYPE_TYPEC ?
+		 "Type-C" : "Micro-USB");
+	return 0;
+}
+
+static int smblite_init_typec(struct smb_chip *chip)
+{
+	unsigned int val;
+	int rc;
+
+	if (chip->type != SMBLITE)
+		return 0;
+	if (chip->connector_type != CONNECTOR_TYPE_TYPEC)
+		return 0;
+
+	rc = regmap_read(chip->regmap,
+			 SMBLITE_TYPEC_BASE + SMBLITE_LEGACY_CABLE_STATUS, &val);
+	if (rc < 0)
+		return rc;
+
+	if (val & SMBLITE_TYPEC_LEGACY_CABLE_STATUS_BIT) {
+		dev_dbg(chip->dev, "Resetting legacy cable detection\n");
+		rc = regmap_update_bits(chip->regmap,
+					SMBLITE_TYPEC_BASE + SMBLITE_TYPE_C_MODE_CFG,
+					EN_TRY_SNK_BIT | EN_SNK_ONLY_BIT, 0);
+		if (rc < 0)
+			return rc;
+		msleep(50);
+	}
+
+	rc = regmap_update_bits(chip->regmap,
+				SMBLITE_TYPEC_BASE + SMBLITE_TYPE_C_MODE_CFG,
+				EN_TRY_SNK_BIT | EN_SNK_ONLY_BIT,
+				EN_TRY_SNK_BIT);
+	if (rc < 0)
+		return rc;
+
+	return regmap_update_bits(chip->regmap,
+				  SMBLITE_TYPEC_BASE + SMBLITE_TYPE_C_EXIT_STATE_CFG,
+				  SEL_SRC_UPPER_REF_BIT, SEL_SRC_UPPER_REF_BIT);
+}
+
+static int smblite_write_jeita_16(struct smb_chip *chip, u16 addr, u16 val)
+{
+	u8 buf[2];
+
+	buf[0] = (val >> 8) & 0xff;
+	buf[1] = val & 0xff;
+	return regmap_bulk_write(chip->regmap, addr, buf, 2);
+}
+
+static void smblite_program_jeita_thresholds(struct smb_chip *chip)
+{
+	u32 soft[2], hard[2];
+	int rc;
+
+	if (chip->type != SMBLITE || !chip->dev->of_node)
+		return;
+
+	rc = of_property_read_u32_array(chip->dev->of_node,
+					"qcom,jeita-soft-thresholds",
+					soft, ARRAY_SIZE(soft));
+	if (rc) {
+		dev_info(chip->dev, "No qcom,jeita-soft-thresholds in DT\n");
+		return;
+	}
+
+	rc = of_property_read_u32_array(chip->dev->of_node,
+					"qcom,jeita-hard-thresholds",
+					hard, ARRAY_SIZE(hard));
+	if (rc) {
+		dev_info(chip->dev, "No qcom,jeita-hard-thresholds in DT\n");
+		return;
+	}
+
+	smblite_write_jeita_16(chip,
+			       SMBLITE_BATIF_BASE + SMBLITE_JEITA_COOL_THRESHOLD_CFG, soft[0]);
+	smblite_write_jeita_16(chip,
+			       SMBLITE_BATIF_BASE + SMBLITE_JEITA_WARM_THRESHOLD_CFG, soft[1]);
+	smblite_write_jeita_16(chip,
+			       SMBLITE_BATIF_BASE + SMBLITE_JEITA_COLD_THRESHOLD_CFG, hard[0]);
+	smblite_write_jeita_16(chip,
+			       SMBLITE_BATIF_BASE + SMBLITE_JEITA_HOT_THRESHOLD_CFG,  hard[1]);
+
+	dev_dbg(chip->dev,
+		"JEITA: COOL=0x%04x WARM=0x%04x COLD=0x%04x HOT=0x%04x\n",
+		soft[0] & 0xffff, soft[1] & 0xffff,
+		hard[0] & 0xffff, hard[1] & 0xffff);
+}
+
+/*
+ * smblite_enable_jeita - enable JEITA hardware comparators.
+ *
+ * Downstream smblite_init_hw() uses a masked write on
+ * CHGR_FAST_CHARGE_SAFETY_TIMER_CFG_REG (chg_base + 0x90):
+ *   mask = 0x0B  (bits [3:1] = timer select, bit[0] = enable)
+ *   val  = 0x0A  (FAST_CHARGE_SAFETY_TIMER_768_MIN | enable)
+ * Use regmap_update_bits to touch only those bits.
+ */
+static int smblite_enable_jeita(struct smb_chip *chip)
+{
+	if (chip->type != SMBLITE)
+		return 0;
+
+	return regmap_update_bits(chip->regmap,
+				  SMBLITE_CHGR_BASE + 0x90,
+				  0x0B, 0x0A);
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
+	int rc;
+
+	if (chip->type != SMBLITE)
+		return 0;
+
+	rc = smblite_detect_ldo_mode(chip);
+	if (rc < 0)
+		return rc;
+
+	rc = smblite_detect_connector_type(chip);
+	if (rc < 0)
+		return rc;
+
+	return smblite_init_typec(chip);
+}
+
 static const struct power_supply_desc smb_psy_desc = {
 	.name = "pmi8998_charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -897,33 +1542,164 @@ static const struct smb_init_register smb_init_seq[] = {
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
+	/* VBUS under software control (dcdc_base + 0x56) */
+	{ .addr = SMBLITE_DCDC_BASE + SMBLITE_DCDC_OTG_CFG,
+	  .mask = SMBLITE_DCDC_OTG_EN_SRC_CFG_BIT,
+	  .val = 0 },
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
+	/* Enable charging (chg_base + 0x46) */
+	{ .addr = SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD,
+	  .mask = SMBLITE_CHARGING_ENABLE_CMD_BIT,
+	  .val = SMBLITE_CHARGING_ENABLE_CMD_BIT },
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
+	 */
+	if (chip->type == SMBLITE) {
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_FLOAT_VOLTAGE_CFG, 0x2F);
+		regmap_write(chip->regmap,
+			     SMBLITE_BATIF_BASE + SMBLITE_BATIF_BPD_CFG, 0x00);
+		regmap_write(chip->regmap,
+			     SMBLITE_BATIF_BASE + SMBLITE_BATIF_JEITA_EN_CFG, 0x00);
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_CHG_INHIBIT_CFG, 0x00);
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_RECHG_CFG, 0xC2);
+		/* SOC recharge threshold = 250 (0xFA) -- aligned with
+		 * SOC-based recharge strategy set at SMBLITE_CHGR_RECHG_CFG=0xC2
+		 */
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_RECHG_SOC_THD_CFG, 0xFA);
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_CHG_TERM_CFG, 0x80);
+		regmap_write(chip->regmap,
+			     SMBLITE_USBIN_BASE + SMBLITE_USB_APSD_EN, 0x10);
+		regmap_write(chip->regmap,
+			     SMBLITE_USBIN_BASE + SMBLITE_USB_APSD_CFG, 0x00);
+		/* 0x130c, 0x1340: no documented register at this offset */
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_IBAT_STATUS, 0xc1);
+		regmap_write(chip->regmap,
+			     SMBLITE_CHGR_BASE + SMBLITE_CHGR_VFLT_STATUS, 0x82);
+	}
+
 	return 0;
 }
 
 static void smb_restore_charge_enable(void *data)
 {
 	struct smb_chip *chip = data;
+	u16 reg;
 	int rc;
 
-	rc = regmap_update_bits(chip->regmap,
-				chip->base + CHARGING_ENABLE_CMD,
+	if (chip->type == SMBLITE)
+		reg = SMBLITE_CHGR_BASE + SMBLITE_CHARGING_ENABLE_CMD;
+	else
+		reg = chip->base + CHARGING_ENABLE_CMD;
+
+	rc = regmap_update_bits(chip->regmap, reg,
 				CHARGING_ENABLE_CMD_BIT,
 				chip->initial_charge_enable);
 	if (rc < 0)
@@ -959,6 +1735,7 @@ static int smb_probe(struct platform_device *pdev)
 	unsigned int charge_enable;
 	unsigned int float_voltage_sel;
 	int float_voltage_uv;
+	const char *pmic_name;
 	int rc, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -966,31 +1743,73 @@ static int smb_probe(struct platform_device *pdev)
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
+		chip->fcc_step_ua = SMBLITE_FCC_STEP_UA;
+		chip->icl_max_ua  = SMBLITE_ICL_MAX_UA;
+		chip->fcc_max_ua  = SMBLITE_FCC_MAX_UA;
+		/* Use the charger peripheral as the base for SMBLite accesses. */
+		chip->base = SMBLITE_CHGR_BASE;
+	} else {
+		/* SMB2: PMI8998, PM660 */
+		chip->type        = SMB2;
+		chip->icl_step_ua = CURRENT_SCALE_FACTOR;
+		chip->fcc_step_ua = CURRENT_SCALE_FACTOR;
+		chip->icl_max_ua  = 4800000;
+		chip->fcc_max_ua  = 4800000;
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
+	 *   chg_temp -- optional on both
+	 */
 	chip->usb_in_v_chan = devm_iio_channel_get(chip->dev, "usbin_v");
-	if (IS_ERR(chip->usb_in_v_chan))
-		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_v_chan),
-				     "Couldn't get usbin_v IIO channel\n");
-
-	chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
-	if (IS_ERR(chip->usb_in_i_chan)) {
-		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
-				     "Couldn't get usbin_i IIO channel\n");
+	if (IS_ERR(chip->usb_in_v_chan)) {
+		rc = PTR_ERR(chip->usb_in_v_chan);
+		if (rc == -EPROBE_DEFER)
+			return rc;
+		dev_info(chip->dev,
+			 "usbin_v IIO channel not available, rc=%d\n", rc);
+		chip->usb_in_v_chan = NULL;
 	}
 
-	rc = regmap_read(chip->regmap, chip->base + CHARGING_ENABLE_CMD,
-			 &charge_enable);
+	chip->temp_chan = devm_iio_channel_get(chip->dev, "chg_temp");
+	if (IS_ERR(chip->temp_chan))
+		chip->temp_chan = NULL;
+
+	if (chip->type != SMBLITE) {
+		chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
+		if (IS_ERR(chip->usb_in_i_chan))
+			return dev_err_probe(chip->dev,
+					     PTR_ERR(chip->usb_in_i_chan),
+					     "Couldn't get usbin_i IIO channel\n");
+	}
+
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
@@ -1005,6 +1824,11 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
+	if (chip->type == SMBLITE) {
+		smblite_program_jeita_thresholds(chip);
+		smblite_enable_jeita(chip);
+	}
+
 	supply_config.drv_data = chip;
 	supply_config.fwnode = dev_fwnode(&pdev->dev);
 
@@ -1012,6 +1836,12 @@ static int smb_probe(struct platform_device *pdev)
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
@@ -1025,9 +1855,11 @@ static int smb_probe(struct platform_device *pdev)
 				     "failed to register power supply\n");
 
 	rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
-	if (rc)
-		return dev_err_probe(chip->dev, rc,
-				     "Failed to get battery info\n");
+	if (rc || !chip->batt_info) {
+		dev_warn(chip->dev,
+			 "No battery info, skipping float voltage configuration\n");
+		chip->batt_info = NULL;
+	}
 
 	rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
 					  smb_status_change_work);
@@ -1035,6 +1867,9 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to init status change work\n");
 
+	if (!chip->batt_info)
+		goto init_irqs;
+
 	if (power_supply_battery_info_has_prop(chip->batt_info,
 					       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX)) {
 		float_voltage_uv =
@@ -1043,27 +1878,50 @@ static int smb_probe(struct platform_device *pdev)
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
 	rc = smb_init_irq(chip, &irq, "bat-ov", smb_handle_batt_overvoltage);
 	if (rc < 0)
 		return rc;
@@ -1087,6 +1945,15 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
+	chip->vbus_reg = devm_regulator_get_optional(chip->dev, "vbus");
+	if (IS_ERR(chip->vbus_reg)) {
+		rc = PTR_ERR(chip->vbus_reg);
+		if (rc == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_warn(chip->dev, "vbus regulator not found, ignoring\n");
+		chip->vbus_reg = NULL;
+	}
+
 	devm_remove_action(chip->dev, smb_restore_charge_enable, chip);
 
 	platform_set_drvdata(pdev, chip);
@@ -1100,6 +1967,7 @@ static int smb_probe(struct platform_device *pdev)
 static const struct of_device_id smb_match_id_table[] = {
 	{ .compatible = "qcom,pmi8998-charger", .data = "pmi8998" },
 	{ .compatible = "qcom,pm660-charger", .data = "pm660" },
+	{ .compatible = "qcom,pm4125-charger", .data = "pm4125" },
 	{ /* sentinal */ }
 };
 MODULE_DEVICE_TABLE(of, smb_match_id_table);
@@ -1115,6 +1983,6 @@ static struct platform_driver qcom_spmi_smb = {
 module_platform_driver(qcom_spmi_smb);
 
 MODULE_AUTHOR("Casey Connolly <casey.connolly@linaro.org>");
-MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
+MODULE_DESCRIPTION("Qualcomm SMB2/SMBLite charger driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_CONSUMER");

-- 
2.34.1

