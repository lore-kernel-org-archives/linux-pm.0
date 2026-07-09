Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69B38F226;
	Thu,  9 Jul 2026 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568112; cv=fail; b=jqQXhH/j95MstWB2Ct5fVk3naOAXPcCS6jtFoIGM/79K7t5dVIIH6/Q5nCUQp8uPpc8CHdDxl7U3zVAVYVxLuzxfjonGIOH80N6C7U/M9SG3Ox/eMkoTQlBN0CYf2n+kWKSJOJ1/5GM+5s4El7dbEPu1izWIdqUaZxgD8mNqT4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568112; c=relaxed/simple;
	bh=xnsUXReOtq6kLomMMEUyWSiqEegcHtXndQcqYufpqHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTz6HvQKL6U91zJDFWe3Ls7Hu4wTCrSJU4nScdEZBK+7EZJTC342lp7/xiMorH8V02M4QXchaP3rPfpqcYBhq2JWWbDso/Q4cZuwmNXz8jwq5FAFneyAvE+Xwl1FJv4HsiEKsnaBgiSh9vzXg+hulYnoGJdAkqMZdLWXZ7NhtFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nIO7Mord; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nIO7Mord"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyQy2kVM+OTKjhPpHwpBE+3TyKnXbe0BVmPkzFBIn27FM1Nje+P50cAZzQdTOtDp/qPcE+6aq4L0jpU2K6++d5o+NgnyYbhz8nhtZG4RBMTYrOTo2wnP77cPG2kbA6LlZBMEIP4FtmCm4ueah2G5Bmm9o6/Ke1FZN8bcfVVlGNVDAMTRHkqOOqFqDf+/4Yhxer99uBsFo1UjJkeW/y+CHgRHCO35BUmDhcCtZyehvEC4F7kwrNo7F5V8X/Q6Joleieir18M5gjW2W/fzXaF0J/YbrD6PnCMxScf2PZAMYd/MH/++PWVTRfuXevLH7po3i0LIEsUZUJR/EAmo6itpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sTn3gEuJdqXKFaATJaAH/gVy5VowlZob0uU9wu0RpE=;
 b=fC6rgsorZxb7yCR9gJnJET2awpndgfS28z7uI5Kdadx8aSQG+u7l1c41Aspvj5hqwIdi9kyuaFe9hTEhnMcJVCA+Qc5l6l9noBAQClDbCec/nufg6d5WWj/7CDaI5G05UXAMKqUnY/IqGHUjDAkV06qm/3QWWt/yNqTapYMcZNRS1eemw1wANLLvqxR835EAFHXW2sOqlN0VqoMe5SeB1+6UNr5jsIVBihYQOUL2Q5w1nrsljJ4f5F/UTyuQ13dEieigiWm75APjoyjZPdkd1Sf4ELFSBdTzaxG0jfoXKEjvchY6IjyKB7ODUOimYXuaPR+24+dTgdSQxr6IqH+Uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sTn3gEuJdqXKFaATJaAH/gVy5VowlZob0uU9wu0RpE=;
 b=nIO7MordKURM2DYzojdQGLRQUSK1fTfN8F+vQMelr61Ni0IoBeTTC80rCli+hbW1wxY808XjaPaKxnarfrLRxFfOFhsjCXPm7t6CPAEOui67zP6M21fgufyeYuRAj+kelqi3CZRGrBPuSrOgYxyHv2VSzqM2E/Mhz8tbYd4XEwo69vUYK7XKq83JMNTotRGZ7t8jhB2CUkU12qQnvaCzhIs/XFqdSvC7K9qp8R8aXFaVMeGo3l5/ItcIANUWmhmp01y6kzAZgruKreNknQsQ13GqzJQcLQEhvH4D5Uvd4Q/iLVhv3Mfxod4mVf0UEmdemPYHiiHMDBwV8yi5cuMKkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:57 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:57 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 06/43] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:45 +0800
