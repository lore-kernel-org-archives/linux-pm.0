Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63861448391;
	Tue, 18 Aug 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046527; cv=fail; b=lvcQGq4+2lcRH7sj8uxZMrtNZtCVp8DT8V/JA66aorh5kQO30LMU9C6bY5CV61J0sK7D51iad6jTHGqCos64ubDVninYbqk8nTOZvJGOQPtQaaj0nkZvj5SEA8Rk9zCvYU43zOgRD9hldh2Z7+aNYPBitjLxGj3cqKXANmZAPis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046527; c=relaxed/simple;
	bh=E/shANQmU4vttNXNOFfp9ght3L+2Z1ZMQzVdFHEdPUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gLjWK9iX0f/7uLtmZxnrPiNyu0K3rRawbEMLUCirOQGzFmUb9AcuPuQq4O/BOz5i875jBuRSf3whcTCeAhPD69pU6xGqj03M8qj1QvYlCA88EQM6kee09jjqeA7+6w/AFLIoeGVuTlraSLwskJjIcYR+8BWdxsCCyDq4OMy7gy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=I+JYDS2R; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="I+JYDS2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvDyoxUaIPUY0n1SE+W8i/spadOZAF5SZ1YnwSKikJU+JWV/ZNvKX5KSLIMw3gP2GBJ0dxtARK9aBviRYVxYwd+vq5wIu4cGj0/WDwwNsEENUFzAqaDKhLDHaXHBh8xjiYqvGbfu3cDi9g+8kgPQVTTHlo30hLEOgKen787oOwunkGjiZ4tb3cjfpjC6L4qJI1+ONY9nHV47MsxQsXkqlIe/LO/3UfJW/vuj7vCifYFuzCUGOFwX6MQgD/BDX114b3tBikhKZOmL/+BK1w6v7kwHPCi2y3Q22s60sE9MlbczhfQJoZHDyXFtn1U0MR6ZKhArGpAVq/g/nnDD4qx/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyUCOa6gaorZp0E4Ve9aA2lRJVno3UGUKOZcg1tSx4E=;
 b=hlPWgC3lTQ3Khm0jvo1Qow36fXrzbcXMwkt3bbQ8vIhbCN/JMm8KYU8jqR7eLkIpEBFjLN1+lmxLjWchYUrDsl9/gymJ6DRMpByRj2q9jCSwwfezykjQwxlPX4iQBKMAOww2nQ3AkVZFT4aX+a7W6RQaQBVEM45Yz+hxLhvDOz9G1fmlWWeD9bXwRSRuZenbMkVVr7+zhgTc0pDvuMpFDHPn2f6PqFgIHNhBzZGM8J5+G32a7UN2guBl1R5U2b1HRaEMRaBG7i934O//8+/Uwh5f++lTLh1lrJGo4HkQqJW0s8E81AX8IP6LYUG5ocAAsfZ43Zid+n8e0xNakHjRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyUCOa6gaorZp0E4Ve9aA2lRJVno3UGUKOZcg1tSx4E=;
 b=I+JYDS2RDwk/Cy8b1atJhCcOPCHQBFscOZp/iK0bIrzlHv3yvbUdWBZ9ZVv3RqJCiT1fRfpMGG+OBvImUDxTRzE/YR4iG6XrNCq2JfrLb2+IP2Sh3XGjkTPEua2NB9yvF3BXOHN+vYpj3nTES/M40W/rC8Fq76LsHnDN6IvUy9Q=
