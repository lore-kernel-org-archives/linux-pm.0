Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2B3BAD93;
	Tue,  1 Sep 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291322; cv=fail; b=UHDpVeE9HBO0DB28F0PxIgYpI3q/8BdwYOEnuUNH2Pp6fGHsM0CwUhHjR97BEq597ccXGDC+rrUQTMUm9SQeq+7Ob5eF+t92hhUAiCKeOsTqYlCA8JXRnQhV1vml9RpQXJeuTENZ6lU4nMSqlXbiUma3VoX/ATC0PkPBPLrioWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291322; c=relaxed/simple;
	bh=6MVF0f+1FHPa5F7U4kW5QTIA8tYSuj/mGN6Mt8ccexw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fXmf+AwSlg60y/+7TeH4Vfd0WLTwBPhJJAWIk2eUUgipp8fXfvMrFONzrcd3AJ0WPRSDO2RIx3K1zp22sUKxhjwZ7p2dxJ5XY4/B+i3IGHrlPMMCZNILf56VbGHMjcLCBPiR3raNcABpNZQJ60XZZlAEJRdytFnEQNGfDxcHavA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=DaO/ZQdO; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="DaO/ZQdO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cynkDZwUau1cOMANlVzu9x/nmK69Fu87drJGCSCzYyLzcLX6ipl8QqG6iZN6l7/jd3Iki0e53yrBXowK+oHE/WjNOxHXgeoGvstKO0in5/RWwQ20j1XT/yONrK9zt3Lp6WKMOQJDV8JRYBlgEPlT2HaxI4YmMTTeS5KipYQOsIHYyU7NIpxdRcuXSTK5K1rEsdkHjPYsZUcn8LRIG+/R0KmK9qtvfQ0gp3+2hPPaa5ZK7RzYE2gn3Ki2of21b3j4egv3NywZtoB7LQMzRZ3R564M94FCwtqTp/z398fe0ymEPoMo/oWmBuTAtXBiw3UP8EntRjBtQEYiv+Qywh9EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C+XE3+qadrmpj2B/fnprpwPK1fOBtC/NyBYVWoJDvc=;
 b=YNqG6nifkFilFQ22t1XimKXm85wVzbB+ESQFaXCIoq5gDhT1evQWzJoFbdi89MuPg1ulDxiylJ9pUzKXtXhjYb7woYXiE/qh+dt7rpYxUs+Cs37qRTbfBhoI47gMUqEaQ8EuJVX964g9NMa8hWuHsAfGvWK34oeVNFE6vXqW9AhytrYdXm3omoGSQb1xdVa53e/DycO8S9aGF5JYzf6lrqGyUZZfpC0ltJEjjrEvmwzpzIheNx1sHOW4R4DMAvgixZcMU6u7k/lpFdBnul4QQMp/orzHlY0FEhqjupSG5t0K4ZfjO80hkV+Stq+JTMyyZFoBECammt50PLNA2MubAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C+XE3+qadrmpj2B/fnprpwPK1fOBtC/NyBYVWoJDvc=;
 b=DaO/ZQdOvcW17Y+fHIdppfxSMgZlUHgHDzPrhwSG7pfmZ/8zQYzcg9+mMyxCxK61R5aQIaSGoRZ2btEMpJp07rtaX2E8mt5oZxKlc5eBkIxDWyVHD/WC3yawY1ySQwc4zus8is/JwHqR9vwHLV1sFi05mD4U4sI74l8H+Rfd+B0=
