Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4543AE6FC;
	Tue,  1 Sep 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291319; cv=fail; b=F4VxgQeDJPDqGaTdTk8S9YvZajDfBnkQrt3ysoF0OD7Gkz+jf1+1iGHCOUe3PMNVl7KtlP1i52gkMMPawwcdAeziBg5/YQYOC0NaQfDBy1RngTXyaW/Es6IQpMu4wbHADEmzObulbDmQwd+leZfdkLw4uarggEf7VOyeFKlPQTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291319; c=relaxed/simple;
	bh=FzNIehgfoBKpg+Fnn5gqeBX+pVVkdG+wkQgyCYHzwy0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Qtzz7iLTxr5fcFdaJwqpRVjitst2ocAL3m++Tpz4wWwo0PAKdsTKwl9Bgwr4U46N1+OIrYphA1ey2rRg3/AsCsD26JiDurKDd22W6nbL2N5GBpB9sfRllPklZQo7MxHMkaVoSVXQp9n6bmMuMt3n6nDaGzwPqpJaiiduAlFL64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=n2CvcZRC; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="n2CvcZRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brXhBnhH0Jl0+TqVa07INPCNPj++OV6F4LA7h7hnkFLX96XWo289U+/u2OoAE8kefNaXwlXhG5lsr0AHGOkpZapTAYoIHgH6QQz8Ro8tzqUmEVRtaLF2/xNFfLXPVg/qHwwuukyEA2ASII9hG9xVfnuM3BVJjq5npY7dDLgwa5Sn6jm0b77h3dsX8fl/kS2GqctjpSXjxf6M7jIpl8tfFsYFRJqL+a8+7r7p8LoHvxBwDJAJBOxQ9jFZ9JS1QnrqDiwZE6dx76I2X6RUb4M3mXI3Bhp8xVOOuVt1dSMcm0/PQRLE42W3FCNeO3eWj9sr5/8gBAVjtBOQLFsltkeYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+2ty1SQpH0wAVzV/rsGR53VXBNQrr+lGHbTdnlljIM=;
 b=qgbZfsId2C+78fnzV2LJyhNx/k+ELdflGnWZn+uh+r6G4SKPofPFKbTBk//RlA+VH2z8wfFRp9WLuL7NBkbgMxyEiJQSI0Q7K1maAKdzZ8n1WChVIUBaWKVnn0R116eLLr8bTSBTuomRSkrNLDaPM8myHb0kuiyNbVcU0D8uGBOlDVJsvQcWDxOyWLPkf6YRLcae+IuU/iwRB6299R/b/fY8JLVtoX+F9sETKG7m2HNTseoon10ZTDuYvPzvz3TuWDxxAxovRsx41hG+FTSEFppyh3HSbqdxtXx4tpMi87SblSO7wQ8/KKTGHNgPQmu8wrT+gXV3O0F9YsgeYs0/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+2ty1SQpH0wAVzV/rsGR53VXBNQrr+lGHbTdnlljIM=;
 b=n2CvcZRCGJuHIHklB/wonIPDaIFMfBgM11+VYAGg4cwMDAcrduJ63+9UyEJIkfKRD7cgOXtF0SIP6o5SjTCuVgXvj2a4URwaxnrDG3yVn03Ej/dZiBZtDjKIMYUinIgpENwzP3LWVk1y3b533mqACXKVQbnjmjQcaoXpIQYlHm0=
