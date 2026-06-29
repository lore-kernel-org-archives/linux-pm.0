Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032D43DA21;
	Mon, 29 Jun 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747904; cv=fail; b=BVMust4qZ3FPngBG8M1TA8MaCBXM2Co3vbdbMezwMubfwUsKYh+YtuYmj8VmMlL10NNRbJ2DG1+bsGHapsWNm2yNYUpvwXclT/bjR++hdF8XY6it9zlLvVkuSJDVcu4py3copgcYrWH5+4pRT5CIhQuvfjqbbxbd/E00BrW8JVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747904; c=relaxed/simple;
	bh=7kH6us4OeqdrAG+uBkpkwFs+32Q5tHKhXt4DmeNIH9s=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Z+UgxnhZbLLdIz//HuNJgeLJxSc1Cm7QP8aK21zIHTqsRXrQTAIIOH7Vp5cjTthwlqZ4YRbKHhC6ZgM+JzWcwHcDqqHV0DbnbkxtBwvo5FRh28VOkPjkAbW1I8zLQi1uYB0gG+QOW/ypWNo6QE9FNhu5eubyoj4a8TMBw75/hU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Q3o84CR3; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Q3o84CR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz4FKQvLNy2p1phS+eNNWG5TmWsC05nzBQC+liK1cW/vcGq7H9GW6M1YQ6QZLaoepU094MuvASIx4pW1QWJ+Pk+0pkyUHaxX4PXRnSqR3hSOwgai2bGYyr32Z6AZzdP6RkJhnmXNmMjLc34+GH2q4vYBOTjGGrt71+DPTWC4GtVEfHPa4lU1Fr0d5SG96AVzjta2kiiXAi0FZM1+f42+l7g3hayWkOZWrU0CtV9hNQmFfZDHJhGDMsZGZneADIb0Ljqj3yH/KWcyLDNTWEV4UksBfJEgETypziJxak/9gziDjdI1ujw5QMtTOQu+/VYMXZKpj5mLYwAgDg4+sTWbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGx6qJxY3juWLOdGjxoSu7uV16YpiHPccu2jbdj4fJw=;
 b=dQofHD34xl0f/wHFF1mNnyjYbYLnQgxyNztqsIkua9FxWbeofTcxr1PhreZtgSZvV1+UtHULAF7Fvpn8t1qvZPyB9jKgTdi+ofvV1wcn5a4aLroJeu6g2fvzCI8rreGdBtuxM2hp6Bts27HQnptUUf3y+fhhvl/q9fsHTdExmn6fGEPZQm/WtJlUDTslMKcBktJh4U99I6NpZ+I0RAMTpXIbOZ/BpbjGkbf/smf2UWnulVjuD2ZmvwnILqiO7xHFwVe7ERZQiLlq4xdrivM30pG/a/1OwFshR88u6YoHKuzAkImqcuyJxTLOGZpvu53jB80Z+HxE6mU1dhzIgqw19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGx6qJxY3juWLOdGjxoSu7uV16YpiHPccu2jbdj4fJw=;
 b=Q3o84CR3pLVUD8HYFWlvBiYSxeV+MlORH0BLbFwRVW0094XaKETMNaxQQUcNJRnh/O/jAlbEuarL5zxpKmvRUAZ9YhW5YQ8Qp8/m0+zuR1CCUCeFZ6f7wjpyFEpSxayMlFZw3cOts/pHELgqjbOyxiDQKzIfrlBR9q7nvM/xGys=
