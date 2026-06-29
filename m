Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABD43DA4B;
	Mon, 29 Jun 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747909; cv=fail; b=LB2Bdij+DV/+dB+iaXFWn9WRZCgoV8FzZlL+fOITvnIfV23k3AiNbKTGXhI3nLA9OisM86eZvunhgq18kMU2IuopqZhvhSThZ3CUgfLOEVgr7yjoo2swZ57aMIv5QMq8i30wPURiHAPRtVfNdRg8rGSyEB1eC20jDCoV8/NDfwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747909; c=relaxed/simple;
	bh=tOX+Kj3PtbiQx4w3BHnvyDPtxSgGmuHNxqlvgqoAfac=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=oLS5FJVZgTQ17nADqHcxZNmTRawLJ3m4BFVUooqfI2fir7XjsHncDsxYtAOMh1jnkWd70yyUOFdNF7BNp7u+2A1AJ9N5WDXbT4OOISKTmGmW4cXCjhvJWG2b+iR11eO9stt8A5kA4GRANXweoOllPu1ZiWz3HyWq029jkxaxFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hqkAs9V5; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hqkAs9V5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB5P1rOoz02izQmgwFDsgy3kfWtHoq9saB/2JpntICj2TdNTD7jRV0gQwPLYA1E6Lc+ZAlY+QIyDvjmLFfyBiBsUIcJYUc34cFnZwJRYLu4nW9jhBoC7ZtYN3cbVR91J+4sqDndm+r5VqPh5VMU+8DWWoHBPMPAhl6m2kXLC3iwYGnXZRkMAJIGfmt2cic8OzKPGNer8CD2ummYVZgrtjadey/Bckx3WbRC2oRtxpT5BOJ53dq0jdXddmBpZW/dHWZCgs9h8G1RN9Rmr0T8/lCZvVy3geV/Z4BwgSDfm17IFhCBiBXdH+r3a2fMp5YveVOl9gtuixaFkhiyxyUh0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyvf9CnnRH6nsbXKLwpjMf4TOYkTu6d2dG1M2UVuIqg=;
 b=I3R6ZcmQPXVjIChbrVqn60VgwG1TtZTwLppPk8E0plODaPOaVSdBNqyIzdW7uZFHdcjOFNSfeC1hL/UOYMlfp0niO2BVgaaoO0NwM0p6ZGTj5y9EL1zKJosMpDBbuFo2lB0W1mE3YLheFLSM1xbQ4oPsbgV3QrTZzFEJeYJ2IRx9g4VZZciU/UEwCDthQzT1yqZmEbu6V9X8lMRUTDUO3tE6LUw3C90ExbRfhtS/2XbhdI/Ne3M0HpJfFhb2/1BAQG9n8kSvBMcT6jnoPtt1Ay6TzGlYjbu4jkx5lJ1oF6CmLraGX6tJHBlRIr1swit7JZNfNvYFRLE7ZzJhupwLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyvf9CnnRH6nsbXKLwpjMf4TOYkTu6d2dG1M2UVuIqg=;
 b=hqkAs9V5AfwQM8IgLrqccj7lIrcMgSAmxtImzt15glGbU7P/pm4gnjvO3LvdPe7IGFkjffh5B0+8oLKAzMc3NySCcYlr58CjO88sJsXObqr6sXldXWXBXD1sctL1xRnXmYgiAFvmoYmODLwey60F3gtn0VfdOUxXlzN7LMawTC4=
