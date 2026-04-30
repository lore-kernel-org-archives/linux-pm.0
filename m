Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DD30100E;
	Thu, 30 Apr 2026 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517463; cv=fail; b=Y4RiUCQlxexJap21FIFWt6I2ozL6xw/t0MKzBoJw269/uNNG8kNPR3AbiW76Y+DbQqk/ibe+Zj7KqGNDFf1lV+PuGT2+COWjVLILWgJNb3SXkHJBqf4nSup7BYSlfqxucmLk8bTiL1gJOPr3dyFTch8iU/5rwR1TIIyhjAWf/fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517463; c=relaxed/simple;
	bh=fy+z0/bFhSf/4s/RtukX+UyuWynqdkTYlUWIA8DmpyE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YUCVlk3INlTnxq6Z07fjE6XIXjnXz2IsfzABOXc5gKYXCi41uVSkTjDK7zqnoXj/CDdTeXZddMqjlpHC5EpwVAH29w+06FIO/zr1FztAvatk/+kJ0OzK60xQ3hsyBFzmLjIPf0ezLXSHsCJcCYc+C9osGBSZnU90Q4UFumSAwdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eKhr4Xv6; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eKhr4Xv6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJxxTxlYNActynEHjykSu4/ntJZYpa684m9CGx7gCXLLGxG/aWxOvU8NOTVihDg9s+l9QvSt+bKXnkmiV7OuShQWS4oWbAnAIGENmyp9h87xEXiCz+pea5UsNOACym6ofPMCnC/avYGJ6NBzUGUfnHPJfQhCLYPMLKcfEmpE6C+5F1r3IGiD/NrAAPghelJWs7vTssc2H9OqN3bDtr/RQIMvCk86PFuBHV9LrB4tYr3Ap497ZOwKO3OWk+wDgg+tFpyb1A86oZazYZdk4ca8uzErF50swWr7ZfpcwdpTuSzoaGh+D8q1vKtjq9ElKmtFaQlHNCLHT8LL19+XjYQkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl0T8RtrAgfrgD+sGvAbuhDpfcS7pyPwXSJ7XtQMhVw=;
 b=KnjO87ya4XlDEI71sO2Ef/wXqI5AEHOYpFlG0JdUFNDwBvjwIXstCeacGF0P8QA9qRRuJkTbRUrWSF63cKh51xHbbCmC4la28TvAnBysf3DNxDdr3R5gQ5sj7xKRxESagk/Pv0a+kUw0QVb/VHXiGuy/Qoo2gXBTWS0u/VV8cehFeWkruSCe3NXgXmgijF0kQ+e5uJDhYM1/w8FseJBnh3f7TCogrxGqqKxPVjTNe/kHHY2cZEZlierBcT+VV1PKpXNkJvp1mTjHaGJG/iF6dp3/2LY4Zw1MUC35O0ETymyKfhvCHNuORtcnsKDu+JI25zaNNm3X1ElkPtaMyulHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl0T8RtrAgfrgD+sGvAbuhDpfcS7pyPwXSJ7XtQMhVw=;
 b=eKhr4Xv6F0ez87SAlL8dCBnksigon8ZINGllFvihPKRSZRX3jK67O604Avv1pK2fOuzEM+778JS3A8MVdhvsgQcXXLBB0+AgPyIqdy3AIjO4jrrVmTSEOqipQUxP/ssLmfItBBOxiQHaZ1znWxxH+Bi4DZ532O4oIl197x5NVgC4uVE6LZcCb5uZdfUTZJW++4wluosB/IoMIvGk8C45ulyCIFn3klaY+04JkiolajZrAcJ/QxwuOteuICz0oXfjnvcvUBM7FtUMkZkh4STuq5y1p3NuSuExSgv99rYT84oH14EADxMo6wq35CbPWjorxPqU/B1skA9tCB6dj8SZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:50:59 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:50:59 +0000
