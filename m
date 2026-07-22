Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793244AB72;
	Wed, 22 Jul 2026 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690613; cv=fail; b=Mif8BMhqK3NzGlQK1JCyPwLMXnHj2x7OYJ3fn0ckw2NWehQ5MusobHyamyiBtdtUQpU/MOez8AZ4YMYBcS1p3T0COBFgvwRF/KILq7kjJKqElVUvswUbZxOkFrVtRzOn2Pmx1uw9gzcv/SYOGvRaAcZsn1SmiFECl6/pV8zbK04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690613; c=relaxed/simple;
	bh=j9UPUZRewmQFFnUGboJFjtXjix/8xkBgg03WxY6zXas=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VfCK8xkss9sosEPUKpHl5/yjqdosj6Jaj60Yv6FE4byWAT4IlLbFcAGX5VJcbPP2FQNS5bgkCWu9UOyk21OQialYV/Ucq8oZJEkYSpUfX+cwK3/7ax4tbd2ZqqEbRFDGThzMqAM4SMMenWN+b2yZ+emj9X09/qjfjlBrCEpQ/3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y8CMAz10; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y8CMAz10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6kHtYoiar37Ehz7kiu8fjG42sjNM7YFSIgCzudS05L4huKn2Zp/noMcJonRcSTFMy5ZgTqLyVVD2f+N/4butk8LsDUyjEeGCYMn5zeOlq1M8y+imen1xDQYWYKM6peXu59TRWhc+KFFWzTpnF1Ej3jXTpm8bS4BOGieCa1EJyD1C71pOYj39KtMV0EC3ciPunh8bH5dV5l+ssV/ysRbIsCgLEVrFFF2v4LByAWGYTcruhSMkPxW/yhp8APrxhCVSEBdaRpAx7/9DWuONe8dP4bLNHD1a8E4zoBgscPJjTwH3tvpxfib1VNDiQ8k0k527BzdBxAXVf/Xl/LO5KOFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrYsc23QNWhkFCZxzlcJXweaSTTT9UiaFBEe05NwC6o=;
 b=xqZT38URjfMKF3meRToVfGhdMC0A811kqJ0VDlK8L6eORGiEX2m1TRMKRd34dFLYhCM5JgONtiV82rtxq4KciKd/HWvYx/AcbpZha1HDcaq7MB772m9qjy+esgotwOvh2aYs+NFr0rK8DxOitD6zr+q+IQK5CltSDt4SSsuft6dwmjXdqIou8x7GjZhjiQ/bqRS8JwKeioJjtrzVdZ9RrCEJS8Y46fmP0jtKCYH4aQG8TYTvRhgkrhiirGQoZUWhLgx+JMmDog3OkMZfYAzriKeI6a0TfUw89zvEHqjR4Ze0uSRc5CZpdGtiLvQyNTsUIQR/Y/q1j8ZP4nvQUk18Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrYsc23QNWhkFCZxzlcJXweaSTTT9UiaFBEe05NwC6o=;
 b=Y8CMAz10I/SNvueSDNhRGCNLNatP3kLGRJbZHcvdWr26zmVf0Ux5DkrTdaG2U0b1DdaGVwSOZy1lm952xyTLtvCCiQ80MEqoxxB4nz5+W9taj7G8RvdU6QmdkqltgdDftfsF+9KFcW/s7KwiJhRTOozjKHrsX6xXJzgNR7fJwv4GI9raQ0sMKtQoxtTVqh9+We8OjoVvUcBOb/1PB5wpA+1yOtUzeG1j2t6ga+TkQ40BnVUa/7z0fUuTZhwKP3UIheOcbUobEN8nTCG0Zyc5Iz4uxsxWEkTK5enDel+8aCNHkOgD/XY5sAuy3m71a94JkpPjKm6zrnMmnIVSKP+p8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by AS8PR04MB7719.eurprd04.prod.outlook.com (2603:10a6:20b:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:23:29 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:23:29 +0000
From: Zhipeng.wang_1@oss.nxp.com
To: robh@kernel.org,
	saravanak@kernel.org,
	ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	jindong.yue@nxp.com,
	xuegang.liu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] pmdomain: imx: build the SCU power domain driver as a module
