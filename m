Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7639281D;
	Thu,  9 Jul 2026 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568170; cv=fail; b=Z2/KQ51Fmw3vy5cu91tpZHd8a42sqtmM4du/WBtItaEKJ1VRbwkrfin58zeDp1TpNtOXjVhYfQWk4KJay4h2SrhtrO8uQ7b7c6UD5WlWnDSsPToQ4wCR76voL+4bPJa116Vi4QUyncu+4vWPeYVX57Ef7yB3Yhm8Z5wIf66O2lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568170; c=relaxed/simple;
	bh=zUoebk8YYGCuBRHCzlZOKLkflt8PodQYy9jSTGwIBFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBcy7y81ULZ8JBvdlg028fxW54Wnne+b+UUaurOCq2XWws3AvNK7F9FTtKOTrX12V8ZNvmL/P4A7cwxhG+AZi2oDi1CJ/XWdfU/pOKphD3Y5vmLUDpx/1ufworZmZOZHGZkYkM1P89TCYik/rAY1HTuGzB/PJuEKOgR/HD72gPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oKqArD0i; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oKqArD0i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8bMpPklLznCnmNs194VxNfABX6bVSaw0NadVzgZFymC5G0iwFV1O2ybeNjcu96XQ8epOjTF3vTFNurv6V+OOZ6j0EhjjnxxVyyIKyas1+cy79rUay9ah8JcxalFcZ3N24jk4Q4qMyimE2bGgxZjtap3T6GGbJ5jo5uNNvGOnPwLTOGqjQ/PFs6UpayEe7gxwjMCpYZGkQqxQoEpLZslMBp6uhKf8fFuP5SEh4Ax66MxB3/URY+D740KEMtUMqdeTud0sgWvIb1CVzMnVpwETfkF0PCoFWNBZ9nZhPHW/H4Ns9NZ9GrhdvGc9xwNpiUmyNknWrNzCbH1vA4Y4V4+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCfa9KcH9WSsd7dJTqAJo8ihVvWLPza+QSw6nXx6ykk=;
 b=GKk/egXX2kO9DDgblkckVKRX+To/R4+ctn5JFJVg47PF6lYS3jHMGclRtCA3mrh6TSRyEbEEDUt1w7PP5X4awX8iFrmE3RfPYs1J7hBBUnkYvt1BhTG9MH+u/yS1VryizsBIXL+fbqc0nrEpJhqCJdYx8KkcM5y5MIha6+gYwKYOE+pYFzNuA8ILIDFLYqJVvgH8eTrdVyuyly2KFSA9esX4B1bV+2NdpoLXh4WF9tiUfOQtRz9UZq5OfsMJumqlOOMI5628+5LPFyRzXjlGxFb2upE9P4XvCdJ/CLADNydWvUeGFneCiHVclDsfMtsA5ccVSTLWL7mLpoe0gy3CKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCfa9KcH9WSsd7dJTqAJo8ihVvWLPza+QSw6nXx6ykk=;
 b=oKqArD0ijT20lyL0SlOkTyTjReHN9VWnIHgTV5rOnLKul1Qt2Avzdvm99tWVn4gIcebS+tN7uZ/YY2wJl9766zeTTdDDeHaF4etuOHz5L0jJICiwsEzaaGIi65MbJBM/adYHwniCbLS1B+gef4L7DRRrejznciYuQFZw/oIfGl5hxHCr7euER3ToD38WQz2hW8Ts/wkiPr/D044yjVmjLyn+DfOYprlpYrauLjNpfXQ/VwHJfP3akd+LIQQhRIzQUgB+yv3W/47D9RUEkd/tjV3kyVKYDyOfy6BFx1giS/y45aLMfb3zD/BofpFJua7j5z2G+icO0J40fFxHgHIjeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:02 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 33/43] power: supply: rt9455_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:12 +0800