Received: from AM0P309CA0008.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::8)
 by DU2PR02MB10282.eurprd02.prod.outlook.com (2603:10a6:10:49a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:12 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::9b) by AM0P309CA0008.outlook.office365.com
 (2603:10a6:20b:28f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:12 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:09 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/8] power: supply: rt9471: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <aff418f8059465203ef814a1b508b84741175ab9.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU2PR02MB10282:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c442a9c-8c21-4c83-2a1b-08df0860241d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xqtL/Kvw9PCRJbg7F4qYA1CvKRCLJy6aUXVG+tmI6UGnSfVVv7NusptSECu2ORdYXTx0uyQamEnzKdMxhCUTMIuf1oAPO8fyqB4AfKcuyI/dOEKVa9qSiGOt1/0Rc+aSmB767NJcvESyWYjMliJwFD3ETA9MHdnEUZ+wb/gPc/A/QysaKKqLDuGRRLzxkmmPOgIApXDG9zo++rfKCVNxQyv0bEqHzv80GtKfMMhahBAM4AudzuCiuyRNbomwVSRIbiNTYioAmWWAyUcO1NTz1/LC9zbF+E8QrT0/WhCZBWaX/22+82vr8i7J+ETJCnAI7OJ3R68HHl8H/BP4Dink/dfg4gtbP/ZXBHcUBBcXWR8FseOl09t1fmMk9B73iEBj42IQgcwAqgP2HDiai+lMn/cERvXcIi5ZxjzwAy/LGWcylCVdop9LttjBkUi2ProG97Kq4PmPtmG/kqSI/hNUIiD9XjyqayOZDwXBLrP5Mdy2ouI4HX/GEWKrOsa+IVbC0Jyz86vSi2EqQOisyIDdVlJA81eINHD/CmD8paiq+/2aQNfF9reqdBh0lpvxIUPLhMKX5Ri2xLaZvhnFg2VnWO28DElGHb5w9bB7ROJcGgGJHnUKaiACzeM/jYvEbBUpH3OSC5nqE8eyhuOp1ozL7r+8F1F8fZslPw07V52IMfLedIyhsP6L2w8wsgOqcM2P
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1odPFfUoRU6uuN7tlSo5b9Os6X8EG6jGeWpyZUgYy8SFZrnc3bwtEJ+MOVPvDFxz8mYKI3OuSZaaGDhThJg0c6M/Uubd7g3FN6gwlZzNoxZBTDWn2yHvQ8bCb5+EIxbTn6D6E0TO+4bvE8l0EoztTux6wwRgbNQ2L4mpoWIYP12fzjicn9Zy4hfTDAd0q9szlRgMN3etMXZxF++TOP1liEzYjGG3MGB4MiYQreR8lNJkO2FYBFUwGVyzVanMdO4AYfOyTYkaj29WR2jZG4HtSUuOrpjWkKixBVmEhofYDc/EAPZ0/jNXjTOUgPT3CfZkEdkqgFMj4eWe8QElx2862EDdmfm6qadIM7xK0fhWzpV70O6t18WB9AYWSAB7ErmvMLGwcJeTSvV+sIxdoWA4ceK8tY/p4Q1BHFtSawtRo6yRGgcjWMcMrWLsxAtzXvV
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:12.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c442a9c-8c21-4c83-2a1b-08df0860241d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10282

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control the BATFET, but
keep old custom `sysfs` ABI for backward compatibility. However, add a
note in ABI documentation that one should prefer the property
`load_switch` instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-rt9471      |  2 +
 drivers/power/supply/rt9471.c                 | 54 ++++++++++++++++---
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 0a390ee5ac21c..90cf94c1cbf6b 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -11,6 +11,8 @@ Description:
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
+		Note: use /sys/class/power_supply/rt9471-*/load_switch instead.
+
 		Access: Read, Write
 		Valid values:
 		- 1: enabled
diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index b67f5abaa9938..b16d39a774dd4 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -265,6 +265,39 @@ static int rt9471_get_ieoc(struct rt9471_chip *chip, int *microamp)
 	return rt9471_get_value_by_field_range(chip, F_IEOC_CHG, RT9471_RANGE_IEOC, microamp);
 }
 
+static int rt9471_set_batfet(struct rt9471_chip *chip, int val)
+{
+	unsigned int regval;
+
+	switch (val) {
+	case POWER_SUPPLY_LOAD_SWITCH_ON:
+		regval = 0;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_OFF:
+		regval = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_field_write(chip->rm_fields[F_BATFET_DIS], regval);
+}
+
+static int rt9471_get_batfet(struct rt9471_chip *chip, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(chip->rm_fields[F_BATFET_DIS], &regval);
+	if (ret < 0)
+		return ret;
+
+	*val = regval ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+			POWER_SUPPLY_LOAD_SWITCH_ON;
+
+	return 0;
+}
+
 static int rt9471_get_status(struct rt9471_chip *chip, int *status)
 {
 	unsigned int ic_stat;
@@ -342,6 +375,7 @@ static enum power_supply_property rt9471_charger_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -358,6 +392,7 @@ static int rt9471_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -393,6 +428,8 @@ static int rt9471_charger_set_property(struct power_supply *psy,
 			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9471_set_ieoc(chip, val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9471_set_batfet(chip, val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -439,6 +476,8 @@ static int rt9471_charger_get_property(struct power_supply *psy,
 			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, &val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9471_get_ieoc(chip, &val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9471_get_batfet(chip, &val->intval);
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = rt9471_model;
 		return 0;
@@ -649,14 +688,14 @@ static ssize_t sysoff_enable_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct rt9471_chip *chip = psy_device_to_chip(dev);
-	unsigned int sysoff_enable;
+	unsigned int val;
 	int ret;
 
-	ret = regmap_field_read(chip->rm_fields[F_BATFET_DIS], &sysoff_enable);
-	if (ret)
+	ret = rt9471_get_batfet(chip, &val);
+	if (ret < 0)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", sysoff_enable);
+	return sysfs_emit(buf, "%d\n", val == POWER_SUPPLY_LOAD_SWITCH_OFF);
 }
 
 static ssize_t sysoff_enable_store(struct device *dev,
@@ -671,8 +710,9 @@ static ssize_t sysoff_enable_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = regmap_field_write(chip->rm_fields[F_BATFET_DIS], !!tmp);
-	if (ret)
+	ret = rt9471_set_batfet(chip, tmp ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+					    POWER_SUPPLY_LOAD_SWITCH_ON);
+	if (ret < 0)
 		return ret;
 
 	return count;
@@ -744,6 +784,8 @@ static int rt9471_register_psy(struct rt9471_chip *chip)
 			  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
 			  BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID) |
 			  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN);
+	desc->load_switches = BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+			      BIT(POWER_SUPPLY_LOAD_SWITCH_OFF);
 	desc->properties = rt9471_charger_properties;
 	desc->num_properties = ARRAY_SIZE(rt9471_charger_properties);
 	desc->get_property = rt9471_charger_get_property;
-- 
2.43.0

