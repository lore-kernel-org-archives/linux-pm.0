Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012063.outbound.protection.outlook.com [40.107.75.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C373451B3;
	Thu,  9 Jul 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564309; cv=fail; b=JoZqYuUkP92LSzbmMGrdJ4tyk5Q+Ry+kRaT6MWjSI9IBOisnzGF85mFia0/ZfAL5pJBU231uON8ZEPVeuXos/kqa+CMLtHRdZNGh8rmh+O7oCnpQAyee+eFkhFuoVp6qibnmR+iehoflAnZLMx4G2YCkUo2fT7FpUjxzeVzGlbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564309; c=relaxed/simple;
	bh=5ROYlLLEy7V15dNY/gnclfBGCPKPuHCnRaqloV3AbkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMmYGRC7k3KEZvcdM3ciwaP+KA4jzzEUkU3U7Z5QSjF3sFHSgZGI0+aOfYTVf6ukL1m9A8T1wvnbknAVSBBgZDunyZSmWVqEYN2UeGINojviZdLIhbD0FMhtL3+nqgubfxfgh6+i6V8B1ttV3VBHCBrkTW3wFwmj0QLOp7a1BmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XtUT2IGz; arc=fail smtp.client-ip=40.107.75.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XtUT2IGz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWoCu62/q4xNDFQxx9i8kJC39wGLov+32kYZdiSIo35Pfng/f1CIPrEtH5Tk0JSpvrJRMqfZxjU1C51tR9FTp9JlSKIMC0TXH+MWuhWIoH4ETZx7d3vjzyJhz1m4k31ezDh9uzfV5DLoEatJnlVO1uihzg3eHleaAB/6rgWxtyS/QdD1dbPGtiHRamT8TjfN62k8DjQVLfmtP4359ou4ucqcLNEDaET1XQ4wzAZYR8MxvjqZoFANsbf0hkGY+uF6P3RGO2JJuLutP/s8PfDxW2/OLUE8bgXs2XiXHgUnjrRNTZZDPHyiXKH1+2S5w56t4SyjJtZvNKd3EJu0PF7FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZM5LhvjJWOZb4cF+HzjgkVtmf8hSNFLKGa+QhM1AeU=;
 b=EnzNenqrsWqMNELasYe+6Aiod0co6IJfwAQuHVglSHcY6fYD8cYgWxjWIUvOHsMMmwKHkyQSZpN+mCtar35h78Oda/Py1C/aC9Aw6gBDj7Iqju6aoB2ybDPxTJJGRvqZfLyhBdz1nGsRxGTNYXA23142wDx8MtgGXGWhavCW5KP0a+ijtDFzJt+s1EJF+3CPG8Cqz30+fI3aHpgswI7j9blElRAqmw6Av8EXhFbi9E4Trz0G1jgfqPJJys0z8TuIVhwC+2cy7y0OEsD5oIrBP2BPsNROVmR/+gkL/VpO8gOtR23L5v8UaxAQKAHRQy9U+FAZ+LfW0X9/8kUYeRPIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZM5LhvjJWOZb4cF+HzjgkVtmf8hSNFLKGa+QhM1AeU=;
 b=XtUT2IGzuOoqGPM5/n44F1hVs4MK/cwGn4GXcVB29gsDQGIhkY0AMRtF5St8gQq4R3/V4FFF9dDs+BBVIUwo2NlvXgdP6ppjabPZtRpAxzPXoAWKW7je5r7qZlZR2YydQr0V+001D4tcTJZLn7JZELGazFcaVc5JDSq2ISe9BvzSyQw0Ij5fyRk5PlXFtQHzsF36JcsCp16YngD1XSHHuWLKU5bM6vOmYNdEzGJEVNr/AtsG2mezfsDKM/whHuTELKg7A+iQg5/3K4H5UxWdvukvQxR8h3z9akeqorPpC8THzUcYY3HGm1F37etxRWV+7CaTVwSPewmlINECWez38Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:31:36 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:31:36 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 01/18] thermal/drivers/airoha: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:04 +0800
