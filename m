Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224584;
	b=E/ZN5dGflKO3SC0WioC50Blf+B+tgS2h0Gn/pYzLG73F3bbQYRmjPoR50Eyv5pdW8SXS
	 K+tuRLIoE+JS7FEgAzaHq+OTx8bHEcD6kO0hI902B35X58DhVlq9A8kTIN7YHxL3o1NnI
	 n1tk9FjAxewB0MHhrx4KeQ9O+eFh8glfAsqvpSIbplbdWxZmP4/il8CjbCAl8vFet/8IP
	 dOKF55h5zuYBAkhPxyCeQjvht+cEzNs+mr8AwSdSY6iEiG1qvlC3e9fLiVd4mWjitjKWe
	 ZwmVngf9CrZ7qAcGVzGmG9cGA4hPKuyRs7OHeQ1Bzcb2KT/52qN8q30YljHGVYoyBlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224584;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cwHDfKzPJqK9u5eKFVtCIbHjqWzMR9vJ9deY9M3mm9E=;
	b=cnxU40H30w/rYPnjyUg37gujVfs+ERoRCzAhUSpPodhFdZCNq9Z8MFci+PGQZ2xqaUJC
	 HolMYWswJ+3B2xapH8feXqGrAYLhu1AC8sxhnpJxCfd69gTNpnMWl8aj2qBiJ3noe72QF
	 waDiHjH60FiPaVsyryHanKYT6BzuzqjYhwWbB95g2jyHElguJUOTOaZcpl91QmwrC0be+
	 rqe64CQA+AFUDVMGZJMvEIK9xnGRhH0v7Ru44mKQrdsZ2O95Z6CfUCWH3XU9WS7fOGdq6
	 RJtN+UqvAUoEg7E5w1vJ+pjE0Uj8Bu6BnaS6e/JBcCw4FIQlZXclKIxzJpbpXuGYESw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=lXbw6PfY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.24
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31884606A323;
	Wed, 28 Oct 2026 21:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31884606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=lXbw6PfY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rper5bFN0LSvh226MuZBCWaMxZ4exZfKQp6Q2PlSyvSxhzNoXANHA6Gcs4z6EhSZYrTVlivdNn8O3Q+rw9FjYuuGFv+sB1xKt/9zBVw0nPqcaFiikjg/DtRphUIBCVC4JQrpfKU6i1HY/JAifQBF0CQ5z+BY9ALFqpeQ9/3vUipTnOVKftFYqnzOBwjUoS9tzYwhdcHUXp6dE6viIRhel59/v7TT+7yJIB9yQlahDtXjVtw1e5EnciTUuu33cWZvFszRwmTlokbJ/lt+k7LG1QqDRRNCg88JbOSLjUOrODVCwsTzKzVsuVfFBpCnzh3EwO7C/p5dm2NVulWRcQPz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwHDfKzPJqK9u5eKFVtCIbHjqWzMR9vJ9deY9M3mm9E=;
 b=oHhQh1hZtA1VSSWIGVLa2hF3btmp0+riNNIxSmzVZ+npkfeXOVlM0mrmDiTwFUjB3QZ7niBK4vQKcWT8Bzyf5vuWqPRFglbzB9k7ZGvihF4SLdQnMg8YrpszFbXxKhIVfjGy7wmejZlcR5tIHrJW23dYkRuXjS6sYyVjKJVRXF4Piq4HBNBV2NBk2Q+sqOx6zj35z/ljmLp2Oj8ohhMY33UXMGLK9/R0q7V3q54+mKCfBjpOktt1p8hhp8rVZVbpiUR8X5GrtGjxJjzEKWOCZ4nGzY1mVEKFC04w8ldcpuyk6erumi65/0wZ55Th1tV+UYHV4VKnhE9dWE6gKjNytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwHDfKzPJqK9u5eKFVtCIbHjqWzMR9vJ9deY9M3mm9E=;
 b=lXbw6PfYc933T9ZAs8H/Dg1DMkE3zrc9fyr831U/FTtNQXr/Bb/2Fsr4XTZhvffiaj0JO/rjetBcHwLalXss2AM9TCyFvnle1dClbvpGYZQH6U8/DSP5XUGZrCGWPYgMjjSyMZV4MEXu8okzZvWrA89rReN0dU1s02+udjF2J7o=
