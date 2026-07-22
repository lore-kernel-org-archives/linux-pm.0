Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A529B228;
	Wed, 22 Jul 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708751; cv=fail; b=o5gHDVNbltMigRSRdkPHQcPcs/NK1LtfdEcdo4L+K+KNZKYohMu1lXVrhFyM2RqZlQxHG0kt2VnGa9NIwg6A+UzOgfHjuw5+aZ+8STn0gXn8euZXy62EBxktETpuyVXZcFHMWHQj1IzWEYC2Ysh3icFD1Kr6S9FPQarzZTKsUqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708751; c=relaxed/simple;
	bh=rQlh20/0ve3ZaZ+GFo8ShOzz7pRjRA29gfIR3KvlQMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FY/Iz+vKugZu98Lr88avuHF9ReSF4mq570mrVNFlpV+4FNINu5xz7ufR0u+9CaM1UA7a9OCZ2st0CW3wyXX18s2wyw825Fb3naJp4duWaJNOtiZX/lbNqW/hx5nklsiOdpXvKZ4qGAseI6hmMOhBb+nOahN/HUVjJaZ11a6sFJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w/axM7TY; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w/axM7TY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWU8F0B6O6dsqnYoB3MxWnNPQf1TGFNcojKN0AJpMHCg98cSjrppXVd4fmREHmcTNcxVl0GVN5rxwahGI9utwmez5Px2IuOApmFBnvMmHBS9Cye/UOWODN4o2v+kWaIn6Qk9qioLHeDtbd7sjuXgVKOWfTDzYy+2EeOH3i28Da78EyOWWMiR1cVi2N8m//TAg09a0/CSp+5JywcrGI5C70o1N/psRAG1q4GKxAXORK+/3J4Hkk+R+mI3myoUUvMrTHe5OML+xjPyAozXR6+5WQITii88nbJi3Yp3XyFNIKuW2Kpewgb6jrLvOBYGJkOtFzW4/fNpArW5xAZYgCmAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=hsDJZQx83qnJSfGhJx2YR6lHMiJUtQ+R7NG/Uk+kc18O3/ywyxgT1iMj2p45V4Hhb634NfO1QXYWaInbCaP/PQbk1jmafMzkf5s8OcoHdJOu1VaTej57nN/MMWrXnJVWyEUhCjVYDSUqQ8OqKO9GnmiytLwvn3tUDyWsRT+m7rz/XbsdEBUmEK1OwJACG4Nwe1i0NXS5JuG07cmhQEW7STy9A0jw1TW8TJwZTez7zm1dzbGg1BO9gAFQDDMp6uqc0hQKDjKivpeQnJqU5BlU8bQxeIXYlSXR2VWNuI1M/nXu5y/dZkjobh2EKXA05HqMTRiWNd4sO3kI7YFqaRKsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=w/axM7TYDvZHtSr6I7Jqq9KOw4XJ2jjvqTwQwNWfeeuRfT+c3zxPdE2YPiME9encUKdKSqjNgqjnxtVdx1QCpwERqjyzlzD9qfCvZteR55yTCdLA3lz7N44Hxi4OB9xX2rcgvUNQgv0zDGQyQE+/mJuhSeIiTCPljdwHPi8Or8NPH1EYNycbh+GbCdQeZKX/80ePxOQiRhyI70CFSUJShpd1lkekJ9YEI0/SFjWHgsaE1teycCHeQc33EdN5UbCxIiEhjteXMdsIQNCK9t9IWq/+215Gg+UKxpNWdklH9nhqwr/jaHvmFBOa1WYBf9jPB5DD8ccp3jKztq2INHwnKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:25:46 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:25:46 +0000
From: Zhipeng.wang_1@oss.nxp.com
To: robh@kernel.org,
	saravanak@kernel.org,
	ulfh@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	jindong.yue@nxp.com,
	xuegang.liu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 1/3] of: export of_stdout symbol
