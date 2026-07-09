Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829A39732C;
	Thu,  9 Jul 2026 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568171; cv=fail; b=X1SO+/YYVWNSbr6I2XqW6GrlrnMq9UvejEd7Z4f4ummV3IgifmnkwXoPa/5N+wxx2fvvrPmXN5YTQOJbDYBRbkzlkcbh1f/4K7G3ZcRS4ZIPG3qq2MaQKAdoA42nCOVl5xHDLxiIgTjGKHwRW75aD37b3I9V8II6vdz2M3suSGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568171; c=relaxed/simple;
	bh=JYM81laQ78aB/IjUEFPRpzT+MBNwx6aQFCKqCXSzp5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTK8fwmrgwJMtOVRhwGyQY/f7oHUetwNmoOhimnn0hGNbl79RjAWoyXFnLakNy9T57/gt3idpZi9dgjuJNuysSF3JGRrDR2bSjOfXXUukXzPcESrvRYxRVDx7r6iQJD37Xk1Ja2M2rNvSMUFNp2v2EZ8ryiWmRhcOXFieIdCf50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W9NTQ2Oa; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W9NTQ2Oa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/C6it3/m5J2d70RokfY03wdU+KBKFUOumomoFQ7+9yUpH/ye544R3tNqVjb+LIQm+kvhXApozLetyB0kX9Sa0sVH+2jyo2cT9LpwNh2xbHT0kouW6XtobCvVByYwfZYjgA76KeaX+NKWtgDbKVvE3VcPYV/RIhdZUpF/JIng9DXpLTsjjEc30EZClZsd9FiUPy2dDUkXO04rL7V8Xjab/qTceF5CaG5kYU/SkYxPVb+VqcCy3/ZLC8o97tW2jlxs7zLZtBlio2fQeyorgIzAMfvl4ramYuM/f8ghwEDY2UNz5L8DEC8sx4eLTly+GVB6NjkVD7x3qQ9x0SDwxscdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm/+ImxNn26wtB54Ar7bdvcS4jwBEf6CAOzQFX89cZg=;
 b=ZxfoGfAcXVSmdAAREI3GkkaDSXWEXroXXpMszbO/ctF5SPDSD8ZbGwNCQvDtLizJ4QSKN2iQDE0rCCm7qVBdB4WI7+SOyKg2eJAOO361Q6UJwFcAOM67uCOjCwsrtCoBYlOra+Jt0NHko6Yvj5gxE91pAI36IuczYmJ87jimGPMLvK2/cpZXFBCjXose2TY0k+pYT6D/3FozDyNhV+RPZTU8FdDS+plYsIkm7r+a/QxFNUUJlq1UIGEqrkMFAr7ZQyw1kby8iTHAdy++FwtPME4EyjysOw6EE7xfRCa6VXV5vRItvn7zsc1yShvxQHlvziVbXm4y0BAX8xdNMle/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm/+ImxNn26wtB54Ar7bdvcS4jwBEf6CAOzQFX89cZg=;
 b=W9NTQ2OacI/7xqnsbeURw1HvRBeKvz6d/dGHUiShMyH/PF8Dyag/MRz3HaJ2aCXxwCrGGOQ44ZzNYsGoS0lHmW7x5t1kGbHDl20qOeFXN12aqRQfU1xAeTSPx24Clb8svR7beCcWxfSdox1V121kld4mxnQ5qZPmiuDgj/RuEuNWti1ibEDVnmKxAR+9bm1BkHBe1HWYJoUAEL8rdH7R01/Uc96n1wboZ9n519ZKdnDrMdANrsk3m8WnPKeiC5+Jm2+JohB7b29HsA42xPvJld3m0UwTrL77pXttmEkV7PnXSDhp4DMfaw8rFEAEkpnMWqelXsb8IUu2tEQAlREXmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 34/43] power: supply: rt9467-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:13 +0800
