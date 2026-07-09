Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341F3909B1;
	Thu,  9 Jul 2026 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568113; cv=fail; b=Ca4z0yMG9z9Md4mMll4j2SMEwr39zjYQHkdNOXFxnic+oupcJhUFnrXm0paXbqgHy6yehNl/SOKSALy5bT1OBgK27uLIFcdTSkdxglqsDCd3lrKTOylJFtgPbUVPqYGf5on3ctAT+2yQlP7JzhLSBlfl9ESuEz4QvWqFGuov+aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568113; c=relaxed/simple;
	bh=Ipp5RTYOKO0MBOXZa5Bd5dAFOijslbHoUMf5CXcTgq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwmMH3ltGGkqo769hObcO1uzq2R7r850r5qfJHyCUHqfV8IB6f1YemDXab013PMN1uJPSfr7APU4BQd0ffXicmzvP+W3V5SsMlit318el+Ffhzh1VidO06mr43LPKP/2kaQoX9bI/mithC5xhnT5WdQdYmhUntBI2XwcXPAUGPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Is5DTFrD; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Is5DTFrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyFFMNLmJriRVu9ftUhCG2j5twy6Nkyfo1cqd7z9kwOdt6DAB32eg5TNG/8IyZD8HZK14glGeI9LPuJNwYSVG9L8f2tERAR+F/halsT1pf/VcdtOB+CxPKgdEeHt7HpI950wO7jDYCq6OGSjw2fgPNFCV87ulHVK+DogoHNJhqeiqGL2roNufCS1DI15wxWOokiUrM71mQptUmYPuOMCmAbyUUEI/rmMNWNrl/Hg7LV8ntnA8NXZLXdTxsWf6ba933LCg1YBk+J1iNi631jYo2tjaBno0gZAVEt9G9Oy5Ly/wO6fvWROC6ItOpHj4ooawM19M2B0HW4No2RHTgRhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7wv0OGfe7b8EsnG1UFRcPXGbzMcv4L8X6BJ1NStd/U=;
 b=P146tt9tJDhgrkEVBJJpDEZbJ6YPOGIhsapwvbvLNp2B5dAMzvvtzBpd/HEnkGM0QGDrgyWlMGhDKsHxbqmW/zDEbRx6p/jm183MBvUhrKv6ebnMYZo8bDMp3ePtMthEkSHyPCFr6S4Pj0X6sFhlobxCGjVOtN2ft3eY5iN4y+U4M+1vsFBRA7IvogC/X3pCHqPDjZ3CnAdBB7wajMCl9LJ1AMXK54PaOnzMVKeaCrp0xlC/6XyWeJg/0f1zUlht/bL7bgeXROdaALev/jju/sB641foCf4rIoSXH73IPoQ+nNqJYNgUf3a6QmWs+StjcY4PErnl1slSSbE3k+K0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7wv0OGfe7b8EsnG1UFRcPXGbzMcv4L8X6BJ1NStd/U=;
 b=Is5DTFrDCE8wJxG4+w5v+clHgwSv2UPDStdcjd9PoDdUeGFSRfnw6RvLdjlixmOU5N2Hmv1VfVJ19BOUPbgso6OuTs4Mwpezjw3MklfozGIiCggOFLnESHCCQ2uUXgWtWoCru/ozo+A/F/eAUP91bKNdT0qyL3/4oB2sjbdIpeKOIl2BXL6sltFpuMAzEkrpJWZV9C12IUsSU2Ul3s5cpr9SbtdFlr6EAxEF3ZZBz9iIwPTCGlCF4jPfSdDDKSR1svXrezVFB7c2Jz/AIuP0EEnmG5TS0+St7kF4RjNOHsVgoqJIw3W7rZzPxXgblg64NGBPQOzwPaogOH7shZW09Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6360.apcprd06.prod.outlook.com (2603:1096:101:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:08 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 14/43] power: supply: bq24735-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:53 +0800
