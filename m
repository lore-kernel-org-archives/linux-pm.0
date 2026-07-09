Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDF363087;
	Thu,  9 Jul 2026 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564317; cv=fail; b=tA3PTOJynTrTjlf70ncAs3VSGi3/uAIp9XYJsXmfdRiPQM3TY5lPsEfbyxJ/WwW2/kU153DVi+ZxevXl/1F31ax50cx37X2v+kFbvz9nIpqt/4UyWZy/Y+gCSQ3VBc3AexSBDApUbcvMs2luPhu5571tW9wy6n/etutJhVsos7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564317; c=relaxed/simple;
	bh=nIFbh255VzlGUVuxlIVy/U7kQgkuNsUD1yntVczT60U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNlSvy8LanXR3OS4YNkd9inKwGJQ06lsuTK19N4Ce+2VFWq9b3bHlBFsskGoFiEArVXBbKtWMWiTduyI1UIFaZXUsIsOhaNSS6/ebpWw8wBFoqklORN7ct2jluL1kcjB6qZpeA9p7dwUshSRauujCrUugAE/t+db3h+lz/Ko+lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WGNkJJQV; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WGNkJJQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pujKcgMYgPD6xpzMj8MPaM14chywGnXpFr++kcenkg9bliB08rsAGZ/w1K9klm9WsbokL6UVshmuHveeuwWXdEl3RxFgBHVL8BaFLwoWG66lezKGupj1V1d7zIWk0dSXX+hSdj529fN4YaTWRJJv0dCmYvcw9wksOyWn92/GgLK/5H+4hUr09H3mJTUdMpZGYXZ8Lxf8zSsLAF+kcCjIB6x+Eho01hm5aBqUdk93ykExDzFfnltLDoOj0ojNzvrg8siQeQtTVkqo57dHxVCiTpMTYG8nv9l6Uk6aLR5iJdzbQMkmZzDZ3eiPCok2WZFBuRqFBU7JVVDJ2BmzU45Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQcJ2aiEwhDeFRD7PYooYxBMHNFFBIi1TlMbO5e2r7k=;
 b=AngW0A1YL82kVeTSAXANQOokm1fqojWDiNlNi2tnHhl/ZJ35vskAmYFKf3AEObis8L9Ea3661747ONsBuWN0t0GdEoai9EEbk77Cwfy98JG2gZG6mG3rdP7JD28NjHOGF77AQV4IfYJRHpa6uSnmHGCMje473B+xY/UhXkIAqfQxTkJPJC5rbJyoC5ilK3I2yiTML8thbNtkudynmyq+89fem+8JoL70Kz916jisQ+Qhq68pKJ/wwgsSAdc2ZYqN1Qa5ZeLCRzVRIA6o0cEPsDSSoUAMGMj+DadFvBpE621dy1VtMMTQ0m9+6jUxcGq/EQSHhDFK7gG4mBcaLaXs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQcJ2aiEwhDeFRD7PYooYxBMHNFFBIi1TlMbO5e2r7k=;
 b=WGNkJJQVhoUcp7/8BiBJYfTDvZme+JGdpKvLQPjNrgKeko8u2YkRfH8se7UT4p5+2mDEH391jGmhFFzBoauxG7gBrvwukMDHHfxMV9J+kj4SpZhHlrkSrdvFETWIyfbFE+8tA9qQOI4Pxgs7tPLH/AEC8x5nPZYd2ITUxKEB5j8tdTrk/5I6nEaKvyzT/CaxC4q/7Mjw+3VHJJVmErPIDV0+N+tbJ6dYTVi3vSA6BmBVKiYZ1OxBy/AN9DustROnAmqmY/WYvWCHuYYp0mbD8+iotbLIWpkjqMOMz8fKxVEhWISB3rSr1BntlooS/ZbO0URBER3jaWsyi8m7FWD1sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 07/18] thermal/drivers/max77620: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:10 +0800
