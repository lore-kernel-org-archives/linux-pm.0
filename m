Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B03B2D18;
	Thu,  9 Jul 2026 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568174; cv=fail; b=HpaDDlGO1+rIxkvnQT0EY/nrXC1L9yKAjXGK/wqd7iK8x5LYU4cXt0VKffZPFnHYnXk5vMzezf4y1G6EDCzR6Oyq+e0uj7PUpGkFKDr3Nk7ikyFLZuW9dOeJYZyaYwRmCHzqL8darWOaWB70APXkgaI3UTboFv4tnCnLrf9u7MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568174; c=relaxed/simple;
	bh=akAfToWJ6u218eEdzvp4ktt0EJNHmzZvThR+eZRc7Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYysvqt/Uknm3/UwLt/xurQkEYeXnoh7/m/ozd0PHAGKqEg2ZnlmULrxORZwqoC3euX+ot82t0j3mdrpd5oJ/Tcd1zG8DhDocKShjPeSh+dernfqqXO/5yRx4KgNXn/xMVT+rgv1DX6szJ3zpWg9MMBGMzmhlST23VbTCrRcKk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vig6jOkC; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vig6jOkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k76bidB3WTNWCEBdY/L+vcBKZa3O7jmgIAFSHpIjS3Hpn4IykNmi5CpKKgkw78nnNISig1p7R3+T3QZqq97zILplWB9WtigIAMM7CDcEFfHb8A0hofBYChbmJgqI6Du6gyg0nxX3ZKs90MLzt3VK17CZYHTbOUfhBkbQtmDMIR72X8HB0U5ZAuoI+LMP7pGSzPwrZQkzx4mChyPPkntstd4/dpUcR0AONQVI6OhcBwPtuGaAEjikZEmYvoFcVdy3SBMbYN4nT5i2/+Z+vfTc381I+BOihAEa8HFurkR0H1K1tjZOpOtdUmwm+0heEWBnbKrCHLv2Hfr+4Cz/NwZQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSDazNjtbm/IZDNxSRt7DxITiZo7mU/o3+0dY0Fnoxc=;
 b=v4ij9lQ7Xl3oFqgMhg2b8rFRL/uENFnw3NTjZE2VSgcYiHpIBTYEpQuYtfNT66XoAP2ulLyt3Fa2wXNfaw+67lLt4NM6Iny2xVkCigJhZ+uq6HD/2ag0zuRjPCMoiH5Xh10ioBYIuqnYtPi5x7dJOmqXD0+BDfEuQqIq/QfCBpMsrS5MsPfk7xMVxpnwT7jI91OA2FfgSW7CZKzHg1vsXLEfEDpzx05TvRqNXUdx0YKfOVJqrREieh14eLXH9h4hay5C6iDJf/K0mRCMuEp6aaW0mkMcVENCMYLTocv4B8Enl5P/3kYh5I5IgtgEy0QPqhFAbPRm4JFziaUH60eQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSDazNjtbm/IZDNxSRt7DxITiZo7mU/o3+0dY0Fnoxc=;
 b=Vig6jOkCBG2AKKFQviE27IZC3ZPROdwuArVksls+LrR/uj9liTfunzbaRHnPinIL6agmvdSCqBE0DdKv5P5OICz7TDi6R5esNAYSGE5dxUw5yHWz8Nvztd9yzfgp61AL2f137/efIAGaXodtlRmIfixAlH2co3gfBiMDOUongkFTACwHBCYd7D7eJGM/fW1/VeMTylrgIRyY1nCsi9/enK0fODYftqmtlg0/QI9z2bVmUPsoVV3SqhQHqYj8Ncu7NimWb4ql+dWD65NIP6K05pSL1xZqmZWoG8W2C608OYLzw66DUFBVjpMDEGySZcvoFtLjHgy3Lg+gcMcSAGQ9rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 37/43] power: supply: sc27xx_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:16 +0800