Received: from DU6P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::8) by
 AS5PR02MB11488.eurprd02.prod.outlook.com (2603:10a6:20b:6c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:44:58 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::95) by DU6P191CA0033.outlook.office365.com
 (2603:10a6:10:53f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:58 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:56 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] power: supply: Add sysfs entry for system load control
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <3290b7eabb9dff19d77ff50d5ff1c4db4d37bdc1.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:56 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AS5PR02MB11488:EE_
X-MS-Office365-Filtering-Correlation-Id: af056702-34a4-4995-bb0a-08ded5f55f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	20SkSe50fmAHPg0+AX/1+EqosrWXkWwV9aeLIyMHSUgkbl8mO8fzDaxvGS7jahruhAPgAsp2NOZylALuYekqEkIey0o9oXQ4hc8tmf/Ecm8gAuH4pfmRn+XK+p6tjRau8OLZ1ofTBtnz/H6o6U+Bz+7Atc7E6CNbFep3Lumh6zB0ZSoZDOkLDqQDu83HmprKoCYqDDUwJZR2M7UUjDFSITtnE01OuhVpFsw8d4EBpyZtqfu7AdcEyTQ/XdZKEoZ+Pj4eWn4bU8uVDc4KxSivUsR/nMEG/lzQp6kmURxOViRKApAXG19is/nM93vN1vFuy0FR+YAfrUrObK/F1D1I4AT6kA+h3Ih0d0Onzrx7ic5tpHXg5pOqyl17/Nj71dLVKdXYptuBz6a7kymEWj9nfy8+UGilB1F6JY24GUPMyGpAqkeWbMKfPHQ/fJznbopi6Sm/TdrPgWjPtls76XPuom7WU3qC/ZagX8AzFnHkswF5ySyp9iySwzco6wdDCD26M9b7eZXSmPOokPjDL5pCqO+EnDFMWzZpN8DEkQwhVWkUlcAiYyjesE1UTFn+AEjNgAdaf94LOmHS4GUnyLCErPJNkhsNx8QGSX5SMvxbhwa4Ao74zAedXQTSkOYAruj+P8FEFr1FPvWloU1nu+wLCxkLEsy6GAapFwqTIMgeH3M/k3UXzonGKzQk5wkdoKeo1capxGfQL8D6ty+pguF9bA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ecwKPJEoliTaT97mISseG8Be5NURsY3arPOsfcltebmCYqKglCkIW2mxTQYq40fyaTrtfMAoHW7zblGPCO7YpgHcLuM4Z5igZS/6P85rTIpqgUZ0WczFdp4GRxDbK3X/LAKeZHXylwkUIXxVJzyuaD2WcIKPlesGXxQYilpOljcE4ihjSMMQz6OFL9easzgGDalkghM6Hcf0g1kYYQ3Epzzkkby5uzcpte0/sZi2fq0Yr6vRO3DxX/VASwal90Mn16Psbm8Q2qBmIMB4dCihtkRAZNV6yOPFE1KNsBZ7j1+ueitBfgnrnklOENfCSl3DBs2BLR505Xt+2lF6CIEkFe8ZxoUo9LzOMzcP0xxDDuTWE9L6oJioT6x1MPf75K1s9xHwgkLFR8NmEWZ/XN0b53jlFzI+ur38qkpHai8iyhDt0I5OPJaKiDHehrrslbC/
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:58.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af056702-34a4-4995-bb0a-08ded5f55f9a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR02MB11488

There are devices that can control the connection from power to system
load. For example, with a field-effect transistor between a battery and
the system load (BATFET). Drivers for these devices are currently
enrolling their own custom `sysfs` property to control this.

In order to unify this, add a new `sysfs` entry for controlling such
switch and corresponding `power_supply_property` with `enum` values. The
obvious states are "on" and "off", i.e. there is a connection or not,
respectively. However, many devices can also enter special modes such as
"low-power", "shipping" or "deep sleep".

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power | 24 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  9 ++++++++
 include/linux/power_supply.h                |  9 ++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 32697b926cc8c..2287b207311cd 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -590,6 +590,30 @@ Description:
 
 		Valid values: 0 - 100 (percent)
 
+What:		/sys/class/power_supply/<supply_name>/load_switch
+Date:		June 2026
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Devices can control the connection from power to system load.
+		For example, with a field-effect transistor between a battery
+		and the system load (BATFET). This entry controls such switch.
+		The obvious states are "on" and "off", i.e. there is a
+		connection or not, respectively. However, many devices can also
+		enter special modes such as "low-power", "shipping" or "deep
+		sleep". In these modes the switch is usually off and the
+		quiescent current quite low.
+
+		Access: Read, Write
+
+		Valid values:
+
+		============= ==================================
+		"On"      (1) Power is connected to the load.
+		"Off"     (2) Power is disconnected to the load.
+		"Standby" (3) Low-power mode.
+		"Ship"    (4) Ship mode.
+		============= ==================================
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f30a7b9ccd5e9..243d6e57704f6 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -148,6 +148,14 @@ static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]		= "force-discharge",
 };
 
+static const char *const POWER_SUPPLY_LOAD_SWITCH_TEXT[] = {
+	[POWER_SUPPLY_LOAD_SWITCH_UNKNOWN] = "Unknown",
+	[POWER_SUPPLY_LOAD_SWITCH_ON]	   = "On",
+	[POWER_SUPPLY_LOAD_SWITCH_OFF]	   = "Off",
+	[POWER_SUPPLY_LOAD_SWITCH_STANDBY] = "Standby",
+	[POWER_SUPPLY_LOAD_SWITCH_SHIP]	   = "Ship",
+};
+
 static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	/* Properties of type `int' */
 	POWER_SUPPLY_ENUM_ATTR(STATUS),
@@ -227,6 +235,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
 	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
 	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
+	POWER_SUPPLY_ENUM_ATTR(LOAD_SWITCH),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a01..eff5de03fd2ab 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -100,6 +100,14 @@ enum {
 	POWER_SUPPLY_SCOPE_DEVICE,
 };
 
+enum {
+	POWER_SUPPLY_LOAD_SWITCH_UNKNOWN = 0,
+	POWER_SUPPLY_LOAD_SWITCH_ON,
+	POWER_SUPPLY_LOAD_SWITCH_OFF,
+	POWER_SUPPLY_LOAD_SWITCH_STANDBY,
+	POWER_SUPPLY_LOAD_SWITCH_SHIP,
+};
+
 enum power_supply_property {
 	/* Properties of type `int' */
 	POWER_SUPPLY_PROP_STATUS = 0,
@@ -178,6 +186,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
-- 
2.43.0

