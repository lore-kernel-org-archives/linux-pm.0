Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8A36A37C;
	Thu,  9 Jul 2026 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564359; cv=fail; b=kL8fzbiwTHVjTHY09+9ggy1DiVn2l6EIUIsrT5KDgs4z1ZNay1ImBVoHAQPiPe2SeZ9YSFyRZLh5iKRtqoC02DzQUpwx6kO0oNAycR6K1GxI4J8+qpENodYjboWKcuJj755xUMHbhFnuxb+M719OlMs9ug/UaQveHZaxOH4q9Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564359; c=relaxed/simple;
	bh=MtnXKKMZH4W039bp5/kYgMR8X/JPXgulBgGYf1QDKoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdRAbmbw8Jvy3SAkn0jLSOkDaOYRsl/36/daGEKIVCQy30PTOGoxjaj73bFkzhG9X6rpyJnn/7CC1qoKJoWVBdN8BPDm78AajumnmwKEfaiFOa9+xY6s6UmUarJTmnB3Au0h7+07wB7okstKqnZjNlqZdhlFeZjksWApb8Q4acE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kHfaAOYg; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kHfaAOYg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra0ByrTPfR7UVjTQEDNZ/kc3QWFnp9M5bMtGRRCDZhDoQL66/wuId6xVqvsEfrjJgl3Cf7xN71ose6kxQTkBgM3/Y2WnOkGgr38gRmB+hVxR1g+ZezSU5oHsSKA3rjT9HwUDVrMYbYgkTHtnGCzeYvryLGXlDRuS9FCeOT5xgbwUWFBZOHTMzwY+5juMbcR/+aErLjUxlQ6m3N2qgvmjixOY45jRerNFAQi/a+kSoOAD2iJ1cmYV966sA8oslDKT4bbtP76YsD+p4xHKAxrfXnIMwwL32Hwt7r4IjQAejE8kgpFImO6KG1cWfjSEpdSzEnreH/HW6HkiUx68oNMxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9kbP25YUHSMgxPX68EIBIpaD329KhcBa9nH5yu5OWU=;
 b=qVYaCs2KCjMI/zhnB50r8Tt/apN4wQL2R1V3tB7KI7UbJOsaRTysd3eaKyALPdxiKlPEC0FtGYds/X7orxh1ta5i4AyyjmGFMSchCDj3xgwbiC/EZgmTGW7g7h3wqItElydrPOhX8fBdjL5V1IrT6QtOeeexsCfjkVU/BDxjz4KQQnhngM/K/XkIyfs/xG/wqnesgqgEgouWuoRiskmpZq7j2PCPYo7Vy7Y3ehlZkT2+/Iux/4cUDRrW+3A39RhigFjRkHBWTkm1M8KKOg9gceaaDoYG9s2Q/rYkUZa1nh+cXAcJTWv10wLwGiDUTjMWPiIhNjBud5TEemMJ07TlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9kbP25YUHSMgxPX68EIBIpaD329KhcBa9nH5yu5OWU=;
 b=kHfaAOYghE1IBKQCLPZZD6w9uvo4jZnZIwms2tD48rGIubUSc9zG/dEDy2iQl8QfoSluGqTDWl0guWHeGv2OhTqWmYUnsaTaHpjy/VQqNXUVpJIOfIvRiifAqMYlDRO+6LgkbRldeEcTW6RnWxTGZ4Nz8j+aQRZ8dUGqsTnS/EQvMAADvEB4hDD5CcLoYHEKHv2cghjZx8QQuLABlRzlY1DtvQRnmg2MAyPlr/McyEodZhtkOi1W9U8kuJbcGl95nrXHpd7n1VHy76ebApIoc1dT0tHb9CDrbnN3LSSJ3v7Rj9cilQq7uxDhfJzV+fUl05BWhKZ650b4+ONNcfMhSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:32:35 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:32:34 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 18/18] thermal/drivers/imx91: Remove redundant dev_err_probe()
