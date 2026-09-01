Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B13AFD16;
	Tue,  1 Sep 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291321; cv=fail; b=A+aXXxxERO9AcnfCRDAOH8lwwog1dDfSXZphyqrR4F30km1z88Dmko1Zqrmk6BXq9bmgB/I7ahaK9dwTx9F/5tv7Fv4Mltr173O24h4dEwCEDvfegWy+tzR884CCbI/9nU9oNgAhgi9vmnwMtix7D8g5IH/s/6ard3fu54b949w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291321; c=relaxed/simple;
	bh=LFEcsVevcumHWk22N8Qyb0dvidpuh4hJZ5ITKK0ahPM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ikbp1fte5mBSuZRzvclxsdVQVjgbbQ0QeKCacsm/v8wjPxSFjZb+2aiDhX0mzzLkvNKGrLIjC2pqle5CWGguq8ldjmE8jTYuxzGeecaUrtpVxXfy5FRA6ZtUdAL5AA0hx7yVzd3uUfri5NxH023HMA0zx4xDshXbLCEMLRah7O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XMvQpM7K; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XMvQpM7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRZ2D+fk04LprlcuqtQTEod81ANGbXbroBKZfLaEPi3ZplomD6sPtQnumWkApjziP90urq+ENEVxWa+1FLZBhCuuMLekbZ/E77Hus0M6QJg6Q/P0yPZs+uggJWjHNPPDn76+cPTzdlKo8Un6AC77KmzhNovyd0Onrmq/GTWE4FtZMCVOOX3/BiVzR9x5iwWTaOSHTfFE4O7M2Ud8ZS/GxjeYcJ3UaJC4DYRCfxZsMh9B/ypTenC2KSsgVmYWxR1Y+g9SFhexOI93inBvZSh/Q6UR+vovFiL/nqkQatnK93mckEE6WF9kXOe0wogopGU2DufMrMjM6C46uccELklXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/JfYOisfFptAVgcujF7dTg3r84jl/fiddgslNwhY0Q=;
 b=vHSoCC1jeYLNOuEfbhF+bzIpgyA/66e6n1eyB02D5ISPU4ikNIC6xEgjSeB1WGuQeWzACsgqofzB8yRQ6wn2qoNZWV+DCbBBysBD0fS2AuHK8mBlLKOgfp+irEVYIvcm5TWqbyXMPWPBXR13uuytuWHXEPeOd1FnthMGj2ue36q2DamT5HTYMXiRIW8kB07HHssCHrXhTO34y4mjUn0OQSxG0/cDm7UE3GwwCDnwTlrxetpiAmbKeXTrZcoXdrldFE+dvPObkBZE3BhJa3kwYsxm7O0qJtlRFtu+nNv+IVwVLnYXteqiK6Ct8dE1pBtku1Sqkv+f2eFtm1IH36A1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/JfYOisfFptAVgcujF7dTg3r84jl/fiddgslNwhY0Q=;
 b=XMvQpM7K++1Hdc654BWXvZjDm8c/b+1bXJorG5bg/sgW1P0ADTZjYfXnGV2Irb7CA1iM8166V3wAQJkf7zk8cYDM6zkQ/BneH/cexEZn3qO36OaELhHIixDaT+R/naAuhzO4GYfEMVRtVTpJArT0TR43ytj0GeRO30EOl8zaSjM=
