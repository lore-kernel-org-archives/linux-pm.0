Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42338E8CA;
	Thu,  9 Jul 2026 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568124; cv=fail; b=pKJJmembyNBo4U5cv9XreN+lUoggSGnEAp8TjlSJNQLjuqj8nVev2duRYf+NoCjARsFurwOpAnKgQTl3An4OtKmHmiHBUVs7Yyh1Ew2SK3JRJDuSEFr2ERxZ8qRNFu9v1At88BZ2C5UqOb5zQ3f/Psb1QKN1i/gGBuqBV7zpUvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568124; c=relaxed/simple;
	bh=mlGhOTRSCgOMeQN+AA7rWeG5GPITods08lGAHJWVq7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0O98f5L0CMRXLcMPZO01xgcUpi3CPm4NDDfdK/eNiWntLFa0/QMuyBmh2g2UVhQ96zYhGNles7jwLeeIgxOeE3GsLPd0Ul+Uxz+XpYMRhMbcp4pCdeaGa4UJBMIqJzcgcLXDGr2VHqWy5BVwjZZoesWUOsZ7uCK6QUMwHrgERo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WqOYf5zU; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WqOYf5zU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0oULVIlgNihcH7xdq0l3ARnKx4bLdtKhY9syRRKnLYYIJbD4xKZweNZEBwl/+tYwXnZsvME/QqFLGjumx7j4OkIct2V9A/ZYQMg6Z4nUpJ9TeCsK0+b+C5CNu43yK41cnoLOKO92/8BkFAhHUVLbTbs43Al0fuVgzh4QFE7xEhyf5s0RimCLov139zN9LA1BqqURJWEIl4eplui0XWGMauBUc7L/GQZG9grFgL9rihbJKUPz9UISbCUyBa5wVgQIRhAIQXkazq8GEAJajJ6r2tMz/jsW51u5VYYGy33Wh01IrnZT4u+tqoiKgivNDE2ILk8PatRlYyMRWFPWSFsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm90mlIJq9uNPAR6WTze4Erv+ygpH6I89RHr7jhMUL4=;
 b=Wilt+moh6iMs3z2E6CPG0DEWeOpZBz70h9loQM9zhKAsNERCd2cecw4R+6qFNUtqs09HH/6cr6uqyicQouvHL7Z+ji4JGWSgJ/GfGFeRipOvZOInQyOK11WhJzlSpWz4iD/ZWervDQoCLkCmG04+/SD3YylCaB+c2AuD8r7bz0TXsldq38Bpf87LP3fwaaFmLvWJFVYDeyqWZyPuEFrPWnyaTHNh7kmYUexiy2xCfMwiZcdrn1wHwoaaiiyu31qvMiRSIYZnu2b23W23PH2eIFG/hv0vr4CuPZIXNmhNhctSI688oC5+lrnHCZKUtuDujyVu0WnnAFppBd4pzWAbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm90mlIJq9uNPAR6WTze4Erv+ygpH6I89RHr7jhMUL4=;
 b=WqOYf5zU67fDNeCvebtdrfdAz8G8H7wRJ5NqyAKBHQ2LlzFKtGU4OGEtAkWXTmXvx+kKA81A5OlhK2w6YliJcf+MvgZPgo2SFYZ7tAiBw8ee09V2ts9X/WBWSENZCt/wPgtUBrPa+ky9G4C/TTbvac+WJ756Eeb4wWYJcFmpBpr1zlyytjstjrM+aoBoLBS+rL9yNSs6ISSuEObmHSJJxsJqQ/oeIcCfvjFW65qoVR5yFLBNJ9hLpbrYwmPLesQWa9IC73aDRBChKDWev1pFJLAoNqzQLTBQhCYFfGgqUp9qHbKf3jNq7DtXFw3bM57DMuQ0QJnm1bdyoR05YMxqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 10/43] power: supply: axp288_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:49 +0800
