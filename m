Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DA3B95FF;
	Thu,  9 Jul 2026 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568178; cv=fail; b=J9P7eAwyPEbsBo7ZRb0p0jXQj1iQm6SOgQtRMgNnOM8dmJRaYbmURoTYTC/sLmZYVW5vyODML0uDTDdCVNfqthVxOZZMtztCN6gzuFnWsmcnHw1Wv/ByzN3U3FFCbAP3TnQ9nokTQCecB8Q9GrwqoLzzUlxd6RSzhF9uvrfUH+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568178; c=relaxed/simple;
	bh=aiQpZ91VKej7RjM+UMbKiXUiwnxrZOPIszX6IlcmCmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxOaWyfxj/gnajBw4m1cM3lkHmC9RtaZ/aOtaLRuyhwU3sv5O+etNd/zvCyxPKBheYILhjgbUetJqqCbdVOaIFkdP6k1ZuIZyiE7Rc9lIFlZn3ApCTHGkc1aCsITquD4peiXMO1eQJutDaqm/4SyaK4aSR9ELav4Ti3CDjDKB04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DqUTIc7t; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DqUTIc7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK403QjlvOsI5CRSLqzIvd1IJFUHWlBMnRAv5MSrAomFQlBkkXXS9xoLXFWUitRPm4STUv7KfINMtL7B9cE+VIFmg6GR4l7o6jaIkzGOfX1SS4UMn1RmNLG01bf92GurAwsF9LZPD3eIY55z/BiP731nvGtUReR0v6+3nE1/ptUWN+m3vzZpAkSZjNFD8AmUyJvRoQ1yHZfljwwRtIdKBp2yjvJxA7EXfeLMemhluC8MBrw95IhCSgHOYcAEqyyehKc0ryjWab1eyhc4D1xit3jWRu38hyCiVRI4SurPXm7xawkzu0qYRaaaQZUhpXl+ZB6ehmQD0QhHyCbgb4uLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ux9IznGT9CAyYc/hIegt+hTs/4Gpwx7F5Tluz/sY0k=;
 b=Y2viksH5aZLnPhhs4Aeeul3d22jNtbxCqPxCEQzT1drq3RUu4VsuHEQGJJElQEHuNMRSt7e47KJdXE+NiMpy+vNDwhPGD/ONicCUI5ob4D8xuvbkp4vyGPPp6+GI1KEalY8vpRYNGLfTaLpEokEN8HVkZ0WtExn8+8iqjz8L6hKfsk7f/DO97JqorF4jy1qUPW7yygFDTQQmVtmRBl6ED/VGZ2i2VUjYCYL0Kc/bAXc1UqJ6M1kmSdTxsWRtAwMoNSjYxdLk2IEpxKLcjko1BB92/s5//EAyYsyDnuI9/hHkNLP6uH8UdRQw5GcBk2I+EUOzx8kqVzkqcdneFs8gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ux9IznGT9CAyYc/hIegt+hTs/4Gpwx7F5Tluz/sY0k=;
 b=DqUTIc7t8JFdzelNu2H3DkI+gE0ysq3S6Ak8beVbS773mQWc40TllTlmCkkiznZPZrUY3cXc78lMH+tZ5aBtKyGPEEPR7s8g9XkowvSAJwgn7V3yqXhxmqW7O6X5V9uGVHvuU2ifO3UWck2EcI2k2KsoFgyPFMNykkb/qfcgRzRh+B+TvCFCCueaelxyNktGN+bNlpspjbeIC/wzsNyGuevYfWeIEBzEXl2s5b48qegCO9sWS6FYIAK5DtaQ1AWJTGtXAz/zx8HbwsghN7OaCzs3fb3S7Clk0exuV0NnijpcAfweDMsIxvHn2ark+ROqyAxN4uJVIfHrW1oJ8vy5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:08 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 42/43] power: supply: twl6030_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:21 +0800
