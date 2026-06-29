Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF73F787F;
	Mon, 29 Jun 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747911; cv=fail; b=oecXIvTrL1gV1bbrhhACivLmRtr7ykBP/nsqkzcAILRgj6xh6MsKaTxCRNMp/Vk5i0lKAP2RBia/Eckg0LffRyZRNwTDsavRzEjxpDbcQ9I7aP6QiCut9HKCprIzixOyB/5K7Iezr/SqNymPq6Svt8fnnHrkTJEtx+q5Rkq3LCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747911; c=relaxed/simple;
	bh=s2CFdxitsdg/RittV3AdhzMCY49nkZt8y46DlVDHqpo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=RrFxeQi4+goiepCDkkNr2g7+bdfPD41L3RY78yag+jKToNbuXJmvmQ9CgrKu9RUBCb1GsWPslClsFWfFdcLXWAOM017IrWk6aMSggyZ5WqrBXpYUBBgUFZTBIe4Hr24aRodgzp9fF/PM3QAwExfhT9C8VGI07DX24LPCTVMn9ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cnN9sP7c; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cnN9sP7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krxHj+BJmiEvcJDNlfDE37N4i3nX1z45rke1G1rEhcDpK/t5UWkMNNgpgIDsjVieKmvSXyQnvwglDoboaEBMA7rmotnXjJdCuH1n6RdNdFtcJ0qMrW289F1voUoofrq9g+leJng3avtwToE7TGCZ0sLcz4iEzd4+BL4KxmjlvgOxppS9abOEVtaQovuhOacfOLiaO1ykT87Dfrd/cANqlEZ7sMpMm5qebOTThzMrF17latpLmHA0sJFWEEFHw92cJ1Kw7hbuGqvWvS3ye7Kgvec9QRhg9lgufRkL4Qz4JMyUyBndtevNqLgPTgB5lk/OgpeRLjzrED5JRfrT4fv/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St79+K9jjKclGn9TPTTI7JY61kE7CmP0XQ6PSRFAamk=;
 b=HF2UFwxfAAS2ewu897iPaO77XHXXkH3ICyBFP7Ne0h0TAZHabwPXspzGUuejfjYHCL/osftrUjJ0hwGg1yvEwrNPdltWGkrhO2H/heUQRNRtbMlKh/fs7+w+uyfAJmlMXQ2a/D2HnKWvGmbgAhrPXXPy8WXC9/tylECbAr8i+WyrKet7VIhE4dqc1Ur+1xZdYmZZcwq0/e+wOesBRRGhn4PSrFE2Xl6MXP5weg5BwGml+rtP3WICDJgH5Gj68IuY2yKpIMCi7tHPgwvIhvAc5Ti/aRvrppf5uEKj5GDqEjaevQVkJOJQSvjs7GB86O1AegtcZpMZt16LhTJ/VbyTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St79+K9jjKclGn9TPTTI7JY61kE7CmP0XQ6PSRFAamk=;
 b=cnN9sP7c3dp4oqv3odReUhQlv/iZGQD53T1y/2SsSwmUM29HPNOq4n1xWaCN+fyilRgoD0I/IEHd9WmmyHf9zN5evj8QaAsDomPhbLuk1kf3crFV2TzysmzMYxzZ+UtopfFoKsYCAQmCpAVSEtISHa0Vth1W91i37M2N7WNVuLI=
Received: from DU6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::6) by
 AM9PR02MB7122.eurprd02.prod.outlook.com (2603:10a6:20b:26a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:45:06 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::6c) by DU6P191CA0034.outlook.office365.com
 (2603:10a6:10:53f::6) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 17:44:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] power: supply: bq24190: Remove unused watchdog struct
 field
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <5c9b9ac1599704ff94dba34b9b2a82f62f348bd4.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AM9PR02MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 177c60cd-82c4-408d-22d0-08ded5f5644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O1WNJJ019edWNw9KWIBUv98dD78hj0JZC8GttdIdVUZWgkfQNAlQQxAQd0ha9erb8+H13TSpo7ykCSxrgZzhFw/HoukyFEAwKphBXKElWDW8/5tDp7wG1w6k+M4Sm8cpo5JYXohbxpouHfZxl2KORjUL2nkF8Zz5rko1VawqnEoMW3YDdaVe2yAiZh+jFsvvMh5bbOb7wcwylojDcC5s6qdGI1ach5RvOg7nrXvedJzTKZ2NgX/6fHX47rRaz1e75554T/myCwxqrFjPRrr9U3DfLkisly6bDk+2/vyG6DOjZfpUrKJ8SS7LSPt+XzDAdn/Oz8Q72rByXBX8QeXzypMJR5hoxVAbuLEyww/+ShABw892n1V/k+M/SeQyzrULIgZ6bEiKP29YstKYNm0GD5ImK8BLQZ3RQYo3vF+/VkSGkBY+rCK7wCSGysltSHMB1Gh8PB7q1YMW+z4aTtySULQb2U7OyVuPZuZi8D0r1orrvuE52JzAizNE3Ipx5k0kzq5AbhFirhiKJLZDr1KS6sifzFF6VAzb8Bt/dHp7yNa7FHLtteudzBglJgYwaFMST2UF5/z9QefHtG43j13kTiZUWxkyl7N4AnUPL751UR52xVMYPn1Yc0iEpuae4Hccy1lQtkY62FHurqK8H9nn4O7d40ZbfKJWBMPuSo14l/pPu0RmirET0+SnR/4j5Y5FhfSjq7HkAfcLZm2zUdbAXg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q0/tuw15eBprqlW/PYf3uCIwF/vnj/m5pSw85OrJz0JpnRbiIT6JYyBxTIFOHvcbGbCEEvjkv+Xgx2cY2FQtcYJGF8bzT5sRPbnj9IkygH361BaOite/Hq8XFkEibaiEyGPzl4IYSfYpX5C/sXqq+eJiTZKKAFsRNwxTR9DmBfOSbOvLIkY3vKf1rBr1cJ9eVMoZ3x7590JBhIlA+jerCYLCxHvf3mBECUb4hUZ2Zv7HW+/RPR+gXPGYG03QbCzVJlKD4QGzL4UWJLRTkX20HK5byGmoQBPrZ0ZNOp8qJ0bRtVbEbTLf0dz7BVbOUCfLfwAHDFvRRaNIRDjzMkG84kNyy2QsEszC8VVj4xFFtaLlUXc7Gv+yz0J4LQuSfEck90LdumdjEpIURtKl04liFj0pdrCp3cG1kINQHv46iyeWRSAYDkYkfh5jkB9qqd1h
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:05.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177c60cd-82c4-408d-22d0-08ded5f5644e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7122

The field member `watchdog` in `struct bq24190_dev_info` is only set
once in `bq24190_set_config()` during probe, and never read again.
Remove this unnecessary field.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq24190_charger.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 6700d578a98f3..6f8000cc700e7 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -243,7 +243,6 @@ struct bq24190_dev_info {
 	struct mutex			f_reg_lock;
 	u8				f_reg;
 	u8				ss_reg;
-	u8				watchdog;
 	const struct bq24190_chip_info	*info;
 };
 
@@ -756,9 +755,6 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
-	bdi->watchdog = ((v & BQ24190_REG_CTTC_WATCHDOG_MASK) >>
-					BQ24190_REG_CTTC_WATCHDOG_SHIFT);
-
 	/*
 	 * According to the "Host Mode and default Mode" section of the
 	 * manual, a write to any register causes the bq24190 to switch
-- 
2.43.0