Received: from AM0P309CA0027.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::16)
 by AMBPR02MB11561.eurprd02.prod.outlook.com (2603:10a6:20b:736::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 19:35:14 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::78) by AM0P309CA0027.outlook.office365.com
 (2603:10a6:20b:28f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:14 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:09 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/8] power: supply: bq24257: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <d5b2615e549725a9294f9dd51787692591743cce.1788290289.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AMBPR02MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c00fe8d-cadc-42d6-efa7-08df0860253f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6msvd986vxIRMVINVUilY01aEFl+42LIqmGR0SE3Gslpmft0loShwcU/D3NYOrRNLiaY2T/PlxtX4TiRz8+FdFSdv3fJk3v4xlGfjNJEyaZRHf92WSugG6G2yl46roNdJ9vbIClpcPdiYd+MYE1y3MrNaZe8+229VFv4VEfjehqsZqLiR8dxQ+zNZUO1AiLu2HBAwekzqOyeOePyR2DI3c/YPCf8AN6r9I1VUqsc1pKQoNGyzOAnGOazWGv6jzM7SqOyZvnfANUcn6dTr79NTh2RP/Mag30E8YnjBn3cbsVxQbkINJiz4g1ALWe0+KsCs1DmAxiK0NCZWSxsoEajpWpuo37X8aMN4PyiMmMIOQ0G2/yjLA1wyVUvq2r7NsoUqqSpa8ln6k0004igUsqctBRe75E1FQ77tulJzOiTvdic6qrUfnRWLy98SPYd+GpYYZIwbB5pmH3KbMob7hlf/t9O3e+zco0KNErui/zz0mmHwkyrfciBE+OpytUhLXb2fRlfQteVSrk6/Z2ckWNEHNiLXLzPHpYFt0G6BkZtz4FMNmL3KHvJtpaGKmRraxpINP/D3gUiL0219cXGru6XL7GtTZrBqM3hk+KOlOddvLfywIubxoIKz0WQSD+RnKtTY/eaBrTPktAtyl9oRc5udfrZnLz5BUZGvcV0JaW9eBUHjjBn100Ecr5+wDz8ob1BcPMXrtUIt0ZDhsGvqdvZGQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IHMpr06H1WXJAHy7DBLjyRaxxYTCdoDRpg/DtJ6FG/huIxT6sxS2mKqr9rW1iXiaVQwnalQgYGYCjCtG3I4qz8gnQfIa/qrs+cA8hqDv4wQJU/ca1UqnGXQpDGXZZcTfRvGZyRcAGWUMfemscW0KVO55G02j3cpE+ZcZ88EM74EtNlXreR1CuZZ/wWIRstlfCjBW9NfqUq5hgOMMwc0243++Ynfar8QtDmdWZeY1bgDH0TmS3lwQg+kOdshNhLFdzGSDF/O7bohL05fBpFTDmrnJQmECk6/lWdQdhp+kToG9o2lpOBUsgVSQhREONPsPVCYazpz/TBuCQzBeVz8OYoVT/aVLsKwDC9T/cIrChRVIYEl69pG7HvPH9Nua6f6WODgL+jiHwNMV4p14JLKhSmcKWeQiLSNmDp6p+M68+yN3fFfOwrT5PpD0BR+xVX4k
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:14.4352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c00fe8d-cadc-42d6-efa7-08df0860253f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11561

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control `SYSOFF`, but keep
old custom `sysfs` ABI for backward compatibility.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq24257_charger.c | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 944a7aa6f187d..8eea7d0395ce0 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -295,6 +295,40 @@ static int bq24257_set_input_current_limit(struct bq24257_device *bq,
 						    BQ24257_IILIMIT_MAP_SIZE));
 }
 
+static int bq24257_get_sys_switch(struct bq24257_device *bq,
+				  union power_supply_propval *val)
+{
+	int ret;
+
+	ret = bq24257_field_read(bq, F_SYSOFF);
+	if (ret < 0)
+		return ret;
+
+	val->intval = ret ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+			    POWER_SUPPLY_LOAD_SWITCH_ON;
+
+	return 0;
+}
+
+static int bq24257_set_sys_switch(struct bq24257_device *bq,
+				  const union power_supply_propval *val)
+{
+	u8 regval;
+
+	switch (val->intval) {
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
+	return bq24257_field_write(bq, F_SYSOFF, regval);
+}
+
 static int bq24257_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -381,7 +415,8 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return bq24257_get_input_current_limit(bq, val);
-
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return bq24257_get_sys_switch(bq, val);
 	default:
 		return -EINVAL;
 	}
@@ -398,6 +433,8 @@ static int bq24257_power_supply_set_property(struct power_supply *psy,
 	switch (prop) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return bq24257_set_input_current_limit(bq, val);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return bq24257_set_sys_switch(bq, val);
 	default:
 		return -EINVAL;
 	}
@@ -408,6 +445,7 @@ static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return true;
 	default:
 		return false;
@@ -740,6 +778,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static char *bq24257_charger_supplied_to[] = {
@@ -749,6 +788,8 @@ static char *bq24257_charger_supplied_to[] = {
 static const struct power_supply_desc bq24257_power_supply_desc = {
 	.name = "bq24257-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
+	.load_switches = BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_OFF),
 	.properties = bq24257_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq24257_power_supply_props),
 	.get_property = bq24257_power_supply_get_property,
-- 
2.43.0

