Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011024.outbound.protection.outlook.com [52.101.125.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2093E6DFF;
	Fri, 25 Sep 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317015; cv=fail; b=JzA32JXw5I40W/qoaW86aSKh/CgPw1icoRyF+flR+1OzHp/S1vZSL1XNgTE1dNyCaghPxhjH/KOBsW5Ubzb26FKuYBVhKO6AhZY0/j9P9tSGDEHvgLG+GwV0/kxJFRqkSGPdRlKN6ICGMwHLqtxlqPJDzTjT1rqE9wXANcBbz8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317015; c=relaxed/simple;
	bh=8lCY5ZRRs25pmJQHVyQ5L9At/JSh+tiEY+v/b9ftiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psu2E+m96GWH4Ap3VngJRGQ+KiUPmIx+e/JOF1Sy28tg1no5JaiXP4zaz0IMvldJdHxcJwAbTJ0I9xNxHguaCU3k+c7bdRlw/srlsxeXyMGTvixPGtXslLMajK+V6xJZ/LtLQvCXj2Mk4uSNcrhZeqxjbGIFuUU7Bsq6JlDmB6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Esjo6vzh; arc=fail smtp.client-ip=52.101.125.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Esjo6vzh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKyovXW7nxT6LM4fCnuEwENpBs3FeN5xPR8DjSACQCrQ1fpDYS7xswViOI5l3N+/3bmR1gwuzYn/O9p1wVL+euACoiEEN/5QKsKevYuHBkXG3ppj/3iNZbNhy+0H8DN+c4GcLz7IaZFygMbmEviOBEQDZcVH5Bb0AL9vTQ0C+xyvYdLdFC9TFOVUZY+gnIoMhByfbJ33P3qb0LYQ/3Td7jki29FUZsVlQY9IfE5rADubwbla6yQnHoEcIHrEzjxiUNjDkwmRUf80LrstD2yaiSsFgIe/g30L/LufkJtS5CeI66WTi6yavJQI/nSPqCAEtnNHPbC+Ob8ULlNq1X3djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AELV/4fG8Kq/YXi0sqK5UrVAgJKJue5J0zYHZuWQUyk=;
 b=fFlUvRCDrHz1LWitu5MC+oanUMIsaNdJ1wPUxwLvBwDZn99i+APUTyWb93W5cyVeGeJeTr+mKYz9D8AHwVU1MrvOkj7HBCWYnf8uJBqP+qlMX3WyJVkr41F99m4Dk3XgwJeZQ8kYlXhdfdtQ4rEHU90T4WcaRB93noDifuCZA/1pyvKRfXxVeUIuf7ZO86YARKUbu4EM3JFyEbT1uhD+kbc/LcbgeyLHYzAnKsfh73lG0OPyI97TaHD2GPWiqDN2yk9BhDx+PYYR2saAwp4pMYwSsrNc2WyurpIr4mF+ksHwl4q5181EprApLi8thaF3E/xFkWRtvnXsEQyjRBITGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AELV/4fG8Kq/YXi0sqK5UrVAgJKJue5J0zYHZuWQUyk=;
 b=Esjo6vzhbw1DfaMuo4jdnETM67ZDEITB2LLBTqYWaPjmv5Ndc77LxXE3K5G8Wg13uAopKFchXcnV0Bc9JZTa8gRRPbTk8HZsEU6PajHQAJjxZL2RRGQSKU6equwPDfUnRypqQ/6DPuIQFBvQKe2sew28zgcnlqBfiOnRbzuBr1E=
Received: from OS3PR01CA0002.jpnprd01.prod.outlook.com (2603:1096:604:dc::7)
 by TY4PR01MB14057.jpnprd01.prod.outlook.com (2603:1096:405:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:16:49 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dc:cafe::7d) by OS3PR01CA0002.outlook.office365.com
 (2603:1096:604:dc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:16:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:16:49 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 939153000252;
	Fri, 25 Sep 2026 15:16:41 +0900 (JST)
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
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 2/7] thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC match data
Date: Fri, 25 Sep 2026 07:16:00 +0100
Message-ID: <20260925061617.127349-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TY4PR01MB14057:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cefb2c11-b34a-4d61-f678-08df1acc9574
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3pmvvBzG5Ck4BrGwi9u3UowiYTo878lsmhJO7PovLjnl2S7v5owfTnwctn9uL3z5zJTS0W0jNc9QE1wY8h6pDJUYtIYkaNdjvhuQwwwv3GJLRB3v48JZgqxsYCWVJEVWilicblUF/8rKb7+zkG4jaFJAjFX7EgN2dS50x1y37JpnUUJumy4sbeEowooBVbSgwxccKD3Ilggpa0Jw6XaiY32FJ/dXSJTlwQ/pnCbuZNELkppmSw8cKFljSoRdV+3JwhB6ePFlg/SOQRb1nh9qAZArtEcMaz6avs0sWPOShBFxhW/ahm36/5+G+MVZwmu/rGaVrixmF6E7UAiVpdw20JenKhWnlKbidYB+AuN2AgB3GELYd+jm8O+5x80IleAAsf3SRjmCAbILVXklLtg2RHRGXo+AXNN+aAEcPmL1GdpK0ZiPr6wCsaH8dvSJ6q4GXSntT6bHJk6JizoF8o3vNlkQvdmT98YKcd+RWy+qq1VTdLC4OTMgAibs6y2sQWaOdJhqts7pz+jeCN4I0fWUIYDdFAL8SktlYsSKPlc1fdnFotqRIPckJd9Si+R2G/FZCix6L72X/8nrprqSIio1XwStZkQVWh6jWzrBSBwsX2+G8hdAzUiuCreZSROmwTDceC3HdLDqu8ZRsQqeA8a4+n8nEseMWYm5TQdcIayMWtrLGwu9VjWwgIp33NnfdsWUbdrn/a9WRpRTiK8/fd/IAg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	afbBbwLtUvBbI8HuuUj/SWEA4aui4AZ4DAEM3cyOZwPUlOTvrwaPE6T5sRvdFi6a0dyQkZ81XrCiqJyTXhqazytFYxI/hi3jQgAiKIPKvWG1VjlKsZGGDLv73mxgO/ceSp9JdmRhHaelnleDux80K5iWyF6LBgLkI390UiFA7SRNmGBD5op5X/9OgU94JXgiK6KWDo3zYFvSRGqNGlbWtp4zc0BZ1t9m05bK/WjBNwhAGpsF3esus0G470pLV9b+lqM7Yoeb+0LFUth/4nWXbZYcXsZ8TxI61hKc0LhHpEs2n8IMD1XhqMyXyQ+8KDKGlusped2wEHTyhGdPETkjDqJlzNQn4YynTOxJNciokxpvAoZjjTYp8QE4yXXeEKzeO31KYRP+2oU/ixobj7Uprjs6tSCbbL7Bv1spPyiKQ9JWI/Vtb/lwxeeUzYQRaw3p
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:16:49.2371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb2c11-b34a-4d61-f678-08df1acc9574
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14057

Move the default (software) calibration values SW_CALIB0_VAL and
SW_CALIB1_VAL, used when FUSE values are missing, into a new
struct rzg3s_thermal_info retrieved via of_device_get_match_data().

This allows different SoCs sharing this driver to provide their own
default calibration constants, which is needed as RZ/G3L uses
different values than RZ/G3S.

No functional change intended for RZ/G3S.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No Change.
v2->v3:
 * Collected tag
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