Message-Id: <20260709033428.362970-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0fb6d8de-4e90-46f9-7170-08dedd6b0ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	58p6UTI5ayBYBdRIRjEO2+SlIvt2sj2sYpUeLiicz+TJTamP3353B3PolVdsSE7n113oG6y766Bwsp9K7JxAs/h+LxVnHWJqBgxLRpne4z3iPTtJM1nmQEh3RNLqIB7j5gsA0e4aNZguhXwpU7frke8L1WprAzG315DtJ4WFFL0GCx/6otZirh0T7WyLeSphXpZj6IdDsIPj3JKNPgSX7EiSklnsFmfWDz6eHpCusTlFmyfSSAWZNX4kltpVp3s7f8wlo7TZX23p4K6xU3ZTqQEFROfzDTnZby3BG16CYIHkrr8ckzxrEXOmcFQzUMM2iGBVWJVD9BDzU8TVa7HGjeAzAd3bwI1WrYaZnnQlloRrrcgEZmtHKtB494LXPSWdz8ph7aKF9RaF0mQgwqfv/w4vfup6YwIvbbShjgj1CcaaCo7C5HQ8bw1cAg8mF/dxylJNgQA5QYzz+jM/PoF59y6dYuTKZf7ZJmBpXFfJwavLUkZgonwE9/S80bYexTqNatAbokcG0yYiJivuakfeZHyD0VpeCTNyDDeFC/Jq7Gy3SlAbI1a/2eawvQylDOPfSM5l3b2Vjksr6U4dj7ybBVtKMdQv43Crrk0Fk/DdusTvfHgmNZPZ2qZh5T9ctuEtcC3n1JhkedReJsUZlf6xJZbCv0Fjk0bMk6A+ooQUWBXxARRMYDwK8EQOw0PKNzQWnP7AZ8OGieyju+Ez64ipVjguY38oHo30mYs33ZuQSX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OcLyhJEd3hEMF6pTxzgvOVoimHmBomKNHENloSuCAxzDp5TK74+GZFe9Dk8Q?=
 =?us-ascii?Q?IQI/uyqN8iK4x0FPCunIPhMHuOGiELsYl5ma1jr37UQ9IUMIRfg87YqjxMfj?=
 =?us-ascii?Q?mdrPBm/fXVdbFQm2vt5865WgM14gqPtblPDfnZztwIlTDr6W8wevQHyCYp3d?=
 =?us-ascii?Q?rF+PvVG7lh6KHKdi6nBb6JX6HqdEzOShUxhkKNIBk8XQnJK32YOzZYFa9+yd?=
 =?us-ascii?Q?7zsPVKoGBICrCajeGSpnrbIuNQsGOiuOwJ1CEkJkCju5K/LLcIwTEne0m9Xm?=
 =?us-ascii?Q?yxVWC37tzSoRIK5aJm25Gy0ams+7tY1LIhj9eZ6L9478KAdMy/OYtqom7xoR?=
 =?us-ascii?Q?vuBF9CXoXccdH5FDccP8DH1J5Gz6xkoJSeVnUC5av+uIDhP8vPRhSeZIrpkX?=
 =?us-ascii?Q?Rz8sT9BYPGd9Xjx7Zq1Ra9ko3WeWtz84MLxA9p6qNLIXGab/GxxnYI9wz12g?=
 =?us-ascii?Q?6HLGSCpmhgv9QKvMfJngiVAgB0CJcL6QISKPqhjMUcHR5GnYY2JjR/LhYNFH?=
 =?us-ascii?Q?wLDAipvCnauZ0E9ULeugXjsPKVGqzKat4zj2FOfYV3ImuMLqRQHmQxxzYo/E?=
 =?us-ascii?Q?nYQzNsTj2/3jIwmwQsLgApBSNImcY7HWN1pW09OPYmqA47rxWFuKu20vdxbh?=
 =?us-ascii?Q?DXLFhqnlf5FL/idiApF5n7rYReZvpzY4HZr8PSa5qPElrfQPGgOjcOq2caBg?=
 =?us-ascii?Q?OTQrcHWst2UPFXt2V4UM3I1LPycNl8e5mvzj1aW/6/C5y6fNubfUbQF2cKND?=
 =?us-ascii?Q?raj1TvEIn6R/5Adcs2uFgU3QCBCb4I9Pd7Li7l6u9CvQUbPXnI38wesfd9cm?=
 =?us-ascii?Q?GtnDFHQmV/hPEFgjFM0sBBj7zLhperE6+Uwxnrly43RSF+7Fbaw2l9M8JGr7?=
 =?us-ascii?Q?l9jil7PrG2vrpNZHPeTrLgHLQYFhBojC5AkSM/t4WhMLjpuY3YkXzlQLsLsV?=
 =?us-ascii?Q?KS8Jg066TIrcv3HsYpTtbFudknvkepDk6Jn001iv5nQmgTunGgXgTVw9jIRW?=
 =?us-ascii?Q?HPrxbKTV7AHiOX2QLnP5g7QuRFP0heHz3jDbX0BHVeCGf0IsYFPA4uS5CPtY?=
 =?us-ascii?Q?vrAXPTHhT1ndMxwaXEXU7NeVaKYwzmiJZMkQWpuDrpTAsuF1vebUPIjKU4Xw?=
 =?us-ascii?Q?jKUjiBPi9MvdCnqJ7yuLr8H0kGTaMWFOQDVbH/Gkig3YnXMNUM7dLDnAsT8F?=
 =?us-ascii?Q?y+U+UrlFVDpCCYdXwWvGm6ohWBxM3beFFCqbawTXK8+//k3jQ84SostgIRxQ?=
 =?us-ascii?Q?FEPpxLV4PSA4niDSQlJANQw9Ryu1fV9MFMiDDsnFgnQTqbomHif/8JcIdrIY?=
 =?us-ascii?Q?+WUZSkrVs1JF7WQMs9bOqeYVxkKSKvGT2a+1P/xy4IensrWDqM4rdy8FPYDi?=
 =?us-ascii?Q?UXkiz1VXSM9K6PEJ8l8+Q+nsnotKHh9+fNUwEm0eYg4s3dgL94UkjEPzAd3j?=
 =?us-ascii?Q?RCAbShj12vE+4uJR0ZmU0q2RFLbIq3eRVQUZjoX34iVUMku48Gc7Y9gQ6XKO?=
 =?us-ascii?Q?IhloAyldxVq9OGmhWGIm7J+LI9MLuhUjlnyCawXQSunnmw8mpcW7JcXKKZYv?=
 =?us-ascii?Q?57lRvjVk40jreFZ65LMblxlhzSNWpvfnUR7S7lQ7lghfFOp0th5/fYDNX45p?=
 =?us-ascii?Q?SLE3f1dI7pdOAFm7xXiumohCj1pgqDLR9jWiJQlkiD3mBXRXV69ShS+46TCG?=
 =?us-ascii?Q?BzH7oIEMq6QWyFZxanydZmk0bHy3RQpwH1Zz/ZzFhO/Hkz+9BVyRlKKopbxY?=
 =?us-ascii?Q?NBgLHqr3ww=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb6d8de-4e90-46f9-7170-08dedd6b0ca5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:57.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nnJlp9ORQBJ5demPrzmgkI5chRiwp3khh4Rynru6M+6JIdVZPjTQss39CeRvl8/xa0bgBnzEcb5Q80gZVWs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/ab8500_fg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index eb5c1ae68e44..f8f392592193 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3178,8 +3178,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.34.1

