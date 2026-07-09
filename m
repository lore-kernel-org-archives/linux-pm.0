Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C538C40C;
	Thu,  9 Jul 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568111; cv=fail; b=ZvyjnYdfEDdL1QgoDUqpsV60BGF1afHwM9p8nPtIp66uh+7rS+JcJ1rpX00UUlW70oqB6NPxs02L++eikK1DG/IUf0EiHDT6sj3+5iWYS6VGtINxFKrOSbi6jnc/cFZBoFntaSGngbhjOja3BUUNJrvpgPtEz/5ccL87Hd725T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568111; c=relaxed/simple;
	bh=DVOz/zJPypNrHQ18scu1h9MfyT/VSWj1YUv20BLqZGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQxkpY3fDq9sPBCMJRMZjfYd+nHAbfUPd2lgxktjKem/80vxK2GgLux2KYZaXnhQ42mXiXE54wF7j0KYA+LsPhoI4QGAKA9/0vX7lzZ9pAZ5vZMwBq9bvlJvO5vpYJND//sbdnXA6yNUVXK4dKaESiFaKxmW3jR//DcIl75oAWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oETJwD8O; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oETJwD8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JINtPVlELZbw7EdL6cZyfznCQ9ujdoers3FQ0MceaAd623AnJ8tj7VONRPWvWN0L4d0FrXNZXRw14H49g7C2j5W9DCAjeSiR/DpsLbbyYzgCCEUVtgO+ZcgmPPGFTJtgEeRANUbE4WvYTl2ILHvnrXYkIxmTkoTX7LyP9woXYCZfeF3GKFTxHH+tyigvbYGyVEC6lN3w8wOH9VwhSbFBjO2baXsEKiuu3npxrq0Bjohp4CtmRwg970rxSxjz8gFIvHwJZWwVGSEVIJ3PHNFDsWFTgqH8MaMQ8RpViOVjHfcNUByV1yTeOqHHOnHeWIGRZZN05wFsx8FsALrwAyop/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=432qlFbCaBT3K7PKW9cFRoKELWpxj0DfG2pYvkgszf4=;
 b=zEdC+OpYS6BiQwzapGwAvu5qGpG7IIE3Mh+vP0jQXhOIq4krGJ0L66oYBdngRaTGi57aftiefgbeCRI1UjD6z8OGH5jmAIpwcjLGcIJugZUHEl8a6jsLdxF80PwI2MpZNUC1UcQXC/PbbyaU7yegGPQNotP5I0Ru7BfqkTy7mbuWXKYJJTzT+jA+3seF+7lbcxPYmh0fudoKb+miiX9ANeVBRX0NQaWEaDgbl8uX4Z2T1zztESLrCNSW/rNv3obmaVF0t0te9uv+54vynKeDCux+8sra3+3R9Tg/CE6lznukhxIilgyrl2MX7uPCy6xh6wi92EVjKkwVwQNjl1in4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=432qlFbCaBT3K7PKW9cFRoKELWpxj0DfG2pYvkgszf4=;
 b=oETJwD8OYRARGoHep2HNWqkU+hij5sR9iUi7X1cLfb40igulafEVLxsc5xrJwe0QftEyr1ragg2wygg4O6+QaHU7gW1J3z57+PsaH0ei2RRva5ariZfLRxwak5VlofeY+wwNGG0pH8djRIS8v9/oQDJ/xMThsWosubt+j1yblKzpwJhdPqqDErurMmK5AAkzEif8YuNgBqr3e1OKLY/r3p329VKcLI31rZYw8a9YdKD9D6t2Ha8LQGEO7Jdzzg2rS+FcdQohruMucxniNJuu+KPk3jnmAfnZAYPBTyBRa5J54xyl29qjhGAgdTAxceo78G8jjmNK2XewZhzayrlnCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6360.apcprd06.prod.outlook.com (2603:1096:101:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:07 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 13/43] power: supply: bq24257_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:52 +0800