Received: from AM0P309CA0012.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::19)
 by DU0PR02MB8387.eurprd02.prod.outlook.com (2603:10a6:10:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:15 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::26) by AM0P309CA0012.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.1 via Frontend Transport; Tue, 1
 Sep 2026 19:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:15 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:10 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/8] power: supply: bq24190: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <44792a20fb581cfd3587fd71147f29e22c7f3749.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:10 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU0PR02MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: fced1f80-931d-406f-cc55-08df086025a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AvLOwjVZWdw2qSBiy9SFvz8baqATBZvedGQ4nkyppV4XTpZ4a1WBN159SWhEHE1UE1SQn9TR8MQg811hVBUEbRq1k9/D0Iojzva4M6/H0LPL3n1zrN61xBevMS9P5rQqqWUoaZDLAfdLGWJ1C/Zmo0LZI1/FxpYP0lTqJWQsD1MONDNd5Ne+QXnLwpT8B8FCsfIBhsNJ/uav3anHq2MJ96K/iyzZ7PSVfVaQ1Rmbu8snMpjhyhPyO47Q2voPEZbgKmNSkDl0vQNb1OwIolhDOKdvwf5LRzVfsYHO0GCRAf/aid3qhSR5eP3gP/HQAX7zKTf/23JnGAUWuo/RUjDtLHj5eUXsYt49maqsv+r4S/IKNtuz5DKeevbOT0OVswjY4zIAvW61Mv+GrpM5xSNgg9EJEEkS33FyjhkPCJg3UPfHHgvlRnuBlyMnoWoKjSvXnaA/C9DmRylMuKV0IQLeaP+Pv+XpSIbdPFXr1J9GdyXclaQiOwgrkC6FExCXt5fygyL/azROyBpV/mIKzcGDDtTqt7mtrl40CXvIUQFhZpUGDGrwin2ybGSQu4G1+8yBVJ6ZGQak80NukO/Jm9U/C6wh6W10GFRWHjL3S+bgSSxEy7xL8o24MlZt4iR+E4/ksplNI2pbFoTd1kXtaxuVoJnQvfJ5351UTDM9m5Xkyn/kvksus1hlA6L+tmuXiJzBOqXqiinfelnsq9rafPqtBA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lufrKYicvkUYYdNKJ3h/1VGfq0CxNUjt5gEYBIHB04epGhf2NG+cV7IDiykh19DBXF1erWHxpTtgxanOtE+J0y1IsNYbtCXGUsw4YHRFQH46JJWL+xB1CD9zyk/bGIpr7nbeuA2w0sUO8PT5rCKB1rMavka2GfKZ+FUtbhZWIi/uwIy3az/iqyATkGwumN2NJOrMFrCbqbvopEnhOOi6hCzOUT3d3QWJM5kP96mJpFkBBmH7QX0G/0jgyQEdoQZxDNYQCCtzeWddIIJyV2L6dFkzfqe8BLykYt0nj1bRzLcogggUeQk+DYyGeR+FPNtW0xNdvHdcSMJ2AggSbWuMNO8uVeYZZKpq/+UUVPbzPvzUWXEsUbKPmcXjRcjfh9k8OTzNVyYtD+88QFnNuJNl0Fzwy/WzTvdRlCE01dcKMoCqUwubdRF6KjLI33u39hok
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:15.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fced1f80-931d-406f-cc55-08df086025a2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8387

The `online`-property has historically been (ab)used for controlling the
BATFET in this driver. The framework supports controlling system load
with `POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control the BATFET,
but keep the support for `online` in order to have ABI backward
compatibility.

Moreover, don't bother with converting the `online`-functions to use the
new `charger_get/set_batfet_ctrl()` to keep the code more readable. It's
already quite messy, e.g. `charge_set_online()` calls
`battery_set_online()`.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq24190_charger.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4bea6fd83c36f..d67bf25ec6ec1 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1294,6 +1294,58 @@ static int bq24190_charger_set_iinlimit(struct bq24190_dev_info *bdi,
 			ARRAY_SIZE(bq24190_isc_iinlim_values), val->intval);
 }
 
+static int bq24190_charger_get_batfet_ctrl(struct bq24190_dev_info *bdi,
+					   union power_supply_propval *val)
+{
+	u8 regval;
+	int ret;
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_MOC,
+				BQ24190_REG_MOC_BATFET_DISABLE_MASK,
+				BQ24190_REG_MOC_BATFET_DISABLE_SHIFT,
+				&regval);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Datasheet defines shipping mode as BATFET off _and_ the watchdog
+	 * disabled. Since the watchdog is disabled during the whole lifetime
+	 * (from probe), shipping mode is the only "off" state that can be
+	 * achievable.
+	 */
+	val->intval = regval ? POWER_SUPPLY_LOAD_SWITCH_SHIP :
+			       POWER_SUPPLY_LOAD_SWITCH_ON;
+	return 0;
+}
+
+static int
+bq24190_charger_set_batfet_ctrl(struct bq24190_dev_info *bdi,
+				const union power_supply_propval *val)
+{
+	u8 regval;
+
+	/*
+	 * Datasheet defines shipping mode as BATFET off _and_ the watchdog
+	 * disabled. Since the watchdog is disabled during the whole lifetime
+	 * (from probe), shipping mode is the only "off" state that can be
+	 * achievable.
+	 */
+	switch (val->intval) {
+	case POWER_SUPPLY_LOAD_SWITCH_ON:
+		regval = 0;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_SHIP:
+		regval = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return bq24190_write_mask(bdi, BQ24190_REG_MOC,
+				  BQ24190_REG_MOC_BATFET_DISABLE_MASK,
+				  BQ24190_REG_MOC_BATFET_DISABLE_SHIFT, regval);
+}
+
 static int bq24190_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -1350,6 +1402,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
 		ret = 0;
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq24190_charger_get_batfet_ctrl(bdi, val);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = bdi->model_name;
 		ret = 0;
@@ -1400,6 +1455,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = bq24190_charger_set_iinlimit(bdi, val);
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq24190_charger_set_batfet_ctrl(bdi, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1420,6 +1478,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -1480,6 +1539,7 @@ static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static char *bq24190_charger_supplied_to[] = {
@@ -1498,6 +1558,8 @@ static const struct power_supply_desc bq24190_charger_desc = {
 	.charge_types		= BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)    |
 				  BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
 				  BIT(POWER_SUPPLY_CHARGE_TYPE_FAST),
+	.load_switches		= BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+				  BIT(POWER_SUPPLY_LOAD_SWITCH_SHIP),
 };
 
 /* Battery power supply property routines */
-- 
2.43.0

