Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04358399899;
	Thu,  9 Jul 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568172; cv=fail; b=OUEyjNLddz4nHnpSWI6ELNSOCXAbSVg5idbNrFa5s1p/vdFTYVK0NOpx+Qmo1WmPBtHVh3tr2skOv6Oaak5vd9h9WjzdFLIXkOYSsRC7FjpYaq4t0NcTpBhVw3XTotyr1NcbpZ34LrlzQIUDzZ56Te7VvnSFEU4H1JhsYtH6ttE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568172; c=relaxed/simple;
	bh=6O3P6M3yb/wDLhZmxj7lA9upGXxHSaZJnMoS58LmAS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqeigUw550OgRsokET0TXEKWt4wdUgTojV69+BbejDztmlbMHy1hjutME4y9pWBImY7tC37TfS95UAIq7p2shRphQvQwrWT71lgIkF0GZha0rVaXYBvcop7WE6YMUr352WQzYVBpQONRUORbfKxpMMAn3/h1uc4iqELYIKXM1rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cogkKOcv; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cogkKOcv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJMOMUXNRjCzir3VrSwrbkqs2wHSn+rrfR02OJSXsvNC+wBqbMGQsaEeH+H/ByqoDWfk0UNxCoBNpe/bV6c1MgRtd02OiVISo01ZyU0sZBXIC0LbHuKapMrVpN4aMJLn0/erxc5uom/Zn81RG9CZr2wZHD7pDDjcWabXidZaKDakLektsjzA3OWZ3oe6QpPcgeGT2za29ei/05zkpErZVVR0wgjIl3h2ys3lUBVGkVJXq40Lo9fPTe9Cx07a2v481DfAKt1mtCiE73Ml7Isw+UA+iwvBDuR+xdp/sRtMjOvPST/Je6r3xsiG8ELSH+W9CHOpd2n5rdcBuERwRFuWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EmkFD33orIw5SRvPeQwrZUugp9l7SYgg20U2d/iQsU=;
 b=QomOIFapYpC05Lu+L2Q04kvaMVBruMqt8VrPUsdf/YYXEOGxriWdMm7OodM+0TVPSjVZHZ3VePxgNXhMgPgtCO7kN5y5U8EfF2dgVz/kL80aWVXIB/6QvXTW443o2z5s7nrTBC52otNf2wRbj+S3yOXFsxpN4tRe8E0pUjOZMuOkmuDbK5CUs9uZFA7CI/lHcCGBCFAYkrRtHn0i+zdIBIvoR1/Emuj3h112hNjPI20JpmuUhaYi1hzkGsl+FywjfVqiPtchEbRAl8Eu4cRjw6G/b4Noglh1h9w3Ap8b2ewVRw3MXG59gQIKThQx1f8zcvUkO2vED8P7wRwl9rL2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EmkFD33orIw5SRvPeQwrZUugp9l7SYgg20U2d/iQsU=;
 b=cogkKOcvcU8OFpC8aAiYLKPxpjLoB+v3h7bjPdxjuLeCkpC7OO97EiANR49xX4VwMieo73Q83CPFidySVvpfRks6QF9bN4EuhkN236K9HdMgaOaDAros7h96VQVhv8RA8WGxN5xkFykvKH3ktenHx93L5c/CAodyhXy/Zd3VXbg7GZm4gyhkqVGK8Btpo0lnwtMaZXwJosAVz+epRnLJUtk4IIDNV+MwGwpG4u3FkdROO3inLVmLNPjGZYZxjiFiD6OyLv5x+KWznQFDaZhHYaLC6K2AsNGM933muZa6qwuqEk3RMVdlzyGI5mz5Bq3XJsyHOkk0lcGa+YpjauNrYA==
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
Subject: [PATCH 35/43] power: supply: rt9471: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:14 +0800
Message-Id: <20260709033428.362970-36-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cc3beca-ee57-4141-f57c-08dedd6b245c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b2k5lPZQuqpFxnLzPZFjqpTrsALKpmBkZfLwzv8CrkQHpAJvNnJwdAXzskVaXoWOCO0mKIvWLzVUTgCA7X8rfUrg+NSCsymZY5Imuipg8yhS/0aRKAObZanu92nZ3Ne//QtZuxhBMguSVOX+qGVWiVU4SGJ16pCdPP3G4AFj7v7rOY2Bn86PuS9JEG5AuSmCfIMfLTfZNkBZKf6R26GImfYIawmnPTT7NyqU1K2EySl2SdF846s+nkZ60blDvirxsiI8YTKC+L1w8qIZ2cuq8O/X+qVNiVoZimh+cAGvKABf3rb54pdOIFSIys67NnhtUPBls1qpOmAHekpKIU1489tt4G/MGf/iHgT1WcUUpKUEotg+yjYaeLac9ikPNvNpGZdJnOOy6Hqg9rC0MXDt5lRZCG6OdYAflm1EH11sAocrwqaneBWnvGMv4JiDOu5ujc5PPqOGerIg02gvRGCkb5cMaxJHCGUVxjZ21ye2kNebFATmigBrszVIzieqoacbOXl029zZZEehqloGGA3uC4vHc7xkgPXTT2sTxR7LWqVnL4Gon/X4qRrBQAtOxQc+LtbknMWeYuRz4prrEwjBHLUE1Fvr3kgp6TE+bhVeTwfWAjOa+vEB+d603aCkwKjLXhYJj4BxR+xbWuto4X+mTOz5+Xg3aRbx9GnbDChTIuSuUJ/WiNO/wWKsdpYGStqosfs/gT5AJ+woBK1KjB+V8aCs4CTt5uhla/0GBeYbqcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4P+B9wcF0wwEPDW7jz45Y0U5CVILcAgxk/p57zkAzowRrcRxGwO9N8++iy2E?=
 =?us-ascii?Q?Clt8SQFT3YAFbSrHN1nHFMdWQDc57tXRpOFyuXSj/RSsJa/AjzpBYF2HVlsX?=
 =?us-ascii?Q?BW2FX9mC+7HLAySm5MIXjfca2kgLjZm4lD6LR9o+Gu/ye6pNj6kgyXQ+vtyY?=
 =?us-ascii?Q?N8E7F0bwPWhTYRzMmHwlE4SNkjPdfdkFrTYfg8IEGclZ+r4oVDNcYTKA62rc?=
 =?us-ascii?Q?5zNDZMMc75HKnL+72qKnr15OiNmqQfXQ7lI1A8rqugULjMtn1WUHhyeiok7y?=
 =?us-ascii?Q?b1l1jrx4++ZQfCOtAmn+I0/s8PXFHRpysRS00rgkXU3OyOW8ThuGFymgkCTu?=
 =?us-ascii?Q?jhc/QldNdR23POtX//ZfGFoqY3TORuLx2vvSAbjYsVteeEvRRiPJJaw35c9P?=
 =?us-ascii?Q?H1rq0pv/PF/HnI+5yZuH2aSUMGumQ3AVwcngMYw52SrOhd7z6YW1u4gJjtjM?=
 =?us-ascii?Q?9EKkh9zu/V7qbah8MFm+c1veaERHAsrq0QWbg9BLF/rIOOTB4JhMPF5+q5j7?=
 =?us-ascii?Q?IRJnxO4wzDafohfC4I69O0GLaZNiR2X5a9CZN0evHHqF55CyHT9IMF3cLhIm?=
 =?us-ascii?Q?0dGJzXWhcJXxbJ+UokwbZnFXfWKrNEqbS8fQ6vtbaUeH8n00g80gu7RR9LTC?=
 =?us-ascii?Q?0r4BR6joHp/hVSwR0s5F5MQ0bwt5BxzAcSQLmYpT5eUe1a9B7I3nEnn3S77g?=
 =?us-ascii?Q?sE5UAUb+APYXtXmIuJQF9UO07JKwXSR/I5ZVhRsEg0LC73GPsziDlRyPOh9p?=
 =?us-ascii?Q?86+bH9KlYZHwD5dUTzFSl06UZaSf4fc6K0mVfsnVPjlHedhcCIjzuxgejdrP?=
 =?us-ascii?Q?tIW5Nma11U1m3HLY8xklQuU2QqJVBl/FEZRQPlsY3NRWkwpAHqxt0AG3vFWh?=
 =?us-ascii?Q?ODV9/qDZ7YSHXTbLrfogH/bZuTozdjD0oU1qU6mYyHFvBg9zNdrzlQQP1eRc?=
 =?us-ascii?Q?P/bzlKWnufcAS42KjpwK55c76iI+QknAK26/6auVGBwQB6K1y9Edu6WqwUiT?=
 =?us-ascii?Q?RbzTFiUhrnt6OI7pEtAOSDf/ihrNThJZmScUndmCnm97LrZqjNTNK/bj16Zj?=
 =?us-ascii?Q?GY4AigQsiOTAALzFdTvy1QipkXEsoAF3oCqClCm9q7smojg89CCg9JouE3qH?=
 =?us-ascii?Q?q75WCoyWQOl1V49XtI0ZWNfDE5xyDub6vQL5OLgI79RwP0tjzB5+dyRHu5ev?=
 =?us-ascii?Q?TB+V3KIEzxCDVfxyzjCRracvi0szczjDGhYP8/WW5Ed6S9EW3UwRQ9r8EYZz?=
 =?us-ascii?Q?PGMn9iPUiqLNwbij8OkqE5HyEqXvJrYO/dHqb4BPnla9dmcK/sJIspmUeJlS?=
 =?us-ascii?Q?zYXVZc395It9uxHkEG9nUUsyZBk2K3wEbjPb04iBQBN+eZJ+6OiAa3zQejrh?=
 =?us-ascii?Q?cC6xQplIvmaN6uz2QQ3JnR94xK9lqcycak+RhAiyYmbEUoXD6xjKkVZk/qjT?=
 =?us-ascii?Q?AxTg3HLrjV6yUC9TYfXORmA7oUAwoWZgR72ImzVWiDPgTUrOT7IyZpt8OWoJ?=
 =?us-ascii?Q?a0k4IsooXwylRS0lcypOswxkdFT7wixlEFSIOom2luENe2AYYAUvYzO+xjXC?=
 =?us-ascii?Q?0fuyEfZza5F8kxuaGQBkvc6X6k+BpqJQyDiKxVAKd1nZCyYtQeSDiXxcrUbF?=
 =?us-ascii?Q?EhEb9W1vVV5ZasEMwREI/RwFlO2W7cb+MhntlCfqzwTKHdFXU+6uIoH8l0uu?=
 =?us-ascii?Q?Qp6gvKTIlubFzKP3fRpUnK/Ssp/dlVoyrIVgiAXJu2pkmZtDmTOolZZ0Mx9R?=
 =?us-ascii?Q?VuvpAZEXNg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc3beca-ee57-4141-f57c-08dedd6b245c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:37.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7eQMZzzHNm6JIq7QFK2jAmqya5HOYz3WbKo195BIZ4oCulb2eNv7VgBepNSaaEkW02ylEbw8JctDxAWwLqNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/rt9471.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index ca7d426849a7..ea0f865cbc62 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -583,8 +583,7 @@ static int rt9471_register_interrupts(struct rt9471_chip *chip)
 		ret = devm_request_threaded_irq(dev, virq, NULL, curr->handler,
 						IRQF_ONESHOT, curr->name, chip);
 		if (ret)
-			return dev_err_probe(dev, ret, "Failed to register IRQ (%s)\n",
-					     curr->name);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