Message-Id: <20260709033428.362970-11-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebe16b61-4f65-4e8d-d442-08dedd6b0fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gAnrOU9JoeFFEhHhWheEyqgZ186PwvdSA7duR4MYgFSfLRHpzp03o14HB7N6vjNrdOxhNcnyEfzrg5BXkJLEVH5X87xinrkouxOVIX0GxAY+OYUJgRLaoI2JVob8Vk/CeZ5y7WIG9O54JFAlYKQI/ykMusnpzvvIZHApwL14V5L14g+F8nYU3Jzwr9cYBjBv4OBp3Uqd7768gKbHnMrBYu7z+hzrl80XJaS3pSblsUrGiR54nw9O8G3+kS6DYcaBqLBqLCaNqMI2AF6eSqzEM4C56/I/EZzbbwGLz8MRG8ZQO7CUBujPbWFntGaKg4y3AW08+iTgZApZLyIsXclNqgm7xRIim1IHAYHD4K8Wl5sjIRop7oIPP6tgspWpKAPntbNjBzrIk/ZEi+BNpz7MUO5p0N4brruEb8zu+TIJph1N19Lt0KRP0zZLlXe6X1KkMLuiwwg3TV/PvfoTWed9FPaiO5PpqAM6ym2hOa5RY80Lj2aB+ZyO6BfoXJaCbV7BjtcS4F1XOd6pLNDczRjbloTxCb9NrV7CGY9C9/cqVHhaVHAGaoqD6h0rW1hlXDF2Uu6GrZCD3FdUcLdsI+44O+RJVn3xh4D4INAQLH81Ln4kU6w8SxetNS7G84J+QRqYfqVAYCVZw/FmK/8zVourI2iTTOxrq5U9yL0KHXV/umy6QmIxvAf9bO9oCoxYYaNvEI46r3OKX3bjbBK1xNJJWpBBODIDmkM7is7MhUhQla0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RLWwMGE3WBT8Ou/VMkQ+zFjj7guz3ieoxYLxG9/HMYi7ZgJ0f5b3CrrlDE3?=
 =?us-ascii?Q?3/BWh2xiOHFEotP2o3V+ZpnR2HIYJb79TyVaR+A2B9u8FB41CwYT9FaO2yR4?=
 =?us-ascii?Q?lvFcm4FxZLXsoeQh4Nqd0LXDN1AgpQ71VmpsHiJ9S6wtV61tUQULwP9Z7Wxr?=
 =?us-ascii?Q?IIUPn9AAMgeTgiEQl5ThvDc/ey8mhRaN4BiFhpleAGqvp+vH0OgkfaQUxPOs?=
 =?us-ascii?Q?RTv/pT4Qf8fTzGwmFhVthmTaXkXoy9u56SUXsAm563owDa3KnuX+Arc4GyXa?=
 =?us-ascii?Q?B/3Gd/TrXLv7vlYCFzsVN1G4eSHBbyyMHPJMU2O21vP3t5tFyeXBlULyFDve?=
 =?us-ascii?Q?3ynyOkpVD81sbTMCB7lSo0it3h4WrvU9HhdC1/L4MoDVL0Cxd0WKRsiOI6Pr?=
 =?us-ascii?Q?aDo5TiAcSe0b8E4KO+0RwDuBHN1ELz1Gmg2tXqh6ungvboBH1dhoGtqukJyE?=
 =?us-ascii?Q?Q3I9hu6oNaAuG+MIQEnZjDZKENk6UcUxym+9552bt1PLeGXYUssrlTcCCBX0?=
 =?us-ascii?Q?WbP35HCslu12xPtp6i2WikkvodSSlkiNvhzhLC0W6tEm/VqW9EBIflFSjPuI?=
 =?us-ascii?Q?b/P+djXaJTIxnQ7FBvR4YqJIRgDaOjjpQtNPG+M2Ykp1q7UqQZh/BxJlcxA7?=
 =?us-ascii?Q?mg4EpfTIccvz42KTcl9sNt2yWiMfOheJXhCIxN5/VlZMMRwn2Y6KNcmH5UzX?=
 =?us-ascii?Q?FVYsw+kl1VocWifQ0c70+bRtSCMzB5jaDiWbQwVL5T3qKe4ZfjF6ErY/r+3v?=
 =?us-ascii?Q?mpSw0NTPSH1xjn+8qzyjZK14PLS1FTWh9Mj9Rb/pNB0lFFdVf7lepnPyGcr3?=
 =?us-ascii?Q?e4sKlzgxEs5/6xkfRG18DRDsjZqZvdQTU+7xGjTMzdTikTspfoXcNb6xX1Ry?=
 =?us-ascii?Q?EYjvvaKeEZix5YbGHuFFB6g3tplEIW7qp5Q1O9weqZxcvQvCOwylITzL/pzO?=
 =?us-ascii?Q?7UtkMLKTM7t583RvhCwCcbQM1gzlwambsXfvr7pY7nE3q/FN3Yz7nMomJpFC?=
 =?us-ascii?Q?EO0JFfLzTUJwm8nu2KhOKr/z4p2vh3qGKOteT+ad+h8ddheR2t0/SPF8zL4p?=
 =?us-ascii?Q?rCr5R23E8J8mOXsb3+LSt/fNFJDe/RI/EPxE+Srj1OvaAqSSzUEXDr+3EeMW?=
 =?us-ascii?Q?rnNJ3vPl0RQCam9mrj/4DAYrvYIGVKrl2S4ycyIBofd1qQA5MWM1POO2T/t/?=
 =?us-ascii?Q?OKWo5dTHNn55aM/8ZOJcukbCg0tDrtuMlpvn/j5lYKVGEfqIyrtBL9OCAxCA?=
 =?us-ascii?Q?dJLLcAAibS5SXkGV4mgZL2Oj/4M1QvXxV45ye3TTTpTGFxUa8f99mFpw9UWF?=
 =?us-ascii?Q?5Ym5+DW/1IDGF5WnSOmswat1TSgpDb7EjcYPBbn2uDec97qpBXhY8d28KtQV?=
 =?us-ascii?Q?JnOW5DUBZi5g5zlJ50akF+5ic0auqPV7cymAOWZfFhRQDxlYgSqgU1sIGUWf?=
 =?us-ascii?Q?L2APFyWMjLufYEUtoyIJmR1CZEXA5XCKGtn/pdXaREeMEXD6JYmdk89cB2BR?=
 =?us-ascii?Q?w8YZOJBvG3HchpG+wtMaoDnUJUBWDxFUOzjyp0LgAVoEgO9EBIMl+gnn02wa?=
 =?us-ascii?Q?gRt3O3eSu74SRGT5knwaV7MkdH0zNEOZyuRUouDUzAdPXnf7MZoTCSS4qQm+?=
 =?us-ascii?Q?Q+1ZcyYoNe+PzyO4AYkBFYdE0Ew+PSebb4Sx6ce6FdfkcRcU/llc7D1J9cri?=
 =?us-ascii?Q?mFc0Bs/+pfw6jJ5QpPmBxy9W6I0+6kV2zb740+pWsnLdkp0yP9epseZEyvGU?=
 =?us-ascii?Q?DX3iVy/8DA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe16b61-4f65-4e8d-d442-08dedd6b0fcc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:03.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow9g3TblpGZP+UjBnLGC4wR8aUSs2/g7WfmdcI0Ls0JZWxgUEENP6YWtomKvKk5xBmjVVIu460Et6ocrEcd/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/axp288_charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 24a8b1ee2fec..8f2090356017 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -946,8 +946,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 					NULL, axp288_charger_irq_thread_handler,
 					IRQF_ONESHOT, info->pdev->name, info);
 		if (ret)
-			return dev_err_probe(dev, ret, "failed to request interrupt=%d\n",
-					     info->irq[i]);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

