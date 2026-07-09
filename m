Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A2399374;
	Thu,  9 Jul 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568130; cv=fail; b=JcIicbK3ijf+CvVd3sL7fiuqca2lHPkBsmfwiSV95QsoNcB8zDOXeCrdmJ2+mdEm/GYdxgodJLQtWudUjT54+sZBzXO+mCQRLPkScplRx66HEtcpIP6zFp9gUHly+yCzj/sfYfqA0K6l3VE9bYMC+ZhckCb0X8VnOkT0Qx10mkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568130; c=relaxed/simple;
	bh=63CGvO3uIE48NqqTF3+fElKv9KfUNXhvfYOLwhwmGGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b07vI5ygVt4Kn/qR+QX1iNcUUHuQwuicSjJrWxsjttdQtZfX3JrnWc4SEiaOTw2PPXztDyY5slEeR436CAxpltUFb/UMK/xTe//j75aYGw3ZUMFAYeHXjOXpVaxXLFohzXWPbisjajU//28qC8+ltWCnHDoJGAIU9wg7fkcvOyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dbm6edrA; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dbm6edrA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCn4O1YoOUL3vbiocHyyFFSq2Aa0bQGZp57TdAGY8PytCUexDGzKPESbRYNQKXomeuQV+j4KlgkLIFbCQocCrPJSBqbS3JvTSsPqN3au4a7jYM81hCB8p/YgMqiLVY9SRjcLnysSZpBZtWU6g8+kpQcDMCbyC77Kwnnp5CkCJFzh1fy3hIJaHJeyZ4uLiQF/imHiFvIITA4PoByvmJ569JLpY4jCDVIFZ3yLy5zW/YXRZTdrpx+zw/ed2wBTzvmrPYFsvORIthxlRKP+NRKYyaQKpcVk0m7z/yVsUOKEKa+9ePm2eEj3wSXOcJPTWCXHj3h+zN4dzWeScm8A7h+aNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o07uKUcLciOTtoA57II+JsesJb0Cdr1GRxFHSOHIwjo=;
 b=ddpq8lym0akvX+og4tmnp7k7dwM+XNMmfUwFcqgaYNiGY2h++diTemBAjQYbUBZXV+XLzpZgFFZrQheXnJVkbzeSDzYzdLA0MLtqaCEBts4+v9trk9JRQfHkH/qhlQgPe+mCUcE3sF0eiu+SoG4lXU9jkbGvVY+jdMAamf1y63lLZ+vreKF4oiWB3///MGEHlyhMqlTwEJoJw/VW5VKsdstQaUYZeOZRq+svsrKJnqAgCXv1fiZ0W+oQ2tUKpscImCb5kq9K94THdVG+XHR+DhCP5cFRCdrZU6/ZVOBXKqHdhqmsoxRqCQhRJHwbtrqRW9KhZx59GAfVuTWJViC0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o07uKUcLciOTtoA57II+JsesJb0Cdr1GRxFHSOHIwjo=;
 b=dbm6edrA4Kx3SFm7wFhTjNqu59hJb9TlOd/ZSasVEJYAPs8GEcD5zpIwEzAlstRVN9DYvf3Ddagk6g9gG184Cr9+y6wb6isXQcxEsRktonqHvDEC3C6RaCC2j+Wr+U17lktJOBZoOzdQeepgegHJBWnKwt2p6s1Z0eLwHXJoTwwN1Xe9M11xexjTadj195oqsOhit0IxaKZgqQnFOFfrTJ4WvdAeMVpCG66GwMPz/CSFG5iA75yirii16pHionABN7EDnEBEK8ayRqSDDb9FXoFEH8B0pUAxtNf6HmqvVjIg7KzSfoOOHOEoTFVfxMyAsCvCHqwTL2vn6uL7j+qKWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:15 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 19/43] power: supply: da9150-fg: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:58 +0800
