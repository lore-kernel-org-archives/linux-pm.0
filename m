Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037893AD52F;
	Tue,  1 Sep 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291319; cv=fail; b=Vg7YQMDz+SQYrGu5h/ypytRAv0F016dGYUdbknlnPBn7V+fSG5YGakEA5unHwhhH6ZAjl9m7Y4klpSrPuSqX4nbQCWCqWS9sOFynN0xgBb/Q3GgKn2SH9kmsNqbPA3dSvso3iU3Gg6JgQLkje5bl0MYEi3PtiqZRIe+cs5YoefA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291319; c=relaxed/simple;
	bh=IWwpAXcN35768jxv8+620KOWq8693rXAtqcZTy8OCwQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=IkLTipTbN0E9cIGfEfFVIm8upVQuOs3mnaLUeqotgN0j2ihgolRBZiz1C62Woj24Px/f1QJlhUCQH1CH0TUumeVKQt5lFEn2zNtvrf0SSPj8Rl4h1TDigzt7KiSE6nv/wy5xGdQsKeH/eaq9BC47wT2e3LRpRttTToj7kbDgRvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Yj7mFI2I; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Yj7mFI2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS8kL1NRz4kHt6kXPX7HxC/bJzLkId7t23ezdagVDtV2GuvbvZXTx9WwCX1cBNwNmt+zsSY88gdllPnbUuV8RAhTqsZJHf77Nx7K59dbxcm5E1yBkw+CCtxroIsWlFLMAJL2SHiyUlrZeMHTBSYllUfqAGZ858xfWFyo8QyhsM4Q27ye6PQpLv935TIlcEWNf6ZEBgh7sNrwL4U16VXIpK9gXtQAxrYxoaZWmXTU1ZdJPPldlTa9KwsN2lB0W+RgJDPD/NsIUpHem8zhpUk89QUKd3jjUl8TzkSRdaAV3uCIggosUWAlaAo2ND8OoquHXeFeqVaNoWwvbtTMDqFEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3auX8yZcFl09pPamyNmWrviWbpPUz7wY9K3Wgy2Z3hg=;
 b=n/QpbKKRGtbJphUzyl0In9X8nlV+JZ1ob8olJVdl8BjqpJYapvx2rgEBZ6dnVXzjSntFwO0QvjDz879ebIejL+FgCAiopvw4fJXlo9iY/3KMSv6w/Q20bi2MPmbgN86T2eyi0ghA04gRRvyniNo7eXkDlqyLXhxpi6afT6Ttl4t07rvds9DSiikjP5KHM+PTd4pSGV3nOpZCBVVmsnZgxCNFSYc+usqOwh3r8CuDEOlCl6ZacGw+PoKBX8E8/F4WUZruIc8q2qYCpOdaEhJBsdB6E6JAo5UEpdjwyBLLixSbgvazq4dvwazAQ7u051qyUZGqGW4yWVUS29vw4ULyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3auX8yZcFl09pPamyNmWrviWbpPUz7wY9K3Wgy2Z3hg=;
 b=Yj7mFI2IPH9GoT578HoJmx+1pBxLp6hfh3kh4+BqMC9pSV2NtTHloxjOBaaiXNCh+ahFPu/cjXYIxv2wIa8ST3DrHi+786g97sXvj4v7tEk6yJLrEKPitq8s945bjFjHcI2bkUCcJBypxmtcQrliQ2kJPLST9fdTpLlCTOwt2mw=
Received: from AM0P309CA0013.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::34)
 by AM7PR02MB6401.eurprd02.prod.outlook.com (2603:10a6:20b:1b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:35:09 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::6b) by AM0P309CA0013.outlook.office365.com
 (2603:10a6:20b:28f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:35:09 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 21:35:08 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/8] power: supply: Add sysfs entry for system load control
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <d86f528de9a058091f806d9676639239cfeaf805.1788290289.git.waqar.hameed@axis.com>
Date: Tue, 1 Sep 2026 21:35:08 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM7PR02MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e5d682-d0b5-4612-1a1f-08df0860226f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	IhXgifDikq2+2Aqs+0qaaBOKcdCDqLR5UuhNRc8P+KvRftfR2tESNDRccvGU8oZvLRLH3rDAfm8hT3gDHwvz05S73had0eri6zPRFKwk2DN6qVYoL+veAqNwnvQQkOw5QgcNTYATqgR8btt/OvLR5z8mqaxJxo+1QK+0X3w/qM0IQewfvBMGUUf4Pwrc6nSubCBvNJDYIBZfoE1r3AlXdMeWKlEvmSQ1GrGwi9tenKmGHNioGowalgt3MDFWVwxJsRz5xAsmlNQ1PaUpLrp21b2V+cj+ddvQ5LkHlE9kleabxYaZQgrLk8dbqf+rUT+YlVdgYDmXlfOQIDTj58GsC/f/SrhnPwluYyXoXz/ZFnvDT4pk+ziSRHPpY4rmD+sYDIwrftoZbDMpMnCXS9mr7WlooRaFoPa9HcLsYBZQ+LH8CPACeAwS6vdtffh2AcQ+Ckq45U4/p59JM4LfS4alP6guNDRnyR4smZ22UCX4Fm9dvHMpfxIrPVh0GN9nl8Ek1TAvdY5MpQRHLirD+irTJBNk5RHeFL0lg31zfk2US02p6TF+ima8LTKxReH6owxigKpaHW2LULWa+9uNuk4VtPKcfGGEAg/gOLMNoBVdx+C4pZzlmnX593pDB1NvgxbEBM3zKgVohrZQleIdFnvc1/y/es5GjBSU/DBc139JsMs3cvwTf0r9vvj7J9+NwKDLaMe4uizhFiuSKJTM8dQ7PA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i8aXKliO+nEcoYn0i7+1iIE3K5/fpYwsoWgbDr5rhHbrQnsXWXw5YyZPP+IZNLEIw+7k4aJW+FxhRR9lPJrj+FRg74LCCmYNNYJu2XNPgl2w1AwmSB5hF4TYXZxzh5YYtyhpqQvCcL9TlY2JPgazRCZfnWl/cfwSLJ+vkAOWlzoLnDwEKtA8uCsL/Qq0KLvoFXEvO1o0CqPhgbn1lnBlXONbg/ny/xHIWAP8KHOpFr6tTw0HNFfrLIqXZetxLiR1ZpU0ubxFTSsay5cQ4RE0nqRIM9iowQQmxqw+lmNdRuFoutxCwg3zRmQGN4e2ObxMg8W4/eamg0M7ha1w1X/2Z5QS6sDTJl0jMRg1TCC+5lu1I5VgpPgbGV0Ib0ebZtFCt6sRFGWBaq2IQQ9Jn0n+xGZJcGBOxC/acFVYQO3aiva6ogQFH1jDxNW50e2Hs8HI
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:35:09.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e5d682-d0b5-4612-1a1f-08df0860226f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6401

