Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227180;
	b=dzmrpbGRORMDsFplT3SBCF8btec0L+YRMdQ3aZEf606K2tgmiAlWNCDDy4Jvb7xj5KVQ
	 /FW58i/NuBUrf+NTzpWlt280u6RZbI3EVgvpObJoMSu8swCKnU00ilPPD390NP99Z3laj
	 /hgGFi26/AALR8c4fsJ1tTziy6KgY7Hth8mqrYwUzxrT5zjJm62Kp9DPf2517yWorQoL4
	 4F3lI6xVVji3nCcXFuYKpAJxNanT4Eu3m4EsK/4tLYuNYEGpQH2aQGgUX9t3BoD5ykwkc
	 tAh/XfreViIgewUWu8vJqv7AGv7Xi00bswP7PnzTgtLubDYqQu5Nyl0WHDyDjx9BOKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227180;
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
	bh=V2Oe2F3ueylxmdLisl3G4+2iSXoSWKbbAPpSV83Ftrs=;
	b=CxDAn3Th06lSQJWgk9pfs4Sohszjj7jm6xppAGbr4mUfAE3G2+UzphSi+iZ2i9AIFE77
	 gWJX23G6jdjK4HRHovEMkW4CiULqyVSMEF2FoDmlIghyvtLN0iRzSvN3EdWeaumngFl3Q
	 XNZBZdt1IIZJNklMJK6mc+yghTV8tvfbaCpFpEJpObH44BJnOjI5CJPUfJAXcwdK0rnNX
	 UJFzK2dURFp97Lp2TmGXTXC/CmnMJx6PuaZZVnkDX4ZoRZlqZE/6sLz99BtdFn3xTvVn5
	 WKfjz2fBUZBuwkJbtgA7DgbqB/f+nfB9yfOdE/m60MXbzhsvLcm0wY+UYsmkSLP4gvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=riz8dxa3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.55
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5125606A323;
	Wed, 28 Oct 2026 22:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5125606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=riz8dxa3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McjREdss7sFI8rXGRFk3QE5D2SCz9DDJ1xCuSsNYHI6idRDkQgV0NskXAlm+sAVukR8K4RknAhfzfcHE0NkV2bO2XCPL7chf56hL9EmI18CFbqAQu8eBz08rqtrW0/aIJJ1fMyYn+TU9BY5OoeSAWBjCI/u5ANCWnbFetMwcH2EPaOhLPQ1BRLaYFFfqM5KLIIN9k4dSC+FKngUdBTJlMQduGuXUWylQa4qiQC3XG8NW54NQIHbhf7W+9D7X/ecl+lnwWyGLwZYmyt5rb9tODj0USgJXDyUNKFevnT0GSq34Ol0Hs6ZCHz65ZmlF6wPZ4iQZUBV4/5bnqrCEBSC/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Oe2F3ueylxmdLisl3G4+2iSXoSWKbbAPpSV83Ftrs=;
 b=p8kV9q3TpqRRijKQX6hxuSuCb9svrEL4GEoVRfw8yUUUYFtS32Gk9ikj734vKPoRCmysf1fTjRIc8+lvJBlJNc36YwrX2+3v5077onhB9glbYbC6K1nkC7UxVErWc5afBHf7EPZHpOlxhiOJ25X1YS3tsDVewCpRUHSFa6Q+NJGTrh0LtYhGGsAK2SvBTlhRkEgsImn/4s1JoqFextATCEhJwYWSYmxj9PCypJMY3Leg/qBoyD3pkDuCszZj4tWmzSp8Lmqf7/F8MEqzbh+aSvmWkZ5q3IEv5ZW9V078Lw/YibxspriHAQ8C92+K3RBLGfwzKJACqbImukjrEs0ffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Oe2F3ueylxmdLisl3G4+2iSXoSWKbbAPpSV83Ftrs=;
 b=riz8dxa3ubHHZL4HrAk6tFLDaE+4n4F/IpOj4bv67PvtXWoyXjaW/Yd8tqq9Eom24KAorV410j2Sm99l+JKpaFKEHuqiOROHptfzpUKLLhxh6/9e6STTOL4Ml3m6YTQfWVacl6cwIRUXikQR8hwR+1Gon+dN5qLi5y2ocMufO1Y=
