Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC444B692;
	Mon, 29 Jun 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747917; cv=fail; b=YmigFLoTkghUDLRGuq9AOlEn8Yjk55NB7dJUpn0sJLIVyLwxC4D2UD0Z2yetoXjPip/zhQMElWqQUFTmchQNRctOjaWHZEVDW+ivsuh72+9Siy1mhdDbCkD6HzFiVzZHV3shEeEpu4Nk/p8h6CUK1LGrMv0eHU9PNzoEe/r8ZP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747917; c=relaxed/simple;
	bh=2ifzvueFON7OXt4gLGa0dqym21xxmEr8+M9RXt4QMBA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=sv9a3fX4t7ANW9L5A7EPaIwoe3KM4G0PhMfte9mvbqCmiU0qXsN/5r2cTp7H4hmCw32xjGaX/16jkK++10BTXw0x2EaGoeH3k20tImtKirLp7LoY0YIa9ttvO2Zm3jBzFj+7Z1q6gK0n+PR64RN8O3jYNegnB/9Hl/ReYfHowzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=E2cqqznb; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="E2cqqznb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UurJz6c43BNMmcc+ov97IaU15qVTDHe75kQZOQsBDq0VpeZjvuQ9M0lx/F7i7+hZyLJfsMN8wNf5FzZBa5xAPVK5LmG2vUyx3SlEk4lAsJKXeNt/GJF1kYaJqpzLOftVsEUlqhmy68ZOw6r7OJBY107mgH2+5pYFoGVvxPqaIz/cQygoD91Wb7qYmaXla5eER9C+nk2t0k840J8R+nbKdHW20fcBc3Ee0r2rV3fwP71X6AHX94Xp5gEoMj4xilpWxOZaOvjM8mLcFlIVPv7tkbl8lk7vddojvQ4KIccRisUL5G3qrYn/JNt+KIMMmZAu/bOB5lW0dnYItZ7JxDSNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb9LrWzFG1ZrIpxFQUD2puYFjbgKleA98igS5P8bWFQ=;
 b=f6PqeswctgXTnVs6mx4lRsxmsrA3B8JotuD795cCu2MNn4VhAwrX56DpPgcs2FY/2lMGl3CBBMaMc4IiG3py9bI3sMpuFPMSjAhbNRzVuEysMLBuw1xtaWIXrYM38yveW4a5F4zG9wjzY8I0p9ags8lIUXXQD7PDB3Amv/lR7TvtvkNbKCAaOJ3J1J4n8qTfUADdsm8jOycRK4yRVETOfPhO+NhgjD1K6XfkGS6ZJvTNMicvvdhiTUYqdywCuqzp0DbDSxD5L5Nu6Qs4YSLcm5EkhdTuM4OYFH7MQdZPNKaS+rs4qA+ZIH3mDebgji0kWt3E1Fs6uk3W2P4MFY8vZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb9LrWzFG1ZrIpxFQUD2puYFjbgKleA98igS5P8bWFQ=;
 b=E2cqqznbjUxVS2e/tFo9Qzn2wq1aW7sdaBvS3mTTkYhi5qEgIyJaUw1EMf9vZMn+/WQ57DpeyXRlEnrAI7SP6tg4REPq87D7odRNXx+uG/J2Kk49ECr6m9EndZ5JeiFzjU73h7lzxcQgbT/yTWJx7XCdrLv2CV42B07Gq+2weUY=
