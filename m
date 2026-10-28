Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224580;
	b=w7G5dJD4erEFu3y2EAKcEWS39p6gS8/k81fbyo0Te+O98LRnkzjqZZHNzdVoIwH4MZI/
	 iehBEnDso5lGBmYgWUR+BzPRn+OS11ci/ASdEhgmRY7rTspAvP52CZgfRBmAulazpdHv2
	 vHAf9KCxRrAVyjCtvLhOmmGFzlNo2IAFBTo33RCn4njlfZ/AhEdYmrGTZ1wHxJwU45c+z
	 d2obx5P9Xw/rQCGWYgTAGIiWG6zCoq6sUF3NG7d51h2deTcAm+iFImZDmpPZzMQ5crHBX
	 d/Kes8AyFWEaaIy18qjJONlMCoNTPP4OM9W2Y7ewuXfqwuqck0ZeHW1NPaiIsxZ5wBw==
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
	bh=QfgB8bxT2hLqXG4O5s29/JEHRFfOmO3D3XlNP5bnXTU=;
	b=bJ6P76v0Mi3vk/dqIy3hOfwQO8tEimmBeXfT7Z5hn2s5Rk8rkluQUIuekulNBv4zrRjN
	 t4bfDHNuuZJjZiN9f+asVWJ1hg4G+XuvxL8w2aI5QZUTSxZVaR8Sdlvu9Sf9HIjLlsr2s
	 GCKkN9TNfP0e4phMVp1iPNyWmkjVI9N+xhNRJV+asUT1ozxhHs8+Tqw9GGAJXqUEhUEjh
	 z8eLFXadZ1vT/YSduGSLtOwzbUToVhKMQ84r7MCZrMUmfm52y+0lBJhPo51/eP2LYvmL0
	 lTOUskUqSI1rAQGKOrXDwB/jTIBrjhEow2rfj0zgVBfdSnV0uFO4FNXn6zJLdsKqZwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Cfuo+zAt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.3
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F204606A31D;
	Wed, 28 Oct 2026 21:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F204606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Cfuo+zAt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVzfSpKFYS7utEXkAqEG67FyE1dTr1TC7SGe5EQUOMU4bDZ+UILN5IAiN1iaNbi/SwkYe9UU3Y/lrugcmdl8iyZZooxkcKCe5Ut9PCgZSapGxmgVp5PHLRs4iZ3h7KHc3MfWVlEWEMWyUlkKK4+gmxROiMDoMY5fFOAt1/3V5zcCY/kJgMDXdc/DnG3efp1VafSH57JuIUVuWCmyz8lJSsUxf91uDHRebyNo8xugdu8v1Id2wR9h9VetJNtJh+Gw4KAigWlyE6uNd3xvsVSLWsEYKFM/Qn3B2CDE1o6vBYSLUSGIKOuf4/TFSvJzq72oJITgOo+h3Kxpf2SPFA1Feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfgB8bxT2hLqXG4O5s29/JEHRFfOmO3D3XlNP5bnXTU=;
 b=GCucSNKj33EVRyFc8E8vXJ9gmA/+3GsXxxRaFqXhez2st1HsQJcm7us1Je84lTy1nbwjLFPB9lJaEnjSQLNnRCjOg4jFEyi7ecVD8169cPzKsYTsh0p0p7yCslZwFhmXylUTZsLXPN84TzVY1IXcCh94wrgImGSYFra8VHmkmjCWD3e1iZMn/366vQ5tomVIaPtnKy9gW61AWOD1vLdUN2dr2KauI7RsRMzywKg+ElwftNY9pk+d9P5Kh+HbUdu7hsYZL8dwxcoYH3zlp3OXFitvQR7iQP0gr/o90p3nmbcH5G+QjEdwnP8ol6dOeCmFfsp53BsS6DYuetHLwrCLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfgB8bxT2hLqXG4O5s29/JEHRFfOmO3D3XlNP5bnXTU=;
 b=Cfuo+zAtKxOLB+MFAxu83bnBxRPjaKnVcJO3JMA9XXlX+BXgZIHyIjuajLkqe48xCjjSEF6y5L6WaNGEHb7FcyulrqGe4/EKdfprL1rB0fB7ad5fOCrSxi/6AAlHFEzaXUC+fbA2yeQZ7TA/KpXgE4fusI2l4GuDmRc1xFD7eBQ=
Received: from DU6P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::23)
 by AS2PR02MB9552.eurprd02.prod.outlook.com (2603:10a6:20b:597::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 21:56:16 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::55) by DU6P191CA0019.outlook.office365.com
 (2603:10a6:10:540::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 21:56:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 21:56:16 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 22:56:14 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] power: supply: Add liquid detection to health property
 enum
