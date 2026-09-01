Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7E3B14C3;
	Tue,  1 Sep 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291321; cv=fail; b=tpqBODoz05PmXD10ApXzbp1ZDiHLtYZeO5Xm7a7pXwPRHsGilgNmKoWgffvyykhtZ7OZNJxW19sFYbUKxWE88qbCddovq6mTYnZ7zF402try1NrFckxLih3lipL+IgwVKdwVkZQ0Dc9NqKX4naJDfiTQ9XUmNQuZWKt7pc6g6bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291321; c=relaxed/simple;
	bh=d8UtFGhCKlrndjnEqLVIopAvyFoYXujS3Zju61xMwbY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=N/2aYoO5vXfM4VJnV65Wu7y56lK/W3CSlwuy5wzx0F8nedz8Fx75kLE1YKZ4/QgknHE8LPl1zNDSVNaGhh65S/IggorIVSzMGXFJzI1WhKZEPbrRcSFOUrNBnKA/8/nOtQLVOVYAJEV3E/RitXJ//rwJb/9IrpYSAO3AVsznu9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lndLRqb6; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lndLRqb6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z26xtEUpyzWT1Rhrpl8UsJBQ5BXawOqU0rHchpwAeAfE9+mKEpIX7XfrE/5RD3PCNaL1budEz5B5RZbpORys0jbPw7XYrGMtYXys+DXx3nqHoNlm8kfAFO57ZcECFJdjw66ksAmLwvjzTBw23zly2/Qtih5Mi/JoBEp5vbekoAdKubPxATZ3cPtRR9hLz2UJG6eMpB7gGhxAAIkEiHuhnpPs0kgWEaaZB1UYny117olLe2PQrQbhJEgR0Fd0OMTUjJcE9DkV5J72lgbqtVGxCRow7QDdd0dyxWx4dBe9e7KtQlX+VG90G5eR+E8GC8WvB4Dpl2Z8S7UnK4mTKA+TAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzTUb9p1hZCrUESSAaiQiN8kC9H0miHDys9hPRIFl18=;
 b=dWsW4jxOSrjuHn94iLkWftJLn3KTc5NIk9zHoIMem7c57WDcCu2gIYKQwCVoWhpH45mtfADN97PmLN4kCGe+lBN5HHySD9c5tQid3CefFbt1FAB6562/wJuI3E8CcxQZKAwajqZ0IKncTYGn3MEQ+Scc0RsZXmJZTrZ3LpoTTfq36Awb59SF7tsrIbmIo9GxIo8AWxEqko2QkkvR6jCMCJE9w/SwPsSW9VR8AM6vCVxgjbsWywErZbtZXGUWbJai4n9H76m7NL63Bc1GQYZtPtwbvf1NKkLqqVqllcJBJujmpKO5LHTzvwIapV9uvb2Xw6fEcq+GQ2k9uTk1En3RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzTUb9p1hZCrUESSAaiQiN8kC9H0miHDys9hPRIFl18=;
 b=lndLRqb6bj83LaLjVN1wPejxygfg9ONVbtbUhD+USWG8X2mMFgWOCj6Hlwbc4UuSNfMJGFgzEFmDJBYEVZXRQ3jahdqQ0biaQjtCSRM6pX3+Uj3mfEy0+b5wL37UI5KhV8M+xlcoeUsZ5k4Zma2MU+WbdM55Yckq/BymXN1Pyx0=
