Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589658;
	b=i9G92tQIsOxmXQ+GsTID/5yxEVnfppPId3A32V9iIxjJOyq2whY4UIOlXlQSB52rtp7R
	 1uidONtwOFt/0GgbGVUSmim3xuWo2+vUmaxgpCO4CgtfxlHCkPPYNZub9Lrb5/mabUCGo
	 EkEKDPgg68NPA31whQH6Oo1WZ5vyO5DJnX+FNYMpCN9DqrTEWR6o2QefKdGCNoHoVAAQi
	 gEL/ekgV6ry3/8GFGWf+NoizNfBELZv5mVQoMutvXcWZFZdWjSj8YB29Pgb6iMDrjdwki
	 dw6QEbcxYjRT4pGMwN7wq0x11HfDanyXybgoosnaTS+D8m+pxiGSsXjwe8yuahygF6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589658;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Va6mJYMfTUHu0VrWZSpoDOznU+fZCjqE4tbceYDWUwE=;
	b=eg8zxVct7PEG04ycFDazlMTUUU3GKsb+vXwDrbx4l7buWHa6OJbqfSJ0oR7JgI0zG9X1
	 ExX62vvgAMunTwaGGw598YA/qrmd5t/pPqO0/VrZiY0AjvAlysJ9MlXC/Q0MSAfhAOrUe
	 lD3wXsTT9DRPWhzDslUHMfzcXdng0EQHk0hXTQN8ZUAgizXFhAJfdz4aAt9KFbTBqu3yO
	 D5IOrc6Vd2yTI1mgRG/Sp6LlIc6KFvB19z27NFZ2o9JwtFkT9VRHtFuI6rMW1qCdcBmv0
	 gOW89ldzK5mUZufwSXL+9bVzbXUWsOsl8OTJEAM3pxoVCInNGvvdMXE6V6kwK3NcHcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=hJFY6m8p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.63
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11644606A32D;
	Fri, 13 Nov 2026 17:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11644606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=hJFY6m8p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPDY7htVTtv2QldSOzHbOO68NOMQffX46JeRAjy8wDYRirOIt/v7QoljIrdubSuTS6n+5b25kM4kqZYk4Wf1ZQCCnuPY7FnA2XB4neHR8aH8g/0R5w+xkjczahftSoUToyJ4oUUAFgbLrUx0X7t1csykIS64Msw/nAKI0tJaibUg2Zx2jOdHNovJocagh3RO56gnayWncgRHjfLhlGPQINTThGd9GvHoRXmAJXFjUiGWx5PPUgxXOZEal09DN6Fe+ELBE1WyWvQqGU45hYVcFfEcrV8HbwIgFDf78HQCQDmIHO0NT7Hj9KvPKOujLrRfxqgDmTTdTgAk6SFhqHtzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va6mJYMfTUHu0VrWZSpoDOznU+fZCjqE4tbceYDWUwE=;
 b=WWPxy41jrRweQdg3mM+IwtNPuoiNyFh5vBgWGaAFCAZySaTkMVcg4s+/iNytVDbQB9tqtSmF9XmC21fA0dtrjmnAFT/eypdSEPyslFnEjWSh2LDU3gSK8cqw18x4hpoGXepdFMrd7flbzo4rn8K71OD51SL9q/AxrxkT7ER6AeSOTLhk9kWr9xrxsXMkdfgqPNzK15uOKflAeMyLpCbO2nh21355WFESPgpb270Z2XzhIOjTVb9PIGsRUuRKMyiPEKXCpH/FvG+gbDF20M9NXE3EUOWWqPLEQ6apncoPe5zC8NUF3y2G84pUlkn31btdLbxgMJptijUW6cioGXs7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va6mJYMfTUHu0VrWZSpoDOznU+fZCjqE4tbceYDWUwE=;
 b=hJFY6m8pt02bsDGrS/uq/iECzgUOCP2ns90C8iEtJxxYl1OZkNkCabwbdXQ/HeYkpGqDkWfnyDSzzEyiCfo5txgOifHTaJFcUbQaEW+fwSgxozp/l0S3meTsqbYwgUnxYYEaoJyZLDCSTDcFE0mw+jROwi9vw8L08MTJ3CuSktQ=