Received: from DU6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::12)
 by AS4PR02MB8599.eurprd02.prod.outlook.com (2603:10a6:20b:58a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:45:01 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::33) by DU6P191CA0047.outlook.office365.com
 (2603:10a6:10:53f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:45:01 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:58 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] power: supply: rt9471: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <650d52910990389a5ed4e6f2fb3479f295925e29.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:58 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AS4PR02MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 643e0934-222f-4e04-3d7a-08ded5f56187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	iWCPLYN5NuMaORieOFQCoUl/whN1clfIlizBLdpfbpeBKodKgoM9hkXwGx+kV3B+t2qKYm4MOtjCsdhVOwfoJSMvHDEEfo2AEZOHvmLHXnDoqQ9NDq/NnH3aOhLvLFDsZ++OC4Qq2PkVE6LEyFzcv8r4JU06OE/kX4mp9qBxo1ZxlF/6UEUovyL0u7wqXfUumtlaQDpcqbjAeF/BVTTW2F2nUo1xUJk5PTrU1TtyNSFt2o0VnHziAGpNp91OO0e1AInESLCWQC4O+2YXwRAAEPWHjNDbIGvnx69zt/m1G7+d3TtdnJuzz7CVo1GlHZvDCO2KvWIaxFh3dkNdtfMM8r5l+QKFLauE82ujd+z9npejL9XW3YtvuIiAk0nVbjqUiGcWUKGz8aXdKie016Xk6c1WutlVcHe/Khv/LbUQa9WLNiy68vRkFsUclZNiv2OgKqxQ9Mcdi1ja2YCoKp2T8e+YK1TL2+9+Irglh3+P1oRXHWLPcmHxqLU5h7MU0yL4U1L6r8McdCIfUEpzEDwy/5SQcypSiBGlPQw+wk0L1ElT/Vxqb6DdgOLyT4WTMJLnXywsUj8djCfJSdO2VDYxiNc3ToyQQJWAijCu9XJs6m927Qz3ZaVUOBYYapkTFHplKwWjY6+p0RMqyemnGOyyJw8ZXx5I7XzFtC6uGYbLcqPIvP4lFDiwbHGLFyzbKA7B
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AX2dPp1/slRbRRJT67zh/D/hPbRsMuESev3xSi7lY/Voz8Iyb1f4ub9J05ziak0nE06rJwGso5XZ12dVPAvSCf/ib86dFdixMK1Rv35yukxRrzu05C0lWJ3H1X/rwmnreWVCRfnHijUuC97jhuo+dkuJbc4qDGPZJ4P7OnYzlfFRJQpo8NQRKBH/AFnW+NKyKaNlI+023jaMQWdv5HyIxUdh/9QkgcTT+EuMwpEihWmhmwGNB11Bxe2FxnDQ/0UXK7j7uGFOYbL8jtskspeZNUnD7xpFZAmej7os5q8U0nNP025MqiKlUonTIxOU8IWNQ2GOLDQvSh4RM5gYcAuwMcxIEQG6I2OOsxKDAIBIIzZNzA0kkUkVqslVeTOae8j0qGsayr+l6UvuhlEnWLAzY6rg2SENHVdvuU7GBPlBqTHhsv9ie1f3cvJOGEo/STOk
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:01.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643e0934-222f-4e04-3d7a-08ded5f56187
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8599

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control the BATFET, but
keep old custom `sysfs` ABI for backward compatibility. However, add a
note in ABI documentation that one should prefer the property
`load_switch` instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../ABI/testing/sysfs-class-power-rt9471      |  2 +
 drivers/power/supply/rt9471.c                 | 52 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

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
index ca3b0b57675d0..6275b79d16edc 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -266,6 +266,39 @@ static int rt9471_get_ieoc(struct rt9471_chip *chip, int *microamp)
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
@@ -343,6 +376,7 @@ static enum power_supply_property rt9471_charger_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -359,6 +393,7 @@ static int rt9471_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return 1;
 	default:
 		return 0;
@@ -394,6 +429,8 @@ static int rt9471_charger_set_property(struct power_supply *psy,
 			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9471_set_ieoc(chip, val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9471_set_batfet(chip, val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -440,6 +477,8 @@ static int rt9471_charger_get_property(struct power_supply *psy,
 			chip, F_IPRE_CHG, RT9471_RANGE_IPRE, &val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return rt9471_get_ieoc(chip, &val->intval);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return rt9471_get_batfet(chip, &val->intval);
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = rt9471_model;
 		return 0;
@@ -651,14 +690,14 @@ static ssize_t sysoff_enable_show(struct device *dev,
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
@@ -673,8 +712,9 @@ static ssize_t sysoff_enable_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = regmap_field_write(chip->rm_fields[F_BATFET_DIS], !!tmp);
-	if (ret)
+	ret = rt9471_set_batfet(chip, tmp ? POWER_SUPPLY_LOAD_SWITCH_OFF :
+					    POWER_SUPPLY_LOAD_SWITCH_ON);
+	if (ret < 0)
 		return ret;
 
 	return count;
-- 
2.43.0