Date: Wed, 22 Jul 2026 12:23:19 +0900
Message-Id: <20260722032321.2693300-1-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|AS8PR04MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee8299e-dbdf-4318-cc03-08dee7a098db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	CCkD89oi8GuluiobNp4cr/EPi69iyz53WhC3dvb+m5URUHGhKPFheSSa8osuRd2oylJaDhNIv4n+zZpEv/IqnUIz10xS4QtOEGX/8jCsY5y8fJCEAQ1vhY/+HKFUvhIiGnp2wrMgezWXyAedPe7n+UryzGA8sF6sYd4Ume2nhokZPXqMJLSvU+lLy8hShOm0l+fJ6t8xJKXIs82XLR+VkagmR76ZenKlcJ5y5eGooKFho8Nf9nYulUf9+/fjOY20iEjhugLIZoCBnJn/5GTqj8ZWxJkYZkXHQrOTe5dqbt+X3n2lXAHnEw5zZgrLZYODfbFIAOCwx3BM3aWQ7fq6yxhPhme6wkL80W+17qrl4zBkJEuA6FTg6UP8NjkvY7/K/kvDYAFtxYtzsLANtbjaAq+wZJTwnsudgjWwZPQoRArB38xFBZMfEceiOYjTMCXQhdFgO6bXkmKzYjKfZ3So6Q0jAWXbAghhZdeDFjTwhAe25j2YbTINBRw64rMbhG8+1pyqSBPtavpA1AnBc/65GxIv7TqV5v012YFRL8SaMS39SIN+uoGEtfci07Ut1W/I/8RGpi8Z3SY1IA38YIcDW2GmVddiwnpk2ay212bDBuszrYfWO/B4mGSgkA26hNF/UG9nG97k5pY5BGnl6qD5aaREQ13dhrmAMt774DDZd+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaZRQDYUOsxBZHFg7IAkJzrstX8CyK5GAVyY5qw5NHjOKzkSpnUweYDzfVs1?=
 =?us-ascii?Q?p8NSoE0npi2/rC991PLDIRQJN4Ug/I57Oc0Iibs9NMum+tFoAsguakP0Pn9O?=
 =?us-ascii?Q?rcn9UzhscTCa22GdpdEwLJ9lz7ZJ/Uy9IeymB7G5Zk4UhMINxOKvDe605DI6?=
 =?us-ascii?Q?Euo0/S4ItEwQ7zWcoNk8vp0IKjZ59LEars1r27v+h1xdWlzTPRnHzMlH/4N2?=
 =?us-ascii?Q?RhxT9jq6vYRgIs67nV12xdNxYnXdBers8nGUDdFbHShcvH1H1bYL27Wi6etn?=
 =?us-ascii?Q?ewVuMWF7iEo9/wZWxfNKJvE1Bvdft+ohxkcQ1pIs2T9kO27Q4JL9zh6QgWuO?=
 =?us-ascii?Q?qEc8lNnGjx4KOikIBsZTjdz1+iNDFCxzZml+UqaOnCmXabFjBO/rZQctMAhd?=
 =?us-ascii?Q?80K8rlVHnUJ5exF/RK2FMmbA7cEM2r3TPUQSXnJe3ZoUGlFqI+Hep5pPe2Tq?=
 =?us-ascii?Q?gGLRw5wFoEJKXHzXk/bmURyxoAjqr8/IMONLC8Sf8hV8GZx4wn1heqzJ+N0q?=
 =?us-ascii?Q?2zXLOCZWiMPG9vRc9xTCS7q/qPDe+L0RFe02W5crvwPjaV8E8gWhJw3aiTy5?=
 =?us-ascii?Q?SJfaDJNOeBTRDey0poGxhaoJCppDNkO5j8R7i8/Q7brhKAe1i2ORNsKDl9Ov?=
 =?us-ascii?Q?q1NXA6nUtIDOxNTBgIMiJ3scmwBNmzfKzf8LnOpSv3fiDsQHhPwazmLXDR/n?=
 =?us-ascii?Q?UiHD/LVXTVkRO/fBjLR/SP935WBnB662sUEuAfEQWOJjcXyya67Rw+YH1tE9?=
 =?us-ascii?Q?iiKhxc0+JgkdYU/SNHKF3KL2vLBozo4OAJanxb8wwi2huTSGUlFIgK+FC1J6?=
 =?us-ascii?Q?ECXv0uAw2HVgEDOQTQqsa/HE6WgCX27VEHwglszNXhAFxK5LE0nCHxaKRQ1x?=
 =?us-ascii?Q?Hjhjrud4Z/fscjsn7SebGKH+NyIWookhlDiPBGiC5Ke3Se07EoJZPZYuEbFd?=
 =?us-ascii?Q?r+d/A/cicdbu5v15B1R6Yn0ZN2jG0qBNti1BWjBVYU1gH+0HEgGKyLVsAdFH?=
 =?us-ascii?Q?NGMsXN3nuqZkhjEXyYEitZr8UAow5aXImzacW+nYrt9k2iHsmsSFCckHU6bU?=
 =?us-ascii?Q?jvPUYySVEylwIbo+Q6LGda4qSdzfG797N/zCFmZKjphaCpb6GF3HjsuAiQYV?=
 =?us-ascii?Q?BqTxDyLpzOTBVhN2tv1/hM18eTWnFXdm5aArv5YEkui40Zp0qDMhmZJJT36w?=
 =?us-ascii?Q?1tNVJ1K1yhglzXZ/PMsRSXHhtXzN+XuPh0Q1K9adqgRsZaOdi+/HzPzwxPEk?=
 =?us-ascii?Q?10k9mFMSBQ9ObrMmAATwf9vhISd35rXXl1H1e0ZY+L743bUAfjbDnv1N+e4n?=
 =?us-ascii?Q?oRKaNqrvUlrp8xxBa+3Eja3ouHcUUNSsLFlbEUwPMDXKoDARtjR6wA8PDGBB?=
 =?us-ascii?Q?ECgRsfpgUze5F3L5olDlly7BZ0iZ0d1GoVhN9YrkpvpDAmx2Cvb+z1ccGMp3?=
 =?us-ascii?Q?i1uf8nQeScDN4FhzdFDeIItXxfabG+GhX4432PY62p2har8hJji+cwA/9QY7?=
 =?us-ascii?Q?srnPIJRviPk96cobE1lFotFWEcRnlAbExSzbWQxlZZPwDlX1zS2qZ/ZAF4Pu?=
 =?us-ascii?Q?cq94wlPA8TYOM2aYhHm+CFbfHWHUhmfqmP4M7coQ/4p88/+YfXT7CLQ2nK8l?=
 =?us-ascii?Q?oWOOibiltQHSDCF2YeRCzp0VxCV9oTEAGBYgucN3skJHIrFe+oUbHEYaj69n?=
 =?us-ascii?Q?7UVeTkLJmi9FtKiBJ1KGMddG8Re+4Z5Uj40Lye4NDXKMkwHhDPNT3akJrfpc?=
 =?us-ascii?Q?niKGwG/VCPH8xefqw8T1qxlQojnysQ9Do2AitrjsaE2wvErbZ4sf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee8299e-dbdf-4318-cc03-08dee7a098db
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:23:29.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B23YHkK1ypwPpsW+/+uSsE1P9J5bNuMiBBCSMsTUk+kwOn8iJvnagGemm2B9RnLym7DF87O/tIvVGiacEWbWrGUGYQkF03MAJNkbxyavrS97++xR/C142ofuuu5jYHOz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7719

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

This series makes the i.MX SCU power domain driver buildable as a
loadable module, which is required for Android devices using the
Generic Kernel Image (GKI) where SoC-specific drivers must be modules.

Patch 1 exports of_stdout (which the driver references to find the
console's power domain) from the OF core with EXPORT_SYMBOL_GPL().

Patch 2 converts CONFIG_IMX_SCU_PD from bool to tristate and adds
MODULE_DEVICE_TABLE() for autoloading. Only module_init() is provided
without module_exit(), since the provider cannot be safely removed at
runtime.

Because of the cross-subsystem dependency (patch 1 touches drivers/of,
patch 2 touches drivers/pmdomain), I would suggest taking the whole
series through one tree.

Changes in v2:
- Drop module_platform_driver() which provides module_exit() and could
  lead to use-after-free on module unload. Use module_init() only, so
  the module cannot be unloaded. (Sashiko bot)

Zhipeng Wang (2):
  of: export of_stdout symbol
  pmdomain: imx: scu-pd: allow building as a module

 drivers/of/base.c             | 1 +
 drivers/pmdomain/imx/Kconfig  | 2 +-
 drivers/pmdomain/imx/scu-pd.c | 8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1