Date: Thu,  9 Jul 2026 10:30:21 +0800
Message-Id: <20260709023048.599150-19-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 528e28b8-80e5-45c4-3eaf-08dedd6255a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Xn2UHLfnaXe9Dl+8hp0SP0g0d9p+zz0VF3+D31tBflhnnYbwrY2UDRrpJlpEXVjKBYdy6QC7/ZeShwyrCQnce/Of+7IKtnYAlVoCvq5Q9wQPvEv6mPxwpp5P6EtLwcZV0LDvJLN7eilNX1YsaGqDjt7a6YeHD42yRoRHiS4j6AphjceRda2rQHCM2pMwtQRnqqtWITh4KjHDEp58Mv/sI8kGvO4ShDCYE+qF1ZTPT6s3RAOLLvPr7qfnAZ/riNyWz9EfZv6IyRiNNgKzna04jtCcPsLz2aAUWZ3REUK76iDew8Hyol4bBPm3ipAxGNY3p0rWI1LPRln6O5R1z1IeZrIL0ON8E4wwh9E+2HX3HS9oOTLNPGRLoT6zxltzC601MV6q9C/EaEoi4Q+bhKEISaWbrOi7ifoDRvyQ6Z6Qaxix4dW+O8SJJ6qseh9vHXtV2IDDyW1VFo5NMJ9nhwJdVao5Ud/ac5ytsny6RVsXiO0a7zaUsoTDiqnKPYsuB6rX/yP/sO+bzjpc+EozlJJr5xAW3d2FBoaHZUJj1U3aq6i0cT2/M+wnEzrTY3OR/WNrZuNw27AeBX/JOvUG28Cbly6v3PN4bHjeJC2Gu2fb/p6MAcxvZmKIsLHRG+5BQ6lXixMfQLZTHvcBZ/O+Yz5AuEnqJlkJvC+56kATAmmv33GfydCKCKyJgkl6AjqcTs4plQI8Bkj/5Tz1UBwKR4gksrljV6Kht/unF8+pkVi1w1Bje8UZ3/aMGV9qwRgHDkDO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EjMHZmPMphycVzbh5f0QVPru5Pd7uVRypOuw4RPH7ltpCQd4jRCQO6B+bFQ2?=
 =?us-ascii?Q?neRqaRfhywrdmmYcfmSxpawMyGFAFzajh2CTyuxQRddjOYWkPOenfLdpl0UG?=
 =?us-ascii?Q?ZtTJWCqug6f7M6GwxpUkFIAVGRMYQBoWZPXvKtsKfm2nLBEzoU9r6WtsIHd8?=
 =?us-ascii?Q?0n/SD5Od5+qg02RPy60CS6RUOww2tHCPXtGZPkpsWq1PLCeuY0OACYaf1O2F?=
 =?us-ascii?Q?SizD4owILxmFaNpnDHKZhYt/GNg/6QiJrb/7Chkai2igISHnuvKCNrjnTC6p?=
 =?us-ascii?Q?ZuYeab3NbVwqgP0+WkyH8JSKspxgZtYFbrBzw9SqFHmSFhccODcpkvYXfyzL?=
 =?us-ascii?Q?DSxjytx1Uwd6FihU1X1KeBbIjIdajzAVuebJS3pT54+yrureO/pSX6J6dZie?=
 =?us-ascii?Q?WMLcGVa9n7EYiJR2mdFBuT9Y4C3e9dJ2rh+8och5w3u4IBnGM3D2jQJ/+iVO?=
 =?us-ascii?Q?eFEZWsze96MSOeODSw5n0NvzWDFUSor8A0Tr/mbU3j2DYZT4fb59A5qF8/xj?=
 =?us-ascii?Q?mSi3ULKmM4ru+0frKUVK+kncz+sBB9Bs5cflMr2hobxQR7TlVLajKZN/k1qJ?=
 =?us-ascii?Q?3OVPhMzahaL7fxocu1DEDMHSSWTZqUTe1DZ0HBRYiM9lQiZ+V2wlZ2PAEi//?=
 =?us-ascii?Q?L9bPMQ74ONgnwx5IrMNsTh7d2iKbtv7tN0a5ibPaxp+YC4LhDd2wFpK6KKDW?=
 =?us-ascii?Q?hsBWmD3+Xb5wD+0BnPERqAIpsRTK1gZ2CFso7VkvqAgPV4AVx4/kQg8rYNXy?=
 =?us-ascii?Q?zs3BPF6jv9T2GBR7vlD0+3b0XE2SJ6V/InJgFC/+/evjdnXx06ABkBLbjFF7?=
 =?us-ascii?Q?p1dZZdo8DnF0GVitgyjuTCezz47vWHjObY1RPdXzYPk3lCzJAdHennaowvtT?=
 =?us-ascii?Q?5Uk4H/yn82raLP7AEcGIQz5HTSNqQKiWZwzALMkgwZtBl/kWiEzcZPzoDvq1?=
 =?us-ascii?Q?Im/HRH9fv6CHuK4hlQMSn2+O1d6+6MBIg+mdD1iMMRsYhK2mVykWSqfagHFT?=
 =?us-ascii?Q?NbIK/C4UY7qklzYcbDLicmlA7mHFxfLEYy3Hz5fCGPrHjO+ZiSBKo9a+Idln?=
 =?us-ascii?Q?cc1K9ZA0oRrQDkbtUlyAsPcCK5w+QY3c7P2/vCogKxre6ChOva6p6B6JDJ/y?=
 =?us-ascii?Q?5RpcfmbcXLk3Zwk2nTCQ4S2XGtO1oe1gHNhVAxQy09xi4YIubXWatPdAEavb?=
 =?us-ascii?Q?A1f4584Z0gmmfaqtM4ewiTk0VNxHwm14B2XcVl8orh/pQoq5Hp2Ui0o29kFS?=
 =?us-ascii?Q?u6UVpJMR9PtDmhvv6tlUiJgRHpbCBMLc0Kv+6roatu1ltCzY6+QPWLxOTqH/?=
 =?us-ascii?Q?PXhVyeGmDDYOn1SXOpFiTMO3yz2wMFNbNTX2W7v5d2W2bVC90MsHqJxHs0CG?=
 =?us-ascii?Q?QaLgh23gGHBizRHlMPv126WNs3RPAFfPtyoQTUPwOcXZyAOl1KjKd1n8jwFR?=
 =?us-ascii?Q?OVy1PmXHb5XYWsrqiKbWMdVHBVnSzgePzU0r0LhCHpTRLzv7psaJ91BEJ9Xz?=
 =?us-ascii?Q?OsGRmmHlesY7OAfRI4DwENAbnCcPTC/kL6tQKMwK/jYkm3HnzsVNzRFbBnGu?=
 =?us-ascii?Q?oWAccWCcd2+u9UCCqkrEb7qAugZ4p/gmEXA2+SlLxGcJSvizXjp1awshG4GS?=
 =?us-ascii?Q?MkKMgS00gTPkwbE+J3LDefDIR6FjKCx1tueWT/haK5McGYiVGMFmFHVeWV3L?=
 =?us-ascii?Q?x90w26MwXSXdC11maPCWSK7aHwCNtMZQMSDdi7yd7RREknfpchJ5lkGDQske?=
 =?us-ascii?Q?yHjiGF02Mg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528e28b8-80e5-45c4-3eaf-08dedd6255a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:32:34.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbDsZBWb1THMFyPEVAjUrwEwJEb9H3wVgiAyYdjvdetaNDK/x90v69LtTXSbLjNAUoADn5QC9648vWpbXbuVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/imx91_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 25915bb702be..274eee303142 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -331,7 +331,7 @@ static int imx91_tmu_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, "imx91_thermal", tmu);
 
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+		return ret;
 
 	pm_runtime_put(dev);
 
-- 
2.34.1

