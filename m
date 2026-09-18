Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC04FD283;
	Fri, 18 Sep 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744122; cv=fail; b=BxoT3bL9C+wtKPz2jb2chRY3habmScCb1LSQwtY/1wLqHj19L1BjtI+CZKFdcKbkCHyt19xzIbRR6G3UBmtDtkTqIi0SROGghiQACRSbDMSr/r3XQdVuzAEGTM2BPYSXXi5+YEYpjMSt/O3+EpAip5DXjBBIzgdLazitATdchcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744122; c=relaxed/simple;
	bh=lZNq5TbE1o1AbYGcPxxOX4s/nkEtyyv7pzDpf+GudX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYKvQrUm1v9SRnLyg4fTJ29HBEM/k6AKKy24BWCVOqG3gZbemwvIphI3oDbcasrAiNibmiKsUgwUpzmr1p9gux3zuQQxVrEpI0L0BLrr0LBIl+0dB2xrxH/Hm2P8xqS3Sqk+epdhFSntljYJRaUAXXptptU/+ZSs0jTApQc1kxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JLVA+sG/; arc=fail smtp.client-ip=52.101.229.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JLVA+sG/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVK/it09U3MV/fl38MsL7Uu8DlhuaOQHK5AdwxJIO23VB5eMUx9Q8h9IIyeBmDET8HC648hueSBqdYVtNk1gNPBrK81p9M0IjG+1xjX2eIG/o9pCvU14gqsAdYZcVC2mz/Yaa2o9FoeCE3w2RC3FdOrJOeqFs0oPDK9P87m1ousQogfCBWpUPL5C9OmkvUEEvUR8fvOYZ3obZFlV73HX6IlVbCs9Rzp7sommoxrqTfz0Lco3C/sEyLcwhH/obJ7ZwEWZDEyQ78E+ZPbCnWBUMUZ6+r9efdjHq96ADg8K5krzydQzCmDMoR7mFCvAIDOF2Z/LCFHdfgieuwfqQgFJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3FTshhc0ttZ9P63YKIiKNhSKWefpHqGreubNdGG3mM=;
 b=X+0uleT2ZsHTRwEQcy+5dA4UjR+2+IBYFfHQygIJn+RHYmybVekCU8vCwTzTlZveGjUETrlPFx1okzz6U2/24hENyZDA30X9pp8Wb6ze7F9BNRTxqdwb/EmHlgG/QLuEUHRKLvs53LNklfcbRpsAcBz/WN2uuSasll6YXErTWnPsER9Z0dnEIM/ARA7yYhbmq1Suk45ndQOO7yTfrVW+J/PkHlgQ60oP5v8uVNqCIZAFepwiJjRQozLxtCz3ihPG1lBQCWgYIIU0Hc0ascEb/N+bCBBBahj4nuKd8lv2qs9/Fqe9ID1RX+5hEQjfWUnsMucx/rbmalV3mG9X8+E1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3FTshhc0ttZ9P63YKIiKNhSKWefpHqGreubNdGG3mM=;
 b=JLVA+sG/tKfNBATqZnoYc/JCBxdGizuvKmI3lGI2/Kd6eL37ZiGbFb7PwKZt+l1SLP4TEUaP9DQKHz9Sm2LQsC/VT45g2czrT/zDLmpHdUmlLYPDJ6f63zDimGSdJs6cRWhJ7X2o0K25WfRnt61NvSXH0mlqiJ5Fn5hmvbUm0To=
Received: from OS7PR01CA0016.jpnprd01.prod.outlook.com (2603:1096:604:24f::13)
 by TYYPR01MB12147.jpnprd01.prod.outlook.com (2603:1096:405:fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 15:08:31 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24f:cafe::30) by OS7PR01CA0016.outlook.office365.com
 (2603:1096:604:24f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 15:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:08:31 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 01A3130007D4;
	Sat, 19 Sep 2026 00:08:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/8] thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC match data