Message-Id: <20260709033428.362970-20-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b59d2001-c5fa-4e89-68e1-08dedd6b16eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	dbWz0b2Jvjn31ZKobKMSlFuA1s2ul13PkfcDy0z256SnEg8aVKpVRNh9k9PTJthR81hpLF209bI1CrJuBuo0F9CEtqBIC94pPVtGYYorl0KsmzUhH/SGsL2yzDkp8xrWqcgYLH0jCaKfGUu8jt0ThVJ9BxbDXzbAeRrHeX562s4HFFVGklvVXTjiZb1oJarWu6x63oOQDk4S4TRUvwgT7bOLkgnvFe+PDNW2FjT+AyYzYI8oU4owc6fOriWy69xIVXTgjMvAsLbUMgnPWXGCWGXapU0fG3mxNX74K/aFQebJd+wvI+PrUwLj5vpDDM7Z6jmGSlCewjb8/QURImsenf4xknkvmp9iAeW7vd2tEWUp5bjykoP7chjUdhQKg50C3T/knA0y4bXsxcogN0wBSiMIsGqCatd+rdnqHSoJBn7VJf9YDXkI46H69yOFnrTSERotN/QzvwtsnW+qSUYJmUnJ0wdh3qJ6DkI3bHUz3m8jmJxbTPIAq4jAJWLQvRdL1uG+6hKVrcH5c32dqC6L5LzCCsowc6qqN8t31iR6bOn45m98x11Zqv/t+lNYzaVK4XPHxxgXn4T7bnM1238SCelbishXoBLJWaLpPwSEyJ3KAw5x0+u5/XV3o8exrk4ruB1DMGaX0rOZ+OuiNjKKH2Vzep/3I5s3w8odAxv7U8xfcr99kEIouV0WLUp7JIdt7VjlBSJir0vD/sA2VdZWT+Z58QOGE38LwlRqVIcZGVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WL7L0Bc6Zie+sLmTVqB4dcP8vam3lDT//HTK7bLzaNOB9q/TnK4Sdd3LYiU5?=
 =?us-ascii?Q?HI09+QBSOn8vaECAZkqxztb/uMC1QhIPORw404Bt8+uzUrJn6qwfRDAT3HRQ?=
 =?us-ascii?Q?u0vAb+2OCNkvlye1ckJxgEjU/kbJq+qkzVrveKqjlN+4Xxm7IRmUUDOBLqJ1?=
 =?us-ascii?Q?yUfHiDSKvTeG+SRN/1dBw6fl3BoaUcTPXNlvVZtgwqSvOzFkFY5iQ7FLY2iY?=
 =?us-ascii?Q?0/mEHxSxniXwrHqGz4fwhxiUvZqqifwxkTSinWLFgjqjW89k+o38G/QrQvwp?=
 =?us-ascii?Q?n7imuMRBoKRRNwpE94W8WM0ZyAtsKx4whs/o04A3U7gQl/HaSZpghgC/717V?=
 =?us-ascii?Q?FcfWPxM+FZ0r3fol3+64ZgY/0GTJagp7xJW2wSRamw9hgTBJJASsTRCWwJZN?=
 =?us-ascii?Q?/7o0CWPIACLecHCGRzW0hxokgRPvhajHlKN6cWEw/ma5VpbVz61M7E3CflRA?=
 =?us-ascii?Q?TcS4hMMmyBGiCBfhpkfzSTJvtGVwkq4/3z3UQihXKraFt4bwQDKavOvHtQ55?=
 =?us-ascii?Q?461i2Yk7u1Y4WcFd1fwIiXUKE073wje8t1v5kijUTSG9orxz1oSbFxpsavgS?=
 =?us-ascii?Q?Al/OiuSZMewHZz/rDfnOrSzn8hFnKaBGQRXTsuEAPfqvg49nubiSjw80QEbR?=
 =?us-ascii?Q?RFY58yVOB8grt3wUJMyxgmbK+cm3TAjg7FUMnbhFCsb6f6Os4w85OtF0cFmF?=
 =?us-ascii?Q?htVjLpreVh5HRGb6u/4yP+hgyX+Sl5qkbZxBc+C/GnvulAcZeValx4ppNr1s?=
 =?us-ascii?Q?5YfrcngQz1nCrQ0YbW+qJCqV1oHC4WPd9V4J7WmkBd91okwRomBEyvNLHQa2?=
 =?us-ascii?Q?3MMtn7lqM3MMQMEG0+mcl9AZjcv4yRhTsibnPzs/MZbw4Irh4ew4DcN/t7to?=
 =?us-ascii?Q?MEgh4gLx7mCrUQkanmpKchJacC5zaV8t9c0q4RYQ8iRPy4s9qNFqDlqko6ms?=
 =?us-ascii?Q?kuxJtNCy1Ak/iOOCgIrCwHNzRogQrJeD88iTnJUl47rb5nnKkRh7Oxhq4VqE?=
 =?us-ascii?Q?Uc2OxBEGq/Ld00CZPXjBZIL+gffD2UxnIyRDrdR6r7q7ZBu/otTd+nfeaFVL?=
 =?us-ascii?Q?0mG+f6S6WwBm3DoNln1ytpu73bFCKg3g6VUnQpaLyDgkLB/CE7S5WU9YUJuD?=
 =?us-ascii?Q?56jtE+f+Sx1glrFcbFJlYEzBfgwagp8Sp2Sep260b7lCYz1ZuuHX8sWfIzMw?=
 =?us-ascii?Q?XXYBBBD1TPxoBv2YrOO5m1ix79gpFPY9Rq2kmKUu4qdnaEmyAaUVEKf6otHa?=
 =?us-ascii?Q?D5VwKHw9+/RO6+4QcTrHclroVNopUZn6jK9GYLDcpbr7IwIYc2eUtyGBDIfm?=
 =?us-ascii?Q?CfrgeHS9DcJ6uk/gCMQxJwRcO5GCxPSVC8SkWGoGZqMlug/mY1TD1Ar4p0pf?=
 =?us-ascii?Q?4O/6CjTCYcX3wbekyybB2Ald0KqQJz5tKaZTnsP4roGGxm94iY3R9/7hBJo6?=
 =?us-ascii?Q?XpzLmNGIJynn0CJwXIRqK6uU0ZjFz26wwxZLMX/MXF3/d0+yA8v9tMo6xm7n?=
 =?us-ascii?Q?1JsX/hX4ETxmuyaHdurpnV/0aRhrGz+59EK36rNK8+FTz7kOpBLhaSAHXFvq?=
 =?us-ascii?Q?+0zSEGw7cEf1LP/64Xhk0C9k3R4riz4TqVhIbAqF7P0XhhcutVlFHIkScViG?=
 =?us-ascii?Q?i5HZUefzHWgZlYnMqJxD0jSfhMIj3GjsqwiVpvDg5xpTXv+UxqRwK29Gwq3s?=
 =?us-ascii?Q?vdr5S07U7CM+s8ZE0n8XODDc0LxMHNR1qTRhZ102BbElFGTs9fJqQRGGlLO2?=
 =?us-ascii?Q?hWD5f2CS6w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59d2001-c5fa-4e89-68e1-08dedd6b16eb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:15.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx31b/ONVmyQswqDBKDaiXd7zNToZx3SGblhxHLW5ESndLbRQDdtcX2LWtdRxFsJnWSHic7KuvpYbjeB382PTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/da9150-fg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 4f28ef1bba1a..7b2fa723acd9 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -524,10 +524,8 @@ static int da9150_fg_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_fg_irq,
 					IRQF_ONESHOT, "FG", fg);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ %d: %d\n", irq, ret);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1

