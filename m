Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF15441031;
	Mon, 29 Jun 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747914; cv=fail; b=mq6SkyAKvvmVYw2esXSklip2Vo+qBGEj7OtbuFWW7G8dhuj0Q1dH51nBE0Q3EG4UPeT+QjKD1B1txPxhjimu6FYs2NAQbnsV8ZxaifRDf/62KD0pjbznjEDHZlqtlzz6wncX7tXeMwqjIwFet0Tjk+CMGnMWstj6wotdpNUtp6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747914; c=relaxed/simple;
	bh=56Ye61thbWMZ+ceX57p/aXWs/FMUB/EpPagvoUhUDaM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=MkvLZeXN5w9kxQsrh76kbHLNj21bdkRuEGqMF8CQCigQW6U6gW80EjabATMUNBpkgqgNJ8r5x9ojSkyZ2NvXSSU0iE+8PfViyb1NLuQUwF3HWudRRNVS1F6EweI9qRcxYbHcPsImtQYdKOCXhhbKzsyfClYixYRG27bzNZdl84s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PwLJfIfv; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PwLJfIfv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR+NQPw8A68F3+F9bgJ+deemXFE5M6PlvaqCK9NRFw4dwELAEy+xF/8pRvj32dag4cFWqous4n5jBDYT17lCBIRl9r688Gvw2sYKSUA7m8ysPLkFZDNYecouFih0DjGn09nIXgCkY7y+Drv2G+aA0zjuhn8eKnX90Xq+nyXlA5yJlM5RFeGK71cBU2jdPIx05yF3xug7RwcqWuxSv0PH49UARDtBNXk+EnO+6LDmmSFslMRmHWJUXir8zJ9LGPlD7G1n5/sImOfIlGL5dLTZZo+aWDogHonThrkjy+ihHUEjJ2MCCfBCbq+R1o4KRLg11OiH+c3l8P7BPlrBimXhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUaTxBe8M/XbjMi0Q91xnxt2msdfMiQZ2a0gT7WY05U=;
 b=HaY6QeaYTl+IYF0Qr0zFADJGJBiRmM6PGSRC87xnXInCbjZpp5zhWndQR6i3pdk3v5F7LxGkRD82GJlBXwVGqCNhaYV3Z2a0TxXjX5bo4SrDf+Q7mNtkLU0dzf2HxD+kJM7ApHRWo7yMPOrCjb6o2wgeoSHblg88QRHwNnBpcJFLMQap1UVLEBKaXXG/Kl4G0wxtFClBf7c8I1zfU1T4dBwDfTfHqCPyVPSCQPR6YDC791YtoMRm2NeuvyCUR6eXKKNDkERdO/r68qYhNELF0uEVjHtkhEOEiYOUPv0Oc6jRV+1CNeNMv0vO6K7NKWwg9A7uW5kpm3BWO1ZJDsbzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUaTxBe8M/XbjMi0Q91xnxt2msdfMiQZ2a0gT7WY05U=;
 b=PwLJfIfvjTq5XFraQeRkbDn1j2QmJ9T5utjg5XsdLoXIO0wWN6YIfowb8vU5DKwfnjseJZY0OE0gQ7UnSKcOXgYxD1jRS5/TtToKy7ipo4kzcQ7cjisA2/wAx/l4wOeJ6vNUQBKelhuO4q9cX+V7g/mYx1lTjEQ+U+lO0bOC7+8=
Received: from DU6P191CA0042.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::18)
 by VI0PR02MB10510.eurprd02.prod.outlook.com (2603:10a6:800:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:45:02 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::6b) by DU6P191CA0042.outlook.office365.com
 (2603:10a6:10:53f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:45:02 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:58 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] power: supply: rt9467: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <7e9a6d817a6d6b364968c76d7956310171d39056.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|VI0PR02MB10510:EE_