Message-Id: <20260709033428.362970-14-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 341cec25-ef49-4dbf-5cc2-08dedd6b1229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|11063799006|56012099006|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+E0+T2eHbZICImHmvYbllJFlRORoosjsApb9sb6ud7t0mkRo+lU4jAkqFH6k4NrLPmQkwbhPgFwctqTcJxdh1tzXvuRmsxKzui+LIBZJY/SRE7FqhtI14VNvELKeMmpQbywfW5iixlAoXnxCEqHg4/+umZFuLjkqSVVcCmUuuIvWWgEpXuLFqrPrVz6q9eT6Y4CP9oJ3Q8YC/5cvqSchbytn2Qgf1Hee0NTfZ0dfK7yCwSDNL9pOpuLAySy8ldW7hgX8rj12HXso9sv/wLDtBP2nBDG3ldEPX/zsbwi8Lwk13kM7LfDz0wDC+1uu6XcZTZEOq+SFSXU0H4k1xne95QySr01ieDBr0+K7vWNZvxPOM4DqLOB3QKl8KgsYETqSCwm7pH0VWC9O2x/NwOs8iRZC99sjVsEjc31ph7cMT+O/KuVmicCE5WNjFuS3ATbY2VJR5iPB3yfXDfywLD1Nht+PQW3p9EBXmq1rJv015U94ToL40ZTa98CuVLlLVWps3JQ/hivraSKa7sqaZQUQXoE4/glEnOyKUlX+5ft+5hw7GVdbd+o0OWgkyv+NIwsY0qz9LvhNVBXIYsDJlHHswcqbNWOZezRA3EaeMktREqV6Csc10c4POlGxfFZYo2IhvzbdhvNW/lh5IFgQ5UhvzMfnDXZZUQiwiBcRIDUHLIlJ97k4Ik4gf4aWCVbEcgUhtqAturXJd5HIAero4CYFCOWB0W26qF/oKuOH35lsHB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0WosFPR60LuJeC3jhdLpLd9SOnFZapii1GeliVXKKxAshGYQjPyedr5fmkF?=
 =?us-ascii?Q?rNxNaNvq78Asb9L7kjzWfzqjCrQSptzojI66j6WaaEIM1dM8uFMUQtGZFGKP?=
 =?us-ascii?Q?pRkO7/7fKLoDWGWOaI8Nlx/2MrgKLNBfgvR+PRMGlCCIC5lMt/9rjG/ZxyD9?=
 =?us-ascii?Q?p2S8V1BdeeB6RFXHePSTBNiRQBaU1TmcvGv61JVupsp7MUXgY4KeDMxo/VeM?=
 =?us-ascii?Q?J1A6ngLnf7M6/wpsLOBYNHqK8buPlI8hA9sjTKInLw0l9uP+vyTWbwYe4890?=
 =?us-ascii?Q?iokP38wze8KHcoJbElr1TgFH3IB+ZBN/YwTTcZmG6Y/Tg4W7lFAoNkzDPuf/?=
 =?us-ascii?Q?05I0x7Df8JHF/tU7oTF1Ht+n9Au5tzeQH5wpCro3555NA1s++VYjzkO1MLJ4?=
 =?us-ascii?Q?LivfGbncMu3q6yc55t80z92QbTJHJCM3VZB7Q550c+Da69QDmtJpn2S5I/25?=
 =?us-ascii?Q?/d17j9NEtF2njJTaHWMyO27ICzX528fAkqn/ej37pGuBrtP5IC8ZY9XLNIWw?=
 =?us-ascii?Q?KntDM56Xgyuwwvw1mGEqsFRfZfukLRwN5aI0T9IKsfeF1QjGip0xsS2j46a+?=
 =?us-ascii?Q?bFPxBPeJJ+IQOOKWD4snxmoVI4mHrv8tNc+bKJxy4dS8N5UjSdgcX+vHUuju?=
 =?us-ascii?Q?CSft3LR5rCJZAsGBmaXOgTnqoTPuEIDecqFAABvk02S3gepOSx4aS1XzTH4M?=
 =?us-ascii?Q?tdkAfeRGHeVy18aj7gVJ3hben4pkMlJIKwejFE3QzwC8/AeVCu1/aVKYvl7S?=
 =?us-ascii?Q?6XU+EdTCab00l3qidwDzv2pLejl5ZEvXIYWf4VXZ3Z6VqoMnmFNijgk28MFz?=
 =?us-ascii?Q?m3T4Kjv8oATsEOAZNsUMDPLlfmnV3g7vITu9MKFnBiZNH14P2Zv5BbPVDjgU?=
 =?us-ascii?Q?DQ9gsA1mDvGNwjp0EQXiRU3Smwa/qlKXCK8Av/HsKEl2A5pMTSF5havN1KNB?=
 =?us-ascii?Q?sCR1I0HmZdsRd3Kt11uJMFoWMlONtYnUOdhMbiZWguTyvszInHlp8fXW//Tj?=
 =?us-ascii?Q?7tjBR2x6WWuX/jdHjXdqKFGf/VKBVfuQGbk41iQUysTRMcyrohCUKv+T1iSd?=
 =?us-ascii?Q?l8VUQK7ls1trD3gnA8jMbkd8IgjDj7UjOlTFhObCXxp/iWlMhMhd9kZsVnIX?=
 =?us-ascii?Q?FlTCovPVwkG2K43HN0l9S5AUgjW1yT/KaHV80gYFL+CIzrdghM4PW0WegRj1?=
 =?us-ascii?Q?upK0SVGKyOwTX7OFDd1FAM1yMIgTgUcv7Y86YrC4fR75YTlKWHqYeIj4ZdVq?=
 =?us-ascii?Q?DjguOxYLy8BbX47sjV3g2/yClVUfeOSFXBscsEIq7T/cZrPxInmZF1vtniBp?=
 =?us-ascii?Q?Nczo5jnj1s+eunC3kSONNAm/lmX88bY1GxFULmAnPHuwkpcU4FyYgnsaowBe?=
 =?us-ascii?Q?AfIOH31UVQ4fb3G0OhjJ5sNocP58t4o5WKgJDD3sbSp/KKlQOkLed8RJ0ljC?=
 =?us-ascii?Q?mfJhm8tn90qxkVayjGAPDPyAU8PogLiu0H0PqavTUtTwioLslct1UfPb4iMY?=
 =?us-ascii?Q?odxEc3S0VXu/gRu2dLY2zcelV1unJVvkbATSNBwFDrGmAGboxQGyOS7ERu+v?=
 =?us-ascii?Q?jENmH5xvQbt0jSyMJwck7PRzuouN9v3bQAYJC5rq7REnDXuWvtFLja29hB/W?=
 =?us-ascii?Q?6u5y7OKFVNCW1tdigAudL6pAK/xeLQP0WGwA4QmdiRf8wmnEXjPRnGPNHHFJ?=
 =?us-ascii?Q?SSMKwXgaYPpCAHY8hx4aV1iiEWJGgyPeY31L+bE6Dkq5L/VMvWVVLjTczUVl?=
 =?us-ascii?Q?noulY4MmdA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341cec25-ef49-4dbf-5cc2-08dedd6b1229
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:07.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faeGVDYPtS86+N2EedBUjENEK5UmAzqB8Fv4FV0Q/NT9E5DquaPySBI2IuIwOJ1RXqyPYNl63WiX0EmOC4jWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/bq24257_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 72f1bfea8d54..d6286be4af74 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1052,10 +1052,8 @@ static int bq24257_probe(struct i2c_client *client)
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					bq->info->name, bq);
-	if (ret) {
-		dev_err(dev, "Failed to request IRQ #%d\n", client->irq);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.34.1