From: Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH v6 0/4] Update the thermal support for imx93
Date: Thu, 30 Apr 2026 10:53:29 +0800
Message-Id: <20260430-imx93_tmu-v6-0-485459d7b54f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACnE8mkC/1XOy26DMBCF4VeJvK7RjMFmJqu+RxRVxrGDF1xkK
 KKKePeaqBeyPJK/3/MQk0/RT+J8eojklzjFoc/DvJ2Ea21/9zLe8hYKlAaCSsZu5fJj7j5lTUS
 O9A1r40V+PyYf4vpsXa55hzR0cm6Tt8cCAiEiF8jMikmiHGN/Lxob3/t1LNzQ7a02TvOQvp5nL
 eVe/PFIhwuWUoIsdajZknFQq7/E/v9SHZzCo6uyMy5oQ9QEQPPq9K8zUL06nR1ob5ENNw2Hf7d
 t2zeOGwUDTAEAAA==
X-Change-ID: 20250804-imx93_tmu-7888c85d176e
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777517621; l=1726;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=fy+z0/bFhSf/4s/RtukX+UyuWynqdkTYlUWIA8DmpyE=;
 b=y+lWMQAPptu5Wp/Yo6M8xhTERoJboD2LTge2qDVEw6ULIrSo79Guti27tr4XgK0Mwc3CB9mX+
 bjQJ2gZ4/FtBiYav2ktvxZlhG8LbzrA7SKH9l8kV1PpEHQABhluIr9J
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: beac747a-f4f5-4009-95d8-08dea6634f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	mZgx1etUs7w/83hNdt/MiJnk8F47HVv/IIjBvA0/C+7t2g573eEg9cTUg7rcntPqfcTqylar9T5mEOeYlp1HhDTFhsWVe5N8GB4OsXnPPYKXvOe+p7JpESzULkKpzIdIbddV+10zvm+CiENPrrJYlRQhV57uY3XR4EUgBYARUSZx8gDrqUEDJKwulPW7iYUWvdt+9HXIm/aeTu586Gk0SVMHB+6BchsAsbfli0lGob7T4f+4WwtJYzwqdo1KrBiSmUHPUaFeRfZXJ0g8IS2D+xFXecOrQQFhGIY3rJKRYuAnvVHRsUacWhvYLKJup0xKKuFXXW6tTQ67PQa2XlpK2ibePqeQcCSYHNTorMHQphYXvD4wAWDXCGv62a9mURir9T/Df4lfJ2hePX4mM1rt/og/hFz4hCUB+BQsFZUEF121kL7Pf6KulGnmraeW4Gnm7rvCiEm1eoIlPqKdtvlWKxidzYkKM8QZ41vxe0wJKl8itZEpr6M0X6XgF5Q9M2ETpcR2MEygQAZ/gtFPAT1PSwjFEshk9TvppkEXzXaQey5gfzfRozPF1BS0pRu9YnOG5Jy8tp5M0HT0J6cYJDOVkn3bkJ+vUpL3jVIqrdsB8jfuXH92vKHxH4Ciin/3qPRuuMcUEiGDwPxaeV3TNwWOv/NuTn83AW0CblCLZ5jrvWi5lxbN6PzDIFEHeZ8uFzPlVSt/x5R8102ZzBmEfJNZ0oujR2PJMjOI198zaYkzbMisi68HWEb2z4IJNb6HUY/jIeuO92AfCeOgnjD0jJcS5QF2WWMWPoZM7lxpatlSf53TEEmQ75UClOVUm9st8orIX/l2H+gR0fsUB2/MIPAQNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmVrRlZBNjRBMWRaSlgvUEJVTTRqSE5lcVJNMGZyMlA0YlN0SG1rOTJVT2I0?=
 =?utf-8?B?aDZMeGZwR1ZjRVdYNU5DWG5HTUNuVUovQXZLd1RWL0ZWN01wK0xialhZNGZp?=
 =?utf-8?B?OUZXRTJZRGk0cmlpZHl0NjVYWmhLc2VVTkhXeithSmEyZncvd2hIUElwZzdj?=
 =?utf-8?B?cEJDSWhLRm1McmRLeHc0WDFZZXROSE9RQmFyYnVyYml6aHFNYnc5UTBCNmdF?=
 =?utf-8?B?dXBkdGlFZEthMlVZOER1cW1PRjNUbm1KUWJlajJSL3YvOEpoWEt2WGQxMUpl?=
 =?utf-8?B?Rkc5dmovbXpGU3FtYjdhTjBETDNuQzRGYjJmZ2lDSjR1MUpUd29OK1VUaEtO?=
 =?utf-8?B?eENVbm1xQ1NQR1hwaTVML25VS2ZEZ1hPSkgwQUptU3lldXQ2Z0p0dkZkcTNV?=
 =?utf-8?B?K08zbU91c1ZuMit6WUNTZERCb2JSUGRBaWNXTmZFSnRKdjBoMTQvYXYxeTJK?=
 =?utf-8?B?RkRVSFBocC9EenFTN3Ztc0psL2dWM043WkJheGxLTzJER2xQblpTTERHbExO?=
 =?utf-8?B?RUNDT0xoKzJLSEh3TVlBdEI3L1Fuek9pRHUyNDBwVm5mM0YvV2ZkTWRDVDJx?=
 =?utf-8?B?akZXWE9oRzlWSHRlY09iR0FBb3JVY0loa3BnMUdENGRhaUxQcEZtL3Rza2or?=
 =?utf-8?B?ZDdMOTJTUVFoOEloRHhKTjlCQmMrazkyQlV1dlBETUV6Z25ySTRYMnVRTzBs?=
 =?utf-8?B?Z0UvdnRmL2VIbnZTYy85N3VpaWRTQUZuSGJZbjVUQVNUMXp5cXhYNTAvampJ?=
 =?utf-8?B?eXVjWlVDUFhrZVBMQllxa2RjL1FSYTE2bUs0NkhGL2tSRnphSldIOSt3UTN1?=
 =?utf-8?B?QlR2VUhZRkltRGZuaURHbTgwQUR1QitXTlVUOFRxajhUMzdtalAxYWhEUU5Q?=
 =?utf-8?B?bUlZUlRsdFlEak80NUd1QXIwL1JvNDFuV2l6RDg2T2Fka01yNHZrYmNiZHI3?=
 =?utf-8?B?VVNVNTJHTTRWSU9kWHY4WDlvcmFFK0gwK0FQQ2srUFBIL2lZZFJ4MTlQZ3Jz?=
 =?utf-8?B?OVc1UGY5bVlWejcwVXlGKzRob0p6S0dMekpmMkZ3OGFEbUVWOEt4bUtUdzdj?=
 =?utf-8?B?U09wOGJPRjZTUlhYcG1tMmEvdks0RUxUSjJidERpNGpQbDN5MjMxTXQwY2l5?=
 =?utf-8?B?dkJmWTJ6dTBtUUFRVmxxY2ZaQjJrOERzdUZvaTBqT3dPTGtFaURaRTdQZCtt?=
 =?utf-8?B?eFZuOGdleVU1WldKOFVqVzZmc0NuQXJzalRZSjYxOCs0anpEV0R2SUxtWi9M?=
 =?utf-8?B?Q0VHUGwraER3TUovUm5OWC91NW80RkhvVXl1RFYwRmhIYU5SdUxaa3hCZVFk?=
 =?utf-8?B?dGZuRmdIT1hrR3BZa0dweDY1QTBMVWxFV2ptWGs2T0diYStjOVVUenpQL0RN?=
 =?utf-8?B?TlNJS0ZCWnRkNVR2T1o1bmVBeDMweGNBMHR1YmQ1eTJVWHBERCtJSit0eEly?=
 =?utf-8?B?Q3VpNEpNL2h6eHhNeVYwSFNaWDBtc3EwMS9RcXFRdDVlbkwxYzUwalFyS0xr?=
 =?utf-8?B?bWphcElGc2c4MUpOVkhtMDYyT1l0cWx4di9XRHEzVlJVNmxYNk5GMlFJQ0ZC?=
 =?utf-8?B?WENkTWNDdmxTbWFvVGRzM1lZYzc4L2xMMm1kdHlNWTVxcG90dEdzcEs5ajA2?=
 =?utf-8?B?emgrWXRTdjFLZER4LzgrdnFLWFo2anJOc3hlWUVJcllCdHE0NmNGWHBFT2NO?=
 =?utf-8?B?V3VTL0VHVmV6VUtjaUJyaW54aFBRWUtmRDVDTUR0NHlmRmF6L1hlUjBua2JE?=
 =?utf-8?B?Y0ZuOXlZbFBwaE1wMDlnaTY3cXE3WGN4Zk1QRGgweE1IM1BjOUQ0T29BZlcv?=
 =?utf-8?B?R2VCY2FEWFNxU010WmI2OFo0clVVYTdKOEY3VjBtSjMvUm9rWDhnb2hiM0xK?=
 =?utf-8?B?bGdNWHNKNXgyOEhwVldRZ1FmSE1BNUNZRzV6Qi8yRzJEdGtCQVo0YTZnQ3ZX?=
 =?utf-8?B?OWxUcTA3bUpxTTVqN09GWDNWMStIUGdtT1pKMjE1SFhlUktWQ0I5RGVqR3Mw?=
 =?utf-8?B?T244SmE5blhkT1IwZzc5eVkvM29aVUVORkFCb1d3ZHBUVHV3UDBXZks4c2FJ?=
 =?utf-8?B?bzlQVU5IdFpkQmRwYkRXWFlidWliUVMrZ25yMnVpZktXRVZJdXlEeUtaclhZ?=
 =?utf-8?B?Mm5zME1ITERXN3cwaGRWbnJ5bHQ4SVlIa09sUFArTUlESkVkL1ZrNk1xRjIw?=
 =?utf-8?B?VzdHNE5qNWFFV0RkSUtCQzlFUllPRUdnN2RqUnFYTDY0c3llZGljQVRYZCtY?=
 =?utf-8?B?dGl4TERwOUpNeExycWtTaC9nUFhwM0xveTRxNTVlK1NQR2IyQlo4RE8xNEd6?=
 =?utf-8?B?OFM3cnlsa3FjMFpzRXdsSC94L1Rid0pXSkQ2QzFZR3ZVOGE2WVNQQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beac747a-f4f5-4009-95d8-08dea6634f10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:50:59.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD7YPZijyGlVQFZ7UE3SUzdqRAMWi4LyxAXwEkz3de5/crVp/pStG0f4EpRXwgmpHO9zXpOANt1X5c0FnUeG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

