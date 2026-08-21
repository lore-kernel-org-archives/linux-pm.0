Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79423451DA;
	Fri, 21 Aug 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324997; cv=fail; b=SGypzgkts2GOdjXdt8pntgIVEX++jlKysIZXNQToP8uXSpIsI0VlQTbSmu9eOaHE37Wxb9ayNiut3Bi9AKbXtOSGDHN2NNKP15tgSUwR4u6KhROX5qD+qg9pnb5H/igABJ1BLfWOu7dtN7z2ma/nzONItpv3mNSXbnIKraohxZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324997; c=relaxed/simple;
	bh=T4vWFqw8PivKlUlCwnCAxMgKTFl334EO/lR8VuIKRYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1OhrbqTU9cRZ9uuhRyC5Q1bYjLeQY++tjKIOm6gzTQ9o0LY/slixLQx0DQRRnnbBF//RPJg/nJb3KbURCs9DsqQ4+nGWPRyLB1szHgcoVqrwfBWDgWuG1obQj9gYzk7JOE5uiyC7FhKnwl1BCwPwfhwoMWT4QCfd3nG/2w90DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Riyczlhn; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Riyczlhn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTlQParuaKTl7tkdHcvTzItsZu+xm32H6+qeYUlr8nf/ih6S2DlC+Ems3KMkwqI2zyhnenjYgyDBcRG5TNvEeFY/sXk4lFNPrh3XRuseFLD3rjMLqcJ/bV9q7hMgpD1+juRvlxPz8GHQ3FfnEM+3bDVxc5e+Krlev+P+wgyA1IF3nZSy6dhvnDOFPOB1JdCQI+epm4hYbQGrIZwRR0mUSZ1YWnHcaATDgQXApaDEWnxnxPXcPvVeQWZrUvVaobVymlWmFlVEe6XsP0JxWHSjv+iUYjApGfnN8jzGy9VSWqXvMR5c9vKHkZECTyMpF38hlwv20X6gf8tPbeU472we+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSS81j0YS4/6K9ISFHjb2nNXFmX/ePSlqlqxrvnS6MM=;
 b=kVYbsypMbwomi/yaCM0PQ73ANDhUKteQPMsINMZHtV9Znhrj9pwBYRJjnhvWADoookAX5FC0cM2c5CkLM5mAcn7tDiqI98mPu2mhlTiNv2Dq+5cWv27CY4GEuK9hMoghHIL/bTCb8pICiKpEr/2BkmYWDSNCHIALd4CygI1++fwMwVazgYsM1WzlSK1fHyQLuTpyFFE6MyFwAEIz+ug/Ym3BpLuqjGf6Kk3mOlV+QLnuJEqfcq1wDjxGdzAaqqdC4T3tRipPmYXG/cao/+6pBqGNYwGsb7FZlnW/v1oosBDx4U8LLNnnBLLi27a9cYJj0Y53EuIZivvGk+c2Kwzd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSS81j0YS4/6K9ISFHjb2nNXFmX/ePSlqlqxrvnS6MM=;
 b=RiyczlhnP5enFO6Vx/d9eB5Yyp88fgThGeT7xrp9BKQMC8DRYp2MmLqRFnq7goBzF4OFeMOsh1z53o7v4a5+e+53el61QXSvzm2ZvxAFMenqHuWlVloHGCCLFVgWiCTQ3jQ3ovFDlB0zs0H6KpeScZ8WVMBabG1XS8OufPCLBNQ=
Received: from TYCPR01CA0185.jpnprd01.prod.outlook.com (2603:1096:400:2b0::11)
 by OS3PR01MB7921.jpnprd01.prod.outlook.com (2603:1096:604:160::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:09:48 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::a5) by TYCPR01CA0185.outlook.office365.com
 (2603:1096:400:2b0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:09:48 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id BEC5230002AE;
	Sat, 22 Aug 2026 00:09:45 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] pmdomain: renesas: rcar-sysc: Update description of chan_offs