Message-Id: <20260709033428.362970-38-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3c3e3e6-ae82-4401-7865-08dedd6b264f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xb+8WNPzv3lKr1puSrhbgq6JtGCMXp8WCOfSl4Uaz4Unyr83Hxqky6HTQgqDBTjfepsNOqRMfEWqYU3IUn+OAnlxYqUuDrEUHgl/R3YvKyLufcMYqhfgggMIl28sFE92jsZ/2nwZj8MvZASU+6lRXEBx0Giwv8ssix3qVpQYS+VPOcttHbVG+2ESlFMb2s267CtKVoW0ymZH2+d9xFL8bhG/4EBK6EIMNs3k4vhJNWqrgsRO0aw1rQIPM/wWNe1A1f+jhBq4FFM1RvOKhYleQ3ljnmwAmE0UP/TTRZON9/lSzHdlYyHrdpnvpiQlEbJP7xuq8olQ0Roo5gl9BdVf/sK6LiEdCQs9Br7ndU8Hp05HcgfPC9GsAZzpv2NnySv/PcCYpixJJ/DJ3/stTUVX/5mgJVb4/WcyPLwOY/fKftFlSyA//4xIzNWf7csNgvrNE39IC5MPB2rvjZ6PMaaaHvJm5KyNbHEl9WQGjR/NkoPMdtK/OPekUq0ij9AlAikgTZWDgo+KAUB4GBFgKkpNyFql9UhztvjpUxuUw/1NmWmNpd/R2NAPfEbcOLXeqD+FFMWmVPbH6JBqw9cgym/J4vnA4ePo3vhY5vDzS1d6HucoamwIoURgI9XdBVSMU7L+d6YTK62OsvPztnpzVoi6wRVahtpcal4X5Fs4PnZBZc1YgjL/OZomShLJBQ72Jy66o3FT/vyMEU3OMQJ8baRoa2iEYVfzTXxRgBoxXX5KU58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Pz5m1QLzyTNRpJa6HTva7/X9IYbSTdWVLbl7ZFifXe0f98qhcO19FgQrtTC?=
 =?us-ascii?Q?jmjqlTSIQWCR1S2b4WeDh3HmHhTwv1dsK49aTCP1TIUZJVWMGHhOjWoyoPbg?=
 =?us-ascii?Q?OWeY0X6QOAvlcF6xfpZ2F4NvJSPwe/E8DFVURsCQ9qh9KMVNCYzVvLW+CKMI?=
 =?us-ascii?Q?Q6POpwGh0WXAS/lqnEBj1QZBBcE9pwMm41fjkDkBFI29OojF8HaPbhmZA3wM?=
 =?us-ascii?Q?MN1HGvedoUtxiwg7EyDKwwF0zMS4sxq+8/X6NODDmhwLeflJ2FmQH1aH7e9E?=
 =?us-ascii?Q?Mudbk2wV+0esXJ3q0KXFJUBbWwCLxDKTPdR+/A1u1rDqoDXI9ErphptL6uev?=
 =?us-ascii?Q?ddcI4fRk8a4b0AYbnW4MI45WihZzbOefws7I3IPT7OEFawvbNIOVMI2CPa4H?=
 =?us-ascii?Q?SYVVSIEWseQLj6Ih7pyyBODLotJfxgkXAkenavEtu+uOkYM0WbFtZ8bc2zcv?=
 =?us-ascii?Q?VJdrNl/GVwF5oHoNV+3Y4etsuu8c+2lFE5D4bGCYMHU69KBNZic1fXXBlfGN?=
 =?us-ascii?Q?jjuv6+fZDdXHIiKdb9zNN7UPTJpNRTNEfeO+mqme7T8praVZ9UWnZA1K/KCS?=
 =?us-ascii?Q?T7ktJmIzZkq5jPa7kGrfAHXO9qSpDJ/Cu4Op4GxkI3wkK3uTihKgH7M5lUw8?=
 =?us-ascii?Q?oaMaDbgKOoEe5OCSLAVNhJSiW/TXajwe8dCeUBTGF0uq9T0BhusMJNhgNDE2?=
 =?us-ascii?Q?7y6OHXY6tNxWMtgX91x+1GaLorZZBx1uOlpkA3Y4Nga1jI+zQnZXgYf9Nwz2?=
 =?us-ascii?Q?CLBAeeTy5+LpLg9C2WAx47o9G7qtsGsqcUNo4+I5BAZN253wiRejZiccguO+?=
 =?us-ascii?Q?weGUcoc6rUhU5jvggJs92skeOsHcsedJHfBXj2rjhNNsz8rjBcYpcpjGTq/i?=
 =?us-ascii?Q?3xILMNSYTrGw1qVr7z128PtbnbvVBU54VQPI5Hr7X4SXaMm/qdMQ5DkdOTtD?=
 =?us-ascii?Q?R1ZOLTyKDL+yXBPh+fGppqGLHHHQDALWqwfFK0HZ0IZ5XhC1FtnvgbeZAbg5?=
 =?us-ascii?Q?FpFiJtB0X5ZxvSJXLYKHqJuLnihpFjzRNS5RxSWz97vhrD5RSMNnzte4HKH1?=
 =?us-ascii?Q?mxHSnKYnb/CSdd5ssP1+XYeD/iVhAlQLkZFSZSE+iJQJedvA5mUYonHJ3l7w?=
 =?us-ascii?Q?Tp5DE72VlolAGGUZ/JbfkOMLl8XGUcr1E1vgdFnPhLNyM+GOMd56KBq0OZOZ?=
 =?us-ascii?Q?AeoAhvmL/jVlzYN9PqZ2HpKDVbGvKyiadqkGc75vy45E8UXN3Wd3PFHRYy49?=
 =?us-ascii?Q?rZlhgFFBDHNDdjCN7CjJytiFZyDKyvOaiYZnFXIPdMlXYCxhyqy6XqT7Mp42?=
 =?us-ascii?Q?n+wLhLZvz7S8ZQoVagQStwp6cIVrAqzqYWPKSOUcBil0VkJZGxmxass8JG3w?=
 =?us-ascii?Q?Gmu1Vu+y2dbzXZRNtHGwYR/WxeuFNckFuVMdCLaJvy53Cj6mIr3pJ5kIlN4z?=
 =?us-ascii?Q?jzsEWrBXdg4CsR6BRW04v2yxPgG7FKrS70pZhK5gMXTpulAsUR7HN6WsNHe/?=
 =?us-ascii?Q?3x9Rk9tAaRravLKOhZIbcdXu/ibhKIh1DHexSS9WormokeWDvnH1i3OYswTi?=
 =?us-ascii?Q?CQWRH6whjhHH85q/tcFuCw2ZZS2vv7/puPKdZIJZVjnhcdFfZ/I1Ik3fIuk3?=
 =?us-ascii?Q?spSJjgzbYwbwVw8fbiB93kWbl1tcoS6youO3/3JWUj200tufMrL+mSSEl28k?=
 =?us-ascii?Q?RUgRhq1FoY+dhUVZI4GK0L8zSJNpDXrhRNzyepsIa6d0cDD5QAYWY+l3vRyH?=
 =?us-ascii?Q?/sZOOXAl7g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c3e3e6-ae82-4401-7865-08dedd6b264f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:40.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bva+O5JTIo98HmZAoF7HvT/gIy1u11DjmK+UBIzlBWORoyfD3mfnJhRVBV0Dsp6uMBenrI0oQHaMeqLsVlLmjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index a7ed9de8a289..9af0017fa88e 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1231,10 +1231,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 					sc27xx_fgu_interrupt,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					pdev->name, data);
-	if (ret) {
-		dev_err(data->dev, "failed to request fgu IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	irq = gpiod_to_irq(data->gpiod);
 	if (irq < 0) {
@@ -1247,10 +1245,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 					pdev->name, data);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1