Received: from DU6P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::25)
 by PR3PR02MB6330.eurprd02.prod.outlook.com (2603:10a6:102:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 21:56:18 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::81) by DU6P191CA0011.outlook.office365.com
 (2603:10a6:10:540::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 21:56:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 21:56:18 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 22:56:16 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] power: supply: bq25630: Add support for liquid detection
In-Reply-To: <cover.1793223841.git.waqar.hameed@axis.com>
References: <cover.1793223841.git.waqar.hameed@axis.com>
Message-ID: <a68c819a948d15b88c6584be73b258c3eec853a5.1793223841.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 22:56:16 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|PR3PR02MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d972bd-c66b-41a7-edc8-08df353e4be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|261026121527099003|56012099006|11063799006|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	wVLIs4L3P7J0gEkHbiOMJf6uxMf1p/2LaaMj8CYUiaoOVgzy8dYjDtzaPIxkt9PqtazL/SBupgYuqiuGe6Pgnic+X3nASgFZvGWtRH/SEV43M7ilvgtXwBsSp9QRgBVKArGhudlgzZfin5+0YOyvzqO+duw4fAFOZ+C33E/hr80Ouh5V5MGcB9ib3EeZ0JAHZhOUfqlzQCeRPR6c1ggIpf0TtSpxbY1HB4yJuzUlrcJDpfWKiLBhhSzStmFY5h/gvlCpHrI0qN9fhX3d37gjYRHDKmXSowG1k8iPCvSJAz8W9biFFtOSz/0FoXnAQjSQFsaz+gFVzuToSlrSm6U01QxdyuQtmMM7THPfHJiyPUhStiW+BWLUfClMeAorfV0Z9opH1rzt+57DQc1RGY6rY1gOJV6q/wdNg90ZutW9Z15jbEfgWsBpa3+MNAuxR8Tk9XOH0eX7Hq5dNAR+yr+HW3tgf7C+kw6nKkFIL3pz8DO9pN1De7KvLkg9UP3aM/500w3hDrb2Pfu2odH/c2CevIQFKSF/d0vZZ36Lx680k0iYRyilaeA+OVS1rkbyTUyYCJtbBV+WiHwBuubD6UmCeP7LH2uZotxP6JdZ+aP+IABD9wo7RF71N4HQhXxWVVz8/vMWJlfQqXUjXbEAQmE3S3bdGwsTNTFLj7NmYiz6LvXzzTbSIpxjXhw4BgPlyAHcRGvQvSAoRAsGbO82ZRLBCw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uvneD5K4Rl2ru/YFaijCEnLGvJ/cF5FndTdVb31ln212c0CxClaNoF5lAfKwJK9Iz93oapsXIFOERGeisaXcWTBQ25HaoVd2FMondSktqI/rT3TXlRMnCENPdY31Znw8pc3wYxIaKs5lZD+504DjZ9b0qhwxI6ZcMMm3hRHuQaenP6kygCWHFBqNXWZqd1S2i/CyWoC+wS9m4ybADRB7XnOF2u6cQ/jDnxmggIbIwUzQdiG3e17bJ3l3a31/1ukdYrPWubrd8nAcunsLNaOMKr89zgSokhJE9DZAkD+8F3rAr/jfbO0rsWLN2Ga/HkgSgGzhs8+HmCTb3FAEvKycV8qfS3KljAm2gm8jQmQmlp9kMbl8MtQkEdoLPygDSIFhq+shq+6MYBZr1zRpg/vFXrjslquJovXf9QAKsnnS6kftcrwRIwMWcJCjokFtiTxG
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:56:18.6815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d972bd-c66b-41a7-edc8-08df353e4be2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6330