Received: from AM7PR03CA0003.eurprd03.prod.outlook.com (2603:10a6:20b:130::13)
 by AS8PR02MB9888.eurprd02.prod.outlook.com (2603:10a6:20b:618::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:48:38 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:130:cafe::7) by AM7PR03CA0003.outlook.office365.com
 (2603:10a6:20b:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 09:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:48:38 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 18 Aug
 2026 11:48:36 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 18 Aug 2026 11:48:36 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 6F20B27B3;
	Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 56ED8803B10D; Tue, 18 Aug 2026 11:48:36 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 18 Aug 2026 11:48:22 +0200
Subject: [PATCH v2 3/3] power: supply: bq27xxx: add support for bq27z746
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-bq27z746-v2-3-0371e206665f@axis.com>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
In-Reply-To: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=E/shANQmU4vttNXNOFfp9ght3L+2Z1ZMQzVdFHEdPUk=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqhCpwr9of04mugRUW/z+PbY3f2o8YwxTFJFO+I
 WBtq7oikOCJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaoQqcAAKCRCwB25JC3Fh
 a/eNB/9xnT5qjK3+zTxHTUfItOXFcNM5baVoGeZGeVixjpQJgwiY3fRPQS0j0Jbwd2ndPBKJHge
 +sfL0JH+bW8R1euncbOHsMPmhPa+3y8Prj30pHMMJCGHn9S69gBAYilJRParufgojg8NwSI7IIZ
 DsHoeJ89rdHNTBrywpptekAhfNNSXwOuI0c82GdWg2Z9pu7L9EprZMiQyzR1KyifJN8W8xHcD2o
 lr3qN9j2LcIxIgdY+HJpz+8r3IZJFVxYH5wn1zPOk2r6Kf8Vd3spUdVbRc6UTPMQsj1R7ZuEI7r
 JVteIev/hNmdowPOG6jXSt1tmULwoac7DaO45qOTuf2tyB1O
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|AS8PR02MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: b7986a83-67fe-4a16-1a3a-08defd0de103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|13003099007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YxlFj8oeBzdI8VYELNqjbbUsg7/7gEsD0V0Qo4v8Kptg7RN0R5Aoj6Ld9kWHvcy05ctC0SeJdOa11teZfAvDlzH/JkGecT/bjQZPSanCVX5v7WWrCESYyuw/JW3b5et1NaFPhltFG/d6NJEQy8Gq/GjQmmQIX4TkzYr6BZLopXSSUtDHWP4nqbKIJxpcHRue+l/9ms4lWpDrzzWzKlmt8M4hjO2nVGCFRWeesoNgqL2hbEuTRv2xMOJ3r7+CaUllCcn6NCHxKA2AA364OnSkLthPejs+cSGlHMp+59shJ1p56BAjobnZRLfSKmO1a9IslsJUAIfcK6E7v7JYE6Sy3H8bN7AVl3J7jRmLxX5QVpCCh7f+jG+3OkL5txo/AOwRXiCR8gJ/DYDHVlgDLjmj/R3uaWOnZHu4Cjl9gbUCQSWZ4laH81kkFN4FOIWdeM4QATi5FBRaaOzX4mUKtY/PAzHuQXDbXWyeaOnJW4CWEOTtSvUKTnhsorvORll0gkymNg62QE8l1R1wRB/GSWdg7Wrll70FHIs9e8DJucv27lRSIu7iN8BJ1SGSKtc0PjHzgriVPPfpD88hLh8U1d06+TeCFmsUmnyy6xkEZ6d+oW9Emv7SDxDYlkNl8pL1rVkq/JRH6F5V08ltuitk6rC6AJ/JUvcmAFFQtiR7S5tTKbz3Xqrammeq6im1NWKktLr/ptyaDkm62l7+pslR9EWK1g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sVYBuA9+RozCXQhsRSBzx1V1MeMwTcHg8pREBTzivMdZw7ROC7Bh7OUeghHGXvM7w2lVhNAoogY9joHuWPAR71zL1wYfIrxO//eY9dCs6YIRD/zjXrr64ciVZb6yUIvF87cjgM+Fk+EiUT5jyVr4kUEMtJQlAbZTmDEd0CVieCdrb0Ak0PgYk4QcOcN2xF2ip6nXBtN60QADuvnsIO7fwhXOEulRjUJzrV/3gVrN0TysbR6I/WHafDXudqWjcG5dQ8J68dHzKujLyp3Gt4LkDBkSg/djKlLUazf/bE3l1UINCID6J46bjwKHiSPm/AgURdb9Ms4cQCkL4O0/IYLgnvXUn7yXLK1AQ2aO/RQNJgrKrb947NiDmyH4CwmbsIqKjKxtbQ/Vqk9Fr0uFELXzi6NL2bOGuV2C43AY3vOjX4Yuzwg2gfDgaS4ruu3tF0OU
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:48:38.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7986a83-67fe-4a16-1a3a-08defd0de103
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9888

bq27z746 is similar to bq27z561, but has additional battery protection
logic. The standard register map is a subset of the one found in
bq27z561. There are some more differences among the ManufacturerAccess
registers, but the ManufacturerAccess registers are currently not
handled by the driver in any way. Therefore use the same regs and
props for bq27z746 and bq27z561.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 6 ++++++
 drivers/power/supply/bq27xxx_battery_i2c.c | 2 ++
 include/linux/power/bq27xxx_battery.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 01c9ec1116fa..5aed8b24119b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -37,6 +37,7 @@
  * https://www.ti.com/product/bq27441-g1
  * https://www.ti.com/product/bq27621-g1
  * https://www.ti.com/product/bq27z561
+ * https://www.ti.com/product/bq27z746
  * https://www.ti.com/product/bq28z610
  * https://www.ti.com/product/bq34z100-g1
  * https://www.ti.com/product/bq78z100
@@ -501,6 +502,7 @@ static u8
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
 	},
+#define bq27z746_regs bq27z561_regs
 	bq28z610_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -836,6 +838,8 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+#define bq27z746_props bq27z561_props
+
 static enum power_supply_property bq28z610_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -994,6 +998,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #endif
 
 #define bq27z561_dm_regs NULL
+#define bq27z746_dm_regs NULL
 #define bq28z610_dm_regs NULL
 #define bq34z100_dm_regs NULL
 #define bq78z100_dm_regs NULL
@@ -1052,6 +1057,7 @@ static struct {
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
+	[BQ27Z746]  = BQ27XXX_DATA(bq27z746,  0         , BQ27Z561_O_BITS),
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index c4e7a9521d08..2a6b4534cb28 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -253,6 +253,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ .name = "bq27441", .driver_data = BQ27441 },
 	{ .name = "bq27621", .driver_data = BQ27621 },
 	{ .name = "bq27z561", .driver_data = BQ27Z561 },
+	{ .name = "bq27z746", .driver_data = BQ27Z746 },
 	{ .name = "bq28z610", .driver_data = BQ28Z610 },
 	{ .name = "bq34z100", .driver_data = BQ34Z100 },
 	{ .name = "bq78z100", .driver_data = BQ78Z100 },
@@ -290,6 +291,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27441" },
 	{ .compatible = "ti,bq27621" },
 	{ .compatible = "ti,bq27z561" },
+	{ .compatible = "ti,bq27z746" },
 	{ .compatible = "ti,bq28z610" },
 	{ .compatible = "ti,bq34z100" },
 	{ .compatible = "ti,bq78z100" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index d56e1276aafe..0b833c4bb583 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,7 @@ enum bq27xxx_chip {
 	BQ27441,
 	BQ27621,
 	BQ27Z561,
+	BQ27Z746,
 	BQ28Z610,
 	BQ34Z100,
 	BQ78Z100,

-- 
2.43.0