In-Reply-To: <cover.1793223841.git.waqar.hameed@axis.com>
References: <cover.1793223841.git.waqar.hameed@axis.com>
Message-ID: <d6f5fe517760a6c54b72ae78dd460aae6f925fda.1793223841.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|AS2PR02MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: ab59f340-3331-41ec-c9fb-08df353e4abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261028144727099003|11063799006|56012099006|261009223027099003|261026140227099003|261021121427099003|261026121527099003|261021123027099003|10067099003|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VV0q7no7i+v6hePmQzD6S7I0bzeSazzf8JqyYELfiv3wPa87Miry16SK46pZec08fF2IjJ6ashfZgOuVU1MuoDOj71mSqmL5vIHcGqzusJbMHnbHi3Gyw4K1X+eMj/gnZBzoJuvQf+2ivlFsdEiFrdYkIbo7sHs8NwmhxMy3kaMxKnk6TGqy8djaeZGLHvrbAHwwgaRzYVE1gt5r3o4QR+bQ3ZeQEYqc7IFuKQ5ajITnB0uidNGg7fFwtO+b3XErrRC11La2F/yQDKEerc8WNZGms00eJwaGRh/B3uDah2cv3DZYCT2kG6kJD0ToDp1HCdvw4JmnLhCVd+iRywrt53ULRzhUCohe6UGv8JpmXqV2atycLb3TxBFxW15TS637wDG34lgO04FIInF4EKEh4L3C1oELpwAws4zjpIv15U1zugN2CGP2YxdLBzqSKL3M/yZpT9pISUZiLI45jYhSmV48/z2MR4hw7cGC9qRxP4Ci3n8jsqF1URgVowEDrfhlkq2fsj3Y4qdPackCAfZDxk8j440QGawTf003jH6sQJv0WEwcnnX5evpOKA8kxPWHjkcJFXXIB+prKBn6vRKYtAPrpArHyDDOXfhHRWfZxKmfx2hae/kdlGDqAlFZTOnsfTSOEDB8arFtYYFcOdOxEn7UKoKcsaH3BkU/6SHDfJ344jsIUZlfmZVrkA4nr7SRVvT1iVBXJaaYCbWJb3lAhQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WEl23DIigGZHSRtizBeevFWmpHDstLMOZWz0QMAOg6GFMIUBVTOA4W+S+2xmy5n1pxNgK6Zunrx7hmv8EGVYmUPfqdDCt53o5fpYx43/MKbwFPHgCvX2k5L4DY8lvny42AsrIeRo8m8Ki5/Yoz0jhEVbZMP1nkGQE9HAogdyOamUNkfDDbBWbtI6PUrTwfRs/DZMQvq15NgBECfXnuEoFZTIvq9DzdcJpxL1+TofK2PwT9WDNApEDzS4igG4JOQQ8ZhSK94X+4quUElmUauh4RleJwPIAnQKARoxodKi3a/Ri8UpCkGM78smFROnG+dnhkbSWoYGZTJqX5QkzfuS0GKrx+HZfAYX00A1y426CF+ZatvyoHHmocbNEqJKfBK5F8VzrIEzddduU5I85dcrqO4W6LBKUHThqkxzeQwpalh4mGJdkJElV+Rz+WqRgNyL
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:56:16.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59f340-3331-41ec-c9fb-08df353e4abd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9552

There are devices that can detect liquid. For example, moisture in a
port. To be able to report this state for such devices, add "liquid
detected" to the health property enum.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power | 3 ++-
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a98e6b2a75fbc..fdc6cd543c229 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -460,7 +460,8 @@ Description:
 			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
-			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbalance"
+			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbalance",
+			      "Liquid detected"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 661b42adf6efc..d851e655f8414 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -114,6 +114,7 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
 	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    = "No battery",
 	[POWER_SUPPLY_HEALTH_BLOWN_FUSE]	    = "Blown fuse",
 	[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]	    = "Cell imbalance",
+	[POWER_SUPPLY_HEALTH_LIQUID_DETECTED]	    = "Liquid detected",
 };
 
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8e5bbdfebe794..7fbc0b80bcbb6 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -73,6 +73,7 @@ enum {
 	POWER_SUPPLY_HEALTH_NO_BATTERY,
 	POWER_SUPPLY_HEALTH_BLOWN_FUSE,
 	POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
+	POWER_SUPPLY_HEALTH_LIQUID_DETECTED,
 };
 
 enum {
-- 
2.43.0

