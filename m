Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223633939AF;
	Thu,  9 Jul 2026 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568125; cv=fail; b=Qny7M6/xE6uWwXM0MqIYs6yCaShJ7KIV6CvYM5PuembXnuV0m3IQU1Y1zYqNkxWyk28aBhSAxSvnX8upHm3rMUHrExn4LQpDddTcX0viIGVjzv0CxfwX80aUsspA7NIxdSGOPN6X8QHkoT0V0a4kuQcOSnremrhjhv2jzPVrxQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568125; c=relaxed/simple;
	bh=xtgyMOpSg4rxnJw5bRyscun70HLftKShLPmUA/AGxrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGlU7tjxQp6eMiy1L8sK+tbTvHyxSzOW+/ZqwRl5x8AAxRBJf/EodoO+natnjZZbrkfLDKuhUG9yZAr3ub77ww4V6s+x2GO1rV1DtDLTiKrwhqOPy9PH7/Cq02mDnsmikhHCVGgHui5PGI9oFV9pyHyzYNvx97005feX5nAzijU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=leh2/D05; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="leh2/D05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK+0YtnBJ+UhscaDidHE62ekPoGPLmKm/7fc5TZp1jIgLCruMw0/YKyz5f8MYzEAtx9dzYN+X9ETnoTqD7y45xzltSXG9ah5NH6ssoVzhrq7jwhoJHviCtoJd8aPtiOENF1htTGYJWHuh5CFINdoHQlPLhLA4GovCfVBEgxfHCvxFYnpO/5Gd8bMur4QYkOCEs/Q50uOikcQ2mOlWWzctHwRAYSFyV0twi02pkJiVtgqTnpyx81x1ikoTKS6wPgPUyLZuKJODymnsW3wEs6CHP80ibR/0JF0I3youeFakLerJpep71d/XYd8M09MoHxhzpJP9Q8WLgP3VGbreuJ8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugbQAI9oiaskTt+Gs6eCYb9EaiZ3d3EzDTEMFXqITHI=;
 b=gL/kjq/mFYQKZ842gFdqcN8GmBgKhj1Vi2qupw2/+E2Q8UPct0pKNfPpcZOe6yOMcAQKOA69mymHAI1idleie2G0QUqvxG3UXRW8o9JoNvpXM922f5blyekXlapai1tHCINmjfQClCYwYfKC1YuEdRid1RjOCbwQZmvXbkC0eDskouBbl77uVe0B+7GE7+afkaPBS/qntV/FA1P5dEQO9ItoIgTM4rRnVNY+ja0x0ocfFduouAVjav7DUuKmmTJ/18UHtNKLviwA/lcwqabknfHrOhjYzUViEGq84d01nZ+SC3yAV/EXmQMogzYcPgQRKCqCm3ZQuSBU+ZSizh9Cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugbQAI9oiaskTt+Gs6eCYb9EaiZ3d3EzDTEMFXqITHI=;
 b=leh2/D050k8AcsAh8ejORjrYYX7TLcUmeL3FVz7Wj+m44fInZRNLrtbKaaBMJLlTs8rayrgplyBTm7gsAymTHyUB+B+d9B2UV9oUXiAj23sM14dPfRj2yFHy2C0n6a0E/uxnUvWPr4Hk2wfQs8h2esaSoxsVbcytvyCBHTybZH3+kvIPoVTPR/8ci+k0wS3xlYwKnjUCXs8EIID+26TEFXK7XQRtLjZONytegJnb0ByuPqVb9Q0gb6rRLopWYBn8CF/9mEIRDxauvweTnDEyamuwk1Va8q58Q7jSVsZXE4i0p09WOtr5tbQU7v1TmjPV+U4UWk5LE8So9aceMPJk8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 11/43] power: supply: axp288_fuel_gauge: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:50 +0800