Message-Id: <20260709033428.362970-15-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: e80cce41-b585-4952-231f-08dedd6b12e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|11063799006|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	lSoWNE0UwAlVPutspO3GkhEWlcPXuq6+IXd5OCqyVbOUUGMv1tfIppiEhZ4wpdIP7JJ4cpuFrfYDbcU9PWZ4nuN/6B+d8ngSZzR2MSnJ7TTIxM7tvxqiu7cpmZUmnPywNauFeYvG0pTJIC2x4gQOBtfL2Qy3bg6dLPmCXcBHbk3tO9VgnuWMozadWj8A8PRqqKFmW5jnJas2AmUwIbX4dR1rHzkGlhcmoIyguUAxVKPtta/St+oEPKBnszrnfX5NItSIeEOHudKpXsoryz2rpMVhrLouamfIAcnHeoihZOjxRupu17e0E80+lrRI3v/Eq3RsFZs3u9LIiqKlLRAooO2gmc6R1tkJsJryDbWWr3Y0cY4zgTOEbymGyXdu8cQ/M28G1rMZ8i2Qohb1vVULXR+7I0JFz15D317deZ7vkalzOg/YEYZ3GrM08AR04BCgOflrkRp+eh5y7t6YbFeteZ8hNgqYzqF1D1zsq5xGOg7CehQVeyAT9nHSQCJG4sm4QvuW89RQAko/BpkA1R3fNYvz7PyY1ntF/nWtmbuWp0GdbHG29GSZY0hrkFTuWhFh5cDGkMYmqtQUEmDkvC/R0yoFMfZpt3W92fnCADD2QidHeXuUt1O8meGnyfHwiR97f2HTxaVdOAiHUq7GJ2Sx9iv4b/3Zol9i0rEchGHDZOlxgauL8mW4YBuPHFfvTVK7Rcp9IvIA3AfeHLVM/zKGPXa7U498AWn6dVLjLHWsqwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?je4JdNOM2je8G5SXCPRdkNEn9V3ZbPNEerFPxnN8SGwSZ0eYL3/bYFS4dQ/s?=
 =?us-ascii?Q?/tA9zjXuTpMfW6WUYBWy7BH5reHOa4YIpx4eyVx4Ly+t3syYk7BJQDEGVzQ9?=
 =?us-ascii?Q?wVDCZ5LHHzosnsgq8iF57uBpOGwhbKUS77Ia1f8CY1IctyH2N2f1rtef9MzV?=
 =?us-ascii?Q?KMMD9K78g+vE62x4W3otUjm9OKMl+XVcjvPkq8wp2KnYCbCbjo1hTVfO3Odd?=
 =?us-ascii?Q?4OYJXO7PtEJmf7xgAjFSgabO8c5U+YWa4wkjsuUweofm7Kdj4mj31+ty1h4D?=
 =?us-ascii?Q?ecEZpj0ynFx+a3zAcI4YTvuM+UR3zuf6hVbKl5nlLiabsADSpnTuuAQJkypl?=
 =?us-ascii?Q?BI6VuZLudbI77hLaNSKpSJY/Ryp1D9UL3zYw0zX/VnWuDKfNUm64Aef//3Rp?=
 =?us-ascii?Q?CqRlb/EAO91nUowFpVcaDfQIq4CbZIRzyAkRSi3osAa9P6ZkkNKflnJKK/RP?=
 =?us-ascii?Q?/gBvBAJimmCSTN7S8GFEOC7y3uS0DPKXf8UocV2SMJTYifnla/0vaB/Z3v/2?=
 =?us-ascii?Q?rQHMk76ktagL6YcYkrsNteKS3TJhgQCQIEQGr/OhjByMUgG1tT9woWE8OBQF?=
 =?us-ascii?Q?/z0JjqkIhZlj8PfvQpn64Q8Z1v5QFMFbd0/IP9wfddLJ3R4ZMocAgNTQNoaq?=
 =?us-ascii?Q?RK3AhUCFKdo32YImWBIUQ1F9zUeH/aw28kR7DrBgiJ4MOISMcsS5TlrVIvdW?=
 =?us-ascii?Q?fJ3bRHr/IsC0PEwXsCHMSSqNFe0E+/Y28EXcbNBZwqlJAxd0UylkdxPLx1s3?=
 =?us-ascii?Q?6hoWDKOxXHZAEDnlzpioUWW49V1hKPjSfeRiApPfbtvlPUN+mbwhmDAqvxOv?=
 =?us-ascii?Q?Q48lpUHKCIbUQ+OyukYQHoxgCsXpi6D20EprkeD+39FxD5cGpI6OtDz8unEQ?=
 =?us-ascii?Q?xK4inVpq1j5fCa88o7b2QcCl+hOoZUuMKiHoJZ8eZ6S/UXbKXzTeTn7jUkXk?=
 =?us-ascii?Q?nBoiCtXNP60yvXEM1MuF/epkS0hxk0As1xwKBcmE1XwNm/K0n2fUJ9v0tiKr?=
 =?us-ascii?Q?zIYeXC4nNGrkGCrHCItxk2HLquVr8k3bmlpyLAjSDeDm2n8Vi6cmRFU1PG7d?=
 =?us-ascii?Q?noeW96/cqu3VAmfIEORKcYmWnNhENpcTV+r4fgHjy5TPdf4+qTw8doizaRbf?=
 =?us-ascii?Q?Scy+AiKItxOdlr74s6xJpRPyua3/OKWRd1LAmP9AK8T1jUwkWf3kdnyryJig?=
 =?us-ascii?Q?iqZ2i/+eahqxJltt1kf/LBzvyVi6SBHz3w0i5v67HjCwoBtwZV8JIE9GSC4B?=
 =?us-ascii?Q?QES4jijLq4+qTjaqP0KZ7Nku+81AFxWqqwMmXDV6ahXLh7WUolIG5gxoJNFQ?=
 =?us-ascii?Q?Ko2kPMxYPKR/LDPN18SIQZzcE8rY1N8LOH/LJeDRS9C6akMC3bXDz/3J9phF?=
 =?us-ascii?Q?qGQqK2rusetMow4zrAdTTOT1hW/8dSM2kzpHzNlE5foxC+DB52dt0xIZffqt?=
 =?us-ascii?Q?eRujcXE7T7mU7gWZ0G55eR+WxS63gK19ybH7Kdv/bns+/QYMm2eiiz/qg7tg?=
 =?us-ascii?Q?JbbQ1WVa8wwt5ObMHFVTvQ9Eh4djfwdLvWJJkAyd1VtgDB41w+x1WWouy51U?=
 =?us-ascii?Q?9twrXeq5sz9VAqbYMj0F5kZ4NkrQkI7TMXYSo6DP1vQc3E1VQMFW6HDhDG0S?=
 =?us-ascii?Q?0mbIMoYhlPDb8APeMwifxwkZeb7g6U9B4zYT0xZ4NI++OQpnPdN9TPmGnqed?=
 =?us-ascii?Q?u4QUxFQVe52p5Dahf5uSCwWMSnM5ZSlyhAaPVDBFrn/DzPZxyq5guE6+OFNk?=
 =?us-ascii?Q?kk6vzO26Dw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80cce41-b585-4952-231f-08dedd6b12e8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:08.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozt++xl/SmVak0t1xZgd1RQWvztcO3XAk99d+K8JGe6w1LU4qQOFAwUl++ncJYA4rrBclrLlDrd/prESA2kFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/bq24735-charger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 99abbaf0470f..22c2b86c3b30 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -462,12 +462,8 @@ static int bq24735_charger_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						supply_desc->name,
 						charger->charger);
-		if (ret) {
-			dev_err(&client->dev,
-				"Unable to register IRQ %d err %d\n",
-				client->irq, ret);
+		if (ret)
 			return ret;
-		}
 	} else {
 		ret = device_property_read_u32(&client->dev, "poll-interval",
 					       &charger->poll_interval);
-- 
2.34.1