Date: Wed, 22 Jul 2026 17:25:20 +0900
Message-Id: <20260722082522.3747962-2-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8596c1-628d-4925-edc5-08dee7cad414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Rpby8/z+J6nFXv9waa86rdx9PSNfH9UGuoeA0CTEoN6fib+DCW2Z7fI6OVgz2ujHcJ5vJ4x/EXQkN6AJ5zVTAqzQ8SBKZc2xvoi3053/x4Xi6p9uRajwR6Vb3L7jojPYNGJZOJ+xULp7H21EEtqSZP1AsuD8yW3ht4Jq4HCmB2eIVLmfZ6LY/fYeOBA3snqkQaTMKqzn9Rfj0JwaulNuhdasU3W53Auy+X5ffs9IFLgRm+0hTbr2bba8zzRgIiEzPqEfihiRtYZGJunkQzgB/BsLQoNre8TGW3Lk4Glz2AGK71OveKC2CiUC7s02dxlGrecshqKwSk5RDxFZvx7IZUIIizAmG4L4wQ+eKIqB73bcgsd/iJVBl6rZDnpJ4zF9LYOpozvf0eS5xCNYkp77jkIciPhKB/RfhtwNAmjZK214h2HCOkDCtJMvuy2gS/11bxonHTbPCKU4dNHkpn9aK8VS2xXb10ncvPs1GdYKyzNBK/rDGm5MoQVfvWmgHJjJhXLJrDyB2wezZ+5cFfRLY3TZmZ10a8oaCzdaSJVxORCI0r0dPC8SfjUmcuoUlzrRiWV0tl+dkn2O0o+M6twJSog3qtWXQiHM1McF0xWlvPMrtOKe2L/yFX97O14PW7JRMKWPEfvAVVv7o89aQX+3UfZPSe90AN+ZvmcGajC9piM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zf6LB5BVqj7/RncPkUkSyD+YMAYXmWNqJZGZfUwEoZzMK14Ugq5lvgyRpm7f?=
 =?us-ascii?Q?enKp8dwV1QO4cqUDxjLRmox6cMlCobL55KTjgcCWRljRnm3aS3H/p2bxdtaK?=
 =?us-ascii?Q?A7Tzz7pyRx5CSJMeELpbJuDRr8CfMc3mWQePXPaHnd27gE5UTSSytZpkMMzG?=
 =?us-ascii?Q?iLRS7MvFIpznhXUDPhl5/Bpm9RtbxIBOCsqIh5MjRI9QL6tPJYfCfK25BRDG?=
 =?us-ascii?Q?OoCTZzQS6/FuF0XMm0zyYTWK46gAM9eXPxinkTJ8PJcFdUH2D+oGmJxhi1dA?=
 =?us-ascii?Q?I1yPsaWnqHUpQ+5kSzXjg1B7fp+5U0xZTCXT3bqfhsbGks9bLzMX44DP3oT+?=
 =?us-ascii?Q?IJR+rSMQZu3sDQgjvvhRschP3zzLYZzbPgM0JxT4LOwAIp7swX/NVT+WIQAJ?=
 =?us-ascii?Q?NXyne0Gg/JsFUHW1LwMT9SY6G2BVLkKnDpFRvcepl8A8BTNc2FaBt7DgHM9Q?=
 =?us-ascii?Q?eDXa4n3ziekq7N5HXrddiDWC1WvOJxJOGfVvFLPfQaOI0egWZXIapDa3jUdL?=
 =?us-ascii?Q?Ktzmi6TYBye8om+pyzC/WHUq0RjPikD1bBuSeeHzfwLNXqQ7NyXUojOqsqlv?=
 =?us-ascii?Q?r5QIhDvJuKT0UY7jHtTqPG3PRZEB8cMB5B7jF3ieV1508aClFGlf4zILlxfI?=
 =?us-ascii?Q?Vwwfgf7ZSUPV05vz1worsVpjKbb080peXtbjgLbuv9Zizt0zUAwRjDSBR4in?=
 =?us-ascii?Q?IqScptg1fHftY3y9b0OFVk0JZiI+bJ3fK99EmVYTcJbGer8gzsY/oPu5/4Pb?=
 =?us-ascii?Q?YvwtFTXOdnL6KTkX0UMcIARhkvlJTJ/D1mt+n0teudds0Lei2b4HKMNfETMI?=
 =?us-ascii?Q?oFzs2/WTXXYSrZPJcJ5YkeCjUcMFuuvEsuzEnDk6gAJQjdc6UFAZJfPW0Z/z?=
 =?us-ascii?Q?m88PsXm1ZPYP+tqwLdDBXNGYtAB8f9ztiokQOiAZg6uWOu7dvHpKD9KArYgb?=
 =?us-ascii?Q?GYJrXkv49GQ+VRnqEYt8RPUsxTJuNa5eWHa7Tcabp1uUksopM/PVkw9ZevjQ?=
 =?us-ascii?Q?eEvBrP6i+yyY8sHM6ssxWcqMhLtsOQxvaLAN6dMg/Whf1k5MOv8m8zZubgwn?=
 =?us-ascii?Q?2x7glhGid09eQu8a2ogK5yAuR0TZl78paYgFHq+biXs4pTxX18il+fw8+9SR?=
 =?us-ascii?Q?XruuEWlo7r6PvLqkxn5QnURvcd8aTYe+6wVz+bmsokFImKxWnZab5WZWVm/8?=
 =?us-ascii?Q?t4nXqa1xMc3H8NqxMI8YW4q7+6eDGJzCR8rdntx3DYhgVTyZU2YspXERGHTX?=
 =?us-ascii?Q?/7xjV5DemvwS80He32ETIOIYvrPMLMIFnu7LuWBcbC/6pxUoOAT0XyFabrkH?=
 =?us-ascii?Q?CTXU5grbvYSnf0pmNoEIyXBalvvKl3vM6x95qNQz3RKXfXpCci7v9t4mKTUA?=
 =?us-ascii?Q?9M4HmutgnR4boCNjSGbJHTJPHgvyYmOXtjtbQxRM9+0gxn2dPR1MKqBvqHMN?=
 =?us-ascii?Q?mAJAAhPNyygtdo5DuRp7yZImFdfeLhBgC08cesVaq1V3rDfp+r4Z2qZe/+mB?=
 =?us-ascii?Q?5G2fy3S41jiHMrcDTXwsALR5wViVqOjcslfDJsOi5yQ6m2WhKml0lnMVaYC4?=
 =?us-ascii?Q?G0sOnGVWb+iw3xXibObjrh0sXw6m6GPUNKBKERHuesAomKAw8uD6u1A9nTs0?=
 =?us-ascii?Q?OsiD4xydArQuqyhZlRa882US5f199DiyMzvorUfWH3n2ZM3vBc0O+EcIVyOS?=
 =?us-ascii?Q?nAb1zHKFIBkIs4rsyOu0OMQFiEtUExJaaZgSlTR595N6+0wCA+8v/qDT9GlC?=
 =?us-ascii?Q?rPKa03WDWX5U7CsE0gV07JoL/ZjtYM7aPeln+qd8RQlRI88ORgkN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8596c1-628d-4925-edc5-08dee7cad414
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:25:46.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BodfFTi1Kxb7OuFvixcYE6/Mdz6BuEO0W+On+dNEmBteEOb1WSH8dVHYf+R/UpbuhB249gTQaGjtyz0NKqEDHPxlFGRMbp7k8Pc5+bMugvmrdj95v9Y72WhbR+/v6zLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

of_stdout is declared extern in include/linux/of.h alongside of_root
and of_chosen, but unlike those two it is not exported, preventing
modules from referencing it.

Export it with EXPORT_SYMBOL_GPL() so drivers that need the stdout
device node can be built as modules.

Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6e7a42dedad3..a25c95800719 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -39,6 +39,7 @@ struct device_node *of_chosen;
 EXPORT_SYMBOL(of_chosen);
 struct device_node *of_aliases;
 struct device_node *of_stdout;
+EXPORT_SYMBOL_GPL(of_stdout);
 static const char *of_stdout_options;
 
 struct kset *of_kset;
-- 
2.34.1

