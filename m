Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA82395AEA;
	Thu,  9 Jul 2026 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568127; cv=fail; b=ZV4f+MRzwBFk5646NLImbizJ058oz5uMJhHKBmcgPlkNVSSQkEX2kuiA/joWKlrccdsLVJ9XuuPQX2E3sdDi1Lus6iEfWaSU79VIAA/BcvtOzoU56MhNtm/N3cYcaHf345fnRIo9tNQClnIBlnQEKeKAXA88UiZXj01xLt2Otlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568127; c=relaxed/simple;
	bh=TsDUhAsp4bs4WhrTKSPx76EBNOTCYPkLvgibU6rfsyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGhzqanvv2TmbHvGMKvm4YnNAU0CXmKBlySjUroH+OKlY9126u29cNvRjPhVzY+2Tr5qNn5TfVQRXGokpxBS1E0ZSssazxtwVxqOvL2IseKWqLpRp5FaXGv4ZnVx/pjQ5SN1rHHbvGdqqmwB2r/i0hPoqcWhC2ovL8ReKwsKe7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GKzbOpml; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GKzbOpml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voSSl/dtSP8rEWPwxKhyYTR684WyQNKECRPz0aJyCbDHbXBDDJFOm2Csf6bznQ1xAJQz7xR2bnkTOVWMsLfjN07I1sIffVED78lQaZZ9kxo9D3UyG4TCEWd2K/TwTxVuDnM+sVMX1Z2YyfqkUhrXV9HBh/3lr4wX3dfp607MqGHb2nYCc+WBeZici/PvDEHEKDHGYZ/y1M9pM1sx2m/kFpNZGRC/xpd7wGwqCLqZyP/8n2NV130hR1qRTqr6JB6nP/RTdZKGmzufNAZoBJDs6Y/0iPDTtTeMArcGkPFPmgGPvz5J85q6ULWp+wB7yS7pVxwmrYmMPQZ4t1TjsmboDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SFtAhVvJ32Ez8T/WGNpu1p5tRXpPAOffVAj7ZwvLuQ=;
 b=WAxPSV0UX0HK0oJRXgLtC9LXvPK88T51CLH9nr1+s9IR8P0UIp3NTRxecwzm/MgprrkCTII7Sh6TbIBg8u9oL0YT9BIWZ8nYNi8ZDhqPgCd7z1q1f/hpFu6RZ4rXB3GwI2RzhAfcimp/xeFe9koFuNAiKDkVganM3xrEAYWZMqFXRcENBEUpT47HeqwH3vgg0ZtpSqpY5A073l1D1PEt0YYsBgXIquzjAuilE2fBMygaLeA7JwO71NOn7PN8XexcC3A/GACdImCp6aen7YaDGFv0P+Td9ipyx16iN1bqjcdVIAIHPBDsxF5Zq3PQOhJOmAq0VZ6A20a71ZaUIPLd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SFtAhVvJ32Ez8T/WGNpu1p5tRXpPAOffVAj7ZwvLuQ=;
 b=GKzbOpml++1MLI2EBEug3efI4xlggtlM/y5kL6KswgdTfKXbbdYnVMZVBtKwvhOzrYBk39ZGDH+dYkexeKcdGb7uH86GLzB7uIzRKAbxVQWzbfg2eALFqMUbhlJqupKiaCFkBiltdUtyadTa+K9Qgov39jwn43p0nUPFjtSKdrqkyLI5W37ckvjmA5ffq2ryxpKrqrWDbVgiUFNuyKrn1wv2MlJkdT7+HbK0z7fNx+HrrABObRvMSy2mxyqlXzLgIsAGO8fp6r+P+4JIJsZbQVwy2LKIrn00e9bq2uIn5gKrw7U8/DjzsgSW0QerV5E8K0p5wAkcyfFPZa8H0hjRLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:10 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:10 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 16/43] power: supply: bq257xx_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:55 +0800
