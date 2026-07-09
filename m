Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AE391E72;
	Thu,  9 Jul 2026 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568114; cv=fail; b=NSJcNKCmKcavq6UPEn+4D2z3E4UHXOaOiqL6JB2ztM+cLVbd3TIlaJTmo162GgUbFrWH73Vkd5K1YHDveq7YRq1RxZyGgYsYTyhxWWUdHSzcIQupNi5WIB+vGixDIGOzrtSIL6btfIqSOUpw2L7O7T+2tZuSeTY+IVroMr+L4/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568114; c=relaxed/simple;
	bh=nvPUY2rs7GuHAFAYvrdL08pu3Hme606NcF87RUucy4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PViPloGcKJrFs7ceRtR/kLaWzWXrsAW33mitSrum7emuo1WGZBQc78Ca8laUON94oaj2jbkotInRYGcv5LL/rGpLcidDiwFPtp1TwXTQWvQ6yctV7z8q7ezW4Nd1ysWbzT7xvV5i+xujkmqjbej9wips/8KNHC4vV+GnFc/sLgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hlmUvil6; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hlmUvil6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrFhxy0ICScGyUV9mIwjVzGZ0idbf4Ztb5DKmzCKL7GRJjxBBn4I8wOkbYkLQUroQnPOgb7He/kYzZXKUfwxIYbvyP1Pu0hy6LjLuAuU+hUr6zDuHlPMtOSo/GAUo+DM4DEDy3nUPwJWR1C2TKQSPjG/xRnDFzqw18Yv79FIjlX42d5u4Keb7DHuoUIZtII353HzldpmGr6EcEncalCLWU0Aqlz0Nuxry44GSpBA0lUeHhrGYZm2id3yLO8PQEkpX+BH/TWbsOS/Tof6CyQYEmhai34XwA1nyZksrsqMz0TY0PH8DyPcs6UPqXDwAYeh++ekALoPvjBcRBdxYZKueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm9b86tl6q/K9HzumC46Knw2z2g7iIjE+bGZAuxMnB0=;
 b=Zu8DSt/ibXifuDGB7NTgfT0sKAc+FN5ugbf7CECfX1J7jUoNsLnBRUaWHJEOEsmij5frQ+n9funBdU/XfMXndTQhY2roEXeadCJlnNMLXvCTqn9k1Ux0ClI3NANWxEkfQPFoJ1xYDMXaFoBzsq2yJX+9Ix9Q/lr8C0hLFyEIWJYBL41xdj6ce8m0pTEBmvMGz/0gf6X27nYQZ6f/TaCLGG4J+aOPSeglEqWwgY5oywOhTC3mmmM8UML5VHcus+By75xJPoP91sW9tz1vM3dVbH/3NPxJE+JNTpDjkdBjWCPnTX/gOhW2pLqxmX0lx/WX3YOOFCf+ReFNUDwad9mUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm9b86tl6q/K9HzumC46Knw2z2g7iIjE+bGZAuxMnB0=;
 b=hlmUvil6dfP6YMp7FlMPj5y+zY5VW5delJFUMu7tuUHGLpLST+h+qasqs6QHXyZLaadpbsvdqSGL1lKKSpn+BIzKjqlh6qmXFasmj5DFzHOD5uxi1DJ5YnRhUOdWNu99CkLBzJyrIlq8g/tZoEYRGTT/mEU/ruF4gIjmp3Iggxv3UwpSKNkrTiq0uU+s8yqXW4GVLS6awLHHgBoYbh/2eMescx/Lbc1hzXw9UvOHTWA1f7LhwJ9sjO8OUmqwjkplnoQ1XK3/U5LcgVKlyCVP1YJfTL7ZYib938ciT7UOntG5yboCeKzGgYCaK9i8MsQ8IyfFaz/PmqccZLkP+I+zNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:59 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:59 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 07/43] power: supply: act8945a_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:46 +0800
