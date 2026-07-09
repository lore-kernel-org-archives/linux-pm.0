Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012001.outbound.protection.outlook.com [52.101.126.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA738C40C;
	Thu,  9 Jul 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568098; cv=fail; b=DTkqsJcLgWoEn6Yh5EJaP8Up9vcGKhgCdPEmhleycheu0cVFWFnSYRV8ud7d82B9GYd4ny1NG+Kli5IjqYxmQG+isbuASKAAJfazya70+TO2GBcyN4ngEXcmLwFNqbeGZHMxHn4PByxJt1Eoz/0fvHreN88hECBkHaH1RROQQlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568098; c=relaxed/simple;
	bh=PQ/x/mrx0O72DxgVAESmWQqhzgGwHfMWeXIspSM9pqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZH9lGYX3+xtXWWnWosJX5xV4hVAd/K81EaFL9Epjvr6rwbRapvmo2nN7ofebtL/FQyreXspgitrgvoYTbna3wgnsGDyZ7Luacb/tPtKCmr7Ug3dPdiiEChTe45ViPiEGqc4Pr9/9jZyRRlDCu6xXDauQHVosp5lrLXdj9peSJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Zm1KywM/; arc=fail smtp.client-ip=52.101.126.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Zm1KywM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXJ+iRwy/G8kIkkSbSVzLt1Zn0RE4iUnMzllBv5Uy6+guX2Hw/JaT1Aj7Wy/ppj8mV39RJyEAJr3qIrvTk+exYU6hrQOVSrs3FE8SoraA9f8olxuGdYFhUu/LSSbesLkTplBtXQ/SQ+B49BRi2AXnBQHlkrxGcKM8Vqbjo/Du/7qGT2AVlx1NUmFL4+J90cexW0o2MRbBi7DxbrIWCRP2SOS7piTXvuZMI9Ubi8YIwwEmT6Gmti9DrDy91D5VujKP/ijkSP/Lyhrb4Q87QMLKOTEKLnyKgJQUvKOfYHplgXgrSaMzrrApgoAoETSm7gZcL8vvaQIAe0f78XaOaUdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYwLBIk0PlIUYVBI4uxG4PkkgexvYpwTeWfzI/bC7BA=;
 b=nfbQ4dmbEmVI7f5kGmvR0Hl4GfgYLi88zy4WtkTMD/l8XPnUf2d1qvcgdbMOmEeFIUwhuIEtOuoKJ4YhDBumPWA2qP26G6jzcHAbATL+XVSE6e7/O7pP3h2t+3Rorp4T2zJDz23oQcCfzuWAntmL4yya7nueyjAp+avq+GlvtYXVPMTkIasdarKQSHhCZdqKgMn2EB6q1M7YMPa/O04MG08PiwPhGA9xc7FhRT+TieFOhjkdRaz+EjY4LrF5UKsbwXU1aJw35jeLV2W4HTWX7oMmcuP87mr26gXbLIA99HrymU2TKXUeaDgi4K/kYpCVbQoIne7/UfCfQ5u3mZ8s3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYwLBIk0PlIUYVBI4uxG4PkkgexvYpwTeWfzI/bC7BA=;
 b=Zm1KywM/unh45PITjASCUEmK5E46yCnjdIRKvrYhlWyj2T7D3HfeHEZUspoVpxJEQ7Nd1m19QqWPIfLe0yNK32vWuIgzl5aTqJDJ+unl7NM9VqRa9A9E2kAi05VRn1jzE+3GTdSmqDyfB+Ad1LoB5I+P1bAUF9zIyjqN85jCB7T8YCMfJMBislRE1kRx1PF5rvZBS/ICicCRwxyCC+ptgmHwjTQ1ZgKGeeMw/ROFgKW5T+SA559T0cbo2Vr7qxlQg7O4cg3Hnpx3UjQ4ry0goF/xjricKE5IPk7/L2teWAma24ilpinS8Kxus/kza/ABYCGUFApz/Gv712VZC0fj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6360.apcprd06.prod.outlook.com (2603:1096:101:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:34:51 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:51 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 01/43] power: reset: pwr-mlxbf: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:40 +0800
Message-Id: <20260709033428.362970-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c1fa632-fab9-42a1-9eda-08dedd6b08a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|11063799006|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	MZw28O7HHzgx5dQaVf0iZJ5QNxWp1MIAa6Jz8yX2ceBNHOzl4Z7FfyeyLS6A++v8pFdmy4TOY+Ha7sHQxEXY2C8fmNgUJV4Tx8u5v2rzFI12VUfJt0PcJBZ6d/UUZMTwXciGCGMvXGQsY2z19StESuOhWW0h29x4B5zhaL43lvtgcp7tj3TRu09rDvRu8K62CakdmKZLkHjlXzevyno8auVHyZLsD5o1e65VmfdIRuBFoTtsjN1q7xB6Qw85I9yUnqkHFP3oSHgl7QI0syF3bK9+bBUfWP0qtnJI/Rsf4+ze/ahWzXB4QV0Njli0bzYRh2lxt+GZ7Fu8DzJoOtI/qjVzDT8ZKIahzWmKaPLdHnm7xZgA5OKWJ3nZoOjGc48mlQUVxc/NKb+2CbkADU0Jlc9InLfb/xmkl+7XByZ5wgrMhVOAqncvxXCOx8xNuEg31PZoxWZl5LGx00KDe51M4M5RzhV6hj8gp437Z43SYynmwTsitgLhAreed+br+m0N6IW1Yjr7aOdjl4jjr3kfKh6zqmVyR92dXKQkYwGm3G/wht07uZftWCee7wNzRH1X8rGb6bDYqSdyatcqNEEbbA6eqPLjtcXOXQYdsSOuBiPUOL1biELDFclAgrX6gOdngqxJ3YZjrddY57xngdSsEyEp4UF1eEpI+xG0/x+Y2PL9LAm691Xa+g0w2dN8Eh48LE9f/JSYeXIUujYrCRyFzQttBUJZ0TNcf9u59AKiDXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZpBb/7M2xq9vyWJOyx9VBYdv+jqgPkkrt7FqkMflrZkMQQJsyTJ1fFWpIFM?=
 =?us-ascii?Q?7lXTZ5KDTm9NF0mwr5gITKv61ddx5QysZndtj5GCsHsSRJxztliyp04mBeGd?=
 =?us-ascii?Q?/MPWi67NlqSVIazAQkmac4VOK5K7xbO9g6IL3FpvKvKXv0Ze8zMbh8R+aVuK?=
 =?us-ascii?Q?jaG2PP6cj4b0U6pZE3PGBGLIvyJFpA6hGMkpAGVh4OZe+7amoJk6WM8eRbCM?=
 =?us-ascii?Q?3jteWAKKPo9P34BCkDNCiF2X/RbUmEUzdGP8KPl7UchXUwF3oJx3iDB1C52f?=
 =?us-ascii?Q?IUKrzqWcPbpkYbupodgnmu2kADf41gIN4z9/wn9J8+234+gh+CmI8hvDYkQw?=
 =?us-ascii?Q?842aae+KKpUXKc82lSI6aJrpY4EHk0J4h2/aZYDX92djfOF/CgUYbu0eU4Gp?=
 =?us-ascii?Q?/tNxbmp9DIWhyKkB90vvdHjWZWnwGiNc1snbRYblmsUQ1zdo+3e14fqirdao?=
 =?us-ascii?Q?PI5bRLgqNIExsmg2veZkicGZj6tlPoHuMTudmKgAZRZrHChYAnN30o3jrvDu?=
 =?us-ascii?Q?VEDTfAJZufPo3RUgBx96f6qCGo6YmOKS1pTnM0LyTZEnYcxduPk8O59KSIOE?=
 =?us-ascii?Q?KMGuPxqvNRdHrHYw/xV2qymuYz2RrroW91znA7fDkKxEzg6+ytoY2G2sUOC7?=
 =?us-ascii?Q?xe4rOX05s5Sw6nOcrF2QruwehRDLIBnIZ1F1+t3cLoMVmmKEIv+Uf2lc7tZW?=
 =?us-ascii?Q?E4TsuwiET6YfEadZtgPry0dLeFRIs8mdumZOe+0h4cnI03XAvWs5Uxg6fOrY?=
 =?us-ascii?Q?T6ehXKdvqX+iOCsuTsai6FDWUqcms72Rco/+ZJxW5Hipy7JnkH65PWCKWe0G?=
 =?us-ascii?Q?l2UtFmS5czyreYTqraTMKk12EKmtZxtHh0iPjD0xIC0yxY5Qg1cGq6IYQRXa?=
 =?us-ascii?Q?NsJI4hcvshxtMqSu7nW1rXi9cF1TToG+xOdRIl9u0Hb7HrpoiDSaEKzwObBK?=
 =?us-ascii?Q?ad74ssCVMp0t/syBgYfXkndhdz/p4gUkO8Efjdsfr7oot15BH5Vkb/nGDfbg?=
 =?us-ascii?Q?Z0Fh0CrFaGMKY3JOUAkERYTYluxYmRAEbqlx5hcR85VaOoa5BMCLLHAKxxbE?=
 =?us-ascii?Q?C+m7C2BMYbBSxo3qJGfIJuin4p4vo9USHXIzywpw9HYPj/ODyHFOLPQeGk4s?=
 =?us-ascii?Q?I+zb+CKJdofyT5tqNFjCSJkFMyDO7+UowfFSdNWrAu/JHQY3wRlWPtXnIRVz?=
 =?us-ascii?Q?vYiYCa5dLUac6+ZfxXiZ8WI815ok57bND6NUu4JGooyFGrxrvRXIcTL1dKJF?=
 =?us-ascii?Q?WG0UB9E09ye7CyYzvDKMb1XEAmbQVafpoH8iNj/iahIHke7/87hT4dm+oXw2?=
 =?us-ascii?Q?ePaog2VK5IbIGrv186d1s76WA2DNqsz3kNI2NV8IEjAj6bZuhkyGMdEWXnsy?=
 =?us-ascii?Q?Iqxx3DUHLoW3UNHw23mHgnTk2JTsIy4bkUVPPaQwjYJGikkT/BfZDijss96l?=
 =?us-ascii?Q?9tfoJyCffNTXTUpUuifZI+MAOTW2wScs7/qoAt+GPW2nj5r1aEr2w5uNRlZd?=
 =?us-ascii?Q?5vyapmvctZE0OhX/ji+m5I4yLiEpYU6/8USbLEmrAZCkG3IqSQa5LXiFetFv?=
 =?us-ascii?Q?guPb/1R/lifwF9JZOqD13L0oKluetAJsdJUA9etdUc9NREkLuU0X+7MyA4ai?=
 =?us-ascii?Q?9C+iCgpPAa5bDNetGcPhiuPjLItImNVulQK3b7EpgENOt5vgcZKR54HMJfZj?=
 =?us-ascii?Q?35dkhSm8O/txihjhhE9cDaSIcheLyU22CvfLXqoaJYcC+HfB9+xH/EdaptQO?=
 =?us-ascii?Q?lPnzUdjy6Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1fa632-fab9-42a1-9eda-08dedd6b08a0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:51.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mynJnyIa8uMrL/5mvHFaE8valhmV9a+b2Mty7RvPsFjGUGilk7SvVwf4A08BvAMcVct0xkRC3CHvqpqyVH4lTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/reset/pwr-mlxbf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 15d92c9f64dd..459c2b7f3a21 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -68,8 +68,6 @@ static int pwr_mlxbf_probe(struct platform_device *pdev)
 		return err;
 
 	err = devm_request_irq(dev, irq, pwr_mlxbf_irq, 0, hid, priv);
-	if (err)
-		dev_err(dev, "Failed request of %s irq\n", priv->hid);
 
 	return err;
 }
-- 
2.34.1

