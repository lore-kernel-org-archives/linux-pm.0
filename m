Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A330FF2A;
	Thu,  9 Jul 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564306; cv=fail; b=tRq2+u6jFoFEwdnpyFxd1LpBbGUVG9DJhnJWliUVRQdITcmcGqjPi8tGSU3CxV85lDlWI3W4S/gEsPxXb4CkzB3gbhhQJdiiairNOIEKrE5N2WH3bWvfTBbUW5jUMEinnKPuUbVUj9+KXxqTMswZDZadfKaZZbeV7vcJ4MhRIIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564306; c=relaxed/simple;
	bh=zpG+veT4SBqEFCdT2yTi5Sy6ynhSZfs/m4S9LAVECf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmFwq7fAPhumUaPMmYNqZtEwS7hCSRTPTBUYJK1BDj/XS2INw0S28VPkg6a+/f6XQ4nJ7m3PkiaF1BaxVk4GbcGTlSx/venbfRfV+hjHKFX3dnLJS8rq7vKdnbgt3LlUA+hzujLI1+fiZ75L1NoraqVUTYJmkKiQYydOTEBhYpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W/Lb/9W8; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W/Lb/9W8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewlkgp4KjpM5pYM1dOBBVHyXtgwN7iB7ai6DIvHwhwnYERqDt5eloETBHnJF1arElHgdLvA2GqxTIMBGhAkIDA3fbMAs+e/G9a4T8yd2Y5U6d3fV5Fu5FI7OrBHboKoQtdfJBmgC8KtQ3Df/MYlmj3c6zVEv1QgbIYwFUmBcuH0GggnmEUFrG5n4jCU9O9RgHLpy/4Bv1JwchDcPf6heLq42LtQgEufds1jUIY7iWaslA4hPGBaoF5TIBYcJOTsBH2HLwvbUCeq0HPfOu2clBOqQKigYh6fbWIpIsIgEJQtxqSP5NnWKH8vmzC1vxU4Ns5tdsnkyYQuLc8MXLgm+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K9aQiUGtqzpAOqgTd+rMfOknqbOEEa0k9k3zvk5FoA=;
 b=iOIxoR65f+41EReXN7FWK7Ab00uwXjaU8TPXB2dPm71HNJHbyHdf2viDBAtNhNFYK485FBO/rk+Ca+cE3kHSEyKCBWP6HyzkiPf10ECT1x2EICUt117hflohgLoMBDX3GqdLaNJLfT/1V4TQVnd9sVObfuVae9gcdER3gU7RrwDqWpRecoPo4ExRCcp2pYdiYIaCt0RheXc44IWM3+VjoeyH03asiJNPYETdHoKhumj9jgyg9+j9tzq8ezRTRi3SPoNouga2hHhjESuYOGEm9Gpov0F90BUjE2DaQeYk7Hx54hm1LnTLP7Ik3QW87vLAC21Ptpb/ruvwBj6quIJDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K9aQiUGtqzpAOqgTd+rMfOknqbOEEa0k9k3zvk5FoA=;
 b=W/Lb/9W8soZSYHuLR3zczNOWwhJIVIFN6POZkXNeeP/P/bgmZYxEbRac7iwTMs9S6sX9qY4LKOlD8LEfaMhPS0s8a6SS4GfP/D9DYhfxa0kIFYvthGRExDtMd2yCe7cx9gvBg3oPZQTSF4NDslxYeiKFEddEdDvjF3/Zx+COyDjWARXyAWuixE8dR7Jlu4TOeV+a0ItKJ+j70YRSA3xfxtCnM9Xz2IWwklaY51NGNzfODSGNB3ahoKrdpWEXt46wjczFpCYKk9xRrCnuB79WaZ5OdJoUju0vyJIXB7AyI047uJ+sj/jfTu8bwWg60GRD1003zArfDoq07b4liBlexA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:38 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:38 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 02/18] thermal/drivers/armada: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:05 +0800
