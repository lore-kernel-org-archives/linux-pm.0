Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3243DA2C;
	Mon, 29 Jun 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747911; cv=fail; b=pgD4jOG/laT44h+pMjnp0T6Z310kbu0llITyPjCh/KH4JDm2ats8Xtkb6rJQdSeiURN3+Q6GsLuHdNv9bTSunBfeLsJpzXHZEWrZPCJ98Z6S1iRrUt9HDvdxLTwfle7wCPUlc7gNDqoxe35isU4mYZInbv5NgtEZb6JbgrFt24c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747911; c=relaxed/simple;
	bh=QaeDrw9jCfh5TgDGw0SDJiIoAp74tALMmJDNDqMgLG0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=joJwV7+nSTpkdwaT7prbaM0iKCpkbcbrzMwEJu+hnpdoPKbfa5WJfOu7qOjwBX4ca2Gb2puq3EeSPIoyrr5ZIGw+UZI6J5aZXfCj0+l0qcMQ0TIXC5MZK6VpvZevjvoUMKuLeXwuZ1h9k+JCCXsDypOiYXhMcoeTRUx+R+2/4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PVthYLMk; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PVthYLMk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4A6aUaDYYNEtqjg2ZDvRQBEba7Asq3h9W/xeIm5AHQzL2lCN6BrmM8UCZ3jWL2K3FMdjLeiey9ZL6CwdxLZvnxb7BSsTz5FSK73tElHdnmG+Y0GogbWVRS5U8YuC8QHqVpyVvq8F8Db8wlO3MLMQvg7OCG6z5JwApe14blEqmtlp3DPX2RveNOnmQy+U50ikpcic7+M73WSRzg7BRFO5OGx72lyDfKhJCf7Zk4zBvt52g4a+AuFQT08KNVN5/8c7hpmkDYccsoewPJAGWmPuqaLtvWtP9kWRuf6B8RCQtBrLAaMjAwi6XpJS7r1/VyY1eYZvDJIE5vS7g8TVcCSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stIX44LAZwnZQ7sLzz+p7y4Ltr/MUN7KpCJcWnHxIts=;
 b=QunKXqeKLAInH4ZTHSSyCzmvY/l0WVKKnaKQ9k4HJOwvsPETxikgLkI7PDJTncuO2BhvU7nSuWsRSujAbsXbydjzlGtiu4JXt83GLnuF2oU3mKe+P2G4KwkKfrO87GPBACOOPVetKbeMTKChqF2/K09ZUse48DLzjOPZf2JPY92RdmHYJvdzop/QG66xsMAiVgCXrl3G+iQFexE0Jii1mmu5WTGCT570NjYbUDemg5Zq6nFRZxW7SmgRpOwCzO8fH4KqRsCCuhUqjb/HDGPonOGE8lMORrwmoSix47WkcvOnu8MwE4f3MoymUndy/aXv0nn1li5UptFzlqVnQJweNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stIX44LAZwnZQ7sLzz+p7y4Ltr/MUN7KpCJcWnHxIts=;
 b=PVthYLMk8xYj/WD+A2TsNn6sIKawM/Fq5cBjCFHxwc/zYMU2xPaR/DOLUo8ZsLgq5jdjnfWk0+bil0SWObaoOaAMLkbr1iCGEiKtz/bb6Y/YkD9e9H5coorIMS4606CeHIqrNKeCT6foA9xHbWXYlY37P94MDA7FjGYmV8OKhDs=