Date: Fri, 21 Aug 2026 15:09:38 +0000
Message-ID: <20260821150940.75282-1-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS3PR01MB7921:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 13894393-9731-4e22-5691-08deff963e5a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xZmT4aquhs78RUP8O7xZb1820NmUx95ZyzlRz0wrBfSL/EovAIy3Qh4Ad1tKreF9EuOJUAEkW4z+LZPhCd19+/btw27bGzGI2waEXUKiKh77Hw8tSnoGhAABsZrAKghwEisEwOKw4qTOLiiTcEyHZYflDEqCruK2KfPNkGnlmLnn3g6uhQiDXejFQ/RjHol9aw/OIQnRildfQ+Fvoh5kwxyZH5l6921l9Cd5l+WVJUa3/dGBLOYlqvwUHL2AL3cesYUS9/m8bfKUGTOkaTWln/SYynY5vjbNHu86Tx6k8XtCQ0q6fjkN/nV3o6EdCv/rm9hIghnqvUswLen3r0KAotOoNUb3b8VKcpze2AIDkSFF+fEgv6P+X9cwShwiFC6m5l9j5B57WVBk0jr5x1tkj/pOaPVhTcSBMKPN6rm/6APWEqtnILzEE/O5NWOMHo+2YIR7y2fnC8JPv6kg+KU9goN3mQcB84ivv6qma5bD8T421Z1ee6xI0zLW/3eL6r1oz8lK4N0oAsXks1aPDAc/1N17gvA5tomwDZAQZkLHTpcwONql0RJUruh9sQnkw9N3INqgHvSo+civWzjbgGNIWTo7wjdHCErIKrIkHyLAtDZ/w1RULdbn6fjMSEhpYZ9oB0TUSl6Ri4Ytq/MYWfZ8WJIRtEQrX+zI2D/3dEG59FyFEhVNMut6FT5kiZFSvTk6zB6R7b0lzva52J0O0E3HbA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rMK7qYAABvK7JMGOwyADc7SH2AAQiJucumExJBOEzZN1xRxoaKHB3EPMUh7KP3UyrbS32/2AkZSbolyBZUBWOhaLYx8rSS1tMvWnYsXjk/6NXHc94K21CfLX4HrrQYioCekcqTNDeyvSVfgDh7gXVIZUccFGWzpXfcqJbsL91rIM/dcmf9+l1GvXVINH3nt0dStoq4XxnKWUxbrsH4B9dUrROt0kn2u3Xw6hT9M42Wuih4jZEFCDE8nJdfhQVssuLQ9o0NuxKOenj+zNj0iCyvaL1xDk+sngXWEpGXPcDtSG0VKmIyqyIeaMuxR0zZTzIHBfUpgIZ28mE/wWflfrAirgTZxNMZR8qY52ejob9mFk0ByL+InaTCMrbBK+qINrwjpRMNWoNLcOIKHuoN8SADkqfxNHj2nuJ9Uo/lnXl0ZRInLqHJdJCURC7E2j9Dv8
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:09:48.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13894393-9731-4e22-5691-08deff963e5a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7921

The description of `rcar_sysc_area.chan_offs` does not clearly document
how the field is used.

When `rcar_sysc_area.flags` is set to `PD_ALWAYS_ON`,
`rcar_sysc_area.chan_offs` gets ignored, therefore improve the
description of `rcar_sysc_area.chan_offs` to make it clear that the
field is set to 0 if power is always on.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 drivers/pmdomain/renesas/rcar-sysc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
index 9e93a1f98f68..5f4534a4784b 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -29,7 +29,7 @@
 
 struct rcar_sysc_area {
 	const char *name;
-	u16 chan_offs;		/* Offset of PWRSR register for this area */
+	u16 chan_offs;		/* PWRSR register offset; or 0 if area is always on */
 	u8 chan_bit;		/* Bit in PWR* (except for PWRUP in PWRSR) */
 	u8 isr_bit;		/* Bit in SYSCI*R */
 	s8 parent;		/* -1 if none */
-- 
2.34.1

