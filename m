Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA83AA4F2;
	Tue,  1 Sep 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291319; cv=fail; b=iGf+w6nRx2kpMSQbqPqT5rK4oEZ7//0dz/o2ds4qtuKQvvHaJVs3ldd/OgqaGvWGcu3zwSjyPU+WT7Y7awkeegAUTOrQzbH4M7qR+mFtvc5kC+TAHcJmhLrciqCsyOSLpaIwCli+tLADTaqPKWP/drmiKIHdW39TltULr+5t9P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291319; c=relaxed/simple;
	bh=1BGOXdCN3lM3H+7KZwOMtvaQYpuLpMmkgQlDYKC2sIo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=QnRjQ+P9kEzWtH68fdBWkjIsgeeKKgBDuj+lui2LwOzFox2LIo3WTSP1V/pDJIZ36bIqoFCo+J/2LgJKfq+F/BhYvHwCRmuOiKOKZZYY5PghdNYAcBHAZaE2+UGnXp0W9YwLM+iM3Olgmiwr/v7b5rFlEDvmMeNW4zkwPz/UemM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BLUO1Vz8; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BLUO1Vz8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9reOmPumqQy3gPEDscvEf2rCHjRjdYdwIOsPT8U8ZtetFsy7j1Uiw0n8s9cX4p7atPlTrA7J5Rpc+yCWfzuOW5l7W2OckcoHSrjX2AiAW/xMUtV2gq7c9VWUkb+4pClcUrVgAnR6JcVnd6MPL4snw99DzdxrGrz7HIGKaJheTKAvrclD0rtZjV7Do5Xz377xtfqZmS7o6TMGWpSerywPUXUAlQPAkaIuZND/42q8rHGTkoMKs9O0vyLLVw2csIAkt/41UaBSMaDIncUym+Pc3rzMiLQmXWf3XWWK6HBdQ5ibmFhZCQMF6IBYNvHcVP6d/YDn6mOaoHSSJejgJrT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsYbSKXBWLviDYIMxIGUYL8L2s2SWt8Yj9ajayuL0A8=;
 b=KOAdkjNJ2IlWxQwSd5bEojyTX/+4F/tye50NuB3tEUACdRlIAtZq185UtWBvG3XCDJHlPMX3jV53Zb30lS/fBJhm3grKure+BEI3b37NQRJlOiKQMDBUsbxsrD4s3csqZOBUBYlLnBzgrWrynWX2J+P2lMriBycy1gCIu8q+4mkXI4fUS6dRjrAAQakA3lWzjHim2bz28TlPrOKkpzWA8OPjfb1vH71i0CHcyol1fkEHzhl007x0+Gf96yhTJeCgYetZ9DKDiAwFPWt31+nJ/OUnq+C9LxJwd6G683FHyHgUWi7otOOivq5ToWhxgB/il0ro9EXvwsh4mZJ9m1AhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsYbSKXBWLviDYIMxIGUYL8L2s2SWt8Yj9ajayuL0A8=;
 b=BLUO1Vz8+SdMYl/PPYNP6kfrouGqOAfhARoIswJhnkv9+QqY7Jj8NLI7VMASKaPVsslcE8vXif1LaoGdPv/psnnFNaKHg/z/okWmFBHStzfc9bYxy4KM5l1w2gF1tfPfz5etEvBKSgowypwc+G/LAPYherEyuBU5FCuvDNn0858=
Received: from AM0P309CA0012.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::19)
 by AS8PR02MB10361.eurprd02.prod.outlook.com (2603:10a6:20b:56d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 19:35:10 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::26) by AM0P309CA0012.outlook.office365.com
 (2603:10a6:20b:28f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.1 via Frontend Transport; Tue, 1
 Sep 2026 19:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:10 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:08 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/8] power: supply: ltc4162-l: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <d3fd0bc718393250815d1c3ef8544a480badbf69.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:08 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AS8PR02MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d68f82-3997-4b79-84ed-08df086022c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	05q8TzKZv/zICuGRv0LN5Nbl/Mlt0+S5ocexgsYHrm0xePD0hGY3H+BYcrgTfNQQKTbNX4oJ4FobWY+NImv5+qLyAc/LglCzOnM+t0XpYLUyKtEE1xZnF2XqQjVNpOArA/kQPVokjCC82xZVdAqVxlNWBbP64B9tcB+uHwovLSjG7cFiLqCNwsq5oFFPtcAFn14CjBYppE9rJNTerebdQtfAOqIJxYww4cc/kg4G9K/cVjKJRpCOFAnaZzjuocme28ObZRkJJSr7ZRC4whtJakvyylVX/YI5vS1pfS6O0ern+2KgU4GJJ4lMJCi0paVgyQyTq+L8Z77wTbzSy53k27Gj3kdmLP6KDWfZM4D79puKAJAwt7FpmrYDpq4ZjHd6G4iOVPxDXlvdFWpDJHtFCyOikEjT3bk5sg5U/EqgRLXfupFc0cLkG8FUcqXGu6MYY7eI35ju/jJMuTpZ0p6C1qmBYMm2w4MFM7RigoZLmlCtX09X0zE84x/wyq6M2Cq7CGfgh80w5CqadBmxrZ1IvFNmnq/+6dg4hnMosG6EOThmvPRsZvTDWPHhw53YVQBEvEqOJMAQpkS8VQgYTut6hevywX4U8RuHQ9DleQUYupkeye3Ew751TZSjwnJvzL+saxyzO+VTyNRJYIWQxvvVmBHfQ9xR7+laAsZhUiyl6mDWja1qn6MrFrivtfhY3dJ90nQS0QqmKz82Vt1o4N7UgA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3vQ7WjOBfkYvKbAHPL/g/VtnGNCh62x+8TjoDnlfukaQ+ww1ndas7DerdE923ivXCphCmrCAdfnr6FJkfkwO7Agy0qEvfDFuNwVpq5gUbYDSH8S9lIgK4S2JvxUTHerBcrlFR6uUknpl6JMN+0JZK3SO+U222b5uxH0RS4wgxGN3ojnAWxBH9Hg1zMv5UBYo3SH3+yWMcEemjvYbP+66aU32tBSo+6bBY/j2uRemBYrJwop3YJS3KZ9X55YMtrHwtG6IskyWA92U2Cr7w9ekOVM3rVfSS39FSYvoLj+s267SiJGvJHiscpHxjsPDHq2UVmuAP2vGqgeGFbIunO0q5umIP7uXyrdC7D3yX57YdXJWN/xSK3c3jtopKw9L3XnoHvS9VOQ2vkaRJ9fwsgfer4c3E6S6TSiVUZiCFd7ny7S+LaO0F7UZD6YmKtdNNjEd
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:10.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d68f82-3997-4b79-84ed-08df086022c9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10361

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to select ship mode, but keep
old custom `sysfs` ABI for backward compatibility. However, add a note
in ABI documentation that one should prefer the property `load_switch`
instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-ltc4162l    |  2 +
 drivers/power/supply/ltc4162-l-charger.c      | 56 +++++++++++++++++--
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-ltc4162l b/Documentation/ABI/testing/sysfs-class-power-ltc4162l
index ba30db93052bf..ad46ad834af05 100644
--- a/Documentation/ABI/testing/sysfs-class-power-ltc4162l
+++ b/Documentation/ABI/testing/sysfs-class-power-ltc4162l
@@ -77,6 +77,8 @@ Description:
 		The ship mode, when armed, activates once the input voltage
 		drops below 1V.
 
