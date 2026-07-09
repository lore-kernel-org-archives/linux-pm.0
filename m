Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53E3932D1;
	Thu,  9 Jul 2026 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568117; cv=fail; b=RIooiDXmVNgWcw0Zg9oeSm1EriwEkrJpEnhh8RVuRm1YKO55un/sAjEX76lhsN2kfeweqtVFXORl+OHufjn5h8B0XwpNiBYg2Vw+n5sCkWn7YwvMDOVPG6vAj6z1r1M8HfdPryrYnwCPycaukd7c3hT2INXEYd7fXgueMpmlPT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568117; c=relaxed/simple;
	bh=dNeMRG94A2a2EmjsRv3D2ybHQpzwZ4DUiHwOWzrIXTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwFj6bGv/2SaQjmHXC/HpGtNWO2pgw8EohAZysf5MC0vGowWEo0utEsjaI6RK+J5hjYrLnJqka5AzFzwFKr8tUhL1ptDhXn6Ops7rqCgg4OI4MgnnqnmpejHNb9txNdMm2f/y0zAw6mbRKMiJeFO8hVTpUgLyJ5koCh5E3nnl3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=moZw3CIT; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="moZw3CIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRTDoUjTvoj2z4FpjADOJk8nU4I6I+dXFECiR0A70VMwxIdXtYIrqmvlBV48OVZeYjldSCC6kAonW5mJ3Yj39x3DwmLjazvfv8MVVuUvi1wDXxWCp7fLAO4EZAz9rfFTeF7ELRuXWgg6OoscpbeweVwemXgsv0lOXLKKQ3V3iCcsiGpu7I0ZMqwx5oFqPvwYNBE/h+V5Fv05kzJhOxYqh/iXWw3p/FwgPRRvN00o+kYDNQ2AViVLmpd4rRsdOQwbRLT/hYfTKunYNrqQXkT4UUk+jUJQPcQwttcc0Ruy2wS9tCEV3u+wkeXK2Rpnnmd3sp3RfDt664gyQDY6uo8Dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrgmkGwzPf4Zzyks5uCQQ3JOPXIomMk37aaNo8Rq6L0=;
 b=dAfycltXnbciv0QT9d4+ppElfXkfwoONde5Tw1f7yphQ012p2PXTzExwOh8Osh5C/oZQJ4dIwzMxddCNAYiaTUeJN5zz3HC44Mq1LPYKrN0qHJuHOxCqJ6pJwhlr8odnz7RnK9Wes1hPvXt1Br621plYos5/XWwkVC4W4MClPIEiUlbPi6DPeN/w/llynX8U3BEtkQAUXDuAG7t/2GT+QPUBe9K/THdqKHxYs6bgZD/nBXe/kz+X8sPvx2mIIwiv3swUZxXBA1Kpaa1nf7A2EkxupeIJe0qmSbdgEV9jVNjaqJ92iTe4XdKnaEpwxeElntz9H3HsGYWaFOhNx5LBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrgmkGwzPf4Zzyks5uCQQ3JOPXIomMk37aaNo8Rq6L0=;
 b=moZw3CITeqbNDo9medM6iXSoWSuJaP9RzIYFpClOLJrlDyi17UtOrDL/Vvp6wDkVlCF1mEdKHYAKg8HFfQ3mvoeuBocPAQmSL4AGYEhtFOj8+V9DQb4beSIZyCG6NGcOjcg+AkIcxo4WXDgpwUtKjGJ1seJQjsLZXGK9kLCzweu4XgzptWzFLQKLrwlH1YbuSH0OomLj/Xnk5ADBUIJ4coHP4lGKk4qzzfLhPTidTCjYl7h4lNoKsynAnXsyMPqle8p8FxlieNoM/N8BuOwgOc7FykD5eXQA0wQy1R/B1i9kqW1fOfwd9yNnT7w/xwSD5K5yaGwWh+bkS62LxXH6TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:00 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:00 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 08/43] power: supply: axp20x_ac_power: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:47 +0800
