Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2103C3C02;
	Tue,  1 Sep 2026 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291323; cv=fail; b=cehNGVI9PLFYdK3xPsdP11EJN9mK5wokhiJOfmCT7KBmggXgBd1GLMk3rT7aTOT68yYw4p66vQIy3nA/bc6e1/69onLCqgApYLa5Zlu08AjaDmu84RimDCC669Bw5vbTxG8yf/tBovIhADip1RMrE+38PhPeY5nN+EqL2YzYGrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291323; c=relaxed/simple;
	bh=5lAqrg+1ETVJqHLWk/f6LkFUX3Vi4boHjEU5HGl7xn0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=DYdsPrkhonlYtMgvv3c2MQJnmNbIgO66AMtsfKpKgC62PS8EM2g/x2SMHAXiRL4ut7OWoWjZqki0MJ1IKblWLFjmh4MWVe8Z3+M/Lo1wq9Ant9psLkZXewIfUuIXDU4qlTaX372aYzHuUxWozKi2OM/afquWPhqiDwQoCTqq3+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AtNVcvS3; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AtNVcvS3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu/5vcFFkJ/jF1aNyvvPK6ZqFWZPQjGjRyOxRNtd5aUEaBIWURNNis9ZZ/Ql3ieiel5B/pep4nvNGedzJSt/q6xdiUuM/10qgQX8hdACNzpAbfYRePedGyaRXIi+fcka9ItwXUVxsv9hffFlY79wlv12RMXEuigHdvjbPjlO/jllJpMQR70XWuQ0jkrS0BowgVP2gV/fOXp19jVgaUnE5igTZ1zVuFdZ32e+0lPnhmvU4pCYcCeg5gdTMDrn0JNzjD2h3unFDywUaKFyLH697hEl0ITE/kW9BoflR5rPSWJFvthilWjp7Tu9n0OsFVUBO1EYZx62F9R170828zqldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqvxhNpYK4poyd0c4aa0/j6jLcA/VVWzma+DLfmVVt4=;
 b=Ksgek3gm6cyGSqai32EH8xviGN6qfLKjPMBbS0l/BQpPl6/ILXslDypJnvGH+TPU0vRlJz5+x5P1ro77B93FsgTQtqP1O6xw15gcguuQRdJ/YWkFg4IsytdVhcz5JWPfLxzfHBpYi1Acz1t19QXX88xTM3BHFoDE7atPdcg7emV4zMAXtnEbKsYMNBG3yHqwGpWE7yHgowx9I49mTOI4efomBBuRMA6U1L2oxD3ZUzjojkagjxh4TSBV7Pyt5u64RoyWuXucEoqVGiFIeKePq8usiHWLTK1H2KXID+af8zQYP/3PwaaAmmPc4zztQK1cJv2zWQ+cSleilggQXQEQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqvxhNpYK4poyd0c4aa0/j6jLcA/VVWzma+DLfmVVt4=;
 b=AtNVcvS3fz3dW9Tp4Z2RoB+eMZ9bta23oVxTeKqvgjNjtxmpbIu0HgJovtHVPEBTx3zJobXHADQWYVxizi8Rx71y4kgQpcRAAeToKZ4doZ/1rF9DpNbExd27KHQDMauERpQ6S8WCsj1UiVGQSqd0450lmE+PEk0FiG//EtEmoHs=
