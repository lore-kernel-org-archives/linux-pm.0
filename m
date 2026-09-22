Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010054.outbound.protection.outlook.com [52.101.229.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133133C9898;
	Tue, 22 Sep 2026 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051273; cv=fail; b=kmQgUh+PqlLp/gnfAvbl0VHZLXFq/ZjTJXuvUaesftNPyDS+aVk3lkVaFANgv9g3/a0uJ0qMNa+IXIZdyDdJ7yIOSx2t78ZucIcPv2iSJlGDNZQ1ibVF/qGhQam113k25Jr7rj3W/T4HJrD6xmTHjvS3HZ5m/uIy3Rn96WUsJdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051273; c=relaxed/simple;
	bh=c7Wda5ifaNLufxTVvoLwruUibqLHIZMucE/N1cDH0zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlooihOUDmnekanbN/P49UPoooOmzzZKWKFJrV54HbMztSylSl5ReVKWa4j/o4z4lCMlKtVYOoxix1caFMW+sp/ogHwd9vjzt286fhClc3lilQWDJEV6PVr9df46tT/Odvtu9QEB2zGYcILkilZK3YRi/12NovPgZMzXzxDSChY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lLiCndZe; arc=fail smtp.client-ip=52.101.229.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lLiCndZe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8ZrOlQsTC1XWmjCAEbai2z83Rgx4UbiG0Bff/kFrVpdiHmS78K6Khs59/2rofCHUOwd3IGsP9yiwmlVROdew9GozxHq8iuMW41WAxEbbOeI+PS5TvC097EvLBhGGkmFB62SCd65xQRPcyBgXbIbsIINOqceNhLGiy1enphzhgnJU+WkvS6LN5AHAckktBj8EnhwwpZ9lwMnKTz47MU0HmgK32noJr2b/VSjNBKrSh3hyP5C00IWd1JoOOk3YBJo9lIDlgYYvk+oU0cdqCzfm1ah9nFycacuvaHGZCQxwSn0qzdmeRoXjPkQKYhAH+P5FmvTLFWFioiOF0edMhPHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruTudwhZIlvAG5ZczX37Gr+4zRGGw97lROzw65OzUqA=;
 b=hNg3g/lj+trOEPKPm5auN7eswmRCNCwx/nO3BAWW4k9j0abp1rEWAUv5wgQHNZuoQmLzvH8URJRd1pPzdRNjRSbbJX8CPmSUpjH6ZpBNBfTYy4X55sLerhbQJtuqIdpj40F021kZLhKkENIIb/nIhrEzrE7u+QbnVN9cFWabWzo52YvK4Tvb7d3ne+6ps6NT1N0S1DxPEL7+hhkM+KsO4BeE/ps8YLuz7sRZNzobUIzgk9J38ZRhzYj0cBHCD8x29czUXGI8myqDaX7TLr6CJ8T09+NhvtKxNvJT8W8I2ICLvGRdMqmVsl+g2D8MSdVvpFsXcU4E8cU31D2Q3VM4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruTudwhZIlvAG5ZczX37Gr+4zRGGw97lROzw65OzUqA=;
 b=lLiCndZeCpqfvMPRvYW9DvLJY7y7xTX18l/Lru29wpKbq7TmbRtDpEVB2Tg/Dh/NNZmmxDDOUBzXJ5kLx/LwYFRlbjnXvse3WlX48t/yehTkSRTWnHU7FbuUS9Y0TJ/AMc/6Zy8abM2AiZpeEM0XrMuaIZH3DAhPrfOeUaigPlM=
Received: from TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2be::12)
 by TYYPR01MB16387.jpnprd01.prod.outlook.com (2603:1096:405:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 04:27:46 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2be:cafe::8f) by TY4P301CA0029.outlook.office365.com
 (2603:1096:405:2be::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:27:46 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 3DA11300028A;
	Tue, 22 Sep 2026 13:27:37 +0900 (JST)
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
Subject: [PATCH v3 3/8] thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC match data
Date: Tue, 22 Sep 2026 05:26:55 +0100
Message-ID: <20260922042707.116378-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYYPR01MB16387:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d616ca42-c7f2-4762-a302-08df1861da3c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0wpOv5GmF+y10VZRRGioBMSJ/apQhtC/Zh+qeDJ7mdo9y4Cw08ZVfXBS0yiTaRYo1pf/USIG8k0lQlPi4uKQ28qdSHaxxBDHllGW7FIysEc5uEYTyVa//+IbsjCMqa4cdZDVTAMcL8PfOT8+pF7ZO45P4rH8BQZadY4QKjCOwV/gola4K9pBEU54Ut+AmIisCbH0WXGZo3cb6JexUkgABVybX4gbxcrjBzsDshyN2HhFSozCRXwGKccXgH4fTJYlVcy+H+Y5lF1v6n2zgPvUKuIWcxmXnjADAKpU9uJ1EnNzvvRXeZrUuR+0+WCa5prRoxnoNkJQ39v94zwVI1aDYORONjm1hgxUwDIFwjhL64B8RxJgD91c2HS0Bykv9QfAAEqahzpLGw+0naBs+T3sGCRfAhDXIdZJnaMllWyVTcrU9wMC5C2xE1LXZ2ZbxwrC0ng0jefa11kGZl/DgCuWzZodYcX4ZxqnGAhveSsqY2i67nqqSkzEEuhu25d62/iM3OEcv5oEyoUPldF7/gNoerfB27URbjxA6GJTVOijZnLi13tmKmX6cPjMHHeEvtEMx8dosMGxzshrHzQaBdirQ7/W4+RyfXLME74P6q+ElQ1twm4jnKmmVcrYcwBlKLy4XHowr2tM1c2wTr75z7THkpsz5YKSgnhTGIaKIOFYcDoqQbmklwsq7gISKH7aWbg0/vTRVFUyn3EbxOyyzHpl1w==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nV30ASLXswdoJIYuD+e8c6OPR0HF0mNN+JBeh5shozHiWqFO8sCz12WMDDIssoW3yXcAyadlGCG4C76JDyQvqUsOPwQTyiQQGTI5HybcMQDAej1w+qOQkxcljLhfGn6BBUBej9x3ZWe/Ijs/7MAiXCerO0+XCpcgr8isKsFXfIpTxvVBRpuy90bVh9UHZWvuoYKHJD4Vu4wpglvkRidMf6tcrPldNPzRJXiKktU9NMbPYR0cG2zUoEsCP6gj04ZY0DSXiJWONVQEyStT4zR2fDemIc0wJO5O3t0Vtp9mobLsQ4MXKIAwcV3QsQXurb8ooJ66zXTBUlvAJ5Cfah8Y7AYyNxvmH1MmiDl0+boTnBHs8dwDdtMwZmdywceOx6O3njEMod8P28SQGGaaMO47/ii2/Ir3b/BG00yGq9kcjmDvDxEbkAHaRvQ8Le3DfWTa
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:27:46.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d616ca42-c7f2-4762-a302-08df1861da3c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16387

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