Message-Id: <20260709033428.362970-9-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8efc9d94-d87c-4521-e99e-08dedd6b0e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Qx3naujdAwpXcV3DYGyBc+kVpRpCbWzjYYduFDZ3gtxV41a7rvNpkjWbZ/H1wYNcXtidJK2nDYNinCg+fMC0MR3bPME0chjiUBZXZ37rQyc1PBBOw4NAmW2Gr/UKes6gPBBdYhnKpAoGZUC1d6UDsxVbmEzr7QN+yVLp36l34FaNg56mIetso7xmJbeD5ChtbkjngRl/FsqYfdUS0CaZZWcVQ8tSxY0DR14G4v2Op24n7grT7bwlmZ+PFfSQ0b5luGlP9ASBwpTCc40ow+5dkOFxxs+EiNtX2vHmn10qulfoaNVwmv+ls+0ikU9jqKLwCxmvLKsqmd7dDeZKL5EIi8Ootn5WrAN71+TXpY8/gCZstvaudKecLcqDGS/5NbOXn1hx/9NbQ0xvobRZD0yVMZA5EoT+jxrWP0wx6vqWRuW/di5T80w2oMdg+sMwFP47if8BzL1/+xE5oozHabrK8E7B2lA/tl5yWyIzaCQAFEHtlAzQN3sT4rVt+nRAGhhIiM5r5pIHbMOUF0mSyNUwOBLcIUH4ANrYx/RpUNE1ltMoiQCe4/UBBTBHtyfB28kkZFrLlp7SEF/Z1m5Xyw8VOqjvPF4Zza8GMHbayvjMkI4rcZziCla8PeC7hvbXucn67nhaCfo/LeewNj/hr6fkaOKx2ziWnldAcmd4IXjdolrcNt5Fqpoe1NUcJICV7y3wR2giDhO+iAMRQyj6AU++Y0JZ+06jmYyOrd/mbkMYFC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KqNM7qOanuykpntMb6DgnzU2k72448QbaEKLOC+qFk2m2MAKLjH1Y8KXUF0?=
 =?us-ascii?Q?jT1xowt0UyZptpFgowWoNUHDnjuPYXgt52gKosewrWxxGu9Vmk6BlBA6K0uz?=
 =?us-ascii?Q?DGt9xNl4iwuWv6akZhyK+o7SZS3zGg+LacaG+eY7Qa7HGHNqJusmd+iD1CxO?=
 =?us-ascii?Q?PtflKvXEB4dnoZeAZtSKOTVMq1KAGiepu0qtwtR1MDhAOVUq45fNbKJut9HM?=
 =?us-ascii?Q?ZRTAOyAgnS1pkS4z6HRXpNrD5dPknZ+uVTw0+ZMwxwBkl304/XnGLkIKy2H6?=
 =?us-ascii?Q?X8lMvSUD/qyGX2zoEpoeljI5ip6rvsKeAe5f++75gTqrN6obvlZm81R0rAcH?=
 =?us-ascii?Q?cs6YBL0ibDNy+e+IxEp1ZZ1KwtTTieeMlsX8/Z9wHs30uYUA8/EkorbULuni?=
 =?us-ascii?Q?aUA4XXrmaaumzxffBx+9OMPSIMMa2QqUkFmEmYwR/46izW0dvxaIgIumQRVt?=
 =?us-ascii?Q?NcxSMbVNBgbTzOuS+KobzlB9SxxwOJ7NLDpcVov4ho+SdOYLLJAqycAvhzBI?=
 =?us-ascii?Q?AWOOc+eYb2Y8JWnPu3d1LO2frVFHLH11czY+3qLErPys7i1JuEe5uCfq8edV?=
 =?us-ascii?Q?97ZUlJjBtGZNi5SSqTwgcwdIXdtk1nY78MR9SMWRny9J/LUY3/z78ioCTZfp?=
 =?us-ascii?Q?Jdxoq3Q2auDyUw1Z09SbgpH3K+ZnyxWkZffL4E8/7sSTfhhcySXE1PTE4KMQ?=
 =?us-ascii?Q?bRLZEQScgnO41A5BnyQ65+Pt5VDOyv6qp3er0NE+jZ2P5b1j5um4lM2EhVnW?=
 =?us-ascii?Q?jWBjaMbTIUnuQMy7Huo25vjvVv0Ov5lDnM/EC6f+lDS67OReKepTAlfIxL2M?=
 =?us-ascii?Q?R4St8WK2lplEW+tV1kY3eX9hnl3anGNuSiPKK8oHqBPWL+kQzypXBdzyUw81?=
 =?us-ascii?Q?a/iqWTq+CZA5eY+q7uZkBqQb1nAdazECVg9yAp89/jkcgIsHcfqD6Kr9N0sK?=
 =?us-ascii?Q?Fxk61W8gXpMdRUZaui+S+/m9KtZfeND2NGlv2Di3sKPOaQHEUz9NJm3urULy?=
 =?us-ascii?Q?hGFFkNyu/eI1ylpn3Bbd5O2pHugDs4pc9qgp9DxUUHuMYpbalgEdAatshoXQ?=
 =?us-ascii?Q?5l422WykK2eYgSGgbY2SdRNCdTL4SUZPhDA/mUJ3ONASgH4A4rWH0BYGnZGS?=
 =?us-ascii?Q?IXV04rF21EZRiRBHpn/8irIjQO2iSgEbwtEc92GcrLfdj0a3wBQXlG0Mqevq?=
 =?us-ascii?Q?xH2mAHV5ictuNBIstP/wumqaltSE+HcKhIPgfSIaNyLnpmMPotCB4OcrE1sW?=
 =?us-ascii?Q?cKVWELb6ZRhyVEKE6ia9TVlCZ0yNG+wl/HOaW2Z8OE4+XeL7KcDRhDqi+h0T?=
 =?us-ascii?Q?R4m48gVqxexhyPEeGZgaspLt6cZXoaIq0qNZ/FPMPAvR0knZrwK9lHD4YWsZ?=
 =?us-ascii?Q?QBVPqZcowtgNBxm/mWPZzDZhUbCjrB0yr5GB+9ElxoCPvuw8Y46SEMVZiDJJ?=
 =?us-ascii?Q?jjhz6HuKX/AXk1k7uMP2vl6hkQQhXi5+WgUHJz5l++J0qN+JaD5bcebQsSzS?=
 =?us-ascii?Q?/GMh3oNA8QaB98jmS8ZUA0LD0MBeudwDdd3XQ0ZfgDcEq2O6xazyUMoE7+kU?=
 =?us-ascii?Q?VJxSOECBiBWp3FyVBIyTXL7rokPyC1zR4y0rFMiD/PoJXz7NILkZVpw7fKbx?=
 =?us-ascii?Q?RoqyaRStsQBxWtp/7QgXJLhor8tB3xJ9i9rKE0Fkh6aJa9Qw8AlFVaXaVc2J?=
 =?us-ascii?Q?+g828Kv8dE/2NgBbl0H2xzYh09LSlvjksf53+5gJYDED+7X9LAxSjrkLhk4c?=
 =?us-ascii?Q?35qaDJOnVA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efc9d94-d87c-4521-e99e-08dedd6b0e25
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:00.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hyeDAC9RkvBYH7zqhont+vz5CB4xvUxnGIjoaBhs3F+AhcFLWvh7H2lEF0WvYBqrUv8JXULNu2OTyx1zohBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_any_context_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() and dev_err_probe() calls that previously printed generic
messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/axp20x_ac_power.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 5f6ea416fa30..474661ba7cf2 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -383,11 +383,8 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
 						   axp20x_ac_power_irq, 0,
 						   DRVNAME, power);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				axp_data->irq_names[i], ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.34.1

