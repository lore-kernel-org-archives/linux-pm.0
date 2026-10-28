Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224580;
	b=JRMGis+yRg3D6yzV/D/FhVYk1M81cXeXB2AWjEtK1etjKD0zYsTL6a+NNSb2e3hrUJKk
	 S/p+8claImSSB9IcwQZIElpzafcp6HQUpH8t/t1pz8dkuT6zDiRFRabqK0KZDAPV3Ytqr
	 6SXKefU6RvUc9niEl46oKHyRfa68s8rXflEf2U8pabc51NmHEXtAWdHkzryombSLUE7rS
	 JiCUjE/iWdoiBDLVXr8IZAqhPp/SpiMIRHy4yp7wSigLvnbHfggM06bBhRM8tL1NakUfB
	 o+h2K0+JbUJwZYc8WNHgh35CKVOVEMK2ZDrcki5P/81UrcUssDy6UaKzafWcHck3H0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224580;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GlhKj8MLLh7jWiRA8984cnhV8kqZCfQit/G97/c71Es=;
	b=FgtvuPPR/dWYVSpFg4HNOPAXUqzNdU/wByZbvHol2KKxaBr+4pAiGmrusLzlWOOJBnMa
	 OBZOJ6X57EILCtffNIs906t6Y0Y3kBIRSwt4WVMuM+XKZIeT/54PAvx+TQHCBj9yz5VnD
	 /9OQ/w277w+KHB4PL8lpMcdngO74wUVN4MhPDQluA2xJngFO5U7Vx/w1mWELrff4oWQJ3
	 Lj669VZr3xcJxZtqvTm6ZaULw9aIcSvfrZgU/uCzxCWxTefR9uOsoxGAzqn2ptNUAAhDd
	 /UIz/jlvsn2Yy6O1wzaETMybkC+nTM6lNjkztBNr6kezOIlFxINF1Em7RO+SVgCvZJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=IKneGL4E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.66
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934B606A31A;
	Wed, 28 Oct 2026 21:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0934B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=IKneGL4E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxCimRqmsNJWU2X1hYCZ/G+FuKiUnwMuPf1ljjs5G57tdjNAGhiuYPG5UafejhujRcBeRV8a9lS4K6JjmtQV7kF1/CMuOWMM4Rq05uKkj5lGZep+du3Md6McyKk3kLDCz37wq4FqIPQeZVxOcLUGajoS2MLOAy6HPjJquK+wwKM97MQG61zPV7BVY1q4ddJqu9QK2gddAvVvRpMctx+d5jV11HyeM+MushxIYeklhlbZiHqhL+777Y+3lsQSVSstxJtio1REOXFuqe+d/iQw+yWUbV24t/yYUeuZpw13KYrQf/wvZFDetAN+pHtkZuhXAQvJcgxBiIKcd9tNgl5cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlhKj8MLLh7jWiRA8984cnhV8kqZCfQit/G97/c71Es=;
 b=kNrNskyD8Q4AfNluhf1VmsGD1ruUhvwXeiGROzdkMYA/oU/94Zkp/qPUBrpbxzq7QlRWmj52IWrCbZCfu8ZSg7d+XJSsa0Zs65LBC/Hn0q1ODQOAAEfl4oYcqdvLyqhZY9A/yWWDhDen2SgvKPNPSXGUFADOWWBBLCVXFO0NMAe1VhAWyuraxioeWztKAn3QwpA/lealGDlhbjR3xICzkKuJtAA03NlFaILz9oN0KSGGPZtlxsU5J3WYrdI0zWZ9M7StPgkQQVlgRXRTdJE7zbSlpzOKxTdI2p6jM3V7EMzSDdbVMiTEdoZ6NFi3xhxg4kJuMYzDzs7t7fEANb5iTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlhKj8MLLh7jWiRA8984cnhV8kqZCfQit/G97/c71Es=;
 b=IKneGL4EOOOUk3MwJWeIHaU4S4OVZxQHvJN8E2R6/+G78NLxEpmxMKkMeRu6cAAW1L2Wk7N8JCmn1LckiIBq1Zv5W4fKPh+oba8W0d9FZ0S8JOZMPXeVDU2DtkNwd0FcNel5QSH1gnxxZiAyBQuucZcb9mkxpddki1kOmExJuGQ=
Received: from DU6P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::13)
 by GV2PR02MB11250.eurprd02.prod.outlook.com (2603:10a6:150:2ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 21:56:16 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::22) by DU6P191CA0022.outlook.office365.com
 (2603:10a6:10:540::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Wed, 28
 Oct 2026 21:56:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 21:56:15 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 22:56:14 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] power: supply: Add sysfs entry for liquid detection
 control
