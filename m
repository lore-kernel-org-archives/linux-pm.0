Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8773B19B2;
	Thu,  9 Jul 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568173; cv=fail; b=OSwnr2Q5gG9GqLXJ+uCrORrV5vQxNJ9PaKSbCqFUzT8aU15JtLpqwD4ZTgNdIxUMfe0tPj6YPloLssKHKI5KIHMDaMabaThVokx2dVS2hUnJL6lQBFY4IlOTxcUvZLEY21XUTao00c6spJqnohVN3WbaPfg/93Xv1Hszg8DcQLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568173; c=relaxed/simple;
	bh=yxTCoHDF0Wj4bUrXr7sm7NopnHxnmNjntfElWYYsp9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayPpc+ewMLNpLcBV72doERQQaTjInK64puUXtrt/NtX2HlQabi+zezr4QlomgIIHz65LHUG2YKNJEIDNbIXGm7K50Vql6AWgzEl3IoeIFHtTm1kWRLV9SqMgceRQ22YqG029SjjOlN7uxo0KVNhZvBMH2uBcjozToVUSWm88ihs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ji2v/rPu; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ji2v/rPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke5aPbbKpwz1bDCTMCK+JGWRQCinE6WIz9j5X9ErtiIDMWqZje3/Rd0fyRQTqx7bBUfDMIREsSNH60RRp6htIANyUVM70l0RhaoHsQZ5Wfx/Ri3NkZpmYn1CjvAgEyV60HvSQPyTIP/AUXLwqFaWRwL9eVciiax9u2BDBz881f1Y3HBKlaJW+/mBZBwNIQe/GBhMOIFpz5h/VdcGsPuUVTNKYzt8TNLqH1Clc7UAkEHCfIF0wC/3eBefXlGC51B3mC2J5LZPa6x980mqaKJ0ZExZTn6C4YxZ8sr9MPM927vVKyqIGk/mSqw53sAcPRn6qqdEi4WmbzXSMOnqSI3byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWxEgOMgjjXWfVhlDFXRsIFuODytYVAXNaYfSAUsMwA=;
 b=jzS3xv9+hntuaH4T/B/lTIX9+9EYDOuC4p92Jj2zDoFWfmBYvi26ZEWU8bOIx4iVXLnPvlSUUy+1siQSDkIjcMZ0uGaAzeFvi5/tuWl/yHdbny5xSxOgGRWB6+SRXIxqVprKzGyGpwpLCNMcwa9Nq08T58oqRFWnBQ2u7lwY6r7aUWd6i0rCyMb+8pmh4N+xI7QRY4g/g7udxCeqjw/rkS+eJZj46JVez8vaMRtkE6S7SCTwGeDwSCdA5PngPuekjz3NdXsN4bePlM6GOMZv+eGoFEQMFAfOd4nry41/9+yblNINg6gWiuajUszX8bE7oZ5VoZ+BkPnJ8pAO23gChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWxEgOMgjjXWfVhlDFXRsIFuODytYVAXNaYfSAUsMwA=;
 b=ji2v/rPuYFTQQOfaEtExDL75LvLBcNhcItmnXTglyBX2lLk8QSDiJ4iYdN6Ug2wQmX+mODesPOrUlp2znSzJ9lpLtJzFLsBGZzvEmY35xzwh5B+EvStfBVKC4Nx+EpSNm6kq3M1soYEG2s8ZVdADA7QIUt6CUtqjQyb+9s7DpI7+HZz7TzY8iPsviM0hlSdXE7WOLFbzs+2wiRs3FOD7jmouPDbuVjZVcXSf1wD47BGeAR4k7XU4tHjO+F/PFUP0RPyEk10UjcVFUknM8hnDULDzr4lESBgcpRNpnve5rUT4xrd2U8c8ANt7GyV3KKpLjprlrcrWkrNpaK8ZKf2Ttg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:36:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:36:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 36/43] power: supply: sbs-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:15 +0800
