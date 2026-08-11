Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89343DA50;
	Tue, 11 Aug 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448892; cv=fail; b=T4qsOx5KVXaA9aYQQSDwsZmSgui3wy3pshyaSFoJiZudqp0D2CvVhscTuPNrJP7ygq4lFr1fv7eRIsKF3A8zXn6FIRj8eVhvqHdc+m55a76aBPD4UiEGsP4DhA2N/b/bJWkMA4+XHV0Yq4oAGm2KYr3GuxuHhtksjzjhoc7K2AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448892; c=relaxed/simple;
	bh=237/Z5yTkI/ngUm/OxRpWwlolKUuzRFb3IGO+UF15S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M6wBmS9vuOC8Epx2odMjLWg2gjbEwlIOed8kMcfv5h2wsePnogbqLamS9kVhOykCHvolNcJvn4ttSplVR7gpbFkDOETPIN1F+SykbMjF/o/gREPYvd4FC8131strhpZWwfx7UFXCRD5sHXGEKBLUftKc2uqIKZRDu1QoteVMtDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dBsS/0Al; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dBsS/0Al"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqDedS8H9mrhYXZFcUmsesleeIt6FbpQC4x+C9tPZ9aciwz1kwRrFIYrnQlUpL7jV8YXmRzEvk/qZec4HPW8vVEcVMgxSMEc8WLqrmNw8L4WKEeba4vuuewWPnky/P/HFgQZfS6kVrVifSnj226H9v81GtUdYwTH/WnBk4xFrXKfrA1oZJRK/ub9i5Hdn0Iv6VKTiVmcLjv9RpnBDK5tPAJ1/zBGEJ5dYqbBtAKmHxK4cDVNgPb08P7mnGdu3JJ1FwK3hrjw6MacUXcIZ1LyuGu7NgKrQiMQn6cH2NJpqX0hiKtOT9VPR0ytGBN6WOaVLx1gcfHzXZKNniTp6lKXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9vAA+aBaW9pkspuuuCTF7Jm6c7RWIqc2G6128yAEM0=;
 b=kF0kRxYTCI0X7HCKK25Tjllo9WEypFFJ5p2YP5zxio+iCFZbMUSKuNMKrmiPaMyfAY6N60Y8wDYOSDWDiTRWArm6kNaHjGOZJqJ4Ub2pEzheWKqAXT72FP1wTXZzYtwdK3i9uqO0/6KkIRl/CoLS+8T+2LJL9DS39EMgZz5lDpUMwm0tzkJTjquPEo9HdFgqKVxIEjr98e5YmkHrDAEYnzNH6R6dXDe8tMLiVJsXocCIMG4qBbxur0up4A+5PsXnpT9y6aC1U7RD0krGHBpEG8+3hrwsQEPvxXh1poiVo8vWFGnw8zIeKYqS7JgMPvMyLgLqh9ADQpJt3s7oC0L2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=collabora.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9vAA+aBaW9pkspuuuCTF7Jm6c7RWIqc2G6128yAEM0=;
 b=dBsS/0Alw6V9nncJXN6hNEKUqIqy5FDhCQWCuCiS/oIDsKV7pCabV+2+vzY2OoZezNGM7cKvyCbVI259drT91rFrJ4XC18m8hk/inIs6TokU5mwYbf2zz5uyhrUqkriBdmkMBtJiGMBJ65BCpTcIF/h2eHHhy4y6NlogJhOtaOw=