Message-Id: <20260709023048.599150-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f61252b-65f6-41a5-554c-08dedd62340f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	9HHMezjkquNz2KH3a/HXHaW4805+8zcYnalpTrp+vIDog+4brVrmULuhubT2nTycBwdRy8ARaDXgTJku/zgSrY1XySerA/1peYqkvvBsDhsN1Xi8yNJqK3J2GQ6wn1l9f0rkle9PhRodTjMwMNx3S0t+A1I9Y1s9QLXQUYoXZJboo7KY2ozxx1We2vTljrzUQq+18OqXhv6GQybC0meGJeJvjshX7418f0h6Oifr2bu2Ks/qjH1H71csb51eWGPf8O6jyewfBcwpxz340/ekBreAoxPqeEwDfoDfMqt3mzO6PxAuR6BiWS0+fA2VKOSHQ6isCqPWiJIOKqBTiDCO/LO/Rd7XX+NDJPvxOg1p9pNrzT5ANnycB+effn16MtALuPBpeFZIHRpxEBSgi1OsKyWFG5spVgkHIu2kBwVgOs9NXM+S+Vcs+Z6GnMRKEJEbIP5c9T+sC6bmaAKYWQXf9pa8B0xHgQYglj/n+v0uawIIcWU/HXqS2pRkkCmbb95ZPiFBeHFzxbWu51MHV5a2D4/DWHIQXYZbLuVmFhVLkTXX15PE4cXz2mReP1PcjuevqGHT3DRiu+m8ZLYKDrGDG9XOSzJBM6XA0lQGejEcWa0G5Tvg4uwZ/k0PqWpfdwX6VExGQ0zuTxddTl+d7fYllnKeozuZcZijRd/9tGNsI71wqftTMKMCwouhg4LEwcJOX9egSNfaZyknn5RwkwS3qvxbOPP8R4Zly7gvQDIvTKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFfb4UEag0N2WtFZf6edmKuVWox/xDghcFgZ2Z61sCAg++g/sZvYAF6t5S0e?=
 =?us-ascii?Q?eiM62eE0xZsUHXUKNyry7MfV55Y/mvxRAPOxxB9lqI+cAgxyU3erIugctw8e?=
 =?us-ascii?Q?nhxa3i4fUmiTN0BTyxaL8/v7pUf/IrJgqz8PLVIoPGgdn+/0uw3OjUP9zmEO?=
 =?us-ascii?Q?/HbA3hqI0vzZStWejIJ0B33HqGN98eS3bOJhQTY8EDXd1hN6eaGLotO7/cAZ?=
 =?us-ascii?Q?H6fBr65O6LyDxpzmPnVc2+P8q0BbN1WasXX3hIKaZTQ/tOzoSSSOax+luB9o?=
 =?us-ascii?Q?uTWBaYzBehILyavDndlxLlj/ME6ira5hSjuVz1F3gkoKC6Q5oxS1k2lFVNtK?=
 =?us-ascii?Q?A40mzafWmRmVEcDQqz/usj3j5EJ+SPsULXAR+bg3wHgJTnOD2ir91PV9WUHj?=
 =?us-ascii?Q?HoAg0ux3xFLyfNPV3lyM6hTr8mxzz5AkIqxZOYvplAFDN3M0/cOZRvdkYl6x?=
 =?us-ascii?Q?tXthlnCfI/PZiYAzh9jNUtb1ypNyol8vBIAwvl100W/xvaB/Lvv/m6AjGIz1?=
 =?us-ascii?Q?sXpK+oq2nQjmfdLbZotKhwP2V9U2gHUNAe9mUJ/yKMUYF/7PM+D4TZR7kVgR?=
 =?us-ascii?Q?1uI1lb4piDLp7fRqVXHNq7LswmX0yjXLwt08gGhxRnO7zMG9N3ZBJcrVuZPn?=
 =?us-ascii?Q?/FUDO86GZBjnNFIk49CM6hGWPaLXUPd/7dUGIz63BJsk/X6euubA3tZQzFq5?=
 =?us-ascii?Q?qXUry/9yZjPVWzSPAKAgwt0aZYkpgBx1x58wUUWt6i4Usfa5T2ADjAn/RrMc?=
 =?us-ascii?Q?Tu2Tb9wr4tT53sV06+31bddITR3JxGjCL21Sz4gbUYHDoqBBpofAIMmee2Zv?=
 =?us-ascii?Q?+4L3WMnD5ApI8ARJz+u1ejsT2MMXcklYtp6r0sA53CvwvQlKpBy2eDS9qniW?=
 =?us-ascii?Q?N04ftFhZK+cdzokMEEHcA/G/ZvCBMplVtnHuymVlPBWyaeNkoL+qi0OGOd/G?=
 =?us-ascii?Q?qvfZ/FN6fBWi843F7ykXIXNeJkZUeOZGtmlKxsyOrWFVFRL3vZgi0Tk5xrEB?=
 =?us-ascii?Q?n1N+9sswUCnK7ksRsrKflzwQ1mt2jtIQOkEyPv7qhTvjusHubEdl3HcNOj6D?=
 =?us-ascii?Q?qeqb4lLBRkD3LBJxoQEWJa4wT6DjJzImz3unS53lDKp1lG4XRWiieZ4CEOK9?=
 =?us-ascii?Q?pPpEIhR2U2EtwLTU90t4HMfDjni+ik4vBE0cCASN0OdyZ29tb1ibswvug3a9?=
 =?us-ascii?Q?Z4IbjYA9ZEAyRtgO4E+yZ6AogNR0CN91sst2ANA6Ff63l9v1w/7VdefZEXMu?=
 =?us-ascii?Q?tuNztMAOa9tbAZcC7Hg4z6Xmk5T8+R1Eaa1MbWYzjMjMIUvSsPd37l6JmvDv?=
 =?us-ascii?Q?f/xiAlrrAZtupmzCrF1ZiRBbGwiJT4RmvMpfuGUhszlVTsh6rv7taJWlM3BC?=
 =?us-ascii?Q?cPHOLx/RChFdkOyknPsXGFZde+LK7zk6N1wx91iaN8iyXV+aavqaoLI1cIOZ?=
 =?us-ascii?Q?TmuDchQI8137+eQKlGil095vBtZCIq4ZodkeCo90uiLGbQymsXRwgDSyw/gs?=
 =?us-ascii?Q?q+jHm9dvu4uoCS/vsf5PV7VtbmA6mNCUrgIMJ5zMsQso5nj39KW3AyXbl3G1?=
 =?us-ascii?Q?HieI2JfvX5k7KmbiVEv0UD6/ON97LBDykRXABE4A7IcT9ySqqaraTO2uRSSm?=
 =?us-ascii?Q?08zBQoZ3M+9e1Q545D6499EvJYegpXQ03en24bYWIPu87LylMM8egeAsDO+3?=
 =?us-ascii?Q?yI2MDUp9BTyX6g+jy04BlExFg0wWh1/ZeQKCYT7n7A0BSmpxPWrVs+4I9FWb?=
 =?us-ascii?Q?+6ZYAVXPmw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f61252b-65f6-41a5-554c-08dedd62340f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:38.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE6dZL3pEh8v1swfqVc9YacRrX8VQxd5U3GwTGhPepi9NIzh0+VgzkM06f2e689/sczRUoNRdb0Y4O0pvTqleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/armada_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..44910a953439 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -913,11 +913,8 @@ static int armada_thermal_probe(struct platform_device *pdev)
 						armada_overheat_isr,
 						armada_overheat_isr_thread,
 						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.34.1