The TMU (Thermal Monitoring Unit) on the i.MX93 requires specific
configurations and workarounds that differ from previous implementations.
So, using the 'fsl,qoriq-tmu' compatible string is not appropriate.
To address this, a dedicated compatible string and corresponding driver
changes need to be introduced to properly support the i.MX93 TMU.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v6:
- Drop the unnecessary local variable
- Drop the first errata check in get_temp function
- Link to v5: https://lore.kernel.org/r/20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com

Changes in v5:
- Drop the unnecessary macro defines in patch 2/3
- Add the drvdata info for each of the platform as suggested by Daniel
- Link to v4: https://lore.kernel.org/r/20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com

Changes in v4:
- Include bitfield.h to fix the build error for RISC-V
- Use macro to define temp rate threshold related settings
- Link to v3: https://lore.kernel.org/r/20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com

---
Jacky Bai (4):
      dt-bindings: thermal: qoriq: Add compatible string for imx93
      thermal: qoriq: add i.MX93 tmu support
      thermal: qoriq: workaround unexpected temperature readings from tmu
      arm64: dts: imx93: update the tmu compatible string

 .../devicetree/bindings/thermal/qoriq-thermal.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  2 +-
 drivers/thermal/qoriq_thermal.c                    | 71 ++++++++++++++++++++--
 3 files changed, 69 insertions(+), 5 deletions(-)
---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20250804-imx93_tmu-7888c85d176e

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>