Received: from DU7P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::6) by
 PAVPR02MB9889.eurprd02.prod.outlook.com (2603:10a6:102:311::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:35 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::35) by DU7P250CA0022.outlook.office365.com
 (2603:10a6:10:54f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Wed, 28
 Oct 2026 22:39:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:35 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:32 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 3/7] docs: ABI: power: rt9471: Fix mismatched quote
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <3c0bb424d41a1fd4b8e27751d842f4da36b9a473.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:32 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PAVPR02MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: d876e757-c8c9-42e5-6721-08df3544579f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|18002099003|261026121527099003|22082099003|261021123027099003|56012099006|11063799006|261022105027099003|10067099003|261009223027099003|261021121427099003|261022075727099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	aPoC/fzROAwNwzUhwot47AfUX3ke8JryBmI5vcPieJZuIh7zS5TmqbsPFf38/e0czf4EBBsovNMOVy1aCruE/ONhjpyT+51FffEa9TYtEHcZU6CEvBbUgUVt5DR50PZ61vrZwPqi02PxyVhEnEkT0aMNF9bRxS4qgwrwFCD78AzyaAZaG5gdI0cUtYPMxfC7qI0xdEw9lnpFaseoSpwxTFiWcEQw6QxrV41ZKmM6Ok6BhyWMNFMIGLWttZNUVAFFVT7Pxr71rMu8h0STnXLQmdL8hLRhJdELmtv34nohnUrrgBI2LfDUPJMhv3pgKxFdD5UlRgR6syNrRR/hAboAq1YpuCIzJ+roLdjqCOnmheprEQYPfmu0UHB1P6lTuFhYAXLSBpBCvcZn5sDcPzh7dSslFnhNj0WombFwwZFt86RkDkgaRCokSzVaEHuw+konnOB4M60GYOP4tOEBwYnJlpaLYxKSvVS3sCIzFsKVqZYt4vXMCF2L07oxCdYIPjCzIR+EefMseDilpdCG1V7iEQah7AvpMZdHvOz2CIbJYIUqxo4Nn8SGlz39YgNGlX9FOjQlLcTKSGiqkIcNYfxjrdXtbIIFCT+CEIJ1VXL4g+b7HBbdtIiOTEgjqZQU26Wm5EngVUSYdzaprvMB34uQgELORukpqx2zfxizuvwuJwc=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(18002099003)(261026121527099003)(22082099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(10067099003)(261009223027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ykRN7r1CPA9oX+SHpBN2oiER9F52Qiui/0Q+04QePgganyStZXd0qea4iqXqDm/j8/C/1N9pzI7/L46GVYPCOmnFVMnShruihUmOc7+wZYiwG3NqauRedXzWzqtokhCW/TTyYHc6TPuEZt/i+L3Qsof7T6SiOIzwW9wrybRyBc9qTS7OXafqcZpoOpi4VMXBf50a+IdsgYicDBF9jiRDq8aghHWIolZL17uIBB3AcuMQbwPfxHFa0VaYbrzLazLHO2G6bIUYIiQ3Fn02F6knR7q84WoeAITP45D1Qz0IP58nIXW5bB+f3loSdIxbu/trpjkJ1e1jxS3cZcq2QjfxmLoaZj8hGoY9+MHaGbcH8fd1EBSEFQvcQcLgyAeVIyDQNxxuvYd03XwW10njCldp78sGHOfa0/1PF3TT03OqOdQydpoz/XR2vY/bG4JGAS9F
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:35.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d876e757-c8c9-42e5-6721-08df3544579f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9889

Quotes should have matching characters. Fix this by replacing '"' with
'''.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 53393488ec419..89455f6b44a47 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -7,7 +7,7 @@ Description:
 		If enabled and the input is removed, the internal battery FET is turned
 		off to reduce the leakage from the BAT pin. See device datasheet for details.
 		It's commonly used when the product enter shipping stage. After entering
-		shipping mode, only 'VBUS' or 'Power key" pressed can make it leave this
+		shipping mode, only 'VBUS' or 'Power key' pressed can make it leave this
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
-- 
2.43.0