Received: from DB8P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::14)
 by DU0PR02MB7971.eurprd02.prod.outlook.com (2603:10a6:10:34f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:07:32 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::92) by DB8P191CA0004.outlook.office365.com
 (2603:10a6:10:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:07:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:07:32 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 18:06:10 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add TI BQ25630 battery charger driver
Message-ID: <d94273dbcb55dfed01f75a02e9d0f28aea390ddb.1794579149.git.waqar.hameed@axis.com>
Date: Fri, 13 Nov 2026 18:06:10 +0100
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
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|DU0PR02MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f51ec44-07e8-4364-eddd-08df41a89b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261026140227099003|261021135927099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uLL+hOLM3sNG9qldqC6pwtEvyipBHIwl6wHKncCy3ly1SHERE5j14lKs60n/EI01f4Xn//blwD9LOsRR2zPtkDOiE67m/u4wmzt9njXLD1j+MmO62+KPUJRe/aRxfEzrVB42WpPwkmm4JHAjuUTiAUQIMK/kwCA2+2a6CZ3/NmpiR0UN64w3WPZvyimk0gvv/VBLoEEsBreMUfXxB8B44iIs5f04j/iU1z2S96KDg49kb0SyyqhCzQXBY2l0yzvTkYiHjRoKT8nR06O05UHHaROCKYmORpwCpDPBkmdnpUmS9FHQ91gNPLKUrJmeYsUMgiqhxLNXKBvr7UO7IqS2eyvrujLZubQAH4rRw23FkKktkYyNYbJSuNyvGLy6SkQDXSJYW33nAZnfPDkVSuaXBzV6teJccS1tQIzv31SA4zswMjlptfDBKc/K0vv6WMPdvAdXQym/ZdpyDngP773XdpVNN3JInOVOz42GDdjvO/ZRRtrXpibwZYK0tcZ97xFtRXfaiZpiN3XAXV3b97T2b4Dqo7OKGnqAwSgi0U+/Eo2p7ad4hcGTqcmUp3lVHytvrBaFrNHfPoVYxBBxa+oyChCV/tXq+rjxRHHTpOOLbkIlX9PigU7EDSjvxnBJR/7HkyJaBR8i93l8ITVbNB4fzuOY0rFeHqt2pMiSRLKolvj7BAqEjzgA5PPe9RTBqAnVX4DWkB3FVPTzroVqhA+oiQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026140227099003)(261021135927099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3zKkMIMwBmJKQIhYy9tb9haEoDg8afMyTdVXi6F5Ydb/XiBzdmM/n43SuH9hkgjbK+/lzh/ToiCaFnhkjv5w7BSNOu1/ieqY9u2rK487kPJrWlxDvAumavnudBhgXzI/pq6T6I1QCNAjoNTINQkUJkydGMcokA6ofDFXhMSQlgxQ0g6TINoXMs1MkwTe7OIdDpdSbZDF3cDDYnoCEtDsDFxK80KFPPOYDp+KTBmdFSeuKaz+z120SeQPI7Uozk4mm6hsek4Dc9fUr1Kxgl4h0j80GlckGPNsUB5t7fvp1c2QBAr6C6Z06UaCsbgh6TMdgUD2gWIDrd3DqCdLU1k5VvZ5PyKWegvVpLZzo48em/qB2CcDTsnP5SDI4Gz+T2icWnGof9gDZUqgobwyGjS7rpJYcYKxfUIouAmZ9lGNc6pYqLtz9j6dONnVdhgz1uOv
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:07:32.4446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f51ec44-07e8-4364-eddd-08df41a89b40
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7971

Axis Communications has resources dedicated to maintain, test and review
this driver. Thus, add myself and the company kernel mailing list to
help out with this.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7070cf5dbfe98..f9a0cba48c31f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28178,6 +28178,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
 
+TI BQ25630 BATTERY CHARGER DRIVER
+M:	Waqar Hameed <waqar.hameed@axis.com>
+L:	linux-pm@vger.kernel.org
+L:	kernel@axis.com
+S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
+F:	drivers/power/supply/bq25630_charger.c
+
 TI BQ27XXX POWER SUPPLY DRIVER
 F:	drivers/power/supply/bq27xxx_battery.c
 F:	drivers/power/supply/bq27xxx_battery_i2c.c

base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
-- 
2.43.0