Received: from AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27)
 by DB9PR02MB6636.eurprd02.prod.outlook.com (2603:10a6:10:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 11:48:06 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::49) by AM0P190CA0017.outlook.office365.com
 (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 11:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 11:48:06 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 11 Aug
 2026 13:48:03 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 11 Aug 2026 13:48:03 +0200
Received: from lap5cd525d1j1.sto.se.axis.com (dh-10-133-4-142.sto.se.axis.com [10.133.4.142])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 695272162;
	Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
Received: by lap5cd525d1j1.sto.se.axis.com (Postfix, from userid 22105)
	id 4BB60806C63F; Tue, 11 Aug 2026 13:48:03 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Tue, 11 Aug 2026 13:47:44 +0200
Subject: [PATCH 2/5] power: supply: bq27xxx: add support for bq27z746
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260811-bq27z746-v1-2-3a4fa38205cc@axis.com>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
In-Reply-To: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Andrew F. Davis"
	<afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Dan Murphy <dmurphy@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, <kernel@axis.com>, Henrik Grimler
	<henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=237/Z5yTkI/ngUm/OxRpWwlolKUuzRFb3IGO+UF15S8=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqewvn+SfCnsjFk7YoINdrOnn5OxCj16ooNeArQ
 ze5ruuB2qCJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCansL5wAKCRCwB25JC3Fh
 a3GIB/9qTeFzdqxI6c9ukzAVljwodHuTAcuzHvrDQjJOGR4posMLClLydg6fZJq8/PsxawwTkFr
 xFw26HyrTWgjsVIi7C/SRx8h4ZXyxWf1cpqQXg1hvBJFO7n0xGFUjtEFYl3xugmWlLC7fsYnBGV
 G7C+gquq08wWUjuaX/hrB+YL8OC85zwkXfojgMMqnaWN/BdAaLxM2UPHXI9pkqUYi+qmm6SNO0k
 mNB4wyv8QcTLZODisoaSOfsqHsuSk5xzWdgiKVAEad5ET+PuFdt1Vg4rtzHy3V5ogT1fjqCT+NI
 SSrZX1P+3L4J5vfxfxQED30T0RDUQgGxd8j1AUo9yOMmbZ61
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|DB9PR02MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f56d0f-71ce-49c2-0245-08def79e68a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|13003099007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zHJnd4xqkD8xHefeEmm0ZEQr3IPTtc283H2pL+bRDQaJsxu+F65yMTk3tUVwPHgaPFW7YlHx75BqbHtSgj+FSKWl08SeePfHQ/s0z9GW7OMwxMorwdtPPOhhwd8LHjgaUhj9aiCQp6iF82UllLhMyNnDUN9Ly2gFI7VE+7FZ3NFZcREWRx93GotqYoNZTLlmKKdr5x0ADTDUCT3YyDbayMK2+wssCrCoImPEqYc1JfdBG3nGPbIxEpeXjcnUyUUvyJSSvIDlweyWM9zPBJcqNUDn4e0ZnWmfcddT+lA7QTz3w9Lp/0M03ZC7fb3Ymis1P6Pn/Qk6UU+afLZgGpFnDztsBC38Xx2dxxBofiA36ZKch2jlH1Xn3hE7gaMnaU/NtfJ4o/wjYlrR5It8temunc67PtiXCBwkf5XsapiYDiGt9Df8N4xoXWMukd13fhsgw96FJ8OQgvluiY6ORiW+Dm0DkWRqj61sgK7QjoMngNUinEvOA4jmwEIqOtQNCMe/fGvKj05jGbdH6ljYV/65OV3Z6YTSwsicBcnN7vaEUMQQWlDRTZ3a+jWWNc2a8ZtszpLudpkcS3TdelKVH91LXVRTzajHncZIgKRBrctqdIpYRo/lyjjhAjS3/Mixg7WF4G3jeZRNgG9SRZARmYoWXt9YYKeK+UILlSkD7yPtoq9vdMcAuAoqOuGdN27xdC4xJlqFuzFRXHu7CgJPE8sZ6w==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6QDvaPNQa21kKoikE7sU5nAkzS5R3Pfoma6Ny2ym2cOl/UIVYU+iMYd0+inWwpV8V9996no2K6FEwvtfVypaCwcIH9hAXQMsvPd/RixKgVx92xrqBIGAUNMhNiHgH30UX380l+lw9jnLl8zAev/cc29/EgzolVm//M4tCasBtjuFwpv2Brg4TQU35Q/qouEJHdwvVJOE7Nzk+0NH7GiSPwTNWUg9N1Qw0o5yX/ByLyJyaydbgUta8aHrzhreZAnrswdxJZXtYdxTjI+q4yBfVc7hkxb6W/2uRwniYBagUZRC1JxqOm1DMyjBjnUzQA3LiBxnyMesbSkn1dcNbD91WOWoRZ2EhUttEtJS1Q5QsEs2r0wyCDYoFqaLjISqYdBZapc4LLZTDTePby0Udk1iDqUINsXiT/OtZSr/6dbG8R9OmVpEgfvBFIqXk2nUZKmi
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:06.5274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f56d0f-71ce-49c2-0245-08def79e68a4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6636

bq27z746 is similar to bq27z561, but has additional battery protection
functionality. The register map is largely the same, with deviations
only among the AltManufacturerAccess() registers.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 6 ++++++
 drivers/power/supply/bq27xxx_battery_i2c.c | 2 ++
 include/linux/power/bq27xxx_battery.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 45f0e39b8c2d..be3ca4b76c80 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -37,6 +37,7 @@
  * https://www.ti.com/product/bq27441-g1
  * https://www.ti.com/product/bq27621-g1
  * https://www.ti.com/product/bq27z561
+ * https://www.ti.com/product/bq27z746
  * https://www.ti.com/product/bq28z610
  * https://www.ti.com/product/bq34z100-g1
  * https://www.ti.com/product/bq78z100
@@ -501,6 +502,7 @@ static u8
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
 	},
+#define bq27z746_regs bq27z561_regs
 	bq28z610_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -836,6 +838,8 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+#define bq27z746_props bq27z561_props
+
 static enum power_supply_property bq28z610_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -994,6 +998,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #endif
 
 #define bq27z561_dm_regs NULL
+#define bq27z746_dm_regs NULL
 #define bq28z610_dm_regs NULL
 #define bq34z100_dm_regs NULL
 #define bq78z100_dm_regs NULL
@@ -1052,6 +1057,7 @@ static struct {
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
+	[BQ27Z746]  = BQ27XXX_DATA(bq27z746,  0         , BQ27Z561_O_BITS),
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index c4e7a9521d08..2a6b4534cb28 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -253,6 +253,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ .name = "bq27441", .driver_data = BQ27441 },
 	{ .name = "bq27621", .driver_data = BQ27621 },
 	{ .name = "bq27z561", .driver_data = BQ27Z561 },
+	{ .name = "bq27z746", .driver_data = BQ27Z746 },
 	{ .name = "bq28z610", .driver_data = BQ28Z610 },
 	{ .name = "bq34z100", .driver_data = BQ34Z100 },
 	{ .name = "bq78z100", .driver_data = BQ78Z100 },
@@ -290,6 +291,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27441" },
 	{ .compatible = "ti,bq27621" },
 	{ .compatible = "ti,bq27z561" },
+	{ .compatible = "ti,bq27z746" },
 	{ .compatible = "ti,bq28z610" },
 	{ .compatible = "ti,bq34z100" },
 	{ .compatible = "ti,bq78z100" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index d56e1276aafe..0b833c4bb583 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,7 @@ enum bq27xxx_chip {
 	BQ27441,
 	BQ27621,
 	BQ27Z561,
+	BQ27Z746,
 	BQ28Z610,
 	BQ34Z100,
 	BQ78Z100,

-- 
2.43.0

