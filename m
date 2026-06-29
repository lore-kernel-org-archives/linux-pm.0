Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408D43DA38;
	Mon, 29 Jun 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747909; cv=fail; b=mTybBh8HLQjfwD8MgzKpi57JFcQ4dGHGBQCHpbDBp2ks03cVj/DFFib1p4LyFiiz3H/46OAFAqXjbZqzhSyHG3Fvq3yVvUudKZbWWE0bQXWJ78pv7WjNcQamTmsTvwFC7lYCPZPoIfq5olgfGdUujY3SIL3+lYcn9vd9saHnn1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747909; c=relaxed/simple;
	bh=PqQkjLISy5sDD2dwkllkwhIh5O/J4bKNsfcXLTJ6Xew=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=dl5mPKXv0H5Bo1yMXc//jQ1fhgyza6CQ9TLk7yV+WDkfCABXx6AhT1oT6G3vTtWGPtorCvxnsgwLMHgm13vLYaAPDcNKlcQX3PzPwv3mtOfbOwAOTybW7Pvk645rtelg11wiCJZwy6h92EqHOm3vAG9giw0DIbVdQ7Tq9snFLag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=SgM9s655; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="SgM9s655"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR38dkZ/hJeQmem/mZC+cNiidUpyAAobF0pNQCSjXqusmQ94hTDYqIPaMnO6t1Z56Il33FG7Xo710bXdVHxByJ5hMzpOgFmQ8p1p7N93+ZLwrJYSVzOiSbS+6O+6a268V9FFtM7kvtcs30aN4W7drZe1oOFk67v0JGy9jRQe+vVxK2woN5ActriOHkxukEI7TvEGDWSzTmnSDRwpOwLMkVXrw4IZ2Z3bKMjQqxGi9JnoQn4UR0h/dG87g3mGn0IoHXk9gSEXamND1En9XErOzVy1betkSvPyj4kg6MYtK3zpqrx6oJEpqs5ZwWG3NLQHTi+O4iuQ4RLNYWG59Nm6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LWpVfsnO6p0p5FQDF94j0YxJ5F0XGArPScGhd4LCfQ=;
 b=qV3+i+e8EC4kC4XrIViPEptA+SH7u79qmSR3IrTlSrC0P6QHTywbx8Ky9uQnR5RVEcDxjx7uGAwxZBh3UdTNdsItdmXIGnh/kh6jAFcTqDvGJ2U7aMqdSyPR4JT3t6XoUtLOxdX7LNKZ+ShCMJj3sidAO4BtKpOaRi2JVGNJonjWCl7BLp5MMUSMuuTHhDi/yK5ZpfrasPIcs22hXVy01C4aO8OmofW7jCk/LDFF0V4X6mgGporPh53nvtxppT5A/3BhIXYGJzjxwYjMqEUCdJx3cCV6i6a/ED5Pz6R5TQUCwxjtD5qUDYnEgrY8DGT3ndPRTA0N64GNAZlLmUxIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LWpVfsnO6p0p5FQDF94j0YxJ5F0XGArPScGhd4LCfQ=;
 b=SgM9s655eYuW8y53sc9qJeivJsNPnHopaldSx7rg4izNU8Gcgc+FhCWyui3HOvSiuIyFEHmhTy3CQiGby5w9FRj78DNVivhwIqKx0i0lqv03FpQteV2rWJb1g0S2wTi4rHAbWz+lF2yVmYqwRb3Q3VLB1wGENNrwfskGLRchL6M=
Received: from DU6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::12)
 by DB9PR02MB7938.eurprd02.prod.outlook.com (2603:10a6:10:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:44:59 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::94) by DU6P191CA0047.outlook.office365.com
 (2603:10a6:10:53f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:44:59 +0000
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
Subject: [PATCH 03/10] power: supply: ltc4162-l: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <8be72a94eac4878768a79ff261c0738c2ae7dd41.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:57 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|DB9PR02MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: b35af172-cd49-4302-0d54-08ded5f56084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vO1rs14ep+3JwHFRsSIqCeL0MjGP39kGPtb48gza8kSXyOQ+y0KaFSwNwL01m+1p9ol8/rsNW4P2UBpO7kwglnSfTm3x7JKxsOM/TRf/eGcujovRjMCACCEmQpMOUZrstGJMH2MwTIKfB2j2pYIU8GVEzXmDHoIDg/ayihdcB8y7M5CAazvcs/Zxt57SxTt0La/d3mYjrEpnd4usEwtbE+ft2KtqLgtQhsDpBrabAXj4ulg9cor1WL2sQrIY7TnG3+orXw3OL+HtGQUSmSFBT6ZCgLJ/9LeJoXRnBVPW+IMwl8YyIUgxCvZxoZnojFfAl0JpxkKk8DazI+ee49AdfFOUnNOP8M3wzAhDIJKthxq7EOY/XSwCK7S6nE8xHba+pAv9EpH9ZuRz5gh/f7NZ57bGrWhn+4NRYF349niP5yoHzP2HRj3wbHSjMi43szntQ4b/IGyj3X6MR6GMWdPxilV5UcVRmPQRv39B6h6v1qO+BIKR2jFenmK3k5yGvSY921DpbMMgzFnliK5atcrKKxbRQhLF6hYsrfBllj5M30+llmiMR6mfI7kkzXnitC08V5cSKa+GK/3OvcGYxmGNdg/YN6/d7Sk4OiFsAxrKtCxDIHDCE9Gu0IyyCo6SRk/iSwBdkjwTbgtfMTqFYkIuuzLNrJmhZjDhdM8SUI572bVqxt97rJfrBQuvfhsvhohUna1KRZMySLxMIBDrPvmK0Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	21qpGenWSF96TuS0xJuqgh+twEfk6F4bvC8lPJlaU1Cv+NK9/g943CPFiOTt606FFtBL8ZTJnXmyudYxrj3I3TtvqBoh7+kHIC72MYj0U7ZX8UzqFA74OkpweN0L6XHyTslvg6nNRMD6KwyNcg1mpT920WTk+5T9HqwjCJZ206WNdtfoJH/DU+KgvTlykvwkTJBLIaB1ZgKJ98AnY5xxcLPCj8Ig8qppuzfT2a4IxYpP0GiHLFhjLazPZjyyfgvpdXeFJfvpcZfgLPBJdQLUmLbKlYOyCFh0V4htTb51n5GVrnKfzmNbl0X0v2GI77nCg9+D/10pWuE5s/8c5WxgGPaF87641tjmqzho5jMEMuRP/L+/E65QG3Lxh0ipW+cWbG/javCaXfGu+WqCPdyB9K18PPVR/xV53iysza1xSU46zyxiKqUxbFBz5j0pWPVU
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:59.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35af172-cd49-4302-0d54-08ded5f56084
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7938

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to select ship mode, but keep
old custom `sysfs` ABI for backward compatibility. However, add a note
in ABI documentation that one should prefer the property `load_switch`
instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-ltc4162l    |  2 +
 drivers/power/supply/ltc4162-l-charger.c      | 54 ++++++++++++++++---
 2 files changed, 50 insertions(+), 6 deletions(-)

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
index 5c09e0368e6f0..b0ad50901290b 100644
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
@@ -1037,6 +1078,7 @@ static enum power_supply_property ltc4162l_properties[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static const struct power_supply_desc ltc4162l_desc = {
-- 
2.43.0