Message-Id: <20260709023048.599150-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2e97a79-a609-4f26-0e4f-08dedd6232f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	GPux5jLlNmOuqdkXrKR+ie0RtRxZFaJ9y4aa+Y4YiTYlwtmbNNwd1zKRQRbahKPUf/RdaPuDbUVO5R2ClhpzgoIF70gkDZGndCFuUUMA24ISJugsSJ/PrYh1icj/vjv4WKPdeqg6hVQTVbeA09ixKuU+WUfnp6hlXpfrACmi3LtnBZm7WroLTGAfqXnxo61RbrrRwDXAmo5wmT/LJRScWC+lZ/hRkPbrtyMrniQNgRWjyvEp9lLddIP9axI/hpmhESzdP0YAQRCekhckcaV+b59NHOG0V93B1Md2KLgt9N6bUaYyofiS0im6TWIfdcFw6HrF352rOR4/35temkfBCo1h5SbqerowB8DHDJ+io4nU/vOdQ1E7i0WoYGbO7ftoKnKcpG0a78E8I+Ayi07XLEuLO1PePmeyAu/xmPdOTytPSem27dkxP4GyTIHWr+7hMS2PtlBbd5mqPLXBdEIoe7mbe2M+AmRrcO2DbD89VL3QsGoxBykq9NOB1YTcAMhx1g6Cfy41zpZBq1jhA7EkRl3E2tKOBXuVG0RJXOgGQtGXucUYlWDLY5MR8ckRKfiVEHUDE/6N05VVN+Z31NTAZudYGuD5m7WaqUx8jdM3Y0W+yuU2T96d9S2oAjEQ4c6wwYqG3IFWPE721fqzuxhDhfreg16FxdYwCZq9BZ2o6EQeCX2p21WmJGKxoeujlk5eH/DAYK2ZxMk66D9v00LaEQuBGTHtml2D1lYvTlWcp0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vc2dMT9KUhv8WDY5WhPASIvl+VrN4txk3aF/CwpGIA5eTvIOL0+46eObqOEC?=
 =?us-ascii?Q?xY/sTSoVpHSVzNAUHAL+F2OPpvC1KPeSo2xDc0V6LZGCkpF9AhI/Yj1Msgle?=
 =?us-ascii?Q?kK6iPBL39AcNDsF0cBgvr7+IYBPji3m5U6KhbshEJqWgru1MtX6LlaiU3XHl?=
 =?us-ascii?Q?58D+duVOKAQajySxTC8zZxFqsMYc8rpBvp/xE8Db06tAF4j9AvR35fLbKynX?=
 =?us-ascii?Q?qXGvymJqtEwJURZ0FivkiQg5NoXFQztGKHreL25iaY9OoQJtzg6/UUJaxvf5?=
 =?us-ascii?Q?0RgdMym5QqUmFSxUhGr+qnUyyVnZsPkAW6qlwbtUwqfZAZ5GQIUTxtLkQl8G?=
 =?us-ascii?Q?O7hbPKHrPdxTK4vctoHyEO6NHgqXWCq7eJc7nRVsJ55OjGtGLVpMW/X+59d0?=
 =?us-ascii?Q?/myBGy3ILWVuSgoC3ihlgummzndETYZWQGlJ97JCijtoGCNFd+6SV+uiQ31X?=
 =?us-ascii?Q?xE/HaONOsyefx4C2SsLAAStNPjLfqZ3Ey2f1sWarOXWkWAx9jhOm4AVe9gcH?=
 =?us-ascii?Q?4iixmI/2b8e5H3HC6MOkUhw5Be4mIc7uwg4t+/yjm5PzZVwcXIvd3/9sehcC?=
 =?us-ascii?Q?MjuwJAcJDKFqJkz1UcsTvWpmtMb3XjaS0w/V0IYoYueODOZkXyrBs7f73Hom?=
 =?us-ascii?Q?SlKrLpwUXYzR9GaxeGV8Btva2D5XC0+2EEPElxKSITC2pucIXJnLt1Xvf6C2?=
 =?us-ascii?Q?1htXrbhTchT+G7li2mZXD/j6Yq8XafSbyol22+OgIXUq4o2FSlLkBhRwlLnS?=
 =?us-ascii?Q?rANy9gfUCwixeKyVocM3FdvAciyPAcHPdBdlcLuP52rz8OSCR6XYQNMHyRE2?=
 =?us-ascii?Q?+QMOeoEPcys4m3+7HGNHVaXEln4Y4qztGH+A/XwS6zhQeCNvIEDkB5kc6ulN?=
 =?us-ascii?Q?Z8VsicjOBkmn4iH4gzRUfapAgaNcmY7lDPPC+wUmTAs5sqHCDVkQ7xPPsOQS?=
 =?us-ascii?Q?M+ccrrG/YkHGBi3xcqhjiWtdkh9i5uJKw8f9Pn8ll/inkNLtN6dddaqdtqVp?=
 =?us-ascii?Q?Bv8ZWKOePq6WD+Of7nMPZ12VKxitcWrzwa+fPPXlf7HeRdWRyo0nKu5zuprB?=
 =?us-ascii?Q?5zggcaZJgbMbVziKRsI+/AqBXaMju+VKw+shOhEk0t19m54cBQt/e/SLgU9v?=
 =?us-ascii?Q?zlsMRTKV9OA5izDo4OGZSZuuffTxr7pgQMTB9FfePoboHB5gYiQZYfdS3uh2?=
 =?us-ascii?Q?atP95VZ3zurifCXKLfDbPuiQ1c0FqfZucGSJnHj3cucv7wsU/E36slvEOyXi?=
 =?us-ascii?Q?uBcZicXQyqNT8bVTz9a02BNeX61sjq58k2dZ7WNnIKINY00Di/a96p46BoWA?=
 =?us-ascii?Q?JvtcZsNCaBJQFXnqNut7EEY+72Fj7SDZr1Z8Vs5TtjBc8u9sngJDP2sqYMUr?=
 =?us-ascii?Q?bMELWToHk8N86BBv2LXT+j4+QZN++H03sS7JHItU5cc5rUCiB/E+YPbF5tpH?=
 =?us-ascii?Q?QWj9ErPGFSuTJrWhjcZXrHGKY5DkYLjpTZSaiG+r+busSpReojow4/wMmBKG?=
 =?us-ascii?Q?1Jz2n9KIOVR49cQSMp8JNMSv4yEQPXYibwTz55qIopVgcyHby3QM1TKfRDil?=
 =?us-ascii?Q?ovDBert7J5T+cXCvCHnuOK2YqUnEGMQO8GeXvtPbg98TzJC1NbXClHlMHmhO?=
 =?us-ascii?Q?g1xfyUzs8ETwda6u4TeZlYGLFX0u88tF/8ygVHW+OJfctujH0NVvQc/sQaft?=
 =?us-ascii?Q?F5sNER+NIJHY6+ule0T6PaswaXoR7NswOX+7gnUJ+TMq55s5ii5LtjdToYSo?=
 =?us-ascii?Q?QXy7/K9fMA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e97a79-a609-4f26-0e4f-08dedd6232f2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:31:36.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXM5v+9c7hJa6KALd2C+kSmmy0oLaUzAUaSOusw/zE1BU0w0EY/VXrIDHPZ51Wc9KMIuJ0gKXoK6DolRuQNs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/airoha_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..b1c2bf28a90e 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -444,10 +444,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					airoha_thermal_irq, IRQF_ONESHOT,
 					pdev->name, priv);
-	if (ret) {
-		dev_err(dev, "Can't get interrupt working.\n");
+	if (ret)
 		return ret;
-	}
 
 	airoha_thermal_setup_monitor(priv);
 	airoha_thermal_setup_adc_val(dev, priv);
-- 
2.34.1

