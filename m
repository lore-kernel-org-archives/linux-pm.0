Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB5396B9D;
	Thu,  9 Jul 2026 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568169; cv=fail; b=fZQOljreC/pOwtw3qWgtPOa+sorhKpCgybIlDRAVpiI46KbVRoJQgVc935rKTUqPJid+2JIrf19Xxs3Lzfx6a8AYDomAhfXFWz6oLX9IW7gtSrJ8LpM/oV8pKjxIqqC8848c2LwqaG19Ddkd+iwE8xUVj648HTiLcegKsQiJob4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568169; c=relaxed/simple;
	bh=PyI6wXHcZcI8QIoCr9wJiid+d00WugHZMZJ0bkQXCIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEut73QcP9qe7m7mab+QLbNKA2MDThbNzSlex/rok7TDBMHGLgOq+8aKxD3ZWrCGQF93P+rQL37WykvOd7BcgCOojnsnzricObTnZkOFWBkYdRm3YLT7ZXlV2KiSxrfcnbhudRGoL/0ozwNFv90wcaX2az4Oq75QnyhctbY5eFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PBfULfro; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PBfULfro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiaNbIClLxledeIajKWvdx5Ob7gMfkvwignfDmpzF7RxotkQVK4FiOiLdxWW48ciNc+KOUvVYzIjYESPH/MZlUv3a2NVbC2cCxuWlmoJaOlzyz0D2MhOTjqfNLnKpAOU85MjBMptDeGjF6kDTD1CX8+tYbDhHsnjNBqwKrN84bX04FPynNSGx2LCvxDeDMS/95dTA1d0Pekw0EFYW43gdcukegm60BWZ+p7dk+BHq8SsRk4nFBXAHyn7HUKA1pg9ukLOvVipRktBZFlJ9iAXtl4Tgr7mn654VoamJQ0IAdEs/vn6lr0Nh9TXHYY37O2WWpoeQmqcWzgmZUtP9pdNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXTWLKp5buUrUSI/starxYNm/MqxPbw0SssvJHdeH0Q=;
 b=gUCEJqVIpbL+kAJx7wjg29EP92acA0WE8tkw4/6nAq85uRAWqwtof07oWgXfAJ+SKSdfRCNLLqOuzCt5XBPG80YabGlz18brxpr7CIj1ZWF9HBXxu2+wNp+kZxOIuiqIaXBN6hMs8JaeLTH4XWWSfW6LVQbMlPxnYZzlsBvc6OI0phpj4GySaDskDnH3vpGRe3Zumx0Dvgum97J9uchwlNXIFMskCadNJ30+Z6vEsd5mAWaekzpQWqkFRxU1S12Nx3cBAbKsjhro2CJWJQs3G89KwGaULXA7LNpXWQzm5hqd85EeOdVEucGqgPiim02AViu9S5I9QOdhmQCS4whdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXTWLKp5buUrUSI/starxYNm/MqxPbw0SssvJHdeH0Q=;
 b=PBfULfrol02euqqbxu7+xHVfyS+55zo4sQCB6fJTuctL1ktTTb2ytgKk5V/yaCLtxeO3UtNR4gxlqFQcOYsN7G0cyKN27CIMsrrwXm8/3cyaQo7BYQKlp2hluGkMKb+21xFbb5buDSZEoakDoOq/EORsQPAKm2MRftnJ8/ueBrD8FQwrRblEZm2/2Rz7aQy41x5u3/CAU8OskZPZqdH4OF0bKgKZo2ILaXFBVA3h1Hdpdd/FbylN7/1BTks4z/VqXfDOjzwZ48PcgjDdh0BJ8FFeQ3U8SIwyX/3KJr3glD3I93M5FZUPQWTiwa2jL6opf4/JU8U/1Jq9aI0ByoJPcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:02 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 32/43] power: supply: rn5t618_power: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:11 +0800
