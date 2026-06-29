Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648A43DA39;
	Mon, 29 Jun 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747909; cv=fail; b=rkCG8pTiZ0YU6i7cp22nSiKho0L5Kv5EZ3dH4zKyLzIjpzDVCgrCfz6OqamwucgEV6gHRACIvuaNwUrxThrXhBT0krSZR8tIGqFg3swcRbgpFhyT6Z3nKumDtuy2AdRHZT5fO0fvRM29Z6yZG1qSTGr4nmrstdyUB3PQzhvu8Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747909; c=relaxed/simple;
	bh=1d5Djav36j9HuoZXt7a6xD48QR9KqbNzl8PNlK4ZyMU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=G8UWvH7eFJokodJv2LPkvYISnf8FT3+a22AsvvzIOAqBVAnh/IarTLTWO8ZqJyY9QJL7W46X6oHRYcoXL6aJt/xDPMEO0dTvjG35xtpCK9CdDUdoNQPy2il+tbTagg9LrvTdHMSlkylz8U5xUaxt1NkalooXEJ2KntnGzX/wJVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ME+ighXF; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ME+ighXF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk1oz7Ie/oRI1jKzreOIZPZZIZlxp6CyUYeF5e4fBL6j8leye0RlTnDoJ6PW2S5zwf7r20WiHwJkXnxtmtJnZLn6ZyVEuAP7VdVZoNczOqCyeyRyKuq54d7QvGooQE77PSK9Ak84tAYwUYTQLc+gTmH9lwhNNuUuOrLiYU2BQeHfEgaLd4o1ZCTD53GjJOGNXhSarfMgM1A2RW0byh/nn9jHv67A+Wbd+rNAdrFFeiLhVAkB0Pr/nP46UAqmqOf/cpRbyDpxr/Emni+nfqPRiAiVTcwXQPyKQfBWAVtiilScFjQHILk7ZGsxYqPHyJXyDMRJdF76X2anI/+M19gWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBmMxIs783SSzUEZFNyJXS+tpGat6o/SdjaG+1X7Ay4=;
 b=wYbTkjjuSqSrfhfhpV1xUcpejBC0Efpi8pXvY0WH3MuyXoB9GWVn6SZZFMpsfoC/JV7LtzvJqT5DMGOpWMpElFmCziQ/X/GpJPMTOoGWVt92iBisuVOT/ffKTUpPrwtW6DGaUisb+wUhljFiTNoQ47qDd9+glRgLaM9iVRW8yeAYnQ+Neihj+F4Cgshmaoj6weTnIHAnMOosM/qJoEijDLTJvQywkShTJtNM5+xy8ApjE9MzJmiP67CVAk5ompVELZcDIJhOInN4JJJ4JLZRhAh2QQT6dT553tEEC79DvukfCU0yFLCHSoTbsHAyvsg9L1Ysni7tccLNrZ+EPWpLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBmMxIs783SSzUEZFNyJXS+tpGat6o/SdjaG+1X7Ay4=;
 b=ME+ighXF/V1gePJT0bNbwAbwa0FgcsEEIr5VwHAzcYqbBMhf8bnCLrfgQbbjvS1+CbDFxr4HN4LQLtvbTRJeLQLxl6ax2ZXypX3Ru+B5dN5LUEwxc/tw53d314pC1Tgse/H+P9zohP0vM/C5fr1n665xupoht5BK2nfiwMlR1gk=
Received: from DU6P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::23)
 by VI6PPF85839F0E4.eurprd02.prod.outlook.com (2603:10a6:808:1::314) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:45:00 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::a1) by DU6P191CA0036.outlook.office365.com
 (2603:10a6:10:53f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:59 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:57 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] power: supply: rt9471: Remove superfluous unpacking of
 propval
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <6b4367512dfad62e865de8b6be52eefd5385fa26.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:57 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|VI6PPF85839F0E4:EE_
X-MS-Office365-Filtering-Correlation-Id: fb095f71-5ffd-4c5a-5a22-08ded5f560c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EZ0lSNcrCNkHA6BGBkPbJIWSLaHnT2F467LqZJvrj1gvEA52x+yW6F8elh36b9oJ6fj4kSvAbQWPPLs8Z4gbzr+9HiEhFn2CEJuQ1VVGVGMEQx+VlsNUa2YPfaUR8blWl3gr2bOM62IiL/Vo7UdYR79HuZgEjYqswYOHb9HrODAeH/yhOWQRjJLqR2N8qRhSr5SHrbDBck/ktjmPlFOwtFnKXRF9RQ6TXdNfKwhJYdz2CNjlvheQ4FoET3QK/7cpzLiHP/2str1EPYwiLDgUSnO0rTghYgQzdv6QQxMUNci6Ir1YVKYWdiNUwVKX1bGn+fndOtEvw9mfGMhIGz/W4zVZh2BsEkfYcFIKlZXi3V/WJKmZfiyfsYmlSHCBIeag7WmhugXq01i1QNLYOo43fD+xZ001kosv2ALsOPS6vcNTUEpYPm1flEyomOG6YfXJfmqXqMbqaDB11rwFY2uGfjVMFksqWzmSNeUsvqnhHnrEnlnC5po3hRJt2l4ZwYFQJ/RqwNQabhN5T8UzhmpBzdVVxdQH4Icqd78Oie3zWb/vIpDbwnPZkaqlGlGbhp5IZQyF7aCfJyKZqndT0/R14EExc/G4NZ0fm2+o/2lQwEAtBbPZsWxlDtned2/50Ns8dHWjIQwwa8CnL9OsLOX8K2Dn86FkoIYsFVNF2uQdH7q6dIVl+AYf8Z9+Zr+4FcEC
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K+JMu1cOEIs4N1vkp1aThKd3Av+BEaEpns3YT1TaK9rDmqIe7R1jNkuffpOvHmuhdzqtu/jO2oaA00OjKoIcKhj4qhakxGUD7aVb5uNK7m0PYAKdsS0aRwQ3S6oDWNNe74A6hfJ2RwL7CNQJL18GQoQKCFwixflNtj0GFTA+zbwEBCt7RYSeXkZ6YB57akkUc00RcGw0GQlTnRBLUzPLuKUNlPg07/UU+vKxoR33Y6HzNAxrE7f4VzJ7hZ/tvORVoJLVoMrZLD0wP9WG1kOqdvw+4Ya5HHpngqIFuulqzPHw2oH0bIlpZlS6Ejv71PgrLxa6aTYnSTtzUeOgfhiHZGa4FzaHlRBmtHi4LHoNf7EUHF9yZuw9fAcKMmkyXrx8auJGNjEWL6srF2bFqD3fsp+diKONqrIe4jGAlRpKNYQlFXoFWdtz0whexOgzNCJ7
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:59.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb095f71-5ffd-4c5a-5a22-08ded5f560c2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF85839F0E4