Message-Id: <20260709023048.599150-8-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: cf360e82-3a42-4b4d-d61f-08dedd6239e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	EBsuKHOyznT2A82E70lR+cR2kPBadsGrt6ZwvGfEZo4uxrl4ovw8XlVcrRL7eLijnbgCbZ7Qbv1jDh69ujznjVMnR37BDJarpuqN4f4pzC0V2rxRIVSlmBTD5g8Bu83L22bfBiR1jD41sJmH5NRwEZCWzZLCexdRxAXz1eXXiOpVQZPaIoeTGzyi11bhWffpmEpKF+2Vqz1QSevWBQQ/Mhw5cFvhOA46Jj+UT/lnDE+nMpX0lVNwzTezKRanWofnnaLZ2WXMbVLCKETiZHMw/SJq2H8wl14lkgY0oA+DS2OtLFXvsKkyoDy6gJHgt0RLMtlMWYD+VTVbL+mFG6E6sCOAGfa8Ir6ScjxV4XD3+SH5eu1DnYYaO8jd6h1wyUQA45rxzk5MinlvG5yBeIkx55GG0DTBI2ljchsmwxpayY+dkB/bIlsYgeWJOs5aFOYOLkwbEwuuiH9eeGrVyh/LrY0G8AU/bG99ZWJU1UCc12xUgkwCg+LQQ0YPQDy6XRsiJew9Pe85x5aKoWmxz+hVdvsNYFKJ5UF1Z/q7fwYn9XiPfHtjZb7k5Clm8vfLCEUzrmVuaWAyVz7FGsqaMYbKdQhLXZizdGroaVt/UDWjUCZtK+mciZ8LCP4WVJ6H7rIjgYpWgYuv8xuo38+RqkXvxIc6hyRrCwS8/1JVUxJJMjmFhIn5qSpgFKNGM4d3lDDsyLprbFy6XmFgDdZW4YQd5kY0S+ZcpfKAOrWr4oUcwX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gB4eoMWhtE7DEYb2ctK1pimX5h6fypBl70np18iTxekkyIVwnoimyaluOr6+?=
 =?us-ascii?Q?Ky7qKfrYjL6xFMP6d2ONC3GrP43SvRwpMBzBe1NmqGxUHwLoCZBiM3n+B5u/?=
 =?us-ascii?Q?fuL8PxWor/E1s2wFq8oqHslQJcLqK0HWf0K59npnUZq3TrcXkPP2xik9CCSF?=
 =?us-ascii?Q?sU1QP7iV5wSoSsNSEs1utBvBc9B+HW0OS0+YbKRdwN3Wbtk5bR/vkyprXHhm?=
 =?us-ascii?Q?hfuc2fg1nuzymrMqZj4mTzbggZQrXLoVC/LZGokMquOt2qXkltylI2288BBL?=
 =?us-ascii?Q?rDm3zZEo0ND+DbKMQg6vRaQWKr5EaCopSVrSmHSLT3mN49ZigkqSqCG6RK5+?=
 =?us-ascii?Q?4hMoPRlAYrB3RTDDNGvioddwgiVo2rktw2WPbTn09JmTBOzEvMRubu82qS2H?=
 =?us-ascii?Q?czUaDKkpBj6JzIkEwToMFP9BqLWF014/JkPl6Me5Fx8/qThpB+jU7hr4aWm9?=
 =?us-ascii?Q?uzOsVipzHbbtCGbLt66jAt7HuQkAhh0+HeEAIHBkZqVbXhZxmrZHObGufgNX?=
 =?us-ascii?Q?aRQCrip+xRMUInG3l9igDQYkVLbbKOQooNt1+PcLGn56eC6MIf+40Zkavxt6?=
 =?us-ascii?Q?1xHv5ofs1eXFrNYAJjXIuoP5++7pu4aYA7GbM361pdcWBk39szmtpP2dbB5u?=
 =?us-ascii?Q?RGU+OpZRHciHtA5cfIYu6rEO1wo356uppKcdoo58GraR0Ay3owfpfdo/VU5q?=
 =?us-ascii?Q?OVxRSmfUunPnH/36CzPgQFNPHLFKA/EKbHT8ljBKzZCTiRhkQLiio1Q1wGT9?=
 =?us-ascii?Q?FDxOu9xiwjvLBDEKC1rYUK58cFg1P+QVdv3MgDpBti8Feg6MkjuURAA4mgRd?=
 =?us-ascii?Q?f1PQkTHfYPiI2BAPU1xscR9qjpJO9asDTaCHy9HGvcADmmdnCeWC4x0/TLlW?=
 =?us-ascii?Q?i57J780dzdMaTDARHzTc1jioZWlUsckhHVAKenlWAy1vzy5ntVdUJa/c/YI3?=
 =?us-ascii?Q?YsS9Ymjq+xyfZPR2sYhwTQCNZ7lTxzm1YSFEl7AwEXMakXd0fdyemg9sob4V?=
 =?us-ascii?Q?Qs1QYeIX6WsgAQSSnEQlrEKGU0KD//XAePFCb1az69qrIPtdNIhBDlKqO+ev?=
 =?us-ascii?Q?CY/MeE+2dK1UWjAb7HA7ESOzMYRhrlaStdnvYpCotBypuMtXPB7wpmmioGni?=
 =?us-ascii?Q?3Ea5hYTSEsQB/JS/wpn/GyZRHx2m0/9XIirlqMTj71zWSjDtk1JsJCnud2Aw?=
 =?us-ascii?Q?ZJeB8UEbwUy5/9xwI6X6fc46EKY5gx4h5IHsIxzkkBA4nwkQHqfAd2ASeLXT?=
 =?us-ascii?Q?qnmVCqN0TpRWBk+x8nojez7fTnNv1x7IH2s5MrK9vOrXTtskvmkKKRZDZZFY?=
 =?us-ascii?Q?R47si8lN9BssDdj79FFZKvYGigmwm53Ko0sLeeQFuA+4y5k6krfeSjV55lkg?=
 =?us-ascii?Q?0Nh3h2jeVUd8+vBFMJQayBhYdJm0bPgQhDmTBKDHsm6exvrv+PkHbBmAficT?=
 =?us-ascii?Q?Cp4UsUFgpJU7dKGCv/XDCsYjZOEp4/4VJWWUuAQHYVZBW4OS0vj9kBtsnX8V?=
 =?us-ascii?Q?eZdcOQu+hFs11pMo43IqIcRxhXZRyOj1U5ZDMEKe9Z7j0AhVyIV02Pm5neio?=
 =?us-ascii?Q?8G4sLfIiqzN6yfyNKHbGSpxTQ4fzuN7uWDuBA9TCgoCl5Ss407JvdhF4yoBQ?=
 =?us-ascii?Q?l9BtvEbGFEHIpogEhlB5grI6dOmWN0CWL4+mxHWimu0bTJ+f07qx0V8VgPBp?=
 =?us-ascii?Q?QqE9fHWmYJgomscLoRMvvlkEEa6IeFh0+iTL+lb+2AbpZVr4kvwpKXWTN5J+?=
 =?us-ascii?Q?EEvfw3Lu8A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf360e82-3a42-4b4d-d61f-08dedd6239e6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:48.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn+zm7zYVPPEC9C9h0qggMBXKu01UE2k5+/09XIfAbNbKI52jSJWNYuVgP1cshdYy5yf7VtUxNceqemnwzPoHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/max77620_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 85a12e98d6dc..f4a1535f4806 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -121,19 +121,15 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
 					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1