The framework supports reporting and controlling liquid detection. Map
this to the different liquid detection registers available in the
device. Moreover, use the default reset detection threshold values since
the framework currently has no way to specify this.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq25630_charger.c | 158 ++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
index a934f3deba63b..dac791718bd98 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -198,6 +198,16 @@ enum bq25630_regfield {
 	/* VBUS fault. */
 	BQ25630_REGF_VBUS_FAULT_STAT,
 
+	/* Force liquid detection. */
+	BQ25630_REGF_FORCE_LQD_DET,
+	/* Automatic liquid detection. */
+	BQ25630_REGF_AUTO_LQD_DET,
+	/* Enable liquid detection. */
+	BQ25630_REGF_EN_LQD_DET,
+
+	/* Liquid detection status. */
+	BQ25630_REGF_LQD_STAT,
+
 	/* Sentinel value. */
 	BQ25630_REGF_MAX
 };
@@ -250,6 +260,16 @@ static const struct reg_field bq25630_regfields[] = {
 		REG_FIELD(BQ25630_REG_FAULT_STATUS, 6, 6),
 	[BQ25630_REGF_VBUS_FAULT_STAT] =
 		REG_FIELD(BQ25630_REG_FAULT_STATUS, 7, 7),
+
+	[BQ25630_REGF_FORCE_LQD_DET] =
+		REG_FIELD(BQ25630_REG_LIQUID_CONTROL_0, 3, 3),
+	[BQ25630_REGF_AUTO_LQD_DET] =
+		REG_FIELD(BQ25630_REG_LIQUID_CONTROL_0, 6, 6),
+	[BQ25630_REGF_EN_LQD_DET] =
+		REG_FIELD(BQ25630_REG_LIQUID_CONTROL_0, 7, 7),
+
+	[BQ25630_REGF_LQD_STAT] =
+		REG_FIELD(BQ25630_REG_USB_C_INFORMATION_0, 6, 6),
 };
 
 /* 8-bit value regmap. */
@@ -451,6 +471,115 @@ static int bq25630_write_limit(struct bq25630_data *data,
 	return 0;
 }
 
