Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4138F945;
	Wed, 22 Jul 2026 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690620; cv=fail; b=p+y5uwC+aCbudNe7Fy2U8dET7vbBa/doGKta1A/u4JMj1DLCySZxHu79piJKSVIMVSbIdYI1QgEuUzQL+iFmfO2IgRKsK+kQ6MeSazKOMConY7I/e576IphDCwG4zo0r+Ta7WzO7r8WUfKYvW7j557ZBW6KQITl+wHWwqrULMOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690620; c=relaxed/simple;
	bh=rQlh20/0ve3ZaZ+GFo8ShOzz7pRjRA29gfIR3KvlQMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiik2rWSdVLeHD1WosnFKih6X6Gv3D4oSN0yINkxDtroqbIQT7zEeBdoIIasWNjJJp6VejvIbQZ/I3S59TRpVqJrwTUdjBEMLzaXL52jpGV0PzkW3tvtxjwAOiUTjHxIZaY57ysJo9o0CDB1Kcz9iz0vkwt2PuBHSflZ1UK34Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KWpS9hvG; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KWpS9hvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL7qYb7Sd3PNBiWHsE65wd3quWDWFZ+pPY1Xr0Iq/M3bvydzTCAwPuEZJjm06D+z4NjdhMA7rNBWEr+oVXKEJHhFZIf6RiwN1nUiu1EBv6v5ZhhYRTeWyZa1EgcgfRIpskFsXI6cekldj6fgin6fe3qMCb49jYPEPDKBgd8n0gH5ll35wCXQGWuXLFpheel9pkKYsNn0W9dGwAacGb3LNHC7BUnsWWStNR/zEpZ4rsCXlvCuvlx2SFcMEBKSRbw2r6MPaQHHQHfancNoas+CXmT1gitaq9DBXiVbKzWWJPXLDOqxaNlvMylod6ZCUC+gGEFbzAptKYeF7KZIEY3TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=vUohMkqj1GqdTo6142cini/ImJvHLfkESy9wKQzDjVTZkJW2sGzHsRUU/momcL+TNwKiU4Pbl6tMkHFqY6hZ3FpuTGpy0BQ16j6uhD33AylbiWMCuCib6/Djk0gjqHnBVDuwkZn5lBojQDJ3owFuL8iUHmBfvxkDbWwmRg4KAmK67lN3bHaeXbHXCpbP17XSnh3VoeQ5E5b+VgT+7AD8MN5I3yKIynkkTNUyrxPQH/NFuRgk+p7JZLMw2Y/otg7T1K+gZDje2UXZU+Jqs4pO6LRqgkIsN4+7ThBAUmdePNA6+6TK5HOV2aiQ6/PPBIv00GrU3Wl5XXRVarGY297JAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/rmX5SaleVT22SXUaqzcso9b/SnJrXyC+pjCMv+/l0=;
 b=KWpS9hvGraM2g5nzqBkvMwbqXqt5RPKotmMMhSlqBwPRiH4Zuho9Cjw87Saf+SDRatCseuGIDdb1NtUXaYNM2b1PKk12oP77RXDhxgZzh4YqroAxvVohECkFCmLAmGMrsjqBPP8qSbqXarkMHI8ve5q+VGKZsxz7mQSEbx56cPsS9XSEQ1dHTWDu4Uv6y7kmE0HUPmxXwPkf7LeBkyABHhk/9XyV0k0yGzHp3mx7lzmeguZFaxbt5R4oiLkM5CCacTjiMB4IRi1AtvI9cP2KA7byT7LataTf0Qph7N5dKBaRTp0lbDSv23unQ5QZ+rSGlW3GCO51O0JsJQlaU2ttRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9)
 by AS8PR04MB7719.eurprd04.prod.outlook.com (2603:10a6:20b:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:23:36 +0000
Received: from DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5]) by DB8PR04MB6858.eurprd04.prod.outlook.com
 ([fe80::bc6f:5fd7:462:d0b5%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:23:36 +0000
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
Subject: [PATCH v2 1/2] of: export of_stdout symbol
Date: Wed, 22 Jul 2026 12:23:20 +0900
Message-Id: <20260722032321.2693300-2-Zhipeng.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722032321.2693300-1-Zhipeng.wang_1@oss.nxp.com>
References: <20260722032321.2693300-1-Zhipeng.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:EE_|AS8PR04MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd92867-d9f3-475f-5d96-08dee7a09dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CdZhhgJGilfvDcnZOuxo3NyRYOVybSQa8Rcltd/dYcIDXsQ4k5Hi52HZEF80T8xr8VbHXgW2XzsN2V9Qxc7WDO/TBf+Sflv6rhAHnBrqHZp8a+wb/F7sztjv1gLv0ZzcbhfvXvpJ+bEb7srS/L/Q/b4P607LXv6OlnvUaBeb8eDrVYe37viLbigLBm6ezbyWn//8586fsgOFQrYMY5cc4WlyGu5hcEg945MyRxoiNNUUtlgsdnQ1/N4CuUwHVoPfeJLqNVZ8X1pQXEEBp6Li6/2k1iOcgT44YdnoP1tciMa4QrTe1QM9SLNlOhsvXfmwv+df270AF1gQbmVYmxdauDzxd7tOIwtZGfFsl/KBRGJcgsunGmBN8lPOOus68el+p+q8z27EN0/yq7lTM9yR/VJmMk0ku3Y/NmvqhxQdEDGC53Z0UfIqBIHZLyC7KU85EHeASnAWxp3jb+gRkOhN21jygk+cAEm/sClpVyNMRaAbFohOUSTyveyOrNxPgLyoXiGES6qT1I1MI9IkT0Vyq3Z+KIa6ABWEwABXZZkp4UfhgawJ6o18klLVtyvYaCkc689OdeBTQKM+wos2MiwYHmYeZKcpWNe80URqkeKH42joh36yGDTwp3XEAMezyF6ooSiULOdErWbz8yKoaiKDOKwpnkjl4yvnHhxT2E0KkuI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcQQFEKlTD+vsqczq6EY6YoRsIMKCjAwxJjLC0zUZf+YTfjQLj4hBfSIHq/R?=
 =?us-ascii?Q?SBU7qabAuuZPB/RtsJIApFKwpz/v6Zj4tKfcfleGXRsl+UDgJ49QYbsNkTqc?=
 =?us-ascii?Q?Jle7mxyqbGNUAoq4gB+Zin/eEy4J1GipB3uuA6VgogEytsb+cRxV2+1KK/qN?=
 =?us-ascii?Q?7pUhTuLV4GPzASzJYiSFvMAAGvmGqQh9e9IY62oaMJWE1G/CiZcLlqQBLt0Z?=
 =?us-ascii?Q?uxyaAiCtaQebgjCXMAR7VHHpuaS3hPwcxYTA5Up6TBj9iuIleVyD02IXCID3?=
 =?us-ascii?Q?jru49WmLpwRev63pnxzLIZJusz/ILSJZgO+kLZPrgE4dgP8DfLasbxGDLSwc?=
 =?us-ascii?Q?FVHs5nlsviDTm0bCkQumyhBoFfprD0jgdTrYneeAzwJs7Rvc+oO1B1DlEbHv?=
 =?us-ascii?Q?wV+fkxyQGUdFQVu6onPlDQVGDPU1b0Hw+gKmlUbYjB/JK3Z/xQgC3rFFeoRH?=
 =?us-ascii?Q?cgrSTjd1UwjRi9Jf3G1cEvnsKUNtaHKaU+X/Y45auvHM47z+ZX06D8j+Zv25?=
 =?us-ascii?Q?J48BtVip40gLv+c46Q+5jVPLARjsDmiPpk3PprRphAMYNhWsiu86HgU9OSmi?=
 =?us-ascii?Q?rQCyIUfStEp5Ddp/UorYltsoW5+41UCV8R3ZJ3sci657d0OMGHB12+sYCOPi?=
 =?us-ascii?Q?WD8izD0hGQ96AuM71RoD9l0CBVmkSJqX3ls6E0xGxw+o0ndm1TCqR05sCdXA?=
 =?us-ascii?Q?gS5fUpnHPTZP0gr0rxk4YtvHviYZVsh/ugIJT5Cu4vquhvQlhKBFL9j5Cuz7?=
 =?us-ascii?Q?ouo1zn8qoikEYcfmTl2Fet0RkYfDdTRBN5PrTpAV5Jwm/NMa7etM8T942tUH?=
 =?us-ascii?Q?FUDs/Z33AhZNN3u4yxZN9qj/qRKkGEDcg81PARJUern8HPlL0KukYT0eAMjq?=
 =?us-ascii?Q?QwfUu+7EGfXQuUJOyWVOnU8TO/VgwcF2rNHvviG+Zm67XwB8oxdhHN4saG4i?=
 =?us-ascii?Q?ngwv2KaZkydPXI82notc9WCUCW6bQCsy9a4dvMOUJrzh0VO7GobxA33aOUby?=
 =?us-ascii?Q?p30+R2Oc+VxOrJteNryvGpCBP5u125RL7jYk3Xny8Gcy5TJIscJyYna4RtXC?=
 =?us-ascii?Q?6cg+WXx8MY9op5SQe47pQEmywUZvLIv6C0mrxe6vgwJfxgn/5Tm3kMZcoAMz?=
 =?us-ascii?Q?IXoOi65fMjSx1siQanztzcGyNmXmdxvq/JqM0NDkeiSpIMnBQh08QdXJ2uY+?=
 =?us-ascii?Q?bA2WPJmnnxhmFw7eqvCMSaalX9LEGj7gHGHmoHi2BoEzecWCmSb39LSxyp6p?=
 =?us-ascii?Q?DW7mml+/3spTju6iXBVzKyFFB6kcniZST221fldlFRvC6zNA/4bhYFrZzA/L?=
 =?us-ascii?Q?9Hhc/GFEUm/7NS4/vLf2cRO0C1fOTpdm5yizFKnTBrDlDnSYnrB0O+Z4uwVM?=
 =?us-ascii?Q?8jybuo5/smdgYKk0xB82RUQXKhSMRdLVTbBZCk7ifwHTTnXJP3XZtZzMA3ed?=
 =?us-ascii?Q?CqkQ5TDkACFjNA2IQa/iUMoAomN8WLFS+DuTdV3BKNFfFsuLKpdgEJW2Wlzq?=
 =?us-ascii?Q?m/oKDnm91pEkWzZZBtkcqv9jWWwKxWfMWGX+O3pWosAvzatKdz4BMRZVQ7y4?=
 =?us-ascii?Q?YoYJn62EgJWIxPScVyCJU7rYVjWBeDWkYSv41YLmwQSkQBMCdPJklTzlcF97?=
 =?us-ascii?Q?NiECLksL0vjW0Wdv1q3lt2+CA19Kk+VdP1u6krCYDhTKRJm+41790ZFBNwPF?=
 =?us-ascii?Q?9mbKhlXf+Lr/iO/jO9OGK1dqmeHxPTmdXHPgKLZlvbaO94MuHAe6cu7mzWPo?=
 =?us-ascii?Q?ERVzb80nKTpWZxf7Fdb1+N0yJfT9N4iaQ5g/J6eu1ECv2KAKteEa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd92867-d9f3-475f-5d96-08dee7a09dab
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:23:36.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Uc9GYrubgAAvHR1xDS1klDqbHHobjJjNFd49M/7qYBHslEEy3L+BZncWYCS5d7i+HE82tl7idUUv7xHBmuNcCt5l9Je16UNMPWq4qrZbCpt5FUQrO9oh9e2e6Z/4scG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7719

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