Message-Id: <20260709033428.362970-17-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17e0bdef-96b3-4854-ac2b-08dedd6b145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ojuHhV5vDxGMbcftwN8YycN8+jSXBoB/3QuY47T4VWXtfE0MqzLWI5cYr3GiHUpGUbfElfkq6QNRIMyTBkO0S9NYYIqPcZVIDMGSnLeTf3jX4CYWLEMZJpsuWPOrusZa9/3EILecnTvyKiZn3PzOLR44TTDYpzOH9vTd+Ph6Ie6Nwqru6QMpHmNYDuuADG9NccMnIXhMmu2yEbu3YLQYNR01Shn+ktPEAPbvlvqiIS20GMbaZ3IRaSBj5Nf8UThP3l1enyF0nCJWkaWhCdjEEjuh1EYpCBTTj90so9/h5d/vqKED52/sBzfsYmmeBAhqjAsBddSkzCp4Q9Cwt0s2yNz7JXw84w5YezyYDTPDS7BwZgw0caySDwBOCB1C6GVp4Q8S8F3pPZmUfM6bXNMiDbioNoRM+yvbXEuBMf2jtIu3uWw/xh7Cjb9X487KAa5//vPhFEYwZTHzILl5vhkC7WOHaD0Xlh4Ng6/cxsAKOQuQSYD0ibAhtWrcI0FN8uLoLXGYsS4dBbIhM4RyywDBvBPEjcx6yY7UhHsnasssvx8Fkjid+0it1UcqTYsZQ2KOwIx7fhyygqnnwEefOhjEZVXbL4EKIPwQBntUFKUOAycZ7RR5sx7xFQvT9tzYokiGbGIQ+7g/YN4KBbaCZCnU3rLGMIBtnQXuAuCTET32FFY9RJWys83cjWZ3hM1tEOrKSFL/Oakt/xBa3KzQLqjlLTaQYPO9HjmgyUs7pKaLkNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8tpcxkPTwWFTXp4H0ksuZctIHxBsY/FCUiyay3wOKsJ+Uvca695WBFkwiOld?=
 =?us-ascii?Q?0G4Ka/uWVx3QornYW2wpRnLBLAgzYBIui0D/I110MeXAdGbPFQ8pZUdZxwIW?=
 =?us-ascii?Q?SravJ7UZMeF7Gvq8nyyjuUnq7R1Zt1ZxpwUOD8drq5WspkHbH1+Lj9m5GJs/?=
 =?us-ascii?Q?VsmEe+fEdnNvIMZN8o5cc8PAv+DHqotkVHrU4TU+7tc7JZ+c4SbamPpgBK7g?=
 =?us-ascii?Q?JGy4iQi9XEWaBSgAgcykiXr9wq877eK23aHvtOq8kyvgx3Ly3lanhERn728b?=
 =?us-ascii?Q?eaNv+VZ17vwhqgXlwMF5h3FTj1Sgl3RlQ2vlpNvYsD/wGGN7VXr8GtjzS0g1?=
 =?us-ascii?Q?v7JR+H5I/Z09sLts8bUSO7Vn3A9tTXyycV1WFQnEOBbuwM6QmoribGWLcDc7?=
 =?us-ascii?Q?oTFmUKF1pR1R+ARlXlgDzanswu9/YOi4m37KYFUj0FSrw1duTrjs5WUerviO?=
 =?us-ascii?Q?5Dbi+oxitZ3vfPl4UWbeLXTW9QjxVefWmu7kbUsMIHIVpUS6u0X1oZqny+QZ?=
 =?us-ascii?Q?vdmc4qFjfh/uNQhre4ForRcUzb3hdMrjLbJqY1VslPRWJFluiJHY44XkjA4Q?=
 =?us-ascii?Q?5oC9+LVcEHI6wGJPShTV4zIpJMW1qVaEPStrO0/01hITUdW5ug2qw1NPzyko?=
 =?us-ascii?Q?szTBd+DklfaCvolTFyUtKiV0VjxTE82qLrk9B5WjnX5SkRW4+aI3iuhys8YS?=
 =?us-ascii?Q?alBXcmevBGaf+8Eg/201eB6tCUoQ8+JR0/ANiVj8qxgRuHHsMa9FPdEhkmSF?=
 =?us-ascii?Q?gii8KBK2xolNJ0PuRFPPPc4busQi5JCg1SLSZ+kmmpPILSWl9E3aZhlJlK0v?=
 =?us-ascii?Q?iKXPfC7/zNG4pO8cUx5/oVbjPl9jcidOLQ8NXPm/OSjxpARfB0ayl4NspmOO?=
 =?us-ascii?Q?r7Hw4thRwRosOVuK96iLOdxo95L2QcRN/XlEWZ9YlY8iTJ9vS4ml2gpshevR?=
 =?us-ascii?Q?kSvXD0CW5IdEwG553fpjMrJT6JLi+sshYs4YBdXjb9W821qOWxlObj5fBVL5?=
 =?us-ascii?Q?NmRrlcDU7ZNohOBb221k7sJ9q3pEWVYbg3sy1CV3QeoqEgH8pb0SmOLWYwhI?=
 =?us-ascii?Q?zhqXlcVRnUD0f2ZYmYAqfbNVM8PHWbOaSSQt/qwqddmBNoR9+sK3wKf9qBuV?=
 =?us-ascii?Q?sV0eVoBxfGPjeBeCD9PEwcGOplnlq4RNbmAi2JfE59oLz7mfJwLj6s143weJ?=
 =?us-ascii?Q?qJojGqXO8g7VKdJ82OC/ltlGORjefnnAWkXVfu8BInwCmFKf5N2uZqcvuVO+?=
 =?us-ascii?Q?dqyM53ACpW8DqkGBEHxCPBjb3o1sntVbDetZUyhWp5uP0mobrGWyo7fl7dvs?=
 =?us-ascii?Q?PUfqeJMUPR0fE3V1G5p3UtnVFjYzoez++a/O9QH4ssCCAqdbv9S5zmvELUD1?=
 =?us-ascii?Q?bC41CF97yL6x8ssOjfEIhdtFecglh5RAPlQPoYrBIj5LROw0qk2oz1Rzje9L?=
 =?us-ascii?Q?UNy1arCLllzZT7spoevgGWHa3Tlr1KpzRKM/KIJr0fdstVOAGeDX8bg0b0u3?=
 =?us-ascii?Q?qRrHpJAOWcIqH98v8W9DI3WB/4MF+1WFRHB8w/LVwbkj1PWqUL9xBUkvlQkG?=
 =?us-ascii?Q?Py1OLxVeRgTVFdzcs5+L577lDNkJtmsNSLqLUk961paoXmUVifeVoaWyubr1?=
 =?us-ascii?Q?V/rTXEZat3tuPOY0G9oLoYGf3wWLUz4nRiZ3/cuaTLxY0Iwpv9YTwZJ0GzF2?=
 =?us-ascii?Q?G3vp+0euxHiSfdNA3GGF7RSBdN/s6TwsgLpU/4+emj3JNqxay9CNsFO6EgLC?=
 =?us-ascii?Q?q/BqiHMuzg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0bdef-96b3-4854-ac2b-08dedd6b145c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:10.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/8+6U5Pw1abW1dLLZeaptoIb75A6kIS3AAiiy8+A/eJgnZ16LmuU8aGTPaq8mWXnhp4IayJPt4wE2s36qU6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/bq257xx_charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 9c082865e745..10d242cdaa0a 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -753,8 +753,6 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						dev_name(&bq->client->dev), pdata);
-		if (ret < 0)
-			dev_err_probe(dev, ret, "Charger get irq failed\n");
 	}
 
 	return ret;
-- 
2.34.1