Received: from AM0P309CA0010.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::17)
 by VI2PR02MB10950.eurprd02.prod.outlook.com (2603:10a6:800:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:13 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::81) by AM0P309CA0010.outlook.office365.com
 (2603:10a6:20b:28f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:13 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:09 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/8] power: supply: rt9467: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <11d5d3f03f34cdc47a9ec9f1ebec9e1d9457414f.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:09 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|VI2PR02MB10950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8fd11d-fa45-4077-9684-08df086024df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	P6N8HnjZWRoej5PcpUHmpo5uD5ymDlYyVbEL6IuVkXlBhUjBvmhXdoGHrhDooHAmHmYhwqGLkEqlfFjS0eS/wt36cGy3fvhQ6a1MKuNzhRWc3dggxjfPzQKft0/xHbgkB5w37GKQfhHFENktF6f81uZoxX55MN3GSJCf18DvWEGmOkcd3ZAIGNnX1GO5Of40+kcRNAu5wejeVp1yMjyqR8sWYPmN3LFvb/hrG9vLWxJAE55oUa1l4bE8Op0U6QUnIstbv47eAerlB1Md2sbDv6TjpgyV2IPMywYoWH9r58RJ1sRfo8oDqmKAmNrquON+FfSCaNdF8wdj7Mwn/B6sA3qhlvLJGgWZFhqfK9g81ZomYl070RLQJpThGM0g1irQBocN3Vv2xlPkmfR03Xic+50cVvwdcBm+kSGi56LFlWt7a96oqfgQ4hrkayAHDhYt19WOeX0AAiS3XO+lBrHZvq6EvalZ4yx40njAV8QXARFaXRUP3T0EgYDQ5r0mPESOlp0R0jHgOch2QZG/V4B8T1BSdX/YfGl0h3edRND4Q3AUjKnZCniUiInNrETsbqTR6kYbnlUptdfBdZb8pOSCxPJS/gBjGlXZP5HiJVBG7YVfC960lnMpYqyg7mM5RXfGcx2EtOi302vXkkANTb79M/AUL7oqLAXM5yU+HFJjH0qSmR+iTys4nBzXnQEMeAau
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gqCHwcGYpkKhqxbOTyO2G6xWCB2YGL+E56IloqrMz1iW15hxfGvgSydUplm4zYeezC+Kg5LPGFnUc8t+kjaf150/zroK6q2qV6q5ylL3MQzyx0USLQ3L64oriv3CCEwa1O7bQfqC4te21mnxjSRClg2MNmHp9PsA3bdgf8dCj5WE1v6NRis2wfWBZ6E4r7oNbCRKVQcJtnvU+PU/zIrEJBtFzMS2vJqyHolAip+UBai6tUHeeII/+J1haWoaMKQUqZf8wDkxY2byjX7kpQ9oBJM9XBjzBOgehSOHvS/IKb+V2USELoMVaqD0nu1XrJiuk3klGNhNisEMxKQ6ziQ0Zlqep7NhyeNTrFn2EoCRWz2uNWELTdcXtag01cAorDGV74LU0b/VyOxwOhr2Mp6w/wiJ0hzAHdfDW8uyFpfoIcPVL0IYTM9bY1s0ttK/oYfZ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:13.8034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8fd11d-fa45-4077-9684-08df086024df
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB10950

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control the BATFET, but
keep old custom `sysfs` ABI for backward compatibility. However, add a
note in ABI documentation that one should prefer the property
`load_switch` instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-rt9467      |  2 +
 drivers/power/supply/rt9467-charger.c         | 54 ++++++++++++++++---
 2 files changed, 50 insertions(+), 6 deletions(-)

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
index a9a83b263e187..f0d10f44b1090 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -633,6 +633,39 @@ static int rt9467_psy_set_ieoc(struct rt9467_chg_data *data, int microamp)
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
@@ -648,6 +681,7 @@ static const enum power_supply_property rt9467_chg_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static int rt9467_psy_get_property(struct power_supply *psy,
@@ -711,6 +745,8 @@ static int rt9467_psy_get_property(struct power_supply *psy,
 		val->intval = data->ieoc_ua;
 		mutex_unlock(&data->ichg_ieoc_lock);
 		return 0;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9467_get_batfet(data, &val->intval);
 	default:
 		return -ENODATA;
 	}
@@ -747,6 +783,8 @@ static int rt9467_psy_set_property(struct power_supply *psy,
 						    RT9467_RANGE_IPREC, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9467_psy_set_ieoc(data, val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9467_set_batfet(data, val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -764,6 +802,7 @@ static int rt9467_chg_prop_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -777,6 +816,8 @@ static const struct power_supply_desc rt9467_chg_psy_desc = {
 		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
+	.load_switches = BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_OFF),
 	.properties = rt9467_chg_properties,
 	.num_properties = ARRAY_SIZE(rt9467_chg_properties),
 	.property_is_writeable = rt9467_chg_prop_is_writeable,
@@ -793,14 +834,14 @@ static ssize_t sysoff_enable_show(struct device *dev,
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
@@ -815,8 +856,9 @@ static ssize_t sysoff_enable_store(struct device *dev,
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