Message-Id: <20260709033428.362970-43-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11759744-0936-4423-4865-08dedd6b2a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ye1a5odq6d4oalVtcKvnyCInMVJgvaJZJCOIZx0ueskqa5i6YaX363f1omp40tcE9f+OtKEUGD9HYLSMhqwMkz8qtOxdJUj+OBYgNVoKuMAvnVKZPcTWzWAp9rY7nvwkwRm7GmDXQENnTxFODzeRQNubsna8KNqpq8kPWIfgR7AjQVC9PFu6TnavyqZDabywMQ9Ce1i16CiRym6D6tKyFep7UlH3r62L4KrJCkVRdeKgCdo2epx98jW1JNSyGsdx/X9dhaGOEESU/M4gHA/MhrBAcYQn7nBKCY57DYNNMCZ9gPerd/n4T6+Z5EjMHqyV6zvFMj7vTgLT5UcUYCkWv0s9idnY90kUpXfsdLNBHJojn43Arp9S3zMJQTSpcZGy1ketww5Wy7FFT5SG0ui7aRNrTlKqeuSuUDx0haXEp1OJIY//A8B/r2xZtxCcq2Bu92hFIhxVFDeA5VHovPy6haSqB7IwPvlEUJHw89+y8orXLjKTMpCCdbXdyHSVj82w3ESYlUtvngowtugqr6KfyHkUDSumb5Q5cU6TlY3FKakjmdywru5eBt/mAJzXjV0n89osg6qsZXSbetT3rjzQ7hM0B9L0UNMmy4Evwamskfg4b8hqiWCFr1hzDFWJ8RXC2GFIrdLXsOKVuCBgl6IeiNiWtHdSedscxqd3J2R0Epnxtr75fncswSNWKrnNPlBSMu7Tf/zFVXcJws6ewuoYaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OViMQfiKlXiCYFcik+agK6Fsq7wEHrZbbVlgOXfWOaA7Rf8QpdAd0l6sATSQ?=
 =?us-ascii?Q?TCp454z9lU7n8uCTTrbBi2YJPFTUbBLdCSMA9/L4UlYI5a3vZJDw90hjUDn/?=
 =?us-ascii?Q?8KknekYJ5W1TTeYJCEcuBSVWFfs5ztnMnlylDwS9Muz6u79qL4y3slVPlYLF?=
 =?us-ascii?Q?8SRtDry5fpICaRlvc05ggXZtRWoUgEFBws2FJ0SnNy0gIzpI7ROjJfCB9vx2?=
 =?us-ascii?Q?vy2OD3jDMeMHT3Vahdk0L/dFJJWAAb0qgTNijBLPGrufKXNf7PIQioJc5AU4?=
 =?us-ascii?Q?QFGcF/elIcN7JBo2x81PDabsU+8Pqw8EncnwuQCgxE0kxWI4NwAKyx5UdX/B?=
 =?us-ascii?Q?8CkHQN4DZ/c+Ae3zV70idWf1/foaLGzTHM5iuIqbsJFdm70+vwyudEOQShFw?=
 =?us-ascii?Q?HtaEcocTASJvyNl68YOH2prv0GjkMSQGzzoZWgfWQej/fT0hCuIJ/m8g9Ap0?=
 =?us-ascii?Q?DU9w1cpAw47gD+GUNP36ZUGqeH1YUIUZRHURJxyJhcyS72496l+YWINtBqy3?=
 =?us-ascii?Q?xOzayGAzhHs0dYlivhvXi7muW+X6m19hFiSetRwt7MwHUMJO8Wbj+/Fn6TnA?=
 =?us-ascii?Q?b3Hx6pAoMgcJONsdofrneKeu5J+pmS7wSBW73nCxcFwu7RoeG4N2Ws7BCrjW?=
 =?us-ascii?Q?lZR/3zbxq0+zuIJQTVgLnu3EbyJbZ6GGqHXSajF1BK2RVTGrbZE97DCdC02e?=
 =?us-ascii?Q?Kb+YIxlwQ+10spW8MsgdT7uY27fo04VO0rTqhDsSdZ2ePEPV9WWJ+GUNQnXO?=
 =?us-ascii?Q?BjL4ZbTpKh++id3E7/XfdvSkNtgxma+p5J4RYHgrgS0ytaLLAR2T+fileMnN?=
 =?us-ascii?Q?TkvmdUOPYonGV1FefMDhzOXSAIkSm8zWCz+eWRRgpj4m3CRsAco9Y8scVqqs?=
 =?us-ascii?Q?OzZNhpwZ5hN0o1o2Syx1MVAMhNfR6ZMom1y8Tz7Pva/q40iUliX7XhoRgXpf?=
 =?us-ascii?Q?hNTj1xOPniL2q0xBK8GOfB3Q9KWT+o3n1cprEe+abIoYvsp0t5RDNNP2f3xm?=
 =?us-ascii?Q?LXVQHzLpsUi83hf3W/Z+qrVRniGwQ8Nw5+5c2M1WKClpcPr9ff8tEimo5TtI?=
 =?us-ascii?Q?K6eMtyELcAUH1K+IQe56U5lr9qi4KjqmMldWi1TR2r/3I5ex4vSLbn7xylQv?=
 =?us-ascii?Q?+1VS6az//L0PJka74rXFUix11O1sN98IrHKWAq8Z+8FreYbi67BjY6vbFnAy?=
 =?us-ascii?Q?+VQtJf9QR3QWS/lFRp0zHKd2U4skzXHcFPYFICX9LsNp3Jsrs4mGoV0DKimJ?=
 =?us-ascii?Q?GmjYDYHVFBcw0CxMIoLTVC+hL6oKtbI/eaP5g4Q4n+o8vk/S4nx5sU7zgMgq?=
 =?us-ascii?Q?AmCHs7uJDFH+EY/Ls3/CSCLvXmL/y8i4yKbHqTadQAXGWgj8jWCi+0JvcWKR?=
 =?us-ascii?Q?N+HCaIcmg//JIqkEDFbpVbT6/qxtefAPt+Q9sS00S/o9nZmtHWaKbRtYwpSR?=
 =?us-ascii?Q?GG4Kz1DfzRSHVLMpJrCenklBIipjsIBTUfc6fM2kBjnoBCt6apKGcRB6PXq+?=
 =?us-ascii?Q?lp8wbAdVjuFOtU4KPXBgv7AsH162uD9ojG5uGIgcsZhmOS5VzECzYfgJdQCh?=
 =?us-ascii?Q?PMPOvmGVG1c1UzAq1cCkTihQ+0BMF1JGwqgIlRD7p28A/81fv+nlYJqVX5fJ?=
 =?us-ascii?Q?uOw/YQNsl/mbk3yXC6BaXeMFHunSimHAJBQcbJWao1Mt8THKSoSaFalwREgB?=
 =?us-ascii?Q?/htKbkH0F0i+qPurqlrl0M3kg1TDJGgEQwfakT/EjAbUuuRPy1qRnwlXpdKJ?=
 =?us-ascii?Q?5bpP0MzH+w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11759744-0936-4423-4865-08dedd6b2a8c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:48.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jq6sy3h3j3x/SeGQwzBJe9HzuLpeRj3vKTC1u/HN08fRJ1qq3vYugXqKm4MZEO8sN9E5OKl6FK60gwwAuiGKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/twl6030_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/twl6030_charger.c b/drivers/power/supply/twl6030_charger.c
index b4ec26ff257c..020512d0e306 100644
--- a/drivers/power/supply/twl6030_charger.c
+++ b/drivers/power/supply/twl6030_charger.c
@@ -542,9 +542,7 @@ static int twl6030_charger_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, pdev->name,
 					charger);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not request irq %d\n",
-				     charger->irq_chg);
+		return ret;
 
 	/* turing to charging to configure things */
 	twl6030_charger_write(CONTROLLER_CTRL1, 0);
-- 
2.34.1

