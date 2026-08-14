Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420343BD651;
	Fri, 14 Aug 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716455; cv=fail; b=rXhc1XXNOUHaqML6HQygF96KXzbHa8zx6MLpnh2hNeudf3fzz5MCSDtlCmB1qjyizYXMbkP1yA1N44OvTeRGllLSbPe5V8p1bIdE6OgvPwksN/DTwy6r2wGpEfkUJ4PjZRLcb3XtedC0BJPkgA2ynBTidQE9lGpV4nTa3sN80q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716455; c=relaxed/simple;
	bh=lY65m8at4YxPc60e/krAVpWZ+ptdXbUMFuVTVenVA9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jVGZUY0QL77Bsgq9DzJH0x1HPOlfoqd186dTVA3hSoRlrBRdf6nqeJog/G9sv8QGDo6pqvT8UtyID6//DZZVRUsQlkK5rFD/jlDHuNq58wubqdla5as7JI2iBOGYYrTlBOM5IsQDa/HmeVZ0DZH1VUDz8YxSiBlUvzyhPGjo6A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Lb7hQQQk; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Lb7hQQQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoyB6sMJT7ismM43+PvBxNRnhhWQR1NQzVgac3IqBkLQNW6pUYncg/dtkP5PGShlSRGG4OlYrN43RwaQBdWJIJZ5F4rLs9hygWKfzfLRNA3spUDSvrjluGxF/v/8CeFiTT++/RiSsvKYBJKfdeynONEg+zWyg+9hbUOsz+UAi7/UO3lpfd0OIhk9+9N9fjNSggWPGKFJ1ak/GcogkBkIo70WQ/X6DCJQfAhwqgbkrBXGu8fJ7S9nLgh+9EG8rKLbOXOj4PUICiLDv0M8X7M8rKyblGiPrLx6TvbTZqvfMN1ZjI3+p2qxx/xWdLT6VDxqCe+Xo4xsJ7Sew2+YbeuSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF4zwO7wkrD54NZKspClKUelcZxlk+npdDCcgOYabbw=;
 b=JyG2lD39KdFv3m+x5KmtQ1yUSOVjVhwCx7gsm9Z0llMCHdwghcEDhQUBf1C4BVGAkWRcuhgc192dmM1aU0RvnN7Fz7J9DOWS7iJlWp4k9kg/8o6rK4VtrWJPCM075YhkdCcaiKuRQFLESQr62/MlCmbp4ZRea+YnOHKdRP7djd3CBWmaoalriKVgWUGldgdB9v/g+POSUcVvclV0vY2vr1H5EhioH+e9RA6EO2x6WByRln5t1haUanDNqa1MyR7aSQVGfvnom1TJ4sTu7qXrkSqpXve3HqaS4tvk6buW1//ToCgovSWT8dyK9+d9T0CIxYiAUnI4yObfGyHtTn89Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF4zwO7wkrD54NZKspClKUelcZxlk+npdDCcgOYabbw=;
 b=Lb7hQQQkuU5KHabwsYeU+uK+VXJKz8Klrm5Vio5O67iqZZw5bv4OXKGY0bO71pjbY1krPacFa5I7eRhzy2ttMkl+FWudgpznMZr9aMd3XBP6XBusYHL/HuU47yN8/an2EyDP5ZIC47fSaeJ0pYNU+hjMZ12cvpOFdQ3T1uWUgvY=
