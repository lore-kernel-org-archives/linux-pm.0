Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24861376A1B;
	Mon, 27 Jul 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138140; cv=fail; b=c2dKyI/unMSmWnBsRHDtxzlJM/BabG39IstT0GWIpS1aSqjMiN3eAMY8MxKt4cn+lvttDaSyWxgEqW/uJuZbcW1XFx5FZj4+uVUiWwJNgc7e1GyjbE9KBti+Or3xyOXF4WXmjV6kL0+sQCmsUY7x5omCIfVPjFNu99lFwfd4eqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138140; c=relaxed/simple;
	bh=bBTwnDoZdMOqzYXoILhXlhuA5G1ti3r0gY6QMNid4uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CETsGe58EaHGDExhcmJcDLw+lDaPjq26gOFK/qVmDMi6vVenyYsD0QyGzgjrcJkvuHMnYRYxe/iOufRsq4eORS6QuxbS8OA9kpPXTK7lhIgE/xxZnz+LeIzHF00v0whZEmJ2qzwqleUgJbvwXBiRG1heGYty3Mo30jhKOgCLpCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t3IItVna; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t3IItVna"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofLo5RsCryPSnQu9E4iiOk0hTT9m0x/oua3kea2lxiftVdfgsiIsHaYO+wEQGZCZx/UYdNlKAMjsjn/csZ0IHJG9uFZWTT2YUabHTxMh+ytHtAkjTK+U4O8L2djVqXWxBisdpq3NOMHX6OznFcQW4wZiFA2pGfeFoNX/LNWJt5G4iEWq47PFYuFBxbvxwDfpnu/Ci7kq4HiQSaLw0BcjMtkZtvKZfm+ZO6Ca7gvRlLg50n2f4c1ohhOAPQa4tlJXHDq3LBDhVxuq/C8HDgZPyqelMgVAXiNJ3/2Q8q9Evbw4hKDp2GT2SPetRnEv3hHq0YR4K7y8tH0CgILMjFLRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBTwnDoZdMOqzYXoILhXlhuA5G1ti3r0gY6QMNid4uE=;
 b=ymuIx0MRCw55PcdK5QQvbelTRotbmD/ciVpbVt9IfMY06s50imycdIAXYRCqndjGYdJ4FzoQm8+uO/wcX4a3bOMvZuBGOJ6alZCG4aVNOKIuvuNHqZqqojNz5byYA1ROXRBmMSWohw5jsQ+YC55j/L0IDd6qR4p6Tu9DM6t3PVqGobvdXJrV3wZIo4n3pUFwBAU1YwuMpc0Kl8jxA/POjJgBPH1KU5Uu6huvUrATzCNczlX92EC1lKwE1EyoCLCFOJHB1Nvn8qz5uSSTrjPL6ddA1EvtSSUHBZYVHYfwQX9YjOMzDbiHn+lLUW53Zx7Z5y6yb6dp9JAIpWgipUgkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBTwnDoZdMOqzYXoILhXlhuA5G1ti3r0gY6QMNid4uE=;
 b=t3IItVnaqh1akVdX1CqCb2qvJ9rkFxCW6EBOBj2FG/P7JEp+uqHUeu8avQxG7NJfvVo5LMDs3/+RMtK6ALsdFCSIyh25Wx+DIVY+t0v7fdhqKRPxv24MUWcs/zVnj24OwOReFrFFynsQlKYmz+02VsDQ+wa1Gn5ZYngtiBQsJMpvA+g+skOwdQlMDvbQINH3G5r6kaZu1uUgNHs0TsoQB1V+npb8sWct11o7knNDXIW0dlMRZv7NelD8QeZo0UyWjonwbR6OTQwS/XdQ/fXD80MydWTTqq05I82LHt6Ra3sY1YAMUHjlG+1VUqSpIXxHBFPtI5YX8P4uUhyDD+2ZLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:42:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0245.010; Mon, 27 Jul 2026
 07:42:15 +0000
Date: Mon, 27 Jul 2026 15:45:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Zhipeng.wang_1@oss.nxp.com
Cc: robh@kernel.org, saravanak@kernel.org, ulfh@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	jindong.yue@nxp.com, xuegang.liu@nxp.com,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/3] pmdomain: imx: scu-pd: allow building as a module
Message-ID: <amcMtNFqcfb40Oe+@shlinux89>
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
 <20260723020524.1886806-3-Zhipeng.wang_1@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723020524.1886806-3-Zhipeng.wang_1@oss.nxp.com>