Message-Id: <20260709033428.362970-34-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32736540-75de-4817-7837-08dedd6b22b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+HUHVRYbXpDogSUczSFyWCMtdzbp8FcpUjPsj/iGJRAzMDG5HPElPHrk2gZmDJ1mfKtp9tPWQ80Th3XLucBcYkU1jczmbUprNPUxLhCIDqsSTo6XhQ/BdTD9O4pzmtBTDAlfJMam6tGNq8sfEWPSCyGy54mT+qBj+wK9a1fUnmWQlpF+ttxwPA106jqqI533CU6IRIlUWN44M63C5DbLr6ZrKGdwYx14u70KWMmVbn4RnqZIyHCiP3AfKQNprrrRlwQiSdfC6JBJ+dVS7ChY5CkfkFOtFg1396tdwqdpu+vw482qEgI4sldGqwv4ZFWDDGqYNH4daX+mHaN7yPE/fORmocx8LVrtuC7xRM+5XBr2UJVGr6HMSgu97EZaUYjvegqNdPEDDO7584mRT9pskWpfGW2zxdXmUpnyp9YaMABJ+nfN2qOPo2SzVxvBjuSExcrZIlnA6L515kF+lVaiflo8HpUIrmmcNCuk3CAEJugu+BXeBaBEYWw8CBKxgT41s3UXv4U2rm/kE0La27gcgzhB/P4143uDXZyZE2cyR2yPAKEb/vI8snj3gEkLFkY+8nDokmCAfR+vBfHPsD/TKpejqr6LN3AWplDfaLtY5O6JCNQy34n2vzvg9vDPrXvMquBFl2M+GOhCafdHI/3LjcCp18io0NZiKJUS4qTiK/KdlEecfLK7tFj54NuBy0kNDc6IahynezY8VqjFhCqq2DtLmA5qZ4oYdmu5S4+8pmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4aNXwLQti+RiZH7IRLuD0TMlJeBwCZPBaq1glykRTctRC1nv6PZ5Mgm8Q9a?=
 =?us-ascii?Q?OdO+MRaqenHv1iBENJ0ab15GVVSvCbhwGkOufYhI3pCn4vTuBJHkUoKwQbg6?=
 =?us-ascii?Q?jsMRNy8lc6J3sVSJjJOwnL6bEdgPFn9PBIhiX3gCft0jbW0bSArjkZ3jr28+?=
 =?us-ascii?Q?LcajmSwyhUqgqJUfl+FbQ1kP0gP3pmydoIWDKUceUaeweZAQXaBwvukABpct?=
 =?us-ascii?Q?bt6kdpd96grbDSZWCGosJI1zMQxn4BnrEdg7Eql4umnbj1N8tVQcWB2JvfY5?=
 =?us-ascii?Q?qs9H1bE2C+bYtnLZrtZSVE1Fj4Elvme7n1GSR3v5EelA4CcxMnF77TbYlNbm?=
 =?us-ascii?Q?LAfyqL6dU2OjYX2lXIePUGwlEsN6maEDqwUjqsQWmQLBRWfbDnU4hGjXdToW?=
 =?us-ascii?Q?r+/ZqH5D2Gr7ZccBdAM2/KsBG/BLBlLpJlgCeqzy2klR5W9TsN9QTcACGc0a?=
 =?us-ascii?Q?0mB7yCB9WHq+7vy0zvFgPq4eLU1fXdiUNhX9/XG4X8IqLTZ14pJUe6LmAj5S?=
 =?us-ascii?Q?y2fIzJsVQ/Pfe/axbt/GRD8qHahpqSHiJpX1Vz4YXE41FVwNrMTyBM8SRc13?=
 =?us-ascii?Q?Wqzd8uLfgIMkPwBy48gPYvH2cZ90Z2XVY04y0dROHoBsyJyOXacSpyPveQn/?=
 =?us-ascii?Q?ulslL1YHQOH5Wnvg4KdStOR01lLqASJaurHmcfQ2+yGR1sJiij1UgJRW5kMw?=
 =?us-ascii?Q?jeg4ula+Yo2O9Ah7qe+e8BOjLbqp9t5/baHo1I8t3s5WQEDFthkc+TY+MfPC?=
 =?us-ascii?Q?lySWIKoeu5/8uNvYWwa/fbDj9sQjEBkbL05ec51m8BqKhoL7vCWuweICdMEG?=
 =?us-ascii?Q?hPE7Zcu3Jh9wzJkxE+hl0W+O8wOg65VzGiSaoe/uBX7wJpR8lGw1DK01NbAB?=
 =?us-ascii?Q?bvgStSCvVBMCW73xua2LFeJ9HXXfXbBnay6AWWvVD85PoJcPGmwK87m59gOI?=
 =?us-ascii?Q?XckBNeF6PdPZwHnv4neW6cieyUi+BMrW6Y1CvQHexg+yRVvn0tea6Y5M5neX?=
 =?us-ascii?Q?nSujVhFgL5FwLri5/EMi82jmYjd4QXKAsGaLku1d2ZKqAW2wKhbfA/mo6rLb?=
 =?us-ascii?Q?MDBCX3iZf46ntFouvK38ljmMMrdJw15CcQifGlTg+y9woeSWSy872Xo5AymF?=
 =?us-ascii?Q?ud8pduWt75UbEOBFvtYTyAWW52TLHqlxe7SMN3V8t6U7E/kLC9N3cXF9zGLF?=
 =?us-ascii?Q?MXq3mBoYZiAmBeISTNbh+RrHohGEDw2f/Cm9m7mEgOj3j5Y0zbjMfRn9nW8l?=
 =?us-ascii?Q?ojSlMtlEL5FQ8u4gd7X875dqCMFEtKAbxb3GHVt6WSJxLe1fOFPSGOUQYjba?=
 =?us-ascii?Q?vRU1UFg7J1wLr/HayoXYjd8zg7UmpeIXSWmyluvTEFMkt7AQiswlBmzYvY4N?=
 =?us-ascii?Q?umUsMTXO9ki1OLiSEqY9vIB90Num1NirOLwx+GN8ugzM+xDP8odCH7ZlHziu?=
 =?us-ascii?Q?zV2PtPdy7aqXF8ZzPIufZ9kJij/sJnCVe2GCUwOe3M4BOt1AToDb1f/7ko6d?=
 =?us-ascii?Q?h0H9pKBdJNvfdBO6EwRNW9ItpbGN/NQRCQjlGKPsnM9mx7aA4Ky/EPrUogKj?=
 =?us-ascii?Q?U56vhhkkz/OMxdVaeiTjNx2Loczc2gWBzfUoVksWALMfIsxiAIzW1a26k8UP?=
 =?us-ascii?Q?nTRtbKotf2XHyWybAjFMnkD4mOvNFNn9GYgpvmjcJkyn1YDqcUWPFwD1xjCe?=
 =?us-ascii?Q?yoQq7HnVgmDe5Y6RxDCgJ98UGOYqlkH2tyJ3+5W/D+d7rWVhyhUYcsNa3Ghl?=
 =?us-ascii?Q?Giqbt72ILA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32736540-75de-4817-7837-08dedd6b22b0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:34.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q47fXcv3jLJhYL74EGj/8g3QmW6X422/fjHpH3s73IgCCHFvdBegyy8wMJEmrdlCTMnuW6VkpauMxvZ512dPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/rt9455_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 7045d2908148..4f3a799db654 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1676,10 +1676,8 @@ static int rt9455_probe(struct i2c_client *client)
 					rt9455_irq_handler_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					RT9455_DRIVER_NAME, info);
-	if (ret) {
-		dev_err(dev, "Failed to register IRQ handler\n");
+	if (ret)
 		goto put_usb_notifier;
-	}
 
 	ret = rt9455_hw_init(info, ichrg, ieoc_percentage, mivr, iaicr);
 	if (ret) {
-- 
2.34.1