+		Note: use /sys/class/power_supply/ltc4162-l/load_switch instead.
+
 		Access: Read, Write
 
 		Valid values: 0 (disable) or 1 (enable)
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 5c09e0368e6f0..01b0511da9aee 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -755,6 +755,41 @@ static int ltc4162l_set_term_current(struct ltc4162l_info *info,
 				  BIT(2), BIT(2));
 }
 
+static int ltc4162l_get_ship_mode(struct ltc4162l_info *info,
+				  union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_ARM_SHIP_MODE, &regval);
+	if (ret < 0)
+		return ret;
+
+	val->intval = regval == LTC4162L_ARM_SHIP_MODE_MAGIC ?
+			      POWER_SUPPLY_LOAD_SWITCH_SHIP :
+			      POWER_SUPPLY_LOAD_SWITCH_ON;
+
+	return 0;
+}
+
+static int ltc4162l_set_ship_mode(struct ltc4162l_info *info, int value)
+{
+	unsigned int regval;
+
+	switch (value) {
+	case POWER_SUPPLY_LOAD_SWITCH_ON:
+		regval = 0;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_SHIP:
+		regval = LTC4162L_ARM_SHIP_MODE_MAGIC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_write(info->regmap, LTC4162L_ARM_SHIP_MODE, regval);
+}
+
 /* Custom properties */
 static const char * const ltc4162l_charge_status_name[] = {
 	"ilim_reg_active", /* 32 */
@@ -890,15 +925,15 @@ static ssize_t arm_ship_mode_show(struct device *dev,
 {
 	struct power_supply *psy = to_power_supply(dev);
 	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
-	unsigned int regval;
+	union power_supply_propval val;
 	int ret;
 
-	ret = regmap_read(info->regmap, LTC4162L_ARM_SHIP_MODE, &regval);
-	if (ret)
+	ret = ltc4162l_get_ship_mode(info, &val);
+	if (ret < 0)
 		return ret;
 
 	return sysfs_emit(buf, "%u\n",
-		regval == LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
+			  val.intval == POWER_SUPPLY_LOAD_SWITCH_SHIP ? 1 : 0);
 }
 
 static ssize_t arm_ship_mode_store(struct device *dev,
@@ -915,8 +950,9 @@ static ssize_t arm_ship_mode_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_write(info->regmap, LTC4162L_ARM_SHIP_MODE,
-				value ? LTC4162L_ARM_SHIP_MODE_MAGIC : 0);
+	ret = ltc4162l_set_ship_mode(info,
+				     value ? POWER_SUPPLY_LOAD_SWITCH_SHIP :
+					     POWER_SUPPLY_LOAD_SWITCH_ON);
 	if (ret < 0)
 		return ret;
 
@@ -981,6 +1017,8 @@ static int ltc4162l_get_property(struct power_supply *psy,
 		return chip_info->get_die_temp(info, val);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return ltc4162l_get_term_current(info, val);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return ltc4162l_get_ship_mode(info, val);
 	default:
 		return -EINVAL;
 	}
@@ -1003,6 +1041,8 @@ static int ltc4162l_set_property(struct power_supply *psy,
 		return ltc4162l_set_iin_limit(info, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return ltc4162l_set_term_current(info, val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return ltc4162l_set_ship_mode(info, val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -1016,6 +1056,7 @@ static int ltc4162l_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -1037,10 +1078,13 @@ static enum power_supply_property ltc4162l_properties[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static const struct power_supply_desc ltc4162l_desc = {
 	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.load_switches	= BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+			  BIT(POWER_SUPPLY_LOAD_SWITCH_SHIP),
 	.properties	= ltc4162l_properties,
 	.num_properties	= ARRAY_SIZE(ltc4162l_properties),
 	.get_property	= ltc4162l_get_property,
-- 
2.43.0