In-Reply-To: <cover.1793223841.git.waqar.hameed@axis.com>
References: <cover.1793223841.git.waqar.hameed@axis.com>
Message-ID: <adfad9fb335164b4f1c86b2b3ba9ec03a33c2a98.1793223841.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 22:56:14 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|GV2PR02MB11250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0b8bbe-7f9c-4cdc-f04b-08df353e4a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261026121527099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	52CbYm/vQAXy/wVN0ZpL9m5vs7XBqItuvhj/LvqYCzGuVvUOGRPCXnIxJaW7C3KD2tLpRJF7T2QkDk6WHYLc/hdLaHtnnf0IhoS0RxaCxF5UBLW4CGPX5FrV8na2h8ZKVIuR9ISswgeUXZBVFRC5xIOIQH37uuVH5sBDIPnGso0txeK8hXmeIqzFGzXBxqT04rD+M2s8ii97KSIgJ8GpHovDXDcutpGmnMtKpLYgcqn4d1gqaQxrRe50zcC7dESsnFNNUpMIYFylm+kyiQCKUUVYIXzL+xJS4rJsFXUgwucCu90hVlRKm2V9H+S8E7mEeJlg2cVKXnvA3A+iMVT3catR9oRexDgCLa/mLD7chMaNa74Eq+gXMU9vDHaxZZNdBCFFCCu5gwc/WozGEPSbQgtO/QCzL8IEndp2cmc7qGfySoPh0HNwwoKunoIuAZl8/3oCQ5r6mv0dsZijHjr1WKF9BtfJFHI/7uQcgZoTCVeBh6KUgyksqJuqyOuqBVexbVaTwfXwLL+TEj9tAi6NmfB1pvscwOsAsaVnFDj+1TN8Ksuvd/AJLRpirRWgpb1nnhs977N/T4RZheAUUuvARGKRQ3pyzgUU/8iE8kUlZ1ZM9A8Mb6SlvIQ6aPwK2NLW/WCJknXCIPghoix+H4hiEbPJKQtQ1vvalD0XazXI3Wj4agQc7ac53AH9SsbkWLCntyYa1xEJcPgdtF7gNO+SIw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2XT6tdoRxLavRM5fgz2bEMQ+rBEiPsPjKFC5Z+spr9yrp6tX89xduy3b4433aegURKY46OJM3kM8IbMhTTA+TdAwPBOFTCCZIvsQzyGImhzT6tadjHji5E3R6guU6uS6eJ6u/ZDvqypIcXqVu7zytM3lftqWN1VhgBmW5SpEMF6uXPnJE7w31sH/rfj3hD9Ox9X+rOeDadWin7mtwjbKTHUWSnFv5lOfpa31Wv4mV94zNLIlOrrpBa3CiqG+ppwlJtipFlCkaHVRASE5jHqxyftHY+fs2siXaFeAG7Xy7u/5BT0EJclFKd3oTvjncYS4GqAnxtFy5iErNMHN+4v4IQI7cJqud2wyjoNYliQdUH+F2pWBc3tMjZtldvjfg08qg6NXPTJgEp45XR4si0H8OAx7oHxaDgFWwfqH2I5jolLhKSykTmumURktpDWRWd2+
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:56:15.7781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0b8bbe-7f9c-4cdc-f04b-08df353e4a27
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11250

There are devices that have built-in liquid detection. For example to
mitigate corrosion caused by moisture in a port. In order to be able to
configure such devices, add sysfs entry for controlling a device's
liquid detection.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  8 ++++++++
 include/linux/power_supply.h                |  8 ++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 671786d4600de..a98e6b2a75fbc 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -619,6 +619,25 @@ Description:
 		"Ship"    (4) Ship mode.
 		============= ==================================
 
+What:		/sys/class/power_supply/<supply_name>/liquid_detection_control
+Date:		October 2026
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Devices can have built-in liquid detection functionality. This
+		can for example be used to mitigate port corrosion caused by
+		moisture. This entry controls a device's liquid detection.
+
+		Access: Read, Write
+
+		Valid values:
+
+		============= ===============================================
+		"Unknown" (0) Unknown state.
+		"Off"     (1) Liquid detection is disabled.
+		"Auto"    (2) Liquid detection is checked periodically.
+		"Once"    (3) Check for liquid once then transition to "Off".
+		============= ===============================================
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9704557ffe1dc..661b42adf6efc 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -160,6 +160,13 @@ static const char *const POWER_SUPPLY_LOAD_SWITCH_TEXT[] = {
 	[POWER_SUPPLY_LOAD_SWITCH_SHIP]	   = "Ship",
 };
 
+static const char *const POWER_SUPPLY_LIQUID_DETECTION_CONTROL_TEXT[] = {
+	[POWER_SUPPLY_LIQUID_DETECTION_CONTROL_UNKNOWN] = "Unknown",
+	[POWER_SUPPLY_LIQUID_DETECTION_CONTROL_OFF]	= "Off",
+	[POWER_SUPPLY_LIQUID_DETECTION_CONTROL_AUTO]	= "Auto",
+	[POWER_SUPPLY_LIQUID_DETECTION_CONTROL_ONCE]	= "Once",
+};
+
 static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	/* Properties of type `int' */
 	POWER_SUPPLY_ENUM_ATTR(STATUS),
@@ -240,6 +247,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
 	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
 	POWER_SUPPLY_ENUM_ATTR(LOAD_SWITCH),
+	POWER_SUPPLY_ENUM_ATTR(LIQUID_DETECTION_CONTROL),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cce61137aef4d..8e5bbdfebe794 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -112,6 +112,13 @@ enum {
 	POWER_SUPPLY_LOAD_SWITCH_SHIP,
 };
 
+enum {
+	POWER_SUPPLY_LIQUID_DETECTION_CONTROL_UNKNOWN = 0,
+	POWER_SUPPLY_LIQUID_DETECTION_CONTROL_OFF,
+	POWER_SUPPLY_LIQUID_DETECTION_CONTROL_AUTO,
+	POWER_SUPPLY_LIQUID_DETECTION_CONTROL_ONCE,
+};
+
 enum power_supply_property {
 	/* Properties of type `int' */
 	POWER_SUPPLY_PROP_STATUS = 0,
@@ -191,6 +198,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	POWER_SUPPLY_PROP_LOAD_SWITCH,
+	POWER_SUPPLY_PROP_LIQUID_DETECTION_CONTROL,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
-- 
2.43.0