Received: from AS4P189CA0059.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::29)
 by AS2PR02MB9740.eurprd02.prod.outlook.com (2603:10a6:20b:60c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 14:07:20 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:20b:659:cafe::52) by AS4P189CA0059.outlook.office365.com
 (2603:10a6:20b:659::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 14:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 14:07:20 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 14 Aug
 2026 16:07:20 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 14 Aug 2026 16:07:20 +0200
Received: from pc66590-2605.se.axis.com (pc66590-2605.se.axis.com [10.92.98.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 08075235F;
	Fri, 14 Aug 2026 16:07:20 +0200 (CEST)
Received: by pc66590-2605.se.axis.com (Postfix, from userid 17939)
	id 05F29848DC0; Fri, 14 Aug 2026 16:07:20 +0200 (CEST)
From: Alexander Svarvare <alexander.svarvare@axis.com>
Date: Fri, 14 Aug 2026 16:05:58 +0200
Subject: [PATCH] power: supply: bq27xxx: add model name support for
 bq27z561
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260814-alexander-laddchip-patch-v1-1-1624d6725108@axis.com>
X-B4-Tracking: v=1; b=H4sIAMUgf2oC/43NzW7CMBAE4FdBPuMq/ondcOp7VBzW6zVxBUlkh
 yhVlHdvTA8gDojjSDPfLCxTipTZYbewRFPMse+2IPY7hi10J+LRb5nJSprKyJrDmWboPCV+Bu+
 xjQMfYMSWa1ebOjSfWqNj23xIFOJ8o7+P/zlf3Q/hWLzSaGMe+/R7+55k6b1xM0kueFVbEZy2h
 tB/wRzzB/YXVl4mdXdsZV84anMU2eCb4IRA9+ToB0eqF44uDqjGGgugER6cdV3/AC+coB1hAQA
 A
X-Change-ID: 20260625-alexander-laddchip-patch-4b565f9844cb
To: Sebastian Reichel <sre@kernel.org>, =?utf-8?q?Pali_Roh=C3=A1r?=
	<pali@kernel.org>
CC: Waqar Hameed <waqar.hameed@axis.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, Alexander Svarvare <alexander.svarvare@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786716440; l=8037;
 i=alexander.svarvare@axis.com; s=20260623; h=from:subject:message-id;
 bh=lY65m8at4YxPc60e/krAVpWZ+ptdXbUMFuVTVenVA9k=;
 b=SS/JOC4II7hnTqFcrpenlfA1CINMg9HTxBIAsV7CPy36gKNqtEdfPnq4vvwN1YDOMm5K3vlsU
 bSyuKLRfpdXASYppywjNWOpSZ3XJ25TDt/JunlqFw703fzXSrZCE4Ex
X-Developer-Key: i=alexander.svarvare@axis.com; a=ed25519;
 pk=Eb0yCULm/ZrhwBZLkGKX7rzFLeRbXb1kjPwdlQIy/4Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|AS2PR02MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f66625b-7d89-4ce4-521a-08defa0d5b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|11063799006|5023799004|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NPQvTpNC7t4MuOpf8qRmuoH6tzatHI1jSN4Mv2MRz+2otHibHq5dz5OvK/tl9Pz4BwPKtS0ypNLkFyUy0wh1gUorrVn/tL+ummP+9mvvHeO7FXtDc+bS238VJtNSKw4lTwV20ZeU1L3qnl9Iwc7CIbHN4t+1r3xogkz/N3zc1U4mwloLhC4zWxQ01vQgxeHYrGc49+wCvNw3eUnc1BhErBxixN99PIIjhdixnbxtv0zbrDtUcacVWmOScUIfdtAAyBNhvxQTikPouoHOMW8PXXqXGWEgbXgAjuOLRPnpaw1D45xx0H0wX4cDQY9Lvu2nn4sRawfbOwCc+rJSANzCbLVGJWdGBy1p5hKyF5w5ZMzMk+P01ksEcJVH0pZ5CO1S+t0SKxxB6OYKBuqqk5zIc2FEhrmZxy0carn5og1bOYAWc96ieyylm7MU9D+B2ytGuuvfU/xG89/a6P/zyQx3i43EDoxAW/s7j1EGuil/qo84k5e//Afp3goMVaDOFcEiB1tfP5HZPOkVdLT2rqGqw0FwP4n2ZEYUlCe3ZLdIYXgvuZ/W3bB1VAAVvKDFgkgUqqSA24Hk0TG+hwyf6C651dODtp9ZuW4QvSamzea6IG9+/fF4v3gLUN9W3lDR+E4dHbB2ccQsFmScrjYy9bAw0AlafmOU/JAMB+Rmehg4df7EleFTDNKkRL+kT8a0BeApww6pJmGPlva2QrYq71ausQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6u5yFXTcYhI1cgLCG+JPxp1q1EYfTnrFo/vPPFB2OiT5zB9snBQnfn7b0KeCotzYMvO7qHifdNDLiupdsHdtqv/rqvzmClwB2ivJA3jv2z9ub6otuRpOjzPEWb5D5EDqaC2OaLnodN8HZWYeSBmUmnLr2kgO9Xm5cr/WFIGbpfd/r+RSg6iWx741o9hBH4ig6BQn53f0lATAsksKFr8tviGMA0on7gNuwPg1ZHWf3ZG+x4qX/fWlY4w0AW+TESd1NkEy57wXeZ+0csn8Krn9dFoRheWJ02gXZaz9ufQa9cn/0S+OU8KFs0wqVmYFYE6/3hk3R4uwonla2rQIolA3BUIe3iyxL+L8fsH8aeO6S5s4ZnK5INGruSbs+PmCNweEynBd3MTv6dTV/ahdWNHA+oziXEeOgqaMny7NuGJYL0gAPXhaAhL2urt7AWz0Dhc
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:07:20.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66625b-7d89-4ce4-521a-08defa0d5b33
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9740

The bq27z561 fuel gauge can report its device name via the
AltManufacturerAccess() (MAC) command 0x004A. Expose this information
through the POWER_SUPPLY_PROP_MODEL_NAME property.

This allows userspace charge-management daemons to make more intelligent
decisions by being able to map battery pack to datasheet and infer
additional useful battery characteristics.

Other power_supply properties can be provided through
AltManufacturerAccess(), so implement an interface. Make it
modular/flexible since for other chips, the same MAC-command
for retrieving a property may have a different numerical value.

Serialize the complete MAC write-delay-read transaction for concurrency
safety, preventing another command from replacing the pending response
during the required delay. Keep dedicated per-device storage for the model
name to preserve the returned pointer’s lifetime.

Hardware-tested on BQ27Z561 using a backport to the product kernel.
The model_name property returned the expected value.

Signed-off-by: Alexander Svarvare <alexander.svarvare@axis.com>
---
bq27xxx fuel gauges (FGs) provide most of power_supply properties by basic
register reads. For the remaining properties, they can be read by writing a
command to a buffer AltManufacturerAccess() and reading the result from
another buffer MACData().

Since the release of bq27z561, six bq27xxx 1-cell FGs have been released. 
Three support reading the model_name in the same way as bq27z561 while five
provide properties supported by power_supply.h through
AltManufacturerAccess(). In addition, five specify the return string as 
2 bytes echo of the MAC command followed by the string. This format has 
therefore been hardcoded.

*Some* properties (varies) provided in this manner which are supported in
power_supply.h are:
model_name, manufacturer, serial_number, manufacture day/month/year
---
 drivers/power/supply/bq27xxx_battery.c | 95 ++++++++++++++++++++++++++++++++--
 include/linux/power/bq27xxx_battery.h  |  5 ++
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 45f0e39b8c2d..2a24eaf1aecb 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -93,6 +93,9 @@
 
 #define INVALID_REG_ADDR	0xff
 
+/* SMBus block transfers are limited to 32 bytes. */
+#define BQ27XXX_DATA_BLOCK_LEN   32
+
 /*
  * bq27xxx_reg_index - Register names
  *
@@ -833,6 +836,7 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
@@ -1010,16 +1014,39 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
-	.unseal_key = key,			\
+	.unseal_key = (key),			\
+	.cmds = &bq27xxx_no_cmds,		\
+	.regs  = ref##_regs,			\
+	.dm_regs = ref##_dm_regs,		\
+	.props = ref##_props,			\
+	.props_size = ARRAY_SIZE(ref##_props),  }
+
+#define BQ27XXX_CMDS(ref, key, opt, cptr) {	\
+	.opts = (opt),				\
+	.unseal_key = (key),			\
+	.cmds = (cptr),				\
 	.regs  = ref##_regs,			\
 	.dm_regs = ref##_dm_regs,		\
 	.props = ref##_props,			\
-	.props_size = ARRAY_SIZE(ref##_props) }
+	.props_size = ARRAY_SIZE(ref##_props),  }
+
+struct bq27xxx_cmds {
+	u16 model_name_cmd;
+};
+
+static const struct bq27xxx_cmds bq27xxx_no_cmds = {
+	.model_name_cmd = 0,
+};
+
+static const struct bq27xxx_cmds bq27z561_cmds = {
+	.model_name_cmd = 0x004A,
+};
 
 static struct {
 	u32 opts;
 	u32 unseal_key;
 	u8 *regs;
+	const struct bq27xxx_cmds *cmds;
 	struct bq27xxx_dm_reg *dm_regs;
 	enum power_supply_property *props;
 	size_t props_size;
@@ -1051,7 +1078,7 @@ static struct {
 	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
-	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
+	[BQ27Z561]  = BQ27XXX_CMDS(bq27z561,  0         , BQ27Z561_O_BITS, &bq27z561_cmds),
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
@@ -1220,6 +1247,60 @@ static inline int bq27xxx_write_block(struct bq27xxx_device_info *di, int reg_in
 	return ret;
 }
 
+static int bq27xxx_mac_read_string(struct bq27xxx_device_info *di, u16 cmd,
+				   char *name_buffer, u8 buf_len)
+{
+	u8 mac_data[BQ27XXX_DATA_BLOCK_LEN + 1];
+	int ret;
+
+	if (!buf_len)
+		return -EINVAL;
+
+	/* Serialize the complete MAC command-response transaction. */
+	guard(mutex)(&di->lock);
+
+	ret = bq27xxx_write(di, BQ27XXX_REG_CTRL, cmd, false);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to issue MAC command: %d\n", ret);
+		return ret;
+	}
+
+	/* 66-us AltManufacturerAccess() wait time, use 1 ms guard */
+	BQ27XXX_MSLEEP(1);
+
+	ret = bq27xxx_read_block(di, BQ27XXX_DM_CLASS, mac_data,
+				 BQ27XXX_DATA_BLOCK_LEN);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read MAC data block: %d\n", ret);
+		return ret;
+	}
+
+	if (mac_data[0] != (cmd & 0xff) ||
+	    mac_data[1] != (cmd >> 8))
+		return -EPROTO;
+
+	if (!mac_data[2])
+		return -ENODATA;
+
+	mac_data[BQ27XXX_DATA_BLOCK_LEN] = '\0';
+	ret = strscpy(name_buffer, &mac_data[2], buf_len);
+
+	if (ret < 0) {
+		dev_err(di->dev, "failed to copy MAC string: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bq27xxx_get_model_name(struct bq27xxx_device_info *di, char *name, u8 len)
+{
+	if (!di->cmds || !di->cmds->model_name_cmd)
+		return -EINVAL;
+
+	return bq27xxx_mac_read_string(di, di->cmds->model_name_cmd, name, len);
+}
+
 static int bq27xxx_battery_seal(struct bq27xxx_device_info *di)
 {
 	int ret;
@@ -2206,6 +2287,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = bq27xxx_battery_read_health(di, val);
 		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		ret = bq27xxx_get_model_name(di, di->model_name_buf, sizeof(di->model_name_buf));
+		if (ret < 0)
+			break;
+
+		val->strval = di->model_name_buf;
+		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ27XXX_MANUFACTURER;
 		break;
@@ -2243,6 +2331,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
 	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
 	di->opts       = bq27xxx_chip_data[di->chip].opts;
+	di->cmds       = bq27xxx_chip_data[di->chip].cmds;
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index d56e1276aafe..009ccdd6395a 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -4,6 +4,9 @@
 
 #include <linux/power_supply.h>
 
+/* S21 Device Name holds up to 20 characters; reserve one byte for NUL. */
+#define BQ27XXX_STR_BUF_LEN      21
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
@@ -58,6 +61,8 @@ struct bq27xxx_device_info {
 	const char *name;
 	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
+	const struct bq27xxx_cmds *cmds;
+	char model_name_buf[BQ27XXX_STR_BUF_LEN];
 	struct bq27xxx_access_methods bus;
 	struct bq27xxx_reg_cache cache;
 	int charge_design_full;

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260625-alexander-laddchip-patch-4b565f9844cb

Best regards,
--  
Alexander Svarvare <alexander.svarvare@axis.com>