Message-Id: <20260709033428.362970-8-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 122d2893-95ac-46c3-1531-08dedd6b0d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rU2Hq9rnFwisMf7RZhmdxceQVaIufEkXPfaxqgGi2n6czEfJbOfuN7u/DbXU9h5cGYY3ohsKOBN+OQfR81Pn6p0BxEI2nmsvlweb+1ppuqFW8h7suoqGJz/ocxU6KoHLvi2QcLkoMBCiQI5LV/f9KJwR8rl0xsvva6gDfLcW1S/BUee9aWBr3HXR+HHfjlEZYkEa0xp/9hAxoB3hv57Ke/8YAJ42CEPr0T8MEIT/5T9HOxsWsKIaUIgCLN/21tflS+Pa2V8Y61VoBtzWrOct0J2Wt45YVVHPNqpy5R7RpeUqCzGGXvrgQIwVjIsmtJFXhWtpHq2mf57eoK/0TaCwA49QdTkATAd2gBoTd/6MJfc8T/MkH0QOnY2Flki0GMorckoDdIUHpUWxdgykk8qgZWLoTVia1RzB3SKB4pLDMJVwB6JbCDHDM5KcV8k6CC1T2pspp2a5nQSGCazl4lmD1U/f2AS0WgKI62fB9GUdVLjLUmaFCClwdFVioOryHR1DwZ8aiKT7LCuzf0sb67ndCAY/+PRN+U0FmZe7c0qxl2tiXWqBeX49egC+qN+/1hm7SIT2KEgLm3jhpCFcfjuxSZYTKgjM6Vfl9K4PpS+wfJFOE7xN81oS2sXo+1L0cfOYTPiNlgkHwg9fctJy/wmMpnf2aQvku89o0g/IOSK6MB8BQd5wD1qPhcB/72sL880i4X8hjA8FrDcvcp2q591/0A/FxPUQjxcYyGw91m1teRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IswrApYLDttmu8g9lPJKooD1lcZgUkglp/0rH2cRRrm/w2aoIWJ2On9rGfiS?=
 =?us-ascii?Q?+t7MyX6GMpcNexxUDBcbpL3nZhLqAokyzQSgkbEQUNFIeEZNjT1/g2FSR8+a?=
 =?us-ascii?Q?Er3nJ7gO6tK5EjrQ99JxxBOUhzjmkgsDriANHOBfrhkVVnhbwfxGBpAEnPmJ?=
 =?us-ascii?Q?K1/EszRHYprmGCL2rykA6vM3gd0jfiszBxXqSjIVdaCnHY66OQh/M6ICQUhp?=
 =?us-ascii?Q?YEheWBREg0nruoXBgFN4mQx7qm400N9ohdjDAgpDYXSk34EeCWZHhqXCKpKE?=
 =?us-ascii?Q?IVBJrdyDIseBMJn3aJl85uPjJfrPomG+SP/eMXxhvX2M1CX2jn4yp/Zx0eUU?=
 =?us-ascii?Q?QbPcmvd9OFqrjCV2cjYe3i2zjtNcki5Wn7eM0ZwLv7ssM7R3d4K8lu+8dPQk?=
 =?us-ascii?Q?fV5YB2xBMV0tBgRMAJlhunNkuUhO/IpKlBN2if2cfuf4Zq3DBICNAI5j627b?=
 =?us-ascii?Q?ZYMT0OS+0e9D9JaSEDuEfYtoEe+xuauxadLWWd72x7i251oCe6z4c9NLklCB?=
 =?us-ascii?Q?9y7vSIRD52B/+CTlrH8zWxkh3QUk0yuzqDDvMaH3zZSqO13kBLMw/sgQXSu9?=
 =?us-ascii?Q?35H//jsgk1pW2xv3l6L8fY9FicP/qtBP9ILJYolHVgekXyboeo5IEX2/0yfT?=
 =?us-ascii?Q?21UWJkavcQUuO+iP2hZasBKBCNiz9T3EoEoUrUmWOZIFaG2iOsnacWisirIP?=
 =?us-ascii?Q?Aiv/2GnMh2l5gHlIYDMesGGmqSgUZuYCH4JX83W8gTGy2mPX931LpgF18IIc?=
 =?us-ascii?Q?BFWZP1luUjBOZQmqdUM1ylRUWNM4/2uoz0ABbZIyHB5+cWhxIck5sbQlmcm/?=
 =?us-ascii?Q?MnKlNkLGnlI9vUbxuiXQsdEhultcM8A10XYzVu35gh0Rn3h/A7Hs1vwg3MDk?=
 =?us-ascii?Q?Np0jh0AXbHENJPvjzYqeGbVkA7GUBah9BkNRW4iHLMfg5ie+bUIP6UpQ8+M5?=
 =?us-ascii?Q?UFcf1VWUM2Y1WLp3m8tmKreoXXmswa3uXORjYr9JBm0Ag70LuUSiQ6kxZqNT?=
 =?us-ascii?Q?qShl+Cv9xBOlj6ULW15C91BGeIzGkqyHCjgJ4/+a9KG2ezRwJOsEtWTSq2J5?=
 =?us-ascii?Q?TpviIdMqyHYzqm8DvjUns5QNf9rucQM7M5DbyVn8+iZN1E+zMyythqV7sUG/?=
 =?us-ascii?Q?qxGQXAGQnCsMc8DgDvYGj++qCdGd8PIaImZd8+JiCmiFtnKHimBEuYbA8b6g?=
 =?us-ascii?Q?UtgGLAWzGKzquDG53ThQZVDqpsE/J+BfOk2SvshtyteNULlHBOE+hsKaCA68?=
 =?us-ascii?Q?js64De/ffCI2gq7A9m7XFj6buqychosW7Wq9JAfp97wA1XGn1D9kh2osVViO?=
 =?us-ascii?Q?+BHntRAMv9cBzxG7vCKhZZRmWyDpjBVoARwyLkn9dTKbPa4zU5kb0rp3nEvD?=
 =?us-ascii?Q?R3hyEe/BkAdRKTes8pTpFIwQxjqrZNfHBTgvjn1DVcZQr3hwybahCXf+gUew?=
 =?us-ascii?Q?yxjGCwpxD6HXZiCrgQcs3uomt1OhfAIxo7EB17a1aDG0hCXw353RKZ2TEVfg?=
 =?us-ascii?Q?kY5ypp+3ge3jnhTT2oCCbYmG1Z0eWnCbOq1IaSYj37dqJ04ABqTD9Yd2FOoX?=
 =?us-ascii?Q?wxQG5gfsggAajEd4l9nwqv6QpfmSu5PmOYM32DCWowmnsMGiH1Tsom5DHIEG?=
 =?us-ascii?Q?v4WTRk88gleNySP5l2pvlbbrhgulRfXlH6GRJCaG4YuqRr8IYvwLQcBuWGkM?=
 =?us-ascii?Q?Ol98hZyHesLLL5S+GJHtsIGx5ryZx7FRMLk5etqbAKzKtqvFkKe3o+BLDInl?=
 =?us-ascii?Q?tk33maRZoQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122d2893-95ac-46c3-1531-08dedd6b0d5e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:59.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVJP7bfWO00rsRYKTXtV7McG5y8ulmWBOkd1s93IeyUyJh3ZhjagNQ5BYpZT4EyIln0iMDcwR7Lza28R7sAedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/act8945a_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 9dec4486b143..7e4b087f7679 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -620,10 +620,8 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
 			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
 			       charger);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, charger);
 
-- 
2.34.1