Remove extra variable in `set/get_property`-functions that is only
supplied directly to other functions. The value is not used for anything
else.

Moreover, wrap these lines. Otherwise `checkpatch` warns about too long
lines.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/rt9471.c | 49 +++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index e7f843f12c98e..ca3b0b57675d0 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -370,23 +370,28 @@ static int rt9471_charger_set_property(struct power_supply *psy,
 				       const union power_supply_propval *val)
 {
 	struct rt9471_chip *chip = power_supply_get_drvdata(psy);
-	int value = val->intval;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		return regmap_field_write(chip->rm_fields[F_CHG_EN], !!value);
+		return regmap_field_write(chip->rm_fields[F_CHG_EN],
+					  !!val->intval);
 	case POWER_SUPPLY_PROP_ONLINE:
-		return regmap_field_write(chip->rm_fields[F_HZ], !value);
+		return regmap_field_write(chip->rm_fields[F_HZ], !val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		return rt9471_set_value_by_field_range(chip, F_ICHG_REG, RT9471_RANGE_ICHG, value);
+		return rt9471_set_value_by_field_range(
+			chip, F_ICHG_REG, RT9471_RANGE_ICHG, val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		return rt9471_set_value_by_field_range(chip, F_VBAT_REG, RT9471_RANGE_VCHG, value);
+		return rt9471_set_value_by_field_range(
+			chip, F_VBAT_REG, RT9471_RANGE_VCHG, val->intval);
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return rt9471_set_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR, value);
+		return rt9471_set_value_by_field_range(
+			chip, F_AICR, RT9471_RANGE_AICR, val->intval);
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
-		return rt9471_set_value_by_field_range(chip, F_MIVR, RT9471_RANGE_MIVR, value);
+		return rt9471_set_value_by_field_range(
+			chip, F_MIVR, RT9471_RANGE_MIVR, val->intval);
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
-		return rt9471_set_value_by_field_range(chip, F_IPRE_CHG, RT9471_RANGE_IPRE, value);
+		return rt9471_set_value_by_field_range(
+			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9471_set_ieoc(chip, val->intval);
 	default:
@@ -402,35 +407,39 @@ static int rt9471_charger_get_property(struct power_supply *psy,
 				       union power_supply_propval *val)
 {
 	struct rt9471_chip *chip = power_supply_get_drvdata(psy);
-	int *pvalue = &val->intval;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		return rt9471_get_status(chip, pvalue);
+		return rt9471_get_status(chip, &val->intval);
 	case POWER_SUPPLY_PROP_ONLINE:
-		return rt9471_get_vbus_good(chip, pvalue);
+		return rt9471_get_vbus_good(chip, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		return rt9471_get_usb_type_current(chip, pvalue);
+		return rt9471_get_usb_type_current(chip, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		return rt9471_get_value_by_field_range(chip, F_ICHG_REG, RT9471_RANGE_ICHG, pvalue);
+		return rt9471_get_value_by_field_range(
+			chip, F_ICHG_REG, RT9471_RANGE_ICHG, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		*pvalue = RT9471_ICHG_MAXUA;
+		val->intval = RT9471_ICHG_MAXUA;
 		return 0;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		return rt9471_get_value_by_field_range(chip, F_VBAT_REG, RT9471_RANGE_VCHG, pvalue);
+		return rt9471_get_value_by_field_range(
+			chip, F_VBAT_REG, RT9471_RANGE_VCHG, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 		val->intval = RT9471_VCHG_MAXUV;
 		return 0;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return rt9471_get_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR, pvalue);
+		return rt9471_get_value_by_field_range(
+			chip, F_AICR, RT9471_RANGE_AICR, &val->intval);
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
-		return rt9471_get_value_by_field_range(chip, F_MIVR, RT9471_RANGE_MIVR, pvalue);
+		return rt9471_get_value_by_field_range(
+			chip, F_MIVR, RT9471_RANGE_MIVR, &val->intval);
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		return rt9471_get_usb_type(chip, pvalue);
+		return rt9471_get_usb_type(chip, &val->intval);
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
-		return rt9471_get_value_by_field_range(chip, F_IPRE_CHG, RT9471_RANGE_IPRE, pvalue);
+		return rt9471_get_value_by_field_range(
+			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, &val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
-		return rt9471_get_ieoc(chip, pvalue);
+		return rt9471_get_ieoc(chip, &val->intval);
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = rt9471_model;
 		return 0;
-- 
2.43.0