Message-Id: <20260709033428.362970-33-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b479831b-41a1-4bf7-a389-08dedd6b21e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J6wEzYMVDfnrHRSkC3yVzjJAJOeGOZoNE+K+qnWbtOLJo45t1eMVIjhanrngow1UEMTRGgQVHs3L8brdBNnKHShSxiR3hmEzpf4Yd9jP5E+a7b1RGYhDMwOWEuys9Tak50tguNPwxamG66xBO542bbCO1n5VmtP1b7xZcRMNdUdnVbLye419uFEdswt7LKL+gnq5tNVtQ3JWImxhmLyyTxqakN0bJfGQFl4zokEBAZjfg/+XCiVkTNtbF03/rH+acpcuoSamsbg+xXvMnFfCi3Pc9ZV2QSCWNm/63UK8rJqGXULWSA2I2z+OOgDD6uePyvLMa19IY8r9yTOVu1wFV0dXeaC9k2vH7ds/mG4uiaot5dpohXDP7TGeZwGm3HtaGQygRxtAbPbrefqymkBhm8SuTOR9uYwzZD1gWB2lzoftLc7hQS+asviGiuhm35tq8+aXgTHBsPtoluBMUuNObDD25XKLENTNPuuB76JlMieXeWuSKVyA5iadgAPoS0zHz6BDYh9hF450CBI3oq4uvkjrN3CgQQfKSz9uQz2PJe72RJ0tEimptoSVkXbQ0f+iRBUoejULBwIccie0ltX74UO2z6+VL5rqgogOd8B4QDSpRAbXTbo+ETt4areD95+CylhS83381taOpoWBi91lR3KVy8RFMO+C1uNF2/NN7lx/zf4W7CwiBHtFjK52xnFu8rjOJGwJrBKNERofvJURlAdHXugipMq+GcvbdKGmpOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhB19I8kewNMnVRDTYudI6BCcbakhVfr7Parh2jPGk+UyoiFfLCbAQHyOtjq?=
 =?us-ascii?Q?hDC0WNCW+3q2MQcQ/pkTWZBi5A3zwv563Xn8F+i075WhWeVnDSiBtLueJ9ij?=
 =?us-ascii?Q?uUzKm3oHqaoKhcJs/Cwz5lo2v4SSLoh5iULcn3I1U9IJ/1vXQXqiyf5UENXJ?=
 =?us-ascii?Q?9yPjn96pljUqGw3xY49H8BwyWeMTwRISo9ReHH69FS/i8SkNhyJ0BbI0+JsD?=
 =?us-ascii?Q?f/aSJepX2YtaQvRWILDvycTSTMLTDIdgCvEKJqWI5peEuehoaX84MID6yFow?=
 =?us-ascii?Q?M7kr16Y1a3nw1kAtQPukvYQ9i93Yxz1cxJqlyVyEsA+/UKJPqt5jttVx3YMf?=
 =?us-ascii?Q?YOFZGuxuM2gtLFyikXzqRKZv1z7dUvr99SeviawYQdHKziQiRvGzS+EIwp1y?=
 =?us-ascii?Q?H9nVVxNLgUISZD6o3rOqqfha0Hc9mWeIPL/ONCgRtClgxA1gsGQDP0To9hQs?=
 =?us-ascii?Q?SS1AiAkHsMICo1DprsHnV/A8jT4dDtCZyzUGk1NSpUHXOo2nlIxc+dalcfhk?=
 =?us-ascii?Q?pcMHr7TtBqVbzryfhWOw+A9MkyLRyYl6JHqXdzd8pUNJ0obJKtLWZNRY9xqY?=
 =?us-ascii?Q?x+RIega0kPt3t8a8c/qm8qe/sIumIXiCa9Z+kw42qw/PNtXKV7UTS1Ydme31?=
 =?us-ascii?Q?8H8DVDWWTF9yyldP8Kyk06ZgMPGtioMfiUBPqzw4HUtqisDuwxsda/ZRwTrp?=
 =?us-ascii?Q?oSWqvzE9h7YL2Ti5gH3FAyGC3DdLP8WT0Ie64nfpmE7qvZc0Xqi3d4r0Zcpg?=
 =?us-ascii?Q?brsXbbEDaMZrI0kQazx2/9HkWc3t5Lep3/O1H/DjNEzWhWmGQG5vV12Awf9v?=
 =?us-ascii?Q?WfIxZclfWJl3ASlrTvA4L4UWiu31ijQufgmzldjInbDYlMbjIukGahyVIPyQ?=
 =?us-ascii?Q?3xxUqwUG0agaQPGCMrfX0nRlJoSMRkHNfLEevte35nM+qXiMVFKlwyf/OWYo?=
 =?us-ascii?Q?MrQWn9M3DV0vLFf4SDm6sUwYocuNUP04GCFqWaCFJu3721hQpUQ/4bIC37bS?=
 =?us-ascii?Q?wZBljb7uzjVWZOWsu8g/QExxlpg1xFbR2FkMxppe2VMeX67AqcpWprU0aG0T?=
 =?us-ascii?Q?0juY4GBG+fDIUjaWisd8qzHiq5GnXpTRstExB26Ub6faH5kT6rnXM+H9DjOR?=
 =?us-ascii?Q?c5LF7Qk6kVp49jF0QPZUrEbC2klAND/pZ4AGKhpfAlD38MV21w+a9icg5ndY?=
 =?us-ascii?Q?95ImGoqpSlRwQE3VqBEW4mexJyJbFUSzQb3TSV+jK7PdPeqvPRKLaX5wWD9Y?=
 =?us-ascii?Q?I6itrUX1j1WVXeRjJPhnMyGLI9cg9/bL+QXTpUXtz5ZSTgiwJdAnzEvsCyF9?=
 =?us-ascii?Q?d2d6KHyJhuAV6uSKKEX7dOdXRiQ+JSysqmzXtJNXVgTwZOeFj8pzOUPsiri3?=
 =?us-ascii?Q?7RPGXY9Xkky+ESZtu6s/RcToEWt8X971u9ekYaCf9JGMvM6Nw9I4hDgNPiwF?=
 =?us-ascii?Q?5950aK8myBOGZC+hVZi2KgkoApbNzk4WZGNps4yCEKaGk9ZxVlUieZepssCi?=
 =?us-ascii?Q?c0PByf/L0pupuF78JtSJkMsWjitUhykOCYjnaTYap+ro3RuFsNNaqGQ4cMkY?=
 =?us-ascii?Q?hJA36Fthr8Jmd9WUjWM8zRpAeF8r4ZQWwPA7ycUz1cmwBfAh7usf/W8Rqnjd?=
 =?us-ascii?Q?fyAtit+TQKIJlOdsBrkhm9MRok5X6JLTiwd/Ifpi7A/yoQtw8NCsVZd8CTez?=
 =?us-ascii?Q?kG/QOdwXXmEenlx8iGuQfBnvtDkLc/mL39qLToahU83eQX5j0avBHQzk8mxS?=
 =?us-ascii?Q?tlzfXQPvvA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b479831b-41a1-4bf7-a389-08dedd6b21e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:33.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaNmF8Pfs/5pmHK/vUer4BIs2lm23++hjwEo/WEThGFgdmyWzqmM3ce+hWhfT19DLtlXcxe+kHKIWm61qjhOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/rn5t618_power.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index 40dec55a9f73..5963a55341ee 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -800,11 +800,8 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 						"rn5t618_power",
 						&pdev->dev);
 
-		if (ret < 0) {
-			dev_err(&pdev->dev, "request IRQ:%d fail\n",
-				info->irq);
+		if (ret < 0)
 			info->irq = -1;
-		}
 	}
 
 	return 0;
-- 
2.34.1