Message-Id: <20260709033428.362970-37-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 310c42bc-9afb-42de-fb5c-08dedd6b2555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M7RJtLRS4A89TJIezIbYkoc+ic1GU+b5WBOHzpveTbo8mXYHVXFlB4kTbAK45OMyUcc+4dAjtaM1hRDVgurtKL8AbBaB6gU0HH7W6udv3KlyqtJYlCPMXvYlgMnlv3eLqZkBLTiEGqI/kOV9EU0nxS/rpVYMLFxrCazm7Nkxt+OT99TK5nu+0Er0it1t57PRKfY26hCMc2y2BcsjJA0SuywUH9UjHVjvsJtC9fDAYxeidcdPfwgKH1y8Gc+MjMAxA40rpS9ifg3T+sfYti4SjrgKr39xLTU5SUVsnS3TDFtJInn3fdCn5qRV5zuJPRS+LqkrCOWZM3Fmbh1mDyrCNaexR9TrissWNHltfPBOblT0VJ8VFVJUGtp3QEO+1CVyoXJcUKyshe/2ezY8bAThwvKSDZ6Yt/RnOe+n6i30JsQx0cev6YLd2/yqYLeB9+6EXmVvXpSr6m3aQentHYSNxZxdIkk8UaXV+wnLPuG0GxliFSFOLNTlHVenTZaSzBjvS36ZiB9+Ig70LcmUzn/1S218l5OGWgZAv1yO91fLVPzKT1LFdg614q3hz5BMjLC3H9J4/2+L1u1F58bW8bkyrgJ80lCVQaMTrXtUbfYTknGs1mOaRQQKpcXl5xEpihH13XWo5VlXnOO6+w5EJhfodZXJlck1YZh/JW3mXdImkDs+kUzXOV8WbmuJCMwJbS8c1FSDf9hNTR2N9PnoztaaZcrFRDPPqgGlXDWFlp39ejI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUdh06fTaA+XlBoBb/l+eYiG65e3epSDam9jOCXBViNFkMMgTpOReW6597ri?=
 =?us-ascii?Q?Mag9/6gOOdIohfNtYQahbD/z28vaVzKkhS8Jfm3QfI3jt19tTum89Z+eTid7?=
 =?us-ascii?Q?/mHnxJPoXRSXt32tW/EWzvemGlwj3fD4uzGJh+GybwuapxGZq1yt+SV69tZu?=
 =?us-ascii?Q?oEAQUvK93DXeQdcjBUjVc23BjRQlGK2ALzUWtllhhGPSMZt9ybIjkfHxDJmp?=
 =?us-ascii?Q?omXSb2L/MBdaHVX7KbDXAKkA3hfURBSgE30MLom0CjNc4PWfzCHJ+MZSCx+h?=
 =?us-ascii?Q?r0+Ta600JOShraVOkj6j6oc+RJZYAiv/uXX0oRJ9rXYly09gRJDFuCWuQ4Iy?=
 =?us-ascii?Q?0ujh1l8VkqEx9SVy/rHpOVRmzClQxw3pw0hxGPEVMoPSQv+hX46BFhtp0LsK?=
 =?us-ascii?Q?CPe21XDDyFd1zk3Typ5CmlZcLBy5B8V5tTQYTApppz83vtbT8RTyVSratlQG?=
 =?us-ascii?Q?FeCDaU+4SY2ufQiWLiSt8EDHFwgeGbEqPBVVzGEZ6kzhHZ0pP9Y7FLSzcOHN?=
 =?us-ascii?Q?wEXnTyXmmOrJ03iLyULExy4+LKkXV4EYFv7MfSP7D6U7hJ34GBdKGlamnXkm?=
 =?us-ascii?Q?dnoixNhIf15kAL4sk2A8hsaktA9w3EQlVUyskt7utYvjGh+iiXgMIF0B8iAw?=
 =?us-ascii?Q?6x2/0mAkckDgCklHQbm5/+e4uBBgFGtWFs6igtsPmRwXVYGUMaRvYFK20Jf6?=
 =?us-ascii?Q?zwSguQbcm3+1G9dJHIRBUQ05l77Ha5ZSKrufQyTrLvqXWeJNJ2TM8Pzxtpkt?=
 =?us-ascii?Q?iGXqYh8oXnLFBTneUewnbwNm4BKK+i5HXcGVFHdd0NiwKPXlNUxLpW4JTqoz?=
 =?us-ascii?Q?2QCh+1liAd7FShPXzUGlqYkynpYhDsvCwmoA6Lc5swjER2ffbV8z2A3C3gve?=
 =?us-ascii?Q?9IUb792X1EkHk9H8px0Yg7RKR/ZictN6Fg47eeXZYDrwFJuKNzFZlkkEhLW8?=
 =?us-ascii?Q?0wLN4Wyd+V/ugUJLnR04ai6l+9YvIUEyH7KDiBZ870MTLMe6As0g+nw/5Rza?=
 =?us-ascii?Q?JS7u7KBIaBtAyq2fRhr47eDIcLnikLRTuXZBCqJWIbc2hmSPns8z8yO//YCh?=
 =?us-ascii?Q?769OA1Ygynbokt+Ulgdjq6eh3jGtkx/0plu19qHz+lR+7PqtRiG6imH1V4ee?=
 =?us-ascii?Q?ucgvRwlmJMcqJgeroq6v0chVMT77d/iSOFW3kDTX9kpRDSZhj+Xw5Vm/vVkB?=
 =?us-ascii?Q?SRAboX4jLx4f65BCtiObQwYh9OVxcwawnL4pqYu5vTVOntN22HH6GurlJoL/?=
 =?us-ascii?Q?kc+MxsesXrNFWDxSpwcOCzQm3sKql8azTmFoFEHdGJ7/oPFyeXD4M8PBvpuW?=
 =?us-ascii?Q?TgrQJO7jgX2JR5Zl6g7Up5Grqtmo36IMnjGgn3rmm5GWJzxDul+JuqbLhpAQ?=
 =?us-ascii?Q?uWtsZ+6F0zBcWeIfINxMNHoCouY+354PKWmrKRUKdSBenNAF4gH/QnDH16Se?=
 =?us-ascii?Q?1FKKgqEJMWLyMK2InbzotjxBlzGdqroANyOexeMc0ayxWascodVGXoi2jO2P?=
 =?us-ascii?Q?o/UoXB0JragBhFgJ4pOnsqvodseLCU+VHzPHSk9ry/fTMtsdJdaDCr0k4W6w?=
 =?us-ascii?Q?C8uJWs648K8r92paYKBZ0Uig3bItzfhoMDnU8/WXKjv4ZLDbP8I1YON5f4zl?=
 =?us-ascii?Q?M05rSZjhTLVxzr7k2+X9Q1JN0t7DYMkyGt/XYuRzUjG7tWHW7Nv314oquNbo?=
 =?us-ascii?Q?Yn4HLyWdpuoeHtw+TNZo/fH2Jx+BZDn+SxOhhvA8wNneac6TWjv2krhipSWv?=
 =?us-ascii?Q?YbfWH0N3gA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c42bc-9afb-42de-fb5c-08dedd6b2555
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:39.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sACs9pTojNTJpaHsx0WB0YKcBXLAOHhGlJlvCTmSgZxTkTk71aBZ5wNI2LhY8qG7xH7jBoquhQ+TbNc7t6YA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/sbs-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index a00c710601e8..e7b4e10dcfd5 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -217,7 +217,7 @@ static int sbs_probe(struct i2c_client *client)
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					dev_name(&client->dev), chip);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "Failed to request irq\n");
+			return ret;
 	} else {
 		ret = devm_delayed_work_autocancel(&client->dev, &chip->work,
 						   sbs_delayed_work);
-- 
2.34.1

