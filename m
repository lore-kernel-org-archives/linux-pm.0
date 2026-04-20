Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B9375AD0;
	Mon, 20 Apr 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651801; cv=fail; b=hF54HItarslgxsMSgN8Kc4JfaEqVL8OlZbFT3u3zOUaJjnAKIA2U972IsHpDy0rQbeLb2Reu9WnWtRIagXfbi2uDFtpEO1YIBQHuZsT2bgp6I/8Ax2opjNsZuQPQ8ah3ZqqKOO7/GaCgB+KjSnIoI6GkN+wQBlxLOckdvBgvoKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651801; c=relaxed/simple;
	bh=42iNbs4OW2i083i8gPYgA8gTzBiTabWjj0IcYkeJ6Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SeHhFYTKY3mCmkw9Y8ATKB/2svWWkrmjSynPuQNL9Koy75BCiHOP/G4NlXgGLvYh8AMgqo62zZb2v+gfQ6B8lmZA7GOkVfY2gL9VeHexYKQxJmG72j89CTJig9/W5Z2NFKqUQMVl3Tz1KhC+Sbvcw/1uz2OkcfpIpzXxO2u6L9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EuRxyy7t; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EuRxyy7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftSgpqPRVzJl2lPl9jH2rodh5BsEmNGkLETKLE+msVhopjEUAEhHMlgxUcfLPjTqgxAmatkHoGdaBqbvlDR+nY6GIroG5PgMPjbU/1Ct7raSc6XPG4/OQqYWK4BSA/cut1GO9/w9VTGnvB4I8crP5DnG0KJnrePzK23ECrgDh8pxVa5CjUzRzVkeqh5qUJbF2wu036dh0dW2pe65HcWATujUi3brTAj3E1E2S2qj0AV/eBRXfXDuwsbq5aHU69y23b5z7CFg4B5ozTqh2rznoil3pxxTScO6mBt4EIB4b0zkgIyHT1HLQSCql5/W4Xs62TBg4wNu3gkvdc8QjGQKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVUhGYVYPAHkM5wQ8mNcRrksVs7TuRh4/BdEg8Gelkw=;
 b=kpkh5NzqtJ61/jovYgGBdCyvW6j76TlOYSQC6x67U2NZzwE3vTzOHRgx0JoSLpcux4afJUIOCbccaZBClvqmB/sBJVd7bRo6p7e7AIAiUBlMBMhJuTMBkGnAfySPg47HfNsR/ruyDRu5VtUNDkepWPHScJ4a2u1smzwubxs0lvlLBPBO5BhVVV158f/eyaL1fcaMjiyr4rQK96xMC90w1Dsv4Ld7e/9iTTulRgSe4BQk0KAGmqOKySuIWpclqWE0jGjs5WuatqxNjauc1sAEcGtbjYWKOoMqsC/FeKvbcjWSFj3hG11Cd22i/Zb6hDaVBZG4RgjdqVN+8QzqB8TlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVUhGYVYPAHkM5wQ8mNcRrksVs7TuRh4/BdEg8Gelkw=;
 b=EuRxyy7tATcL14stY5hAC/2vxtYvKixkn8Y4UPEw8YTXmrlAcj46tJ0CZm8EjeaMcFWYhFVXezvxkBjlpJDSD9L/K0sQr9F6CxtJmRbFM09TbKcoUXHQB03mhVqoSkG/YEIBF63HiU9JUzFVWd9/R+dGpN8jPqYKsidmHrVM3+r8kpXRcaJF4ciKVGbP29tpOuW7EqIZO2PMO+H8VEb8PpvD+9cg+bJYp9zN9aEyC6Z6HZNt5gIRc7qkpWc1TSQ7FAt1JFBe96R3ajBp2+w1uUnEw4dqjt3Ed3ZxURrUkQfEnH3EIV7XyZJ2Z/N8cpS/KUAwX023/Y83wTZRCTTPlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by AMDPR04MB11605.eurprd04.prod.outlook.com (2603:10a6:20b:71a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 02:23:17 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9818.028; Mon, 20 Apr 2026
 02:23:17 +0000
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
Subject: [PATCH v4] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Date: Mon, 20 Apr 2026 11:22:54 +0900
Message-Id: <20260420022254.302740-1-zhipeng.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AMBPR04MB12334.eurprd04.prod.outlook.com
 (2603:10a6:20b:732::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12334:EE_|AMDPR04MB11605:EE_
X-MS-Office365-Filtering-Correlation-Id: f9347bac-f7ae-46c8-4ee4-08de9e83c884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IdwiH1KGMTlfqKZ6WjsvcYgx+iPh30lhxNcz3Xz3S6EVAMK0H8F48igtCcR71prQqHn3aVUfCzSF0BXnFobCkzhBmK55I+AZR+f/6ph7eQ30wTt4HJknsYCkklvAJMIyclfFe8X7Ut/PeIwqnKgiZ9bQJvmAeajRS/cXzL9LdWBYW94u7mI4L2eXvX5tUspqIaib8HbJihVGCGoGNzdyxB1BRC2AKJgsbG5K+BcsoKuwQOeIZn9qgNVP99Cqp7C2jLSmdTrhrdK09xwIHWYEG3Sqp/20m7z7XACHz/HwxVuBvAyzPB/EERBlK6kKVZ3FJYNCkggd/yoYAp68MIZUjQ+0lMc4YjcTpH2gn2BSLpkcnDbDcpSP6SbCPrbsXSYeiKg0pEgxkwk7LvgaIYw6Il5ZNo5Qn5VoUZ+VqvGDIFsQRcSkg95XAWf21LfDdAgUVtqozBb8/TeOawLcLRTEzINiy6x6Gv5LRIJR6ibG278FJaiSMn0F6hedFZW/SeZhJik1XuXQ7oRcstTzr2tgK8dW6e/+ftGI4LG4JUXY2yOTAbydfy4g3IpPkCoxKy2qnsbXOPCt76Lh7T1qE+tyrYAl2CRTd2erZN5TP9w/EEP/XNRAI7XAX9fTOL7jcA6wb9f0rwoy48hG0yikiAW/2xZp2urhWoNNuRMS2nZVsV502JsgAJMkhy5NhkDpHKItCdpHRHuFL9aLGsb/6ICQKawjZZZz5L/hI+kiQbSay0pvUDLxXEJSCkL+cJ8AE1c4kkK6YKrg2SvIJoHx42ttLTZbMo0Ys2C1OaWdmsNZF3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLjBygvyHpaDLFaM/geyVRycbXNKlVMrV3TRarKWJTRJGZkS+NvTRh0/8geF?=
 =?us-ascii?Q?o6N7S2jEdLLJinYy4O1nabPYoPjmOys8Qqgyvs0tZL61gQevGGZAc6USORDq?=
 =?us-ascii?Q?NEWeC2Nbv4L5Kyn8FJz6ePM5i6mrIznupsMv55Fynoo3vYaQk35S3s7n8J8a?=
 =?us-ascii?Q?lEiFx4rstyLDH3AnOsgmVYWZk+ZI5YRBavx7Ravvzmts3SOdYqFhqnJhqmpR?=
 =?us-ascii?Q?HNOjz5j1/EXAY4zXuTdaPzqptURrx/lwxSU8SeTHfTi6wOOfSeqLNFsNMc+A?=
 =?us-ascii?Q?5KBLwsL1krLHsf/hxvER8My8pE2ZwzaBvzmNqf8bqiSV6joeihlhewHNFR4N?=
 =?us-ascii?Q?IFHbEzZrT5C1cRPTcOYVUtbQN6WurzdI4K3AzVCT77VPdth+BsOHOcPXbUbT?=
 =?us-ascii?Q?XW/8KZEZ6W6+g/5i6Yculnq91LQ+Q5Y6P3Zj1hynwkib9sFGu1mxF2Xlo8W2?=
 =?us-ascii?Q?sHjUbUt42dtDTl7tNsb9Ep0U1awbDZWjBlcPppCZbrjEgYLVWYFxcKXHxAa4?=
 =?us-ascii?Q?SxCvnYxwi6LXmNt9vVfMTW9m5HdBvTo+joKy3DCJj2pJpYyKJp1D/ERwhCGr?=
 =?us-ascii?Q?F3CERH5/jpmUfs6p6510Prnde9Zb67MUpJa36tc6RjR1y9AEghPERRTZYRCu?=
 =?us-ascii?Q?1IgQkIhWFfECbhgNz2QoJEMrMbXmZoponagT2nFtwsHOwdEzL8vdeYZa3tON?=
 =?us-ascii?Q?2Lo4uFiBPu1X2f+Vpn21ovBCWlJ9sceccF/YaPzSp22Wy5YHD1LPreZJua7y?=
 =?us-ascii?Q?H4mBWPzilH0UcSTZJUfxMyEckxTGpTkyJfspkvXS0UAfd262R6z5a6X4EuO5?=
 =?us-ascii?Q?re0Yb4MktAI57SGkGi3zjxTvUt1tLptyIv/ag6xEdQwomdimgQ/6+E9iP6B8?=
 =?us-ascii?Q?CnyN5CwcSZYFXOHMkWIAmhy/lXrSOPIzJ3AEnhZ/iYXHKKeqjv/ZlE21iZ+P?=
 =?us-ascii?Q?jlcSZpBbg645PTU3MmQhGAvghvn75MTdaWchbrHBXQgqs3S3muqJVPea67SK?=
 =?us-ascii?Q?A5KyP3VhYNaLBQTfP2CKw2RBLtR/yFtWp+IJmjDcAe5vZnNvHCStCbzXuISY?=
 =?us-ascii?Q?MJVDv+h0o25RB15Nx7qgII6UcERCt31Q+5K96yAweVRvic9vEHjbDmCHY+OM?=
 =?us-ascii?Q?w2PrD+XdVzz/xw3OqL2R6YJ66r/ZADTLhWuKsr8ufVirrd8D/3rejCFZAcq7?=
 =?us-ascii?Q?DZaZTHl+PVnzBYlTbjHnf7iynmCnRU1xWv2vi0DzIVblaqPxeSq66lo/6QES?=
 =?us-ascii?Q?vMH4rLGQSliEebr8/5eLlktCRDIZuh5sKTFOah8sGCDritFAlV51GkxdQ1X8?=
 =?us-ascii?Q?nzxkTrgxVZo8pMXbgGY6fBaQFwVk+URGQFNI354w0pyIQ0LWcskxycDopA0U?=
 =?us-ascii?Q?hyZ3KPQa6v3DCt+soiWDWJWhXZNBd44cyvRDlREl0r/y0H0G4n1hLDNDXD94?=
 =?us-ascii?Q?TrREGZ6C5S4GCx9hoj9Rqh/MyapEgJd9mS+9qyvAnMG/gmdyRSbN+sX/+t22?=
 =?us-ascii?Q?tKJZ1YlPe9U4WVMM+2y9TdTGfejsuJvMpvir5WOa1e5Mc7BSzHMyyFcjno89?=
 =?us-ascii?Q?dynxU30chivG63ukfJhWNaC7WEcSxqMW+a6a1ah+9vTdCokUDoXYjuladHCQ?=
 =?us-ascii?Q?7AbM6rV/SjkBzFbJ1qaA3NrHm2cxni9dVqdzLz+yC3bN75Gd4w6d6fyIUFEK?=
 =?us-ascii?Q?L4EunzcioIhes9fYUK+tF8TeMZ1Ikz3w9PSUZqVAXPCSV7exIS6oCAMyd20i?=
 =?us-ascii?Q?u+gFscCFiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9347bac-f7ae-46c8-4ee4-08de9e83c884
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 02:23:17.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXwZO20D0pPXLPgxh/WFEdc6PGdwcdtTdajO9REQUwnvTtBTq0JjDUwehFquSFvGddqt1abdYag7a2NrmhaNfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11605

Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
to allow building as loadable modules.

This change is required to support Android devices using Generic Kernel
Image (GKI) kernels, where SoC-specific drivers must be built as loadable
modules rather than built into the core kernel image.

For i.MX8M and i.MX9 devices running Android with GKI kernels, the
BLK_CTRL drivers therefore need to be loadable. Without tristate
support, power domains cannot be initialized correctly, making these
systems non-functional under GKI.

Add prompt strings to make these options visible and configurable
in menuconfig, keeping them enabled by default on appropriate platforms.

Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
This dependency was incorrect from the beginning because i.MX93 uses a
different power domain architecture compared to i.MX8M series:

- i.MX8M uses GPCv2 (General Power Controller v2) for power domain
  management, hence IMX8M_BLK_CTRL correctly depends on it.

- i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
  have GPCv2 at all.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- No functional changes
- Added detailed explanation about GKI (Generic Kernel Image) requirement
  in the commit message to clarify why tristate support is needed for
  Android devices

Changes in v3:
- No functional changes
- Fixed typo reported by Frank
- Added Reviewed-by tag from Frank Li

Changes in v2:
- No functional changes
- Expanded commit message to explain the architectural differences between
  i.MX8M and i.MX93 power domain management
- Clarified why IMX_GPCV2_PM_DOMAINS dependency removal is correct for
  i.MX93
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

