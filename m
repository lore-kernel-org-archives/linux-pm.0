Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195343431E3;
	Fri, 10 Apr 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813286; cv=fail; b=eFJN7BKDNd7JXC/ORXXTeTzR2tU6hACrHlD/FnwNHGbfAgwCK68Rb1Z4eTfsD6QGONh6p8vufjrAvj6cxnWSvUI+rnwvyurnpQ/fu0RtEXL3S8YWDdktewzBJI7TzBOf2aiw+YDxRatymCHJieLQSt7SnIFH3vi6ptfqkqHumig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813286; c=relaxed/simple;
	bh=BJgMP0+qS1lrjlxVQO+CWBRIXo4Qi8dPuO7M5SGPXEU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pJZ5jJj+La4oqlDpSmKEomsmwvPSSPsJSxYqrv4HV3WUgMOl11QATn79DffD3OlC+m2+Ehxdg1lZSQElYJQ9DsRhJDl8G7AdFfPUm4iCC1fK9KUCFa/Dglz7XSwJp57ufQdwc4yllNSDMpfSL4GdtfOvFcOdBT3M5GNqmRVejk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QV0sG3g4; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QV0sG3g4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP8FKjlVBP04Yyh/WzLrLoYRLeR+ntnPl+qVwJAto2bWAT5buioPaHM19wJwlayoUhB7eiQk8pyKDbVTdyLIW2mQS7PS9bbALsF0vZyCvs1JZqzBKzeQhcyNsQ95HiLDIml4g5cazl9oERDARVO6sB9GPcaaAw1LGyn+sqM+uKKCdo3Oiz5LY64YBPLtrwqh4Bz5s6XqihtL3r+lvB6CDm0IWtT/l/Bk7okHSZd8AO0AkU2syFUzQJUT3jYPys4W/sLhTY+HokTO1x5b5V38JKY2i+nZtSS1is53hHl6i4TlAn+1G7ua6hHl2oC6Conjdb4R/v8chMSfb9H/DU2zNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhi7es4B2xMqkBuOYksa7iiVydcM7PWs6DNo7qyJQq8=;
 b=E51lcZ5TyB0/B9bKfZ6WGxkYH2GQUdw+kMf5Y+IyF4IGfjhDdGf5QE2IBnfLSZggY84+dqroaSz8pluAXl1CgYGjh1ujnCNjAA3EbSWzH4+eb7xZcgiqsgXdU9UmDmUV38mIxmQzVu4+qN3jUHpE8p/Zms2iWCazMJzXT2gHFZDPMYTnbT3UYaEaPnJw/HntQ3yggLZgBUDVacR1nolgWs1s9oR1K0ADhOkj4fVEU2oM2XSjkBOYMLMkyswZDy2peIsssW7O+KlRT3k8h1cr9hrGC6y5IaBRHomIp8x/tdX++jSbvac+oH4sJ7gQgZ7x3wOUBtvv+cojIJp7Lvz9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhi7es4B2xMqkBuOYksa7iiVydcM7PWs6DNo7qyJQq8=;
 b=QV0sG3g4lzhK08JBkLkZ0ZzqVKjLMO7mFx1IKjRJzHKpdtZyZTMOzmX/841es69IgJutJlnkHZHe/kypKdBselNlndcW5Ecf7B4eJCrgX/S3rekf1bHOOMS5hVw1i7tYHM1Y0g7K+WSkDQtSuQ6IaugzgjLOR3dqKgCJcve81BAQrUPua2ZzXVF9ZTwNXcHXFmtj4mt/+gPAy/fSvkN3dlGJVsbz1SWdc3NkFMMKCRSPXFfz62kNCNibLuT1dLnJRwVooJTtSRTaTEHR5l8SfgQzJ5Tr9LcpMBqOY9JwGdwnHo0vp73pI14JGfaMlPglwzWtMPach+vYqWOs45+7Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16)
 by GV4PR04MB11894.eurprd04.prod.outlook.com (2603:10a6:150:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 09:27:58 +0000
Received: from AS8PR04MB8420.eurprd04.prod.outlook.com
 ([fe80::3f0f:857:96a5:17f]) by AS8PR04MB8420.eurprd04.prod.outlook.com
 ([fe80::3f0f:857:96a5:17f%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 09:27:58 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xuegang.liu@nxp.com,
	jindong.yue@nxp.com
Subject: [PATCH] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Date: Fri, 10 Apr 2026 18:27:35 +0900
Message-Id: <20260410092735.1065294-1-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::7) To AS8PR04MB8420.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fd::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8420:EE_|GV4PR04MB11894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5b6433-62a9-45e8-3446-08de96e373cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L7galnlKv+43TQLK/LTAzixqPm97MEsQYAj2tVDGocS0xHSOoVFPfJb+UP04jaBiptaKL5a0R/VK8xNCeorjHUl7IxqokVRszcHb1nGRgyIf4jyb05/7BBpspvnfeJoaKoGbG+uaqcFu14RpbPomiPtfmx7wT2a0r3HYyY3TFlsHGGs0sfw4Ltu1MIGsyovGeDK6+64yH4d3m5ZdVHSQEZuGByVKTfEbB+kGQgunnQpHsPUUqCgB5QQoUTSVIuCOAiVquHuKNnVmhRtZeDUTrxt6ocAj9/WDbs3YOWRmajTz1Cgce37KA8Psc9cr5uKunmfh8jiByYhVDca01r35DDbQse/aoV2GW6VzJh8AJu77hQSvKIPE8nNmAvOk49tU3fNsuIbrxYZZvvcIHy4lD5DxWcVhVOdAWIME8CvEa9Qm0Y5C9mdLXUpSJ91dJqF7DCY5Elw6b5THT4m72m2C7Sw3kmbzjZIL8yzTSt/4hLPjPg+Iyiys/qWXZW185MZSKjhRfIPS2nXx02cSwXDv0vawuXw+18VMindpVXqD0uJTay9KiB4UYfuHEd8G8a6Yvdr3INBmutjHi9djYGpoLLnzxBIHisuUII9ucUoKFi2AofJkXQGvZwdguvnDaZ0XlqsrT4Byd8ADQ0KYmqQW6sfR2W5BtAs5GvR1EWZ6wBJYNvtaSUe2bjxWUXJB+naC3rw9AZkpBNFCnX7yDOS+2bQ+UFzDGjP6HIC+lZr9z1RCALwZkrpujYsms46FNwn6u1LNFgRh5rOybwMzALlRdyRXtaDCcC6gNJCOeMdNsuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8420.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRVu0QHLpwS0dJ++58WxcZ/LGCHblaur69Y4VWR9/AOuG7GV/WU1MpJwIBKr?=
 =?us-ascii?Q?9znylX9DulDKGbBavhqWoucOrfNJNQyZ6Z+JpvlNslm01aBSOKAVa6VDpHlg?=
 =?us-ascii?Q?5nn7DfFzL+zqKRFJydJBHbpJ1rJSoT3hrTyYNyr+oyOWxF4gBtxHKxLVkUWK?=
 =?us-ascii?Q?W+PRLZqyGuqPtVm5RBUPmnDCrg39R+rSG1wjUVaCbruO9Kbq7rwL30YQKIMC?=
 =?us-ascii?Q?VHkkQsNgGEy1NIH7qHdyIieew4K+Pj2ahKzw/hbWH5zh+pFJ6GBiyp1+dGFD?=
 =?us-ascii?Q?9KCKbyLngScjlFx+HouN2vKmqdfbkIMasUq7wVWasiT3lwS5bZRSoIMPNw6Q?=
 =?us-ascii?Q?uuYVdLHfd24s9bnzjJttCQT7rKrLgJSWld48UoOtIJe8erYNjsFz5YqKXbp5?=
 =?us-ascii?Q?gX9RZjZmQIljlbE9MPEGMKuECQwmgmKWZv/MfOCQzC6tDNVv09cHc6NY5yXB?=
 =?us-ascii?Q?w0S+rLtXcFtQpGCXCP+GcF8G0l6uYcRLwCXMMf2MezbEK7eWX0e8y2g2R7Cr?=
 =?us-ascii?Q?8+nPvL6gsX2XlRDU08SSoXwMTlRvwZa5e7LHgS80QdLnS05erd5jnjZmVce+?=
 =?us-ascii?Q?VqOMpdAhY13mnrGj3nD3bPT4l901z8ZL+kKTNecQJVdq+tRBwRf6GdVhqL3m?=
 =?us-ascii?Q?tezWAVhiYXG12mR5bOWYUh2bklRaA6/SsuMtTEJjjvdOpKmAQ/eUzLfoUKJ6?=
 =?us-ascii?Q?mbI7m2q5+57h98if/1xSsj084i8627uF5GbegQaDOnU1+zV4mmryQ2cu0tvg?=
 =?us-ascii?Q?th4mB/Ed/x0055ylsc80ztqKIQDIYxgdsaKAkvawj3WUVGJ6o8Srjwv54pf8?=
 =?us-ascii?Q?KpR0+2wBeE9hbJib5BVTZ8gG23pkQrT1OSwLisz5aFM0rJdMspwmgJ93kT5Z?=
 =?us-ascii?Q?CJBAHiq/pHwSNDW1Vh5/MrbuIdTllHcz+k2wGtq4sf3lYpYpr5P7DHfMrHTa?=
 =?us-ascii?Q?EbpGEGLnwzNybaJSHrqhFmfZNNIcGsN0OsPubShZ9c1fk34nM/wemfXjZvmk?=
 =?us-ascii?Q?4leeEaq9SqT5WlATw8kVcn4pcQbNtJHdoCMaFQiwyZuPLpRa7HTyuEZ/UPct?=
 =?us-ascii?Q?TaUYqWYOVYrA6nS3muNo9gRtyQFs6DCCHzGbPdJw2zmN29r3WIY8ixx7m/l5?=
 =?us-ascii?Q?lYdZeDBVjZL1Hp45AOOXzoy67+miqqQ2XZvv+y2wLiAmOfy/+pxA1D5mGk+A?=
 =?us-ascii?Q?bqmEq6E5uPTZj2qeSWxz4V1HKBMiZiJnjq68uXP80FcOudz9wXzL0BpNlN4E?=
 =?us-ascii?Q?9b+1gGQzKuqEimWFjN9J1GOPLXrsLu40H8whiFxCJN9ru5ScnAtMD+fDWWRt?=
 =?us-ascii?Q?7EYGvbbE1XEsNu5+3YXOqlPIAVaDKziBSTDIo9qCarCUO1cyCJsUXXBT4IjK?=
 =?us-ascii?Q?rx1026pe06p+EuRDs1dJ8esGLnBjlE0Y/bcF8q60PsZJ2KyUE7eBYdIWRoeV?=
 =?us-ascii?Q?kW9bMHAdTd0AuwduKSsuasFgeMghf6G/rsMOXdPgwgJmbWHX4duDx4G6FzEE?=
 =?us-ascii?Q?ZEonx7Qm//xD8i1aOuX94DJWa7ewq/BcKtQj4xItW3z/dTO+R+/kGB5pNL+9?=
 =?us-ascii?Q?ZAyAZJGuaBbHHnI4HqYGsV+uB7QwOiMG1M3CRG4001hqPUcFYKpCWXqPgNgt?=
 =?us-ascii?Q?Omm2qCd2akQbN738xs2mNApYvwRKohpzfI6vtOrQlwlj5ARs/UfhEw5BbxHU?=
 =?us-ascii?Q?vEMK1roHHhEie6xwjq6pfLwMZ9clFzGP7xYkysGhTKatlu+mztekuGBX5Rpo?=
 =?us-ascii?Q?MjMsHzMm5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5b6433-62a9-45e8-3446-08de96e373cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8420.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:27:58.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aUDksfDPc83/vHvlpC37YCjHupJxrP0i3bFbCoxV5uKVujhD7IM8jIREOFoUeF5RyQzBtjZnRh82Gqnorm/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11894

Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
to allow building as loadable modules.

Add prompt strings to make these options visible and configurable
in menuconfig, keeping them enabled by default on appropriate platforms.

Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL
since i.MX93 doesn't use GPCv2 power domains.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/pmdomain/imx/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
index 00203615c65e..9168d183b0c5 100644
--- a/drivers/pmdomain/imx/Kconfig
+++ b/drivers/pmdomain/imx/Kconfig
@@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
 	default y if SOC_IMX7D
 
 config IMX8M_BLK_CTRL
-	bool
-	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
+	tristate "i.MX8M BLK CTRL driver"
+	depends on SOC_IMX8M
+	depends on IMX_GPCV2_PM_DOMAINS
 	depends on PM_GENERIC_DOMAINS
 	depends on COMMON_CLK
+	default y
 
 config IMX9_BLK_CTRL
-	bool
-	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
+	tristate "i.MX93 BLK CTRL driver"
+	depends on SOC_IMX9
 	depends on PM_GENERIC_DOMAINS
+	default y
 
 config IMX_SCU_PD
 	bool "IMX SCU Power Domain driver"
-- 
2.34.1