Message-Id: <20260709033428.362970-12-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37097fcd-3a48-44b9-7ab0-08dedd6b10a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XHiwHWorDI7R1ty1T29LF/N0OVbCEDRbOyM6dEeWhKIedlxDNKHCfCqSeE0ur+q+9kzmzi/8eOBks/1QR1cXmcbfWBFPII8fMDNw9Xm70thmMqVjAbhOtB+Szg2yh+uowTfyB1IQdK/7jPCo7t+c5FcOrQWmnfg3Zm7yKZYSBZ6cpAY6CSX9vo4fGuAqryCVODD34A5Hga3QwtAnN4afjOZeK45iCTkDy9v2T610uKLPkHXhSf44DEFAYHXBPhTDtjqL5UVHz/h16WfIMzl8b5/UI8tlTKQrIJIYXpdEv9/8a9rUjPMppCs+OTMDXtuQRBora3/OoR79wqZpqX9xEAKQyQxVYNgoO0RNd9e6nXcI2/dEroIaXqdKyoeX1lO4yitY9knqBoELMmsmaKKt4zEFt3Gk6e0LEOuJMr/AJKdpWoZd1yfVFyW6qOcbZ7bCkcfLPF2x5K0D1Rrfq7ygNV4cmVtbjJ9TI979xf9eCxuJYnlDCB9+OkjjePLbwy4Ftw1PhOyBtNvuVvwFZYmpghmkoE0hp6qIl3sC/ShLkhqykqMObaBJWF+9pA5zw+ihnLXT9P5q9BY7ONvlNJH7mnt5vNeMj2fcQ8cdGTPqgJlpAMtGAPHhDFhkAYd2qQ6Xe3J7cusum3aMsJ1iA/3UsogPrIJrqDEa4IYpNn4c25zuWPeZwElvE/7T9Rl6Kb4W681dDy6u89qncEXip/ieRSE/nqFXf7M3CKgdsSm7aYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvxcrDsAzlwGIOzNNCEQE9tuW7lexPIxECBuaclg8guOv/Bis5rAZQuNP7NA?=
 =?us-ascii?Q?+2bq9igDavjXiYekAanp0yIRtSIaxrjOoEZHPPCQ0KCscUka67haWrtMKndS?=
 =?us-ascii?Q?980kMt5tMwI9PLt56zOVOpFuH5TJ/AFD5sEW4UDf84a6ue1tGYOWClfm/2cX?=
 =?us-ascii?Q?vL5GqgmPHyWI4f8LpBNOiYVpOu4G1/KHcmUPCDm9kpIbnRnNdjEifNGEbpkz?=
 =?us-ascii?Q?8XSfD7iYAsgkGE04YumE4ZAuQc8itd3vKj/R9HqICZuKe2BYhFwszJenOu/5?=
 =?us-ascii?Q?5mwIxb2TQJTcNGG6Zlf1cVqFT2lCzR/NtOT8rmyOHiAmrh6rDWIxLl6lb1+N?=
 =?us-ascii?Q?jQ/v7e/+ttD6PJsgDnmSbB1tRlwbt5WWW/dQ3kOq7qzMb/RWO12L7dO7QUSx?=
 =?us-ascii?Q?q+h7xE+T2kH1C5c2bAQFmcL+14lAWX92Tw04xXYT+hKkEddgMCUDaGkFf2+R?=
 =?us-ascii?Q?A0SQCSDs4KBdtz4G58eis4omE5EGiO9GKcGcMMjiVbzQM5ctHqZjGb+vaBqK?=
 =?us-ascii?Q?JxJaDXJuOiCnrIcx2ve7IaUxspgdwQnM36D7OhETkQnfkFf3qhrwnNrluAdy?=
 =?us-ascii?Q?xQhyiawGAFdkPJ5biJLxq2BeAS9HOjRQ3x9fqTaH9qcYmTRKaWof8eTpvHn9?=
 =?us-ascii?Q?1N4KoBw9KurpvYdvPQymLUui1d81SyM/BQiAAQtsDpI/8BM6JZSKvYUIB01h?=
 =?us-ascii?Q?qDfNxGyxEuq7n7KCM92HtJ5zqHT2ajx9B2ssK69NvREAR4GZmaTX+b6GEWJG?=
 =?us-ascii?Q?tOZxxdtFyoXM6dnPAZO1rcgdRqYzx6TQ7QsbgICOOIkx2j0gkPZW8lOmBnT3?=
 =?us-ascii?Q?4XDaAZZR7iRsK73wW7spFLUflX+BqVvdwGY8R2xbKjoFn4QzUOHt0URh+xpD?=
 =?us-ascii?Q?1nvBS9h4vSkZqQJrV5/EFA4Yx7RYtmDGca1igIboFA6I4J5xaXszmkL+bzUY?=
 =?us-ascii?Q?PR3bwBpFElLKuWX2oMHDlAKzWSDNDrOk/ft2fP3/vtEfUXMXsklRA/TbMU6C?=
 =?us-ascii?Q?krrmYjh7Smo2O+fZXw1Ldc2izty+9Rt6kG7nf/c2S1Ep24dMBP6NAmQfaEH4?=
 =?us-ascii?Q?OaSan5sYD1OVB9FyQN1GqRe1P9W+99U0+d4ZI2gc1LwikPcNUa401aWrSYdn?=
 =?us-ascii?Q?hfVsdwsWsbexFWJL63Wo+mXHQ3t7QeyIwhW0KjiMR1FjcJDph7oXCFbB9Jjr?=
 =?us-ascii?Q?y8ggBwVZhwQeNSbnrmYEF8pI+kR5RcAy4BcBJTVbfn63+RDHVO4fB46xMWKB?=
 =?us-ascii?Q?YAtUQG0PreKbtKSw8lSKMOxSe4hAWk5Vw3ahbmdydsEHXN9XbPhahfu/fvh+?=
 =?us-ascii?Q?qAaRdsTeucELWWN4PnO3BEOGVsMLD7czDLwbnWnHpti+4AkqCCb+O9DkAGyK?=
 =?us-ascii?Q?SjBPxJc/3Av3dw6N1p0J33EeGGmXmkFCY0Xt3VuUvkUGxVWUOXpKu4iqrs/y?=
 =?us-ascii?Q?k/5TRbVPPbZ4KJFjW4S7SkII54XSxPclgTK3LhEUHOayZLKH3KOyn30edbYL?=
 =?us-ascii?Q?LxHBKH2Z0byRgd0z04MWtQ4yfxdetJbo3WDjpOijko+L+vg6CYJ03kVlyKbI?=
 =?us-ascii?Q?0Ffhlnp3yGTxv6Qh8aXkcyRmw7kNm8eYb6svokuOFtWifHsW+gLmNiKysB9V?=
 =?us-ascii?Q?u+pTZYSvys2zCKbq9k7Pi3u7xkaa817+i+2ffI9EDLXa+n5PkVurxXasdaeB?=
 =?us-ascii?Q?QXhPQ1x3MmBKClBIxDMH0rVl5PhMu2/CtPX2+MBFZpZvPuiHGGD3mPLB3kI7?=
 =?us-ascii?Q?S6+NVgWNLQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37097fcd-3a48-44b9-7ab0-08dedd6b10a5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:04.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHvV4jJN9fRelX7d1OmeySEzUY6hwvO7STFNgZ3K2N7LORX661noF1b+43ihxIraWuLe+X0f2XHuFBD7AaDDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 5af334c0a980..aa04c54ff97e 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -791,7 +791,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 						fuel_gauge_thread_handler,
 						IRQF_ONESHOT, DEV_NAME, info);
 		if (ret)
-			return dev_err_probe(dev, ret, "requesting IRQ %d\n", info->irq[i]);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

