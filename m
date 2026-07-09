Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306513B775E;
	Thu,  9 Jul 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568177; cv=fail; b=Ly9wkNp+yn1hKCfL0+9UwuzpuDukTBi4emyCYry6V/bStfin78xr9EhG7QUUbBljFXxwfBqWmjLDlNujdlWL8/gEMvAoK+yrIz68x4j8yW3lckyK9JbgRQX6FHEdadrxUKbVc2iEXn7O2VhYbSfLBI5IE2SMxgkkgUK+uSjqLpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568177; c=relaxed/simple;
	bh=lTsbHVl+mxsZj9KDrILcYNdRtq+PVaHhnnZxuxtKWFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjODavzehQ5cXXwPSPdvgGlZu5S/gsQ/AFbRyZ9zQELjz2KlQjvPIdcAw2yXACyf91lKO8cS2xBhicf6oXKXyCflTf7xhB8rmNkhlqWgVxge4t5fvnlHXw3yYq1zUHGiM+bH6lJGgA1SZf60mi/v0PpNx/WH37Rr8StzD5GAekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K1JYJZZP; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K1JYJZZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0VZjB5e9ojIBDF5VtfmAjcVlPstYFRZkFCWgaSR2iH4vAAJnnDAyZ9VarIoLYvVBOUrkHsiTGQfVTKzLNIh9+a08BlBnpfcu4DtA3fEL/ZGZlbCt9xewcJ4VkU9k2kRud0tGM5LUUWQJ3LWzZaNHTfz3IG96ZOpJqzICtsQ8ctvRdbixvHO6mP/oeS79f0J1OSc5uZFw+mcBqTi7KECpvs8gja4hTwKYare/8V4uqn7Z0ErsDmihMzWoBBIPlWlU62Hhl8t7VkJn/HVpRvX6fk3eYBIc31COeYEwRAVkYsog/IqgB2sJDoDzQHrMulK8pUUkAsR64TRel0hrs+rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCjJEXLZCPlw6dTAtCpEihYynVjV/UIvdK+gIyoTDow=;
 b=N+y5AmB9txPp1z93yxG535yesv7J6kG0+M8cS4lsYUkPvvzFONritxUtuC9WGYVxtcVNHmz+1w0tZZo1x/qAa1/eu0o0YUw5QXhx7nOk7/7EsGm50JkkPG6Q364JjrqZL/dbtlUlUKHwuMJRNalieFj+knizjkCUdxN9cfDFkGtUFGp/1rlkTC1FPXfIkT5Y9rV2FP6as0r/8RYka7CX6VvrVQ9/FdZvZTKH6fYkJm3S4c8qhB9iwkModgXvRMkeJguCsSswm2NGhgIxmu+L6LY7hcA/r5D3osu3BbIG1pzSR979RWmu6FoDVhxQ48PN5jHqw/h47nIcZFC2tIH3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCjJEXLZCPlw6dTAtCpEihYynVjV/UIvdK+gIyoTDow=;
 b=K1JYJZZPj6Y2ELgoVGmYT2EwPCtN3/hKAh0aUk6DHYv0Jja8sgx9PcqTmZnfyL79gMgUkTvxcIQPyj/O4IGvPUcmUCZVWzMGW+HXJgq8Rxis5f+/MLosEC36Pb9PNHTWNWITra7zHMnmAyfsOO+TKUn3gkPXS/phEIP5i8KImn5lgDEhbTr5AGkvw0HN6zRPQWMKGceGXBMEaM0AEc1eZ72NuyAagglgRQWFGG5jOztwzN0AC9vu1tny71hilL44GtM5RT1qhl6oTKlfRq4VyhrjxX9xIQIT4Pyxq4+4x/bAXg5PK6Uvf4HCQHNl86qnn4LQOU3n0KeBxRJgiNh5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:08 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 41/43] power: supply: twl4030_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:20 +0800