X-ClientProxiedBy: JH0PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9bf07f-b083-4b96-1935-08deebb29399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|19092799006|366016|56012099006|11063799006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gi5na4xEZumUNzOw1UilLaZzYdCGTKxZ/TSPYueiVfzxM9yDVWMyWJi0BvFvXt+1TMotyyh3GS1Mk0Y0Xwyg13aOHVM62FC77UF0izVv/+IQPFRtXwWzs0lEMCwKYBiqKSgPyHJ0X7WbrV+QKPcyPImP9nfTbfi8UCMariRvzkPwFmNH1qkQBLbWCjFh+ZhGjtxnx37gnHaCDegsvKA/6em2Anq1be5YSElUYrCtlGumyCyzcjWGxvg9Xllo+IrB0v+dH+d6/kQ5qtS7ymAK9Jc1LqoYsguBNoVJnkTmy0wTG8HFTlzKAStIi8YmqeeAvJ/iTyFxriRF4vhe8P6jWCC2/vhBDFbmw//q5FWaeDWfJI4E6ksa9c+5mBPwCk4jsVdoPRNmHXEfigzjvnImf6P/49E/OP+M7cEtn48nVHUfmICZiw8NITLuB/1gb49mjNMZSl7kuxENOO7r63lZw4MmklAuQLg6HIHodsWtYyAzEH1gcjv4dXZPFX2rSIaTFDQnifksVgf2V101IObZTAxai8nIF7L4AEwypY3OqHxw5EJbQYAA+f+399HEcE9jpzKhQ8DL13JprJLOqxXknDu9EtcPKfzToZ/frPkiF1YcoTyLBKp5GGMmLEHf17o4S/z7VqJGa20ODFrLeobsRVBvQCxe1UAvfa+mrnTzKYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu1QBU02MbFEbaZGwnkqALAJeLBUkNisklSM9PG2MyXlUXBkWmjzobf5IaOt?=
 =?us-ascii?Q?pB7u21g5spPUd35fiRM2IMeikgFrrjQEgZIRKQKZel5Y6p3GIu5ikS2VKlAy?=
 =?us-ascii?Q?ZeF2KtI2E/Gw8o3d66p3PPi6sWZdd92eJ85/03UMDSPB9q/y5OxVtdpVpdik?=
 =?us-ascii?Q?F13z1uK1fEU3h0cPoutHe/VQizW7yQdD9K6rifHM6GhilMnfsrwbjLitCAfR?=
 =?us-ascii?Q?KNau+uvlqi/f82ULhN+yKF6ymJgWQUXOqI2bIiPmDNk+/sVpy4ouEZmuE73s?=
 =?us-ascii?Q?qz1r6h7eLj6NsHGKV8gaCk4Mp4iPDI/ln1WFM04VG/SYl3hA2G4esVUfTQiF?=
 =?us-ascii?Q?Hpc1Z0ULuB8AeqsF42nZfVATsWVHwnqM+eWpo1mDv5leIYgnXNlE60yaOmu6?=
 =?us-ascii?Q?GtSVNtlLOJ2ujTRVWIAC3PASPQgTs3BqDNciHqMkaIn++wCDB0CrffSPdIEd?=
 =?us-ascii?Q?Fk40VfHk+nJbBu52ybUvmc4UASNWCBlWceKl15Au+cz305yXwdtGlkKxbQVn?=
 =?us-ascii?Q?fsy79fVcn/Y0GtqiHJ6dMSYDrgKigOXc/VrTf8ARModWq6m6KamnFgYKc06J?=
 =?us-ascii?Q?e4rabqXyL5Kd8E2ZFxYZicXg8A4LmEXa6EH3S2OdUebhv71c6mrlRFSO9Pze?=
 =?us-ascii?Q?usr/dl7tP1okRQLf0oe0xiGF1el3uSCFe1Tnt2IxEfKUr550CJaotmAeASEY?=
 =?us-ascii?Q?vHx3I0/ZoxG1UJ+/MMLfpw7LVpinTUYMALlENLvaWIB4iAJ6UZ8toZqa1zyh?=
 =?us-ascii?Q?d2p+uP4jShryIuNC+Y8xFLajEXkx1KPjBhKfDSLAXc5D8ulVaQ/0X3Rl7VaE?=
 =?us-ascii?Q?sV3CUN54S+XkaW+yyY8Dcb+VrmdZdb2nkZir3zHhlVrwZMUrb8GthMQweVp0?=
 =?us-ascii?Q?jUaXVSP25ukGB0uPkwrenUDLSKx+fxgBiNBXmp1jxpIfYypqK7YeiKoz+GUJ?=
 =?us-ascii?Q?4WYNHeag8tY4q4pCfBfDRGDrCQXlqFv/O3aPPTVuTJNS2EX4G7bNRwbQ8wkR?=
 =?us-ascii?Q?VVUJN3MXeMuEvqXmSwSKRJj9qMJ7gyzt4cDbcHeBUj6rlZy/tqco6ozSOkg5?=
 =?us-ascii?Q?fa4y/G2VMn3cc6D/AD99dHDqHzj70xG+Ydwkrq3uBjngSmIdfLPogw7TI3J8?=
 =?us-ascii?Q?Ge+u8WCl0WXOj945LhrEEjJJyz0JzszJoj6UM4mRBwZcZFNqsXQ9JR/OQpb+?=
 =?us-ascii?Q?oXRJyYJdgwtBh+XyyKcj3cKdQ02CBUmqyjjlQPAEdoI5Rd8CChQXvzyAH2mO?=
 =?us-ascii?Q?ENlGB8Brf44NnKY/nb5R4zim/Gzn6Jy9xeVxc71RwuMt1Z2JeGbNzer4gy5A?=
 =?us-ascii?Q?TSqIcqZOzHrgUIuQjlvPp1HQjcDEQZ3RBoVY83fG7H0IwDjtBcBYVxXORTX3?=
 =?us-ascii?Q?V68W0IBI5om9hcNbNOhTT2A4wYvaZza5jtz4qiErn2IYm8Akeb3po/A1ybDN?=
 =?us-ascii?Q?B/BYQf8xqyUMkTAFoGi7tKloWJgnSkVzglqkt3FXKYfk9qkFv/zxIMLIHfmv?=
 =?us-ascii?Q?PnCI7riz9lRy4tMJjLOCKwNriJCXnnpqvQLbP19wQH81pNRV/kQHgKZKsYOq?=
 =?us-ascii?Q?tc9VxtnDxgXlTV1swKvjOSlJvYPwZe4ziX15c5fEFGkBb3xn0t9pSRf2PV7r?=
 =?us-ascii?Q?fjWG9qTAUOxBxTMdHkdVuzweEf3qGby2s0MZEoOGse8nFsMx7VhCz90YOVcF?=
 =?us-ascii?Q?Jfkj++2pzvWOk7S+4YrDD32gQxuiUMOtfKeQMQ+AhtG7z4vYjqWVV9r+H4GY?=
 =?us-ascii?Q?v+OavM8fscHhpNYo1n9MxnMlwysrZyMQG8zHvlNBHWd4UhWpjHfe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9bf07f-b083-4b96-1935-08deebb29399
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:42:15.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEzuRODzoPPJpfVQZEkHoPreV6PQhkN/xLJK6J8Ntlt7KVONKKG3LVjDcAWwGVSazn/n5M48tYX5wwEluJtaHz7rzXDwY63WkvIkuoZatqEsEPz824HSRzJyjEyz5l2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

On Thu, Jul 23, 2026 at 11:05:23AM +0900, Zhipeng.wang_1@oss.nxp.com wrote:
>From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
>
>Convert CONFIG_IMX_SCU_PD from bool to tristate to allow building as a
>loadable module. This is needed on Android devices using the Generic
>Kernel Image (GKI), where SoC-specific drivers must be built as modules
>rather than built into the core kernel image.
>
>For i.MX8Q devices running Android with a GKI kernel, the SCU power
>domain driver must be loadable. Without tristate support, power domains
>cannot be properly initialized, preventing these systems from
>functioning under GKI.
>
>Use subsys_initcall() so that when built-in the power domain provider
>probes before its consumers (e.g. the SCU clock driver at
>device_initcall level), fixing "failed to attached the power domain"
>warnings at boot. When built as a module, subsys_initcall() is
>equivalent to module_init(). No module_exit() is provided because the
>SCU power domain provider is a system-level resource that cannot be
>safely removed at runtime.
>
>Add MODULE_DEVICE_TABLE() for OF-based module autoloading.
>
>Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