X-MS-Office365-Filtering-Correlation-Id: 285fdfe8-efd2-4dbd-f60b-08ded5f56204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	5pHplvimhMFhPa+DCKIPu8r9qtQjim0MVTTjQoRXl997FnkXUZgFa7wZtRUyETh+g5MUK7qq/1PNljh02CTIuGGpLumNB/euAD6huCex21e81BptoV0tBExmi8/vgj2t4OBmSpGX6qaL3FnpJWa5NfqoPpjPoYomNl/AM/M2gZt2+bGSQa2S7O4cNwWe9gg8Tzx4/fqTOqfXg7wWoswQylEGVqD7yVmrNDcRO3Rxu9jNTquayVOhEGHq6acqSLRGjrkjGH7xbX/obW7Hxx0bropgjuq/APLOYUlZuLEXsLhldCthjPPAeUq3nvvcIWKV581/y8rdmhIR7NIlNA5XWwGKlvFiAZg+ObBN7AM5TRi6O9UustrhxQcskws6JyMwBWbawl0bI1TYyGXegmoh230dnP2Q+JCCJxT25jz29/sdCiN+iqA66MetngUdyzCBldYGg09kqMZ0SDvGoLDxbEfwnr3SvhDjcYWJGlVNMJqyTrNgW0dudpbTs5c4+Qw3+TkRbJe+2A8kcJX5Sb2HV9lsF03rJasAupgy6vR9xEE4u/iZXL9ujq0NMMUqnS+U3dRRvkpTkCIE3WH1Xv4vNE2abuC1bET2XEAtwFRwe0xrRd9Dpz5I92PRUHwv0GVgDOOfAl+w+eaS/vHCI4ejShKU+XCagN20baM2CNrQoXQd7Utrq1KNUSqhApdqUmPyPwT5JLxXEdyNp0tPJEnHww==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qJNSwm8s8cBDuYx6UdOZ5dWQ2bQt76Fg1rsMm0x2RdIyz6DYJKfh0+9xsiVFKk+V9itAUIPBy7w3Q3EkZeA4e7jJojva/MUug/aZy+L4Ujtwc8gsgbk1Wkir5DAYLZ8GxqvtlxnidhXod0yYcLSwDr8rN72zy9pj+rOK+/vq9/rdUsIxxP+24ty+pLOfOp0eBWWM5eVziOM4jbKIk2TeDfTsacMZvT37IL0AgN2LGX6QG6+njH1BmxwhAUr2vr4ZxHewdd8rPjT426MSN+oQr1vTzBcu5uP6Eh8ugbNWEALPhf0ja9wOGQKLEQfBiW6w2kdk3mrz52mcQ2LFp5R1Y2gP8Arki26VlJWroLaE2idNvYOhHBVFBzyh8aQrR6e6WPnokGV8eI6xEkoufDHkBIhK740fHzrMrm5IdZTkjGXaKj+DNiL+5HdD04QmuNJj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:02.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 285fdfe8-efd2-4dbd-f60b-08ded5f56204
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10510

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control the BATFET, but
keep old custom `sysfs` ABI for backward compatibility. However, add a
note in ABI documentation that one should prefer the property
`load_switch` instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-rt9467      |  2 +
 drivers/power/supply/rt9467-charger.c         | 52 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index 619b7c45d145d..bfbfd78ec1c19 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -13,6 +13,8 @@ Description:
 		'Disable' also can help to leave it, but it's more like to
 		abort the action before the device really enter shipping mode.
 
+		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
+
 		Access: Read, Write
 		Valid values:
 		- 1: enabled
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 44c26fb37a775..1ec84ec0b9153 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -634,6 +634,39 @@ static int rt9467_psy_set_ieoc(struct rt9467_chg_data *data, int microamp)
 	return ret;
 }
 
+static int rt9467_set_batfet(struct rt9467_chg_data *data, int val)
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
+	return regmap_field_write(data->rm_field[F_SHIP_MODE], regval);
+}
+
+static int rt9467_get_batfet(struct rt9467_chg_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->rm_field[F_SHIP_MODE], &regval);
+	if (ret < 0)
+		return ret;
+
+	*val = regval ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+			POWER_SUPPLY_LOAD_SWITCH_ON;
+
+	return 0;
+}
+
 static const enum power_supply_property rt9467_chg_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -649,6 +682,7 @@ static const enum power_supply_property rt9467_chg_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static int rt9467_psy_get_property(struct power_supply *psy,
@@ -712,6 +746,8 @@ static int rt9467_psy_get_property(struct power_supply *psy,
 		val->intval = data->ieoc_ua;
 		mutex_unlock(&data->ichg_ieoc_lock);
 		return 0;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9467_get_batfet(data, &val->intval);
 	default:
 		return -ENODATA;
 	}
@@ -748,6 +784,8 @@ static int rt9467_psy_set_property(struct power_supply *psy,
 						    RT9467_RANGE_IPREC, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9467_psy_set_ieoc(data, val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9467_set_batfet(data, val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -765,6 +803,7 @@ static int rt9467_chg_prop_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -794,14 +833,14 @@ static ssize_t sysoff_enable_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct rt9467_chg_data *data = psy_device_to_chip(dev);
-	unsigned int sysoff_enable;
+	int val;
 	int ret;
 
-	ret = regmap_field_read(data->rm_field[F_SHIP_MODE], &sysoff_enable);
-	if (ret)
+	ret = rt9467_get_batfet(data, &val);
+	if (ret < 0)
 		return ret;
 
-	return sysfs_emit(buf, "%d\n", sysoff_enable);
+	return sysfs_emit(buf, "%d\n", val == POWER_SUPPLY_LOAD_SWITCH_OFF);
 }
 
 static ssize_t sysoff_enable_store(struct device *dev,
@@ -816,8 +855,9 @@ static ssize_t sysoff_enable_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = regmap_field_write(data->rm_field[F_SHIP_MODE], !!tmp);
-	if (ret)
+	ret = rt9467_set_batfet(data, tmp ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+					    POWER_SUPPLY_LOAD_SWITCH_ON);
+	if (ret < 0)
 		return ret;
 
 	return count;
-- 
2.43.0