+static int bq25630_read_liquid_detection(struct bq25630_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->regfields[BQ25630_REGF_EN_LQD_DET],
+				&regval);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not read liquid detection setting (%d)\n", ret);
+		return ret;
+	}
+
+	if (!regval) {
+		*val = POWER_SUPPLY_LIQUID_DETECTION_CONTROL_OFF;
+		return 0;
+	}
+
+	ret = regmap_field_read(data->regfields[BQ25630_REGF_AUTO_LQD_DET],
+				&regval);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not read liquid detection type (%d)\n", ret);
+		return ret;
+	}
+
+	if (regval) {
+		*val = POWER_SUPPLY_LIQUID_DETECTION_CONTROL_AUTO;
+		return 0;
+	}
+
+	/* Can only happen after unsuccessful writes... */
+	*val = POWER_SUPPLY_LIQUID_DETECTION_CONTROL_UNKNOWN;
+	return 0;
+}
+
+static int bq25630_write_liquid_detection(struct bq25630_data *data,
+					  const int val)
+{
+	unsigned int regval;
+	bool automatic;
+	bool enable;
+	int ret;
+
+	switch (val) {
+	case POWER_SUPPLY_LIQUID_DETECTION_CONTROL_OFF:
+		automatic = false;
+		enable = false;
+		break;
+	case POWER_SUPPLY_LIQUID_DETECTION_CONTROL_AUTO:
+		automatic = true;
+		enable = true;
+		break;
+	case POWER_SUPPLY_LIQUID_DETECTION_CONTROL_ONCE:
+		automatic = false;
+		enable = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->regfields[BQ25630_REGF_AUTO_LQD_DET],
+				 automatic);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not write liquid detection type (%d)\n", ret);
+		return ret;
+	}
+
+	ret = regmap_field_write(data->regfields[BQ25630_REGF_EN_LQD_DET],
+				 enable);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not write liquid detection setting (%d)\n", ret);
+		return ret;
+	}
+
+	if (val != POWER_SUPPLY_LIQUID_DETECTION_CONTROL_ONCE)
+		return 0;
+
+	ret = regmap_field_write(data->regfields[BQ25630_REGF_FORCE_LQD_DET],
+				 1);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not write liquid detection check (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Datasheet says the register resets when liquid check completes. Poll
+	 * it for the default check cycle of 500 ms (field LQD_WAIT in
+	 * BQ25630_REG_LIQUID_CONTROL_0).
+	 */
+	ret = regmap_field_read_poll_timeout(
+		data->regfields[BQ25630_REGF_FORCE_LQD_DET], regval,
+		regval == 0, BQ25630_IRQ_CYCLE, 500000);
+	if (ret)
+		dev_err(data->dev,
+			"Could not read liquid detection check (%d)\n", ret);
+
+	/* Turn it off after checking once. */
+	ret = regmap_field_write(data->regfields[BQ25630_REGF_EN_LQD_DET], 0);
+	if (ret)
+		dev_err(data->dev,
+			"Could not write liquid detection setting (%d)\n", ret);
+
+	return ret;
+}
+
 static int bq25630_read_charge_type(struct bq25630_data *data, int *val)
 {
 	unsigned int regval;
@@ -493,6 +622,19 @@ static int bq25630_read_health(struct bq25630_data *data, int *val)
 	int ret;
 	u8 temp;
 
+	ret = regmap_field_read(data->regfields[BQ25630_REGF_LQD_STAT],
+				&regval);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not read liquid detection status (%d)\n", ret);
+		return ret;
+	}
+
+	if (regval) {
+		*val = POWER_SUPPLY_HEALTH_LIQUID_DETECTED;
+		return 0;
+	}
+
 	ret = regmap_read(data->regmap8, BQ25630_REG_FAULT_STATUS, &regval);
 	if (ret) {
 		dev_err(data->dev, "Could not read fault status (%d)\n", ret);
@@ -921,6 +1063,9 @@ static int bq25630_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		ret = bq25630_read_batfet_ctrl(data, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_LIQUID_DETECTION_CONTROL:
+		ret = bq25630_read_liquid_detection(data, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = "BQ25630";
 		break;
@@ -992,6 +1137,9 @@ static int bq25630_charger_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		ret = bq25630_write_batfet_ctrl(data, val->intval);
 		break;
+	case POWER_SUPPLY_PROP_LIQUID_DETECTION_CONTROL:
+		ret = bq25630_write_liquid_detection(data, val->intval);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1012,6 +1160,7 @@ static int bq25630_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+	case POWER_SUPPLY_PROP_LIQUID_DETECTION_CONTROL:
 		return true;
 	default:
 		return false;
@@ -1035,6 +1184,7 @@ static const enum power_supply_property bq25630_charger_properties[] = {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_LOAD_SWITCH,
+	POWER_SUPPLY_PROP_LIQUID_DETECTION_CONTROL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -1084,7 +1234,13 @@ static int bq25630_probe(struct i2c_client *client)
 				     "Could not initialize regmap8\n");
 
 	ret = bq25630_alloc_regfield_range(data, BQ25630_REGF_WATCHDOG,
-					   BQ25630_REGF_TS_STAT,
+					   BQ25630_REGF_VBUS_STAT,
+					   data->regmap8);
+	if (ret)
+		return ret;
+
+	ret = bq25630_alloc_regfield_range(data, BQ25630_REGF_FORCE_LQD_DET,
+					   BQ25630_REGF_LQD_STAT,
 					   data->regmap8);
 	if (ret)
 		return ret;
-- 
2.43.0

