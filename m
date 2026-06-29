Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64444BCB1;
	Mon, 29 Jun 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747922; cv=fail; b=t0FumwYvKBKI4goBO+++ggTZUSipgoHSdPYU5b/8UuDgDjZhATonDCBbJt2MmouPi9vycMdVsyK+QUdhiTIgGRiMX2fF2oc4u+0uIjYFTUGvgo5uU9c34fjkAMHm5ZurOD/ghC3uBWR8vyh346LKDnOWrCXqMd25UiPkBZEFreo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747922; c=relaxed/simple;
	bh=o3Hc+TNFqS8YiUZ49GFpzDVumFVCdKrKAZPMR+63l+M=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=k64ZfzqYYN41IXtOpjw5F7OceZAku6jqNNn7Hv3u94Hpio2K0vGyrbInBL5IZkSWDY+cC+TiLUDcUU17VQcstHVRDykiaSXTjmagOvGS5MpksUv18EUDImXLkvBmJNm5nR4OZknsqN7ilpEsWeeuz4YQkUrskt/30whv9HmmzRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=r/4vCRW9; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="r/4vCRW9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/pVgIpyqstzyH5jZ2LttzhSKXirGdOeLcVSuT7BYCCYE0o01bl8snHr5zfnsVUh01A77gLqiluUkyM30X4bwWbNsQOohX9N+j9Fy426rJzBg05dzu2DecGiZGBEM3w1txCp445ob0qKg2mHlhb3Nqg8OJHPNUkHWTqDX3Fhi0iqWQ+ZOJCmRdGOUqM+dTQ4RgR35qFpaim/7vADijNg0uHU5jq+WcAlH+1pkaJADG4lGpMHqv32D7gdI41jNz8Qx4IYrDu+H+8h/aAUkWqb57cS8ze4wG7eAX/5AoXCpKUG7/SfRRaDCuWBdQ7uSykyyuA3fMooZSZ9pQkFFdYiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMOaDAV2ccuqZR1LVDs8m/Rs2WAoNrB8U7c6rbUlb0g=;
 b=W6fDENmIictyaJZKaHa7shwrqOLTlGoLLgbmQRC2BuXeK/mO0xy9J32olozAoLpn2XGoC5Cva4xPfxJsL+p6RLdwy1n6OP+g94AkSh05je/zxyMvB9ru4qKinMr1sGveSs7cUvSL7fkWeEYPJam2kWw9CDnpG1bL8Tzp/OvxlU7XNg9XrjyXoWhBEJaLAl5vP7Qj3a1wROhg3Dd8tvY0Uu6JZ+bQu1MnXbpuY0VryHANUvaUTrOGGIaKRx8XHB9zOIph67WX1LQ3GkPptYi7+RMloTMuRQMW46iCt6g6wyLxfSiB2SM1BeNFnrZs7kMjt3YoOAR8UoUPMXuI4gGP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMOaDAV2ccuqZR1LVDs8m/Rs2WAoNrB8U7c6rbUlb0g=;
 b=r/4vCRW9yAcXclHf6y6GlkntDbVF3vOWl5YHK+2z6U4K8wol8rHdahtUKSgDt97SC43jkgFEhOyPb+VFLP08o7DavoZJd+8RDwS9cULq53uY+yqL1prXpy5Vi1CNlkGJM23VbmP4VM1CVuyzHtp/tjrv3SxinryEgR+Ve4h4s7M=
Received: from DU7P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::13)
 by GV1PR02MB8332.eurprd02.prod.outlook.com (2603:10a6:150:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:45:09 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::4d) by DU7P191CA0009.outlook.office365.com
 (2603:10a6:10:54e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:45:09 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] power: supply: bq24190: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <e04adf1bd52dd5fea9da593c8d6a017317d12bdb.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:59 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|GV1PR02MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dd1223-e27e-4c60-b67f-08ded5f56662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rdxawNOI6FJIOM1OpFQ+Er+PBCbyfQJl1uE17VT31NJI3PN8WQOXQrvLyaZPYCfr/WNC61f+tAVmGtyYWLdzajHkGK7A0u5r+zXB6lP4FyZ4qYP47jddjdCQRlHFUk+foxcIeNGaRUwJB4j2RzCG4Z1abyoxnjneNu19tXumAI/FPHe7EYp++47CSaJtZCgKGlP/Ies2zPOWG9lVcTGPE32O9lYUdYdHf3VYDzDWpIwtuf8qT9Jq0GpDBBIxhh1Mk1pHNB3qdyV2eEXQgV0kUERb+Kq8J1C3wupZ+TJQ7PzsvXPg0rzeKLRRzCumfxpB4rdf6S9fw14I6YDwISVyopyNTPZQkKez6CrWh6VLUQ1qUO8cR39WXObMCk1y4EiYuSuQLJTxq89zig8RLAyKvPJK+60IDO4I6ut4tMLC+7JwM2VOsf1YEbFwGz6yqLQOS5ECDtgJGb4PQo0hPkpqDKfRfLzgMQOQa+MCGf+l5YJUJ2gCPiS1pEI9a7/pSLBBEJGoLVN61VZsH3WxQ0cD1bfkT2tG5IDv6qeIMhe6GOvBKmRrY/TInLBt4KjvyEBzdcjqJb89XNTLaF1gO0QenSZSmgxWXG0sYQzM4/CrOcXs/lb6te5+F8vACGe9lqJFfiWB9xZfKfEk8MXSplG0CdPNaR4alTPd9bXf0h99rMNDMC1pn2JYujuNiofvwNyIHtY6pdLDyTJ0EqVAbgpEZw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJD3DAUjFY89ZYRhIyn42xhnRwkb0cN031n9Rdx2N+EKMy0fgmiq4aruiq1249uOoFCKxBX+bw3AeOVKeKCxehDjFqUD6X/JmB+CQiw1EdeNtB0sBi4oUCPQHEcvGdML9/F7w0pIacr/IgX1Zw3M/+8KwQWxWbXIuUOcYtlQL4nLc35XDcYu7Au5GJ4fhYQunnkbOeGWKyFFthqeSBWWYvgjL9Ou+QnafAHTOzEzErP07xZqR7GLB12yQbC4kcqYO9Iqf5yn6+l+4kZ1+6yBRY9VnrFRO8BtPFGbv0XjAiAHyIHdWOaI0MrH8B+4/f0OPziXlCwvEqpxsxBLRw6ar+UxlsZH9djwgKw0eqIw+GOYTbr/k6H3RR9ce0gZTWkA8aOlxRsii7BAdkWMjYbUMzO7Lmt8l0gqp+qQqZKoT/0utiSG5nw5Uu77gzus9OOt
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:09.4137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd1223-e27e-4c60-b67f-08ded5f56662
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8332

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
 drivers/power/supply/bq24190_charger.c | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 987ef0e29eb15..1e77816c49a3b 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1295,6 +1295,58 @@ static int bq24190_charger_set_iinlimit(struct bq24190_dev_info *bdi,
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
@@ -1351,6 +1403,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
 		ret = 0;
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq24190_charger_get_batfet_ctrl(bdi, val);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = bdi->model_name;
 		ret = 0;
@@ -1401,6 +1456,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = bq24190_charger_set_iinlimit(bdi, val);
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq24190_charger_set_batfet_ctrl(bdi, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1421,6 +1479,7 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -1481,6 +1540,7 @@ static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static char *bq24190_charger_supplied_to[] = {
-- 
2.43.0