Received: from DU6P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::23)
 by AMBPR02MB11978.eurprd02.prod.outlook.com (2603:10a6:20b:768::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 15:45:05 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::e) by DU6P191CA0036.outlook.office365.com
 (2603:10a6:10:53f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:45:05 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:58 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] power: supply: bq24257: Use
 POWER_SUPPLY_PROP_LOAD_SWITCH
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <be145a4186b5ae5cafb4ad3bd651664b4fc5f439.1782746851.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AMBPR02MB11978:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cba537-2f5a-4de0-3b37-08ded5f563cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	8wOqjx9G2PJ1hM0xV+3gGFnCIpgJnsfH9oxBGufTwDcxt22GRCxDLli2F+EHW7wTeE4e4k6iy1GCXUCiwcadcdOA3PZwUOp2riOKdhv+A6IPcGTU5uwXHDaBdStDF3zNF1vhwd3Iilns7jNIkiSfHb4SBuWg2l53jG9CLwctL6MEhOaBLQd52izrS+Rg6PaJuqdPq6qd/jYpHlBzvvJUu6KoAAjfbxyv0JVPsUSqDxKXvomFIiT9GdAIJaxWGBEYGiy+a5dz1zZoo4xVn83fgkIj+skXq1L8cy7ft4vdxnh7u5+dmYrEE2xnN6GPeUGb8z/elMxYXVhl4btXSLVD4yOvxLw+ESm6EXWmIPaapbW751AtZI0nqCARp9vzqoMp0IG+oqXuH7KOkqHlvIbGCKJmichbfxbNxxEZyDaFoY0JOHzYgRRe1KgwUeKpiwsUBookUnteubFGp1oeNmEHgAxCgJwLxsCUiepBfj5JnDUfsUOjUMNKnJwGtv4gQxS5NlExVgZSP7KPlI/VM9i01B1AXXFqhQeX8aRvve60E6809CTytPTTa8bU+EMaAC8tx9q1MPgiABDtI1tAi8YrwVo1gFA7zjT6fs6MUodDSHRnZSVL+oSNTxRJoFL1ZAkquop3xqHnxH9otnmMVydt3jTA9kZGixzz+DcOu8KtLzjToDndn03movdxFIXnNmDl4rTXuXg7x0/ftxqXhvgpDQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s+H/DiVZJezRgvPdTr7IJipHVwh0u+MURKbbPUJpLz1gCs4ZT9jsjg2CFrWA6QHQItE/giucgDGmX1DXda6KhvHln9tuNvQtYHRQcBkWWMUGZ80RoTGcRmWUx6dnLyEAuA/R1ZhILzGrfzg0Wjz6SgX3j38tZBlGQQdjLkZuCsyTc2jqOaOrwFFOABvXagrXRRLIYlVcZ78dkuxIXZMy8cm+sNo5LWR7PqG5XngTNsjiyMezifuZ4ANv744opM79IEiSWHu1tmvXDviDR2cgH5zOsCR6dsH3V3V6qQf5+mw6HePs4pBuRuKfVywdoIJr9R4o2xKW0tVsON624VdaWxInk7okHJ6ckpupPbhkTdFZgdmoa3YuGnHZokrz+f3sMWAskWoIfxciVSbW2lJjelta+7M8p2tEGLezeqI1/7y2YmqDzk3R25ISI0CJdQ3x
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:05.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cba537-2f5a-4de0-3b37-08ded5f563cd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB11978

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to control `SYSOFF`, but keep
old custom `sysfs` ABI for backward compatibility.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq24257_charger.c | 41 +++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 72f1bfea8d541..0ba690e9adb7b 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -294,6 +294,40 @@ static int bq24257_set_input_current_limit(struct bq24257_device *bq,
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
@@ -380,7 +414,8 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return bq24257_get_input_current_limit(bq, val);
-
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return bq24257_get_sys_switch(bq, val);
 	default:
 		return -EINVAL;
 	}
@@ -397,6 +432,8 @@ static int bq24257_power_supply_set_property(struct power_supply *psy,
 	switch (prop) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return bq24257_set_input_current_limit(bq, val);
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		return bq24257_set_sys_switch(bq, val);
 	default:
 		return -EINVAL;
 	}
@@ -407,6 +444,7 @@ static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return true;
 	default:
 		return false;
@@ -739,6 +777,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 };
 
 static char *bq24257_charger_supplied_to[] = {
-- 
2.43.0