Received: from DU7P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::17)
 by GV2PR02MB8745.eurprd02.prod.outlook.com (2603:10a6:150:ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:45:08 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::93) by DU7P191CA0013.outlook.office365.com
 (2603:10a6:10:54e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:45:06 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] power: supply: bq24190: Disable watchdog with
 bq24190_write_mask()
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <efa4524aa6879fd4452807f747a9e522183246a1.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:59 +0200
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|GV2PR02MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8092486f-d07e-4f83-cf6d-08ded5f564dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	L04UYe/vkNPXhp1jlfrXlmbNBgQVf3sZudCImX6kCp2vyn9uyJg54C8fF8HJHuEhi1/VpFtftpHydnZ2Kfoxlip+CKuLJUCnEVUFT3ZSzqbyst4ZXrrupZWCD0MRH7sMnb4F6ETG+iuG1DpxNIxd5oB2RVdKpXN88aQtf8l5O199oPCcwV+2Y+NOU7/C3x4OBEiHV33aHZ4r+ML6Dv89yFO0+QtYwF5hv8XskTWNPWWs3kJQcMjMHgB3gMXk1jzeCg/wQZdl9pn7Hj8HJJEA3n7g91z5/ADaF7cuMJNvwrsprsBdUcIJhQLBHgPlwB2CK+iIkyhJld578FaT2xIUsbyUZckX5jJniytZQt1tCmq/DMfUjq3S4L70CdAmQ25o8jKm79FjngPtofWyristquwrKM9P7xRaj83a1ytvazS91BBrhOnyGMVZ6eZRV2NbBA0691dyyeXIe58hZLN+p0cfQNpZh/gajNVj52Bpeonnh+17zMh6XMj5HoZoVFdBGAm7U4KHvBGhEaEhfQqFKyV3Lg+trDbgyTYLw5PgCht4asKLKnanp+cwWxrVQfON/H7V31f1qDLk9Xk8CP0LNXB4+Lt8dwbQvfWSYOT4h3YaaHsxI5NvWIb1FbMit6hVOIDzUDXbX1LxigAZdb4Q3t/Wn8CQP7J6psLwUsacghbYnjD1U11ZvzLHrzMrAPrmMwJzISsxdjdhhte/Cymagg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9y2xf4Ar7Y7WDLceISlO9NilG9RAemfcafkzo0yVr8BhKBiPlBV1VQYe0asblxesng5gvEvQK2zESWurbvKpO27VmEQxDeLmUQ16zGRQa/Ch4O1Rou1bkrL5omif+dTNRIg1qZ+IfyUteRS/NEllYgAfl8LblayV24VzqDIc729yvyLHNi1qu6t7FzxcGfkFROuEH2my7oqLeSwevvF99sXOwi8UHToSg7ItaUSbN0CaMGWc/fSDdbO9WT2Qu8hD7KiU8BpkCGCRk3f3gUEth0YQxDU1wFZVu2POOfd7Gf+YBLp5JcDx3IjxKiuBmz7nlQ6jUTni0NpAGUSc7OpB9cpWqjPDEf69czaDEMEzcgG12ErTpOWTjBSPWBH8xr8pFeA+s18UXi0ybGr258K5cz2/w/3ku7XkbBmfqyqKX1Pfzkfl4+7ZXIz2hCx9g2u0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:45:06.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092486f-d07e-4f83-cf6d-08ded5f564dd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8745

The watchdog is disabled by updating the register field with a
`bq24190_read()` and `bq24190_write()`. Combine this instead with
`bq24190_write_mask(..., 0)`.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq24190_charger.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 6f8000cc700e7..987ef0e29eb15 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -751,10 +751,6 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 	int ret;
 	u8 v;
 
-	ret = bq24190_read(bdi, BQ24190_REG_CTTC, &v);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * According to the "Host Mode and default Mode" section of the
 	 * manual, a write to any register causes the bq24190 to switch
@@ -763,9 +759,9 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 	 * So, by simply turning off the WDT, we accomplish both with the
 	 * same write.
 	 */
-	v &= ~BQ24190_REG_CTTC_WATCHDOG_MASK;
-
-	ret = bq24190_write(bdi, BQ24190_REG_CTTC, v);
+	ret = bq24190_write_mask(bdi, BQ24190_REG_CTTC,
+				 BQ24190_REG_CTTC_WATCHDOG_MASK,
+				 BQ24190_REG_CTTC_WATCHDOG_SHIFT, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0