Message-Id: <20260709033428.362970-35-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d49cc0f-34fb-42b5-5e42-08dedd6b2382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	revPdg7BgoJnfffmhhxb5tSnzfwMaMK3naFELcuSzfnU5sORRXx3uRl+Qgrb3Cix+kaVnt46uhi2eStJ1ij1NK5435MYs6SRzNOYncX6TAWUHR2DnNgj0WLxpmwrdecDK45L0K38bP0Yr/6ODq4DDztV3FgWvJ/MZcrDzVaZnEfCouNmkC27OXwgGF/yLKihDMOcEPz5h23JAR+Cyd6kESm1pCaCbyq9SzblzdpBRLXK6MBUrTORyHMgW/kthHX9oAavUbI6Wsw8YlDcNC/iPnw/YBVI8Q7wPg135lPt/RMIKJCkSvQIUT2gmAznb7ahvzJUy1l7lzxTH1y2xmLJUj+GS3Amj3h+v1kmEYS+PwYCtTSmoOr1B+1qzz7CtlkoGxruQovxF9iI+9Z6fIvWnTS6mcEzeR53E+OxHuGj+8AnQLu6wglCkRvDrHIlz9fbdsfn/o90eNgMagt5METcGmrPb7mJc/X4Y9PAiE8z/gQj3uukStG4cSON10eRsEpSaATsQIcTSZxeigc7xWuXOUzXy8rtrogD+UC+X6Z0Jk5HCjdTkD9nJDHHEzGHhYEvs9iEOm10XrAAOUVLLropNvQbdmgDN5BuY2e0tD74IN77PXGBCKB5sQf4nDd1EbcM1Xun+iHTSG24oigQr2FnD3d07hD0YuC0d/+xw1RsxTMWCMifHzRkIrBydA+Jsm+zirv62k8Fwp1ZpxEh83g8yLY/nOUHmTR5DNYsvWQ/fTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GZBt6s1WO8Rd8XMwYD/bv3H8ivdgoVcx4bh/+7sPy1+9ysZ8lGVDTjL3Fc1G?=
 =?us-ascii?Q?goSAXI7Fkbv/fHlm1VVJRYAVpcifBLpoN6vZ4jYFyaeFShVG0bxdAkZ6YZcc?=
 =?us-ascii?Q?ktNPniop1vgnNTHAK4wA+KbZqGmun3aOcM9leTFZ07M6UvcJGRvsjn1PgK20?=
 =?us-ascii?Q?sOU359nNyVW3JliB+ArGz/clvndwwTbREv4QbV1u9FqvVMml8TOB8VvF/pwo?=
 =?us-ascii?Q?wGYpWCz5PEukymbgo9Xhf3ziF+DoSMGqQNUM4bVuYmHyrzLPbB+ead14Fbzr?=
 =?us-ascii?Q?tINCHlocRV51fteMT3kI6dvTynjihDHOjVgOazeqHFUsiiDUqHFdNLgn//p/?=
 =?us-ascii?Q?cV08G+H78i6EpaLC4oU09VkTWDsdtOSnzL9GBoux2JgvIpOmp8YY5ZAGYIIz?=
 =?us-ascii?Q?vtGFavKjgp93RUpIwChxuFN7L8fqq8rlyQwfwwwp2GItI4M+jcH5hY2IdiQn?=
 =?us-ascii?Q?iVRQSQKvdfi7ivJMlkVmMtSJ7lFjgAgbeyfmY2hIP3n04p+P/C4Bi2uTRGWm?=
 =?us-ascii?Q?48785/lx/JsQUweq9AifYOvfSm/0vaq9MYKuuU+teqC3XAvNj+Ab9p2da8k/?=
 =?us-ascii?Q?OWskfWquhxLGF8OSWDIn2+7086bbWnOu0Vldz7GwYjSMGWxiIXH6QzDtjgH7?=
 =?us-ascii?Q?Xt5VFCRI2QS7jS5v+OgcBVA8jGpAtLfenwuKEf3dVl/rLLizLc/AD0BiKqJJ?=
 =?us-ascii?Q?rE91/IwY2Os7JEfJGKOSWjZYASzJKvIPgAGxbydZxD9SyxB8lfcAdF1o5lNA?=
 =?us-ascii?Q?fRs2Wdhswk3r28joCKKyak/WLwu8+/Ysdnsp8ikEZRv3BQeN7aeWecKXqKaw?=
 =?us-ascii?Q?O9qeHFWLN1G2S7YpYi+nOd72lhZy7jmsykOjfCRd9+dUbIB/E1pdLk9vCUTs?=
 =?us-ascii?Q?akLDTd/sxL5StuCn5zCS+Gz9XmvvJ1qQOQCXVaN+QREL0PVc8L+dIw3XlDk9?=
 =?us-ascii?Q?y9PvUax3w1oHJBfMQxOCYHph+5NnlxpevOF6IKQQfO28tzAqR9PzNflMIb+L?=
 =?us-ascii?Q?RtIAJXZgjyztxLbrHLa5lbIxuHQOigKftxbE39DpAYjVFVXrcJ53r0FVTAVr?=
 =?us-ascii?Q?skPT3ism/XN+LaygFSWKJcnAQcoLPlHczA3OscNgBoRcq68NrVgteNwHu4Tj?=
 =?us-ascii?Q?dlxP18vmttMzNcqgeTDGuqKRheGpuusGTLgiEMkiDElMxaw2OIkBGfQzslow?=
 =?us-ascii?Q?hmIZAXrH0g79kb1amx5jPpqyEkC1+w+FlFPwKeh7W2svDTQ6DmRw8TlsOvfH?=
 =?us-ascii?Q?QMC99fN5LRRbfOue5q4sZR+LoiozpOc9hHAOe0drDb3nn/vTj4s0zq+dvTqj?=
 =?us-ascii?Q?0gzKmG7kDZ0157GM8X9mfF+xI0Q88zBau6BPFOe3y+lezqqwulPKAo3wY2a+?=
 =?us-ascii?Q?/RlbWsPk/yDqVFkAIV3kBL0Zkw19Nri8egxshtN5MW+yrT7t1SbZfNGfglnl?=
 =?us-ascii?Q?I6HS6ZniL25VrmqnXutKDSdkxtrVialNOZjtzS23pSwt6TgTGiDZRLTaIdBv?=
 =?us-ascii?Q?p/XkDJqghU/Eyb6IaCAJbtMyVP07wm8iVxuGsEKLSM+SzxGGROGmhjM136aj?=
 =?us-ascii?Q?nFjv70Fk5ii5hyITKOucYkllNVD8iNVjN6tjwJrm8JebeKr+D37UXVsb6vXi?=
 =?us-ascii?Q?cZ5iyr8xsIFiEpfAewG1erm21Ze7FpOAnXV8mVTLg2if3sqirXSEU5ucCygk?=
 =?us-ascii?Q?wg4qzfoJYl3JPZ7lwdJ2jS6e6eYBBS2v/aj2uBz8BmXQcEaIgoLpBykBQSOV?=
 =?us-ascii?Q?IJjgwl2QNQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49cc0f-34fb-42b5-5e42-08dedd6b2382
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:36.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCY0n2RVfv9sKSXar52HbBm2U+te1QUeGjXimuQJokBGg6fyYOL+snlFZTNHaEBBnCkYPx/PsHbjhYrpl8Vr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/rt9467-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index de0471e54978..a9a83b263e18 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1030,8 +1030,7 @@ static int rt9467_request_interrupt(struct rt9467_chg_data *data)
 		ret = devm_request_threaded_irq(dev, virq, NULL, chg_irqs[i].handler,
 						IRQF_ONESHOT, chg_irqs[i].name, data);
 		if (ret)
-			return dev_err_probe(dev, ret, "Failed to request (%s) irq\n",
-					     chg_irqs[i].name);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