Message-Id: <20260709033428.362970-42-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b00385-6253-405d-4566-08dedd6b29bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1O6ye0vr8Hx597MBEDiWY1XKML0VseT+XyAI3OwH/nhizzLAwjsHi5ih5rPJ/qDihm+UTO5CY9xPg/J5KzgwnTAEfLzq0bER9kEo2FQW+cR8nke2uNh9DNpQFPMyRZ9MaYM5RNwGB9xdr+g4ZRHNDlo8SeY9x3oNeoV0KouFwjn2azjZkCQf47yWEf6Rdi30QKk3dBgTMdIGPeu3c0yAtjRZiAnGG/59Fa+SrkJ551f/4fLIRlK+bFPJGsPm+y4J0ycRgKMGVPPN1jeBJhDzvVugXLABSiJ6tfRYvMBaMer1ja+2gfJT8g5SLPZCIIFhbaB2Wk1IAAeZ00oN/CJhtX6sC+Y7Z1Wl6l0XWcHmkDLO5mBvAz21y7N6qtI7vQjHid1DC9kOfF9FYcPGaVKqBu9Ez9by9L9YLmYOjK/Xi2E+Rfbh0q50UBUsloZdxTkbfpFf7Fb9PM6MLy1586TrOg2f3MVdrMsVkCKaZb0yhGrlReYN/OQElrwqUK96ENpwECHk0ZpMOTVxYVQA32czV6t7fbsAF+DmeK+3Gp0TumiPlUiAONrU9Gj+eTlSG2nk1ECgFuxOrBF2b9ItrYBhY3p5uBWyqeN0eaWqI2QG2iaBSsJkJOmTW3KLFgZSrJoFzMrNoCFb+KoPYtRSkFY1Kq9uSZy++M8nYZSm6eTBt0yUWKNVKxopLrSLcS9pU/Q06+1Bz6En6O9z+T6URub/29nNEbnyA0zJmVcF0UlYNvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ta/DaCSd8xXfXYbGgOkOhoEE+DWGVpeiSJauyPRYwI59hAz04Pf+TYVGPkcq?=
 =?us-ascii?Q?vvM5vOY68skC7XZCJl9gau7f1BMrbVXVtHE83qGgNkkSkea9bg4Xn90MCvuo?=
 =?us-ascii?Q?8skPAWT56S4Avc8WqTpHo+25RXksMDpJZLOG5HisszjVP5D2BaQAosgHRzGe?=
 =?us-ascii?Q?giZjkTgh5HhWv4NrObOxaw3Xi0PAwZrXeI+tbC9TFUAoaZZaoE2NeBOqFU2S?=
 =?us-ascii?Q?wMJDHBJrkk39CcKbZkVejRlw0SOVhjAZtysTQ9NbgTPS4mU9jboiFZKDhtvB?=
 =?us-ascii?Q?d+0MCBJXxHZW/ZpOLLbJZTMErZRiPd66I1TpDHs/kOW0bTAFHOFDvzgqNNK4?=
 =?us-ascii?Q?195cAY9nMGcdjYgCNti5ON234XyXl4rpW0DIf7zfq4W4jbIAOHpBTe1rShsE?=
 =?us-ascii?Q?9Qh/Fu0lMt+vyHTvBCy5R0engE5V7I/k/uT+t+HruxzoQ0LSS+AoEE/L7GF+?=
 =?us-ascii?Q?N69+K0hv92f54UPc7LlnGHm1q4o0ThOk0Ez5xXZbqsZDM6K6KdqE8B3nHa9G?=
 =?us-ascii?Q?kW/FVNpaD8b8KEaeSG8743jsDMkjN53hMq0iN4ZenMKwsrHoswveVkcvdjtY?=
 =?us-ascii?Q?O7tTamJAAj1+zZVdGz01Nyj7GE+mOvwjt5Wo/8prmDTYArjxTEv1vw8xaUv1?=
 =?us-ascii?Q?5D8Fo4ORZznL0Qd68CtYBH3gwYD4RpjzBgKH1f3LHz3DnhM7coprWrlNSQ6+?=
 =?us-ascii?Q?nkv5ndqOse5Te47Hjfp6V2UmAxGQomD/vZ+RYC8u4MNBsd8kN8G7udoqOQ7Q?=
 =?us-ascii?Q?r8eFzXeQ99WbVc7QioUBWLEJ5fhKwAwrHxUHnmlLgi5vSgMDXR83+YiFagkk?=
 =?us-ascii?Q?2zlV5VO0qRZCmosqKrN5KTvK/Ch5kGq0CM1Qw3sxvlwY0Ggs1ggXzQW0zTZY?=
 =?us-ascii?Q?AUg7RAaD1oRUjgsPzXcMe8f0/Zk+FvkUnaNuhCxseCAVrrFRyIRZzeWs8s0Y?=
 =?us-ascii?Q?gGfn8HR9RnWvSzQs8uox8jJM3lgHqY7eLwKJkf4BQrBCH7NUBNpYsvkMaAza?=
 =?us-ascii?Q?oc7NdMxpK7XGUIWybXT2PMtLui+J1ZmTViXL9jZfJWBadS/l2pbHkdM4Gdna?=
 =?us-ascii?Q?Lb5rOJXXXfeLDeeXqT/Y3w/G4JmRzEUcoMSYRPUvnO3M1iqnyMGdfNXsktRk?=
 =?us-ascii?Q?bQyoPR/odHq6YZ8UtxVIalGfmX8JOzAz+ulEC0tIATLK1OmzHaXI/DMNpUEL?=
 =?us-ascii?Q?vSAAyhXFvva9bcFMyG1w1fBG3H9f7DicQ8LP+RreR6UKonmnLCVrG6ylkwz2?=
 =?us-ascii?Q?SoIyR+tU6mSUeCxbHQ6BP2s0sHdUSB2fIOSuEBhRCiRoLD7UvZXN+vU4d6mB?=
 =?us-ascii?Q?bKjDrZTFodY++/zLvj6eq/iBTHNgpHGtKc/JsyB/oYbb85x+1FyT1ZUyJAJY?=
 =?us-ascii?Q?jpkIIe1fMvgS1+Vyh589JfaUUYVxI7+DyLgur4AsbqrwinDtpMr326ViFpRt?=
 =?us-ascii?Q?OY95yvQs8iilbnsvRC0aWYat/IfaNV/EdApOih0wQO9joqH+HDOc1x0d2N6M?=
 =?us-ascii?Q?SK4GGP6QghijsDAK29J/yVei3HOu+USI56pGslXofJC0coc/4CqjARw2FwIL?=
 =?us-ascii?Q?s0IXx53TsOH9OAWxsi7hwfeS0va6guEH8K3kbp2PoQ6q/FFE5tljMVsyicb6?=
 =?us-ascii?Q?L6Q82eQCLPz/2NP0yhByaSkLdh4hZ1usbLurXja1Yl4yYLpd3/ZnTlEF2pnz?=
 =?us-ascii?Q?q5TxnDvJbGLxMKzTv8FXruLp9CDn1uC1UOt/Tao63NFGkARjgv7wIVa95cV8?=
 =?us-ascii?Q?dDEBrDu4Rg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b00385-6253-405d-4566-08dedd6b29bb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:46.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8gTSJrWZTdWNylqWsAd0YLRGpfguEoQPKx0X8HmxJ4WFftycil2njgrpr1NUfuRiTrwruh2C6L46dAP2SkTDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/twl4030_charger.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 04216b2bfb6c..1cace8f73927 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1055,19 +1055,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
 			twl4030_charger_interrupt, IRQF_ONESHOT, pdev->name,
 			bci);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
-			bci->irq_chg, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_bci, NULL,
 			twl4030_bci_interrupt, IRQF_ONESHOT, pdev->name, bci);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
-			bci->irq_bci, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Enable interrupts now. */
 	reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
-- 
2.34.1