Received: from AM0P309CA0028.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::6)
 by GV1PR02MB8684.eurprd02.prod.outlook.com (2603:10a6:150:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:15 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::69) by AM0P309CA0028.outlook.office365.com
 (2603:10a6:20b:28f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
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
Subject: [PATCH v2 8/8] power: supply: bq25630: Add support for BATFET control
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <f9d62a7fbabb1a920b31f79438cc737df78d0140.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:10 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|GV1PR02MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b62aa6f-2c29-47fb-6b97-08df08602607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	de29ir+lh963ivs60MSdt07GibTtnIvSg6iJIXoMWw9+2buasES6MgFupOc8ZzCPn717NTvihrYyqJapc6JjjZB23QoJJLNwOMm6Yh9IaD892Qwnp3iI78Gb9osLM0H7lAQJxSm8NPdtpl4VN5Vy3uIUZat5YMblaH6t49GXyVxhxiVyEhS+IXyewrWQ7D7oC7BjYCFDIuCfGEGG8rvRcW6g6z1uGY58TUVqit9F+fs689H184/5lkodMIiO7eOUTl10Dtku9twPSsiHxgK9sFCHh3OJZI8HFayYbHIAhSVPJDolA7ZsU4PA0zb29aRlRMK6yhZXvmcn1bpl8eAu6sLsHYUimNRrhJ0BEjRlsd+9t6Q9RrIXXLhZf8Z5nrPmPC1CMOcHi3EQK5QIRSXlhcTPD1M3U+xZRObOI7V9Gt7TGo2gNHh8ilAGRD7S4c3va60A1qFIwG9kA1mU6A4dftLros6w0KcAwRydiYv+W8pc9plE7IoTjWk+or1ouMcZGzNt5Y/9mEg8vzdPXZ6vyMWfvkZgveNOz7bVb4kRT+28Hh+Kw1jCM9gDRUAljLGTuSZBJLmoM0078sKQztk0cbQwa8KU4QWWitTmwaOAWmYmUpJ1L1tGhmDEjHs7NkbfCmzQSC0HrrRpv4I8Oh5b/h4vefyROD24RXNTFt9+hs+5p2of7aNabR5FNbmW9gTh
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MfM7dA/A96D6yhwnR3gwYl5FidUToKSb2o0Qxh8wAOwEUaXgqk+I9VZMkabOO1lztfBUROJF0UHUjQSi6BeCT3Ofvg6JF6BKNZq/lIcNw4N3LjL3CyXSMwZI/rREizW5KamOiZ2dsWAETD1haWaCh07GX2DIbl9bcti0aD7XKHtP89eF1cOOko17yPItZmT+8w3ZNU7qbk29aSQFHfxLZ7voHNf51sftzEAh/awic8WYGBj+mDvcrJtFG+gBIdOhpVWESFrylAGirYwDmvKtU++CP9y+D9Fx0sf40mKHJch8qYnEKg0+pDPyWEpJJV1PHO+C+hi9HktMsQWYOyiVaKOBYwfJFvFAi2bqTEnwUiU5E8x+d7zMcybrql0SMrKCWy28kadIUuxPr3Pbg0iY6PzBlucJD/InNC5Dk88RAqg2zbCR5NQ9jOVPvcz3KlzE
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:15.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b62aa6f-2c29-47fb-6b97-08df08602607
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8684

The framework supports controlling system load with
`POWER_SUPPLY_PROP_LOAD_SWITCH`. Use this to select between the
different supported BATFET control modes.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq25630_charger.c | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
index 200f74f8eab61..bf54ff557a40f 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -112,6 +112,12 @@
 #define BQ25630_ITERM_MAX 1000000
 #define BQ25630_ITERM_STEP 10000
 
+/* BATFET control modes. */
+#define BQ25630_BATFET_CTRL_IDLE	0x00
+#define BQ25630_BATFET_CTRL_SHUTDOWN	0x01
+#define BQ25630_BATFET_CTRL_SHIP	0x02
+#define BQ25630_BATFET_CTRL_STANDBY	0x03
+
 /* Charge types. */
 #define BQ25630_CHG_STAT_NOT_CHARGING	0x00
 #define BQ25630_CHG_STAT_TRICKLE_CHARGE 0x01
@@ -587,6 +593,71 @@ static int bq25630_read_vbus(struct bq25630_data *data, int *val)
 	return 0;
 }
 
+static int bq25630_read_batfet_ctrl(struct bq25630_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->regfields[BQ25630_REGF_BATFET_CTRL],
+				&regval);
+	if (ret) {
+		dev_err(data->dev, "Could not read BATFET control (%d)\n", ret);
+		return ret;
+	}
+
+	switch (regval) {
+	case BQ25630_BATFET_CTRL_IDLE:
+		*val = POWER_SUPPLY_LOAD_SWITCH_ON;
+		break;
+	case BQ25630_BATFET_CTRL_SHUTDOWN:
+		*val = POWER_SUPPLY_LOAD_SWITCH_OFF;
+		break;
+	case BQ25630_BATFET_CTRL_SHIP:
+		*val = POWER_SUPPLY_LOAD_SWITCH_SHIP;
+		break;
+	case BQ25630_BATFET_CTRL_STANDBY:
+		*val = POWER_SUPPLY_LOAD_SWITCH_STANDBY;
+		break;
+	default:
+		*val = POWER_SUPPLY_LOAD_SWITCH_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int bq25630_write_batfet_ctrl(struct bq25630_data *data, int val)
+{
+	unsigned int regval;
+	int ret;
+
+	switch (val) {
+	case POWER_SUPPLY_LOAD_SWITCH_ON:
+		regval = BQ25630_BATFET_CTRL_IDLE;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_OFF:
+		regval = BQ25630_BATFET_CTRL_SHUTDOWN;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_SHIP:
+		regval = BQ25630_BATFET_CTRL_SHIP;
+		break;
+	case POWER_SUPPLY_LOAD_SWITCH_STANDBY:
+		regval = BQ25630_BATFET_CTRL_STANDBY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->regfields[BQ25630_REGF_BATFET_CTRL],
+				 regval);
+	if (ret) {
+		dev_err(data->dev, "Could not write BATFET control (%d)\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bq25630_get_status(struct bq25630_data *data, int *val)
 {
 	unsigned int regval;
@@ -845,6 +916,9 @@ static int bq25630_charger_get_property(struct power_supply *psy,
 					 BQ25630_ITERM_MIN_REGVAL,
 					 &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq25630_read_batfet_ctrl(data, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = "BQ25630";
 		break;
@@ -913,6 +987,9 @@ static int bq25630_charger_set_property(struct power_supply *psy,
 					  BQ25630_ITERM_MIN_REGVAL,
 					  val->intval);
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		ret = bq25630_write_batfet_ctrl(data, val->intval);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -932,6 +1009,7 @@ static int bq25630_charger_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
 		return true;
 	default:
 		return false;
@@ -954,6 +1032,7 @@ static const enum power_supply_property bq25630_charger_properties[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -972,6 +1051,11 @@ static const struct power_supply_desc bq25630_charger_psy_desc = {
 		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_C),
+	.load_switches = BIT(POWER_SUPPLY_LOAD_SWITCH_UNKNOWN) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_ON) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_OFF) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_STANDBY) |
+			 BIT(POWER_SUPPLY_LOAD_SWITCH_SHIP),
 	.properties = bq25630_charger_properties,
 	.num_properties = ARRAY_SIZE(bq25630_charger_properties),
 	.get_property = bq25630_charger_get_property,
-- 
2.43.0

