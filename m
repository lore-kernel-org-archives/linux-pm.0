Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4292DC792;
	Fri, 11 Sep 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132633; cv=fail; b=orEarL4GlgeI9XefrvFCxLSi7/64kh5WlbdvnAHnfW8PrS8BsS8cbt/CRXvQAMWMa1IYlMV0NviCAFeVKe5rgfrYYZCXNm+xFtypmQgQHkRAdOS/4cgodU/JT0tZismTb4JQPD4mZ05+Xq2CPiBBkvpbDftZE5cACwxfXHx/fh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132633; c=relaxed/simple;
	bh=VHzX/a/WRb+83viWQvBXO/fYRfonVCGZVqXesOw6aNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzamgo63hhNeEAsZ8XwaSozyYSX4RBDd+Xh3c7+gkcc8t+++p0ICzRvMBNxcI+Oi1ZEooz22g1J+AtusVnFFdhlmWuk9+BAa6iQBrKlaWt34bjZ1589jtmW+GA6h5BoQGpcX94wUZHUHbsMBf69PWbINM6GTxZ/eTX3dM0HWxSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SbjmgZ/R; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SbjmgZ/R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIRcXQ4esZnHHy6VUVm+mJZeFDoDrgwJhwrGi8l+TK6TLzobJFpyCV697YM12J7xyXA3SO+v8c5ZRlUf7/WeyXBWqeqnPVknWXKMB69q6hxHg11ADfSqRITfsSCcJaYWzrjXQsQfoATYTi6GC8zjllNR63ZlvkiMqN3eNiSgBo5PiUXR8WftYhVH3cqkPB73PElWdcOzAC4YBbujqcTN5vfI4wlfSSc5vPmnFB1O2UlBEcLefVgI98rV9qy/x9y4FyJ7Seu9a1LV4LCJaaGcAIi/OWLX22Qm2TmJh1Jl+SpUpnsYBSejf8pMx+Hamo41TA4StoW1ZfpaQnrL0pmy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhuQzfWQZtO5ENfyzaaRjSMXkiLErgI0B7e9CF2ZLcQ=;
 b=gqKfxYnexvF+T8llkEzd7YCMYbgJLx5AqDcEa8B7O8hzOVczS/eRiFgPgWtE+ylJ6MnWLteZsqQRZVo/LB19jyhk/EAPcWSYYSe3z4jyV3eLi1r8mw6rBdPcAHHq6EdI3i/XS2zGR1UyGmbGzndLu70gkkAbmm9p8/Zuj279+Rllmnrh1CejJMQnPPgpU8n/x1iv/fvwpeU48Yhn+gMutB8GpGVE22JvfeFgiE/ev6FHs26x0DEeC2On5bUhrZ0gpHNJ8D5fP4E6QpCNNCLzR5rmOCzAIpTEG6ZWNQDzqRAD76juaVYTwseg3XEFDqM9lRaCeLzFXA1oxuPd0nnkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhuQzfWQZtO5ENfyzaaRjSMXkiLErgI0B7e9CF2ZLcQ=;
 b=SbjmgZ/RHDLYldMPuXZOQw0BXvJH0Wx4H4XMNmx3yA05zaZYGZ4F0yoyteG/vtRJVGxMN6e5XprklensKgaLCDkCZSK275tC3mHaMs7SSh1VXOM2OJPwSMr0kW/6nwd80ErP2goCRQs8uj4+3bYZCSqBSXMfJpPU8Z28u5zeCSU=
Received: from TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::15)
 by TY7PR01MB13927.jpnprd01.prod.outlook.com (2603:1096:405:200::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:17:03 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::44) by TYCP286CA0264.outlook.office365.com
 (2603:1096:400:455::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:17:02 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.175])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9CC443000250;
	Fri, 11 Sep 2026 22:16:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC match data
Date: Fri, 11 Sep 2026 14:16:23 +0100
Message-ID: <20260911131629.111564-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
References: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY7PR01MB13927:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ffe32644-5c32-40c8-1ab2-08df1006f812
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pOuHvoryKYzFHxNewFifiwF2ilX+ZDfr88K5oCWi2nx99BIRUMzAtLjDS69HGwva/ibCSnhmpGpgz3l1f74kmdTnUlACtlGY+Py665GX/Xgh3DSeAWsBa4aIQr75lw0pVrLyI9ZoPq4SruExDBVY1lttopavV2xFlWkfJ1/QTMZU+Rn88AG/OzoRMWr7mVDFayZyMsg80xMCU4aVt3a4TQm9zmH92X80SZFEdUM6T8t0uXZksLIBFlqqvOZl2Dl8qD6tc6Kviw3RdLp4pWt9e6fT/BRE8WMSXli0BGO2ChoAMQnhKsz9WCR8tY7BOIIGiJyl17tQIKL25UZ23fmvFGcjvBlK/L02Lc64kLXk9G/nzRxDpEvs1fkN0WVBNOpxLhp8QI2oiH/AKp0gOHymVvVePo/0xoc5wFGmca9TL8WR2dw56NGXVolFHOghpnJxsVw26gGJNcywANt9VEABAmYHWukdyMozRGcqpCOkBUIXgyfqQ+gIvMiS15qXfmcxIiG2gNtyM1Ohg4kMhW5eiQ7TUNesdZqWL1La6aXjnbyAI+lXHz8+6BvZiR3Zzrpzz4PPutn/5eYcOpH5AviuJJoj1o3077lY+g5BM5ntm2e1sBrY2ctFCkSY8R/df1dnODKV+xkU6hwvq+14Vmxj/1JRkDVxj5VFrKXWCdmOqeI7RJWdyemGQOdHSzXxMDmZRTtk9kQ33X3lWLcXpYde1Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fmj9/gvF8nyR5JB43ezAE2qfxsh+O/Xz9Qvzef3aJgLHI/SKluaFaxaueVSAiq2kGRXkSZO/Cn4LhFZlcWpAOBx+u8XOFPM2em8q+1cwKExT9lzfS1mpgW4Ojui9X9qZx0DCt+M02LQTE9MkJHVKn8bQn8LOYyrHzfgeZys8nrIqbf1gVhQk7Pl8DuTIUDJoeFrmq1IFJuMC5Mw+MRqlChmrq9E5+wVPqEVbcbxwgajV3izmcoUsNkYsaoWEwQ34cjarLZxWzVHcfCXMkvNrH/2h0808hMZykc+WHZq91PfjHsByn36KM+HfHupmRHUrrZbSHCAwzin3o6w0xo/FKAlCPOF/fexe2cDbiIy3CYHbnKOnfESM6ogfgfdUF72mx9GJR5B/wIiUsIJvQ1jWKDvvdmXa/AP16f+XqBt+D1dp/37r8lo2NlhDRkua/WXC
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:17:02.7186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe32644-5c32-40c8-1ab2-08df1006f812
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13927

Move the default (software) calibration values SW_CALIB0_VAL and
SW_CALIB1_VAL, used when FUSE values are missing, into a new
struct rzg3s_thermal_info retrieved via of_device_get_match_data().

This allows different SoCs sharing this driver to provide their own
default calibration constants, which is needed as RZ/G3L uses
different values than RZ/G3S.

No functional change intended for RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