Date: Fri, 18 Sep 2026 16:07:20 +0100
Message-ID: <20260918150730.122056-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TYYPR01MB12147:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74d52aa3-132b-4be0-6fee-08df1596b3f3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FL5lOcVzZgZFkDaRMNxCBlj3sieKypTEYWmp4uRY4VxxZZ8nrP6B5oqToJSVT/Sm/D9rYg0Jz1UYdVuACYALgTau6xxKfHmbLPXRGu9EvJUzrfJN7JueUPIxRzWXCSMweXXiD2AqeY5G7kZHVrKxSuDgdPErR8KH8Lzola0TcY8cfx3s58ASdBkiqK4OFfX5HYEM8xK4qmHpAjaJrZ3CSqSQaneYsldEW1A7jKy+bq7FhPNKgbQ2kXHiMjS0hsRd7ufz+dGco730wi6hGwV4sCNWquSd6S2tMRX4Xv1R0Mgykb0SCJREI1XxqRR52+oqypqejZM2GNI7yZY+jWQh6zmd8zmNd7lAmICEH9BroaJh3rLjrB/KjoBlMXXkMcB1a0G3MW/PYI/B9HYlUdRXC0ue09K4z/4pwAoYd4R7g56gPWF8U23oJw0IM/dhyK3VLORgyxuikgHlLLCIo5DSd2qFl6LUEnBH/UEDvN4xMMkbdztTcniv8RG72LsQVt9Vw1ZoK5Djheql5ZlVRWNt/5FdJRqtuhhQmN/FWVlqVrftyfhbg75LPzNYM1G9/qv9wfCnwRu3nbWsTUUHDkrAK/aXhu9bVHNR/efVoam3J2EzSzGCCaifapYKZNANhbggTp79x0UbCbC3wGzd95W5z6XlnktW2uYaTeimSdnfIDamf29yV0Ztu7uvOzPjKivA+phiUlOGbxPf6A5a3aOFDQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ud+dgWrItnENJSshdcllXc7b5do2hLzCft7YZ2ulL759/ExOzkzw1biSMSxR9hZSfMK41PfmwOg27ep707JUS3aRqMR3VDYkF9hWgQem5h/vVukQubkvq6S5NAG7N/rZpRtrUYpQbJktUCRHZro27592IGEWW6ojXVBS9UhMMhbM3PX5wTWcDCNGyQ+F+92oMFcLGWtBZlLwv0NoOVDCMi9HUV1OhotXql+FoUCdNUaF9H6Sl+4J8fNvCD79zzSp4wbiDq3RD8NFq3LQjQ1G+BYyuP+BoPEvTFPSoeR1HXGy8SRMG3A8LbR0THS60/+LNrMWJqr65x0UthCo29oPpzOma+XRdxT2/sDySAW3GL328IP4ojxF9vZtOJRU71LZoV/dgeljDxZ81Uqi7tpMOgzRXS37xYvUZCjJRI3lwysco+6GjW9WZUYG1ylbvNMx
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:08:31.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d52aa3-132b-4be0-6fee-08df1596b3f3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12147

Move the default (software) calibration values SW_CALIB0_VAL and
SW_CALIB1_VAL, used when FUSE values are missing, into a new
struct rzg3s_thermal_info retrieved via of_device_get_match_data().

This allows different SoCs sharing this driver to provide their own
default calibration constants, which is needed as RZ/G3L uses
different values than RZ/G3S.

No functional change intended for RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No Change.
---
 drivers/thermal/renesas/rzg3s_thermal.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
index 7ced8f76a0ec..146b73a1b751 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
@@ -27,10 +28,6 @@
 
 #define TSU_READ_STEPS		8
 
-/* Default calibration values, if FUSE values are missing. */
-#define SW_CALIB0_VAL		1297
-#define SW_CALIB1_VAL		751
-
 #define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
 
 /**
@@ -55,6 +52,16 @@ struct rzg3s_thermal_priv {
 	u16 calib1;
 };
 
+/**
+ * struct rzg3s_thermal_info - RZ/G3S thermal information
+ * @calib0: calibration value if FUSE value is missing
+ * @calib1: calibration value if FUSE value is missing
+ */
+struct rzg3s_thermal_info {
+	u16 calib0;
+	u16 calib1;
+};
+
 static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
@@ -149,7 +156,8 @@ static const struct thermal_zone_device_ops rzg3s_tz_of_ops = {
 	.change_mode = rzg3s_thermal_change_mode,
 };
 
-static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
+static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv,
+				    const struct rzg3s_thermal_info *info)
 {
 	struct device *dev = priv->dev;
 	u32 val;
@@ -163,13 +171,13 @@ static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
 	if (val & OTPTSUTRIM_EN_MASK)
 		priv->calib0 = FIELD_GET(OTPTSUTRIM_MASK, val);
 	else
-		priv->calib0 = SW_CALIB0_VAL;
+		priv->calib0 = info->calib0;
 
 	val = readl(priv->base + OTPTSUTRIM_REG(1));
 	if (val & OTPTSUTRIM_EN_MASK)
 		priv->calib1 = FIELD_GET(OTPTSUTRIM_MASK, val);
 	else
-		priv->calib1 = SW_CALIB1_VAL;
+		priv->calib1 = info->calib1;
 
 	pm_runtime_put_autosuspend(dev);
 
@@ -178,6 +186,7 @@ static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
 
 static int rzg3s_thermal_probe(struct platform_device *pdev)
 {
+	const struct rzg3s_thermal_info *info = device_get_match_data(&pdev->dev);
 	struct rzg3s_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -208,7 +217,7 @@ static int rzg3s_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
 
-	ret = rzg3s_thermal_read_calib(priv);
+	ret = rzg3s_thermal_read_calib(priv, info);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read calibration data!\n");
 
@@ -251,8 +260,13 @@ static const struct dev_pm_ops rzg3s_thermal_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
 };
 
+static const struct rzg3s_thermal_info rzg3s_info = {
+	.calib0 = 1297,
+	.calib1 = 751,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r9a08g045-tsu" },
+	{ .compatible = "renesas,r9a08g045-tsu", .data = &rzg3s_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
-- 
2.43.0