There are devices that can control the connection from power to system
load. For example, with a field-effect transistor between a battery and
the system load (BATFET). Drivers for these devices are currently
enrolling their own custom `sysfs` property to control this.

In order to unify this, add a new `sysfs` entry for controlling such
switch and corresponding `power_supply_property` with `enum` values. The
obvious states are "on" and "off", i.e. there is a connection or not,
respectively. However, many devices can also enter special modes such as
"low-power", "shipping" or "deep sleep".

Since the members in `struct power_supply_desc` already are ordered,
adding `load_switches` only increases the size with 4 bytes, as can be
seen from `pahole`:

  struct power_supply_desc {
          const char  *              name;                 /*     0     4 */
          enum power_supply_type     type;                 /*     4     4 */
          u32                        charge_types;         /*     8     4 */
          u32                        usb_types;            /*    12     4 */
          u32                        load_switches;        /*    16     4 */
          const enum power_supply_property  * properties;  /*    20     4 */
          size_t                     num_properties;       /*    24     4 */
          int                        (*get_property)(...); /*    28     4 */
          int                        (*set_property)(...); /*    32     4 */
          int                        (*property_is_writeable)(...);  /*    36     4 */
          void                       (*external_power_changed)(...); /*    40     4 */
          int                        (*init)(struct power_supply *); /*    44     4 */
          int                        use_for_apm;          /*    48     4 */
          bool                       no_thermal;           /*    52     1 */
          u8                         charge_behaviours;    /*    53     1 */

          /* size: 56, cachelines: 1, members: 15 */
          /* padding: 2 */
          /* last cacheline: 56 bytes */
  };

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power | 25 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   | 17 ++++++++++++++
 include/linux/power_supply.h                | 10 +++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5641f1fd5fd6f..93f2398125d88 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -590,6 +590,31 @@ Description:
 
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
+		"Unknown" (0) Unknown mode.
+		"On"      (1) Power is connected to the load.
+		"Off"     (2) Power is disconnected to the load.
+		"Standby" (3) Low-power mode.
+		"Ship"    (4) Ship mode.
+		============= ==================================
+
 **USB Properties**
 
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 9d6b24856c8b0..b0f524d152cf6 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -152,6 +152,14 @@ static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
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
@@ -231,6 +239,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
 	POWER_SUPPLY_ATTR(INTERNAL_RESISTANCE),
 	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
+	POWER_SUPPLY_ENUM_ATTR(LOAD_SWITCH),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(MODEL_NAME),
 	POWER_SUPPLY_ATTR(MANUFACTURER),
@@ -400,6 +409,14 @@ static ssize_t power_supply_format_property(struct device *dev,
 		ret = power_supply_show_charge_types(dev, psy,
 						     value.intval, buf);
 		break;
+	case POWER_SUPPLY_PROP_LOAD_SWITCH:
+		if (uevent) /* no possible values in uevents */
+			goto default_format;
+		ret = power_supply_show_enum_with_available(
+			dev, POWER_SUPPLY_LOAD_SWITCH_TEXT,
+			ARRAY_SIZE(POWER_SUPPLY_LOAD_SWITCH_TEXT),
+			psy->desc->load_switches, value.intval, buf);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index fcd05f4a88833..f6cbeffda6534 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -104,6 +104,14 @@ enum {
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
@@ -182,6 +190,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
+	POWER_SUPPLY_PROP_LOAD_SWITCH,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
@@ -261,6 +270,7 @@ struct power_supply_desc {
 	enum power_supply_type type;
 	u32 charge_types;
 	u32 usb_types;
+	u32 load_switches;
 	const enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
2.43.0

