Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AF1925BC;
	Tue, 21 Apr 2026 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757222; cv=fail; b=ZBkRH/Q2yF1GrDa1gA+3skZUcX7hmMgcGYTmAk5UJfnGTrhpNKahwm5A3DyYZkoWHC4/K+8Tl/0OX7FKddH/cLV7ljMkEKQekNAzIVponqszlZloi6wZn7ecA0CQIi0YyVNBZNr5k0QRhKysss0P786Tuz5g62cFxVMjDnhRqCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757222; c=relaxed/simple;
	bh=EKJCyKZFqoN9OpGmkvj+hYMdFgA8LmJu3fpShLfbBkQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FX2Y/dRrQHMKQVsQyWyxl5Db6iTF8/v7r+w3S6JOve/a45ReB9Qc05L4J7yqRD1FY2m2ddnpiRVCt16T8jYQ4ExvH90Q1L8FCOznPEQgV4yNIIFbcz5xAqO7xZ3sPZHguBpm0iKID9QlC9DHUh4yk4fBVU5xjc3NyhZ0/p2LapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a7BflkSu; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7BflkSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSh1P3Tb10ezXbJ++2zvm6Zr6USbuL/D/E9QFexKlZO1+T6kNSToiIVRZbeI2tEMLOQLxBj2alT8r5r+Kj2sk/3D1z4A4/LB88IRomjdO7O8Dfhjaxqq5kjSjxexsppqZj+KsvUs5x+mtw+Cxs/GFELgma/4FJrJz0cY9A/CcQpuDUwigXof34xeE0OxRJtgqIRYQncUj+yooGn0R8N0RA8l1/reexxqvyrV9YmSohMfivlLTS95T0ysQ5VfELviK9IwxLxEpbxo59VYR3HutY+S3Cb0UNyuHWEKJJcVDo0BWmZOw+dEcRx+/Uib72Y1rdKHO4Qda9tWpIok2zhYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/8DGJr89eq8LORsYUQxNAfQ3X8iGHoKKxyQV0pnqws=;
 b=y8EqFBfhSj42P3lPHYFXU7n70SNVLsYzozUDV5OMjmAsUGKvnk2LLewaNV3y+SmDINMbkG8LqcNH2b7Q1bcL6QJZ+7LZVAcmdpjDEidUCzqAXEFG0vGVXBb6dcKmFKhWwSCn0M1oxej7KQbBZZh7Dprjv1QMvYxL+wNZkif/xwrSnMlkVNoWVv+NO+c6nXF1WMIp3qCE1yjUswpDyP6tv6wfSL97pB19F5BF/0LO5hBC5lX8m0oKLjByYLbFygPygDTH22B9ylpezRp/qlEuwB9ZfPU4y0I5lB42A6dn7OWw0pX9faQC0kfTu9xvIPpYiPaeUd1HKJG/RcdnfaWgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/8DGJr89eq8LORsYUQxNAfQ3X8iGHoKKxyQV0pnqws=;
 b=a7BflkSuVROxos+TjMXPK19yfMBOvQSuSkc14Fw+O1ezprbBPopbKDaSvefUGtpm5Fl1AAn81jr08MdqxPZBxPy21PRy1ed+VZSxkH/Mzq/Yekp4OxRxaAznHFX+Yz/BOWIIMNa4UNATbfJ/GMm16rnup1B5IahvR0gRUi1NKPYP6ygg/4LS6rPhjLFuLimM/LPf9DWAxS7bScjAFKo8ua8KB7uz0hzvWmdLjivN5AGYlgEmcWxG4RkL+Wo6B9QCMXIlKleKZzPZxDC3ayNqZRUwrxD99Y5Q4Ix/l7N5n1SZo1yw9gO3noTRi/qHKqihN5s5YJDywIzNLCxM0hIgyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:40:16 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:40:16 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Tue, 21 Apr 2026 15:42:24 +0800
Subject: [PATCH v5 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx93_tmu-v5-3-05ea1969bb9f@nxp.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
In-Reply-To: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
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
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776757357; l=5236;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=EKJCyKZFqoN9OpGmkvj+hYMdFgA8LmJu3fpShLfbBkQ=;
 b=DW0OKswqg4mh23wT3EhSPc/tV8Da93pwm+t4qRarfWltKxW7q1vshZcopg1MjQMUwTbp8CMkR
 FdMxS9UbAWaCEdrWsZYiCddxgMZEJMSO8Gy7O7Pxltvnj5fa2Msd99s
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 2142a960-84a2-4752-5959-08de9f793b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zxvQjAcX61rG7IST136KpJDh+57BWGsOai0KDc5jb2vk0KS8026VpU2wpStHnooo48VJn186I6VdDHUKNJPZkB3RrarQTqhYk9Ea6qeqX9AogbYuzIXFWna7xuO/prb4SmnwLeN3s0T2lm4KfE8YfLq61JcX7En/vtV9SEsG/vvs/A3jcF4Zywhn9lsevU3nYa35/o3kLQaSlcPIbXvWFzN9Iij9TQGUbgFlXQptV8gUVlaQZe+EEGXMql2dtJba14TRGLvCLVfaRbGwRhTG8mywZoLvH20Ax2+0jxIgk3ZTFAedF2E3DEcEcwKh4hpyt1e7mN6FScCbI1XPX00kdmBoYr8nESQeymHXM+n0QaqTQ/lNoZ5cYbS3MnGtdH0yqy382TvdgCs3n/Q0DEySPFzkw4gerC9rjRi6GzRTEssvV9Q4BAT8ocjTJEF4iGI/+kc70X8h2xKfr2QO0w87dDbJFdx6bx3g0YZCKJabsN9tDW5nRFLrB7bpHhwFMAIfxJQlfMdz36kzgCFpA5ChMtiL5kvxU2EGxhP+8x2CssMPYSQlCjuklTde1TfGP90Yo51gK+Yj4wNtL3StaEWlojpz6AkEGPnLd10/e/0H4RUBINi6seJLBvn84So1pnZ7R8Pke8NUcgGIpZ5mqQFJnjllRVH/zFUTXLQsQIXDSccawigKAnQCzhJ+ZIIuxm8k2WRLqMLhWLa8LWuRJJ22cDQUTGErx9Wu0oiD985bypisM/6evcEQJVE0GWehkUxPRy0XqAUd5u7RWjE1oUSdCksu6eFbPysWHbskGuWftlh7rUP8VaS+18bYVESX/r1P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBvbVVpZ2FqUHMvMFpvd0VvWEJjRFJtS3BSM1o2REM0YnB1emFCZ3VRa0dS?=
 =?utf-8?B?Qm1ja0JaTitlQ3ZVdHFnQXdxc3Rha0NsZ01sZ0FHWEM3RjBoU3JWYTFlZWRu?=
 =?utf-8?B?Tm5hU1laLzZEOFRGT3RtVXJwNVJpSXl2am1PY0lHWVV3TWN4YkNFcVlsYTBJ?=
 =?utf-8?B?SlR0OGZNVVhsNHJIYkJiKzdSUkdkSVlPTDczbEVSZTdlcWlxRkJSYU55bTho?=
 =?utf-8?B?K2thalY2eWdqZkFFN2dkMXRLNFZCUTdFNDk4U0EyZDNRaG9iN0dmMnhkWFp2?=
 =?utf-8?B?bCtEVDRXRk1Xa1NrTGtVNzhkUHlHaHlMalc3MXdSdnIreUsrRVhsanA4NTYr?=
 =?utf-8?B?clB1KzkzRWZFbllnUk04Rkd6SThnc2t1d09zQ3FXcEgrWnJ0a3RPTG45ZUZw?=
 =?utf-8?B?ODdRYkNOMmlvQ0x1b3htZll0RzV4TGdJQUFxYVB3akpZcUJPTXBNaTQ5YU5i?=
 =?utf-8?B?UXBFUlFaQW9Vbk8zVGd1aEhYRlpSTDBEbnVMUzJRZGZGSzRlVFNQYTZNK3VY?=
 =?utf-8?B?UFBaeVRsTWsySUx2cmgxMnNYd0djbWdVcGw5RmtNMHNYTEFadlY1eEgxNCsz?=
 =?utf-8?B?UkRoMm4xbldnMW5VZ2RFdWdZWUlXWFBiSEJqSmtFQWlSN0JKOHdyNEpOclkx?=
 =?utf-8?B?YlNGRWhYdDFweVF2b204d0RDQ1RoZGdyWGUrdUZ4UjJWWlNjNmREMGdtZjhs?=
 =?utf-8?B?ektGVkg0c1N6Z0t4c3dyclpLeGFDZktCd05Bdyswc2R4Wis2STZiL1BidHNR?=
 =?utf-8?B?L2VEdHVWQW5lV09obmNXRWVic3Y5K1YyQ0ZIUVVyMCthRHY1WmZnanRpRGFN?=
 =?utf-8?B?cHUzRkRmZ2cxUXcyQkNSSGZkYmdXTldYRzNrNDlpcWJOTlZTYnc0c3V5QjRa?=
 =?utf-8?B?MHcrODRqUkx4VXFxVTZhUDJ0MXkzZlVFOGF1WTlYT3ZkSTB2dlQrdzNMd09p?=
 =?utf-8?B?Lzd5elBmaW5YRml1OHRvTFQ4eXdJS3NUQ1g3bUNuY2VtODE0bXpnQmZlc1BT?=
 =?utf-8?B?WWtHU2dLT2lmVmhTcUhybUZ2QkJDcHhhcXg2Vjd6SHhFTzlOcFlOcXhSZkFM?=
 =?utf-8?B?dFN5aWZrZ3dCMzNCWWpERExjNVloNWtEbkJMcHJVY1lNeExHUFZhZDM5L3cw?=
 =?utf-8?B?S0lDaVdZSkMyTThjM1A4VUMvQ1RRTGQzdVdPVjF3SmxYdS9DWWZvSnR6ejNG?=
 =?utf-8?B?Y0ZDRlltRFNuRkJsQ3ZTR0dTUzMwT3FOM3ZMVDl3dVhaaGkwRFdOUXg1UFZ1?=
 =?utf-8?B?SzJWdDUzaFJqcDNEaEJLMkJpeXlpU0kyam9UaHVTbjl3MWJzODkrNzBwSExh?=
 =?utf-8?B?QmJxdEVzQkhMcVozaVlvQTBQTmV6N3ZONVFYR3RUWXZXdWs2c0lNYWZwQXJn?=
 =?utf-8?B?VEV5WmRQeFhZVCsrY2U5SThMZUtNdnVUODNucCtubHVpWmwvcm5YU0hLdHQr?=
 =?utf-8?B?YjdpdnJDQWMwVHdWTmpkUTdOUDdlTmpWWmRCcjkxWDNkdElSZTZHbTA5dnh3?=
 =?utf-8?B?MFNMUzZvQ21xcU5EaDc3SFVyb1RLMHZpYVlqZmJEeVl3SVhGTTRlSmpaZnhq?=
 =?utf-8?B?RkNramZ4b2g5L1RhU1dORHVHZFZkQWUrRTlYQUR3M2h6ZEQxVEtJOG5JSVRz?=
 =?utf-8?B?dWg2K1dqWldqcnA0bmIwL0x6bFUxYVdTbTFJWXR2dDRJZUdac081RDVnTGNp?=
 =?utf-8?B?NFp4RjJuR21YdlhtOEEwcmpwQUc1UkZXU3Y5cXEwSUJvYkM3Nk4xYTI2cE5S?=
 =?utf-8?B?RjZjYWFkZVdObmU5U1JNdlAyY0trVU9WQ0lGdXhEYyt2K1kydGh0cmovNFRR?=
 =?utf-8?B?cy90bWlNV0szTDZpZzg0VjF1RHg5b3VjV2NFeXBXejQ0bk5ZeEVya1pzamlW?=
 =?utf-8?B?SDJzczYvQnc1a1VVSlFxWjJVdEVvZ1N6Um1LUFFEbmRBTkJuT1FaUHZYNUdM?=
 =?utf-8?B?TFBYNVBXZUljUFc5QmRhOW9FRmtJZ0RraUkrZG5DVkoyamZxQnFTNTdqbFVO?=
 =?utf-8?B?YVVFTDVNUFZoQkNjcVBsMk8rYlN1UWlaRUhkV2NyelR0VU55ZUd5MjVKLzNm?=
 =?utf-8?B?WUJMNVBqamhQSE9MeUgyUnlkblUzYVF0Y1ZidFJ2d3ZSbDJ1WVNIYzh3RGtL?=
 =?utf-8?B?Q3pyNVIzWVBWRWFDdVB6Mk5pbldOUk5ZdkpZeXllb3pWUTJuZFl3bndmbFk5?=
 =?utf-8?B?eGJYUXBheHc4QVRvejN5ZnVTN1kzRS9xNUV4N2RQa3pGQmYvL0RTcHJhanRj?=
 =?utf-8?B?WFJLTjkxNU9Ca1A5akd1MCtIaDU0MENnY21Sbnd1Sk84T0o2ZUdlVnNuTXJT?=
 =?utf-8?Q?K+DTCk2AgsF0Umaept?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2142a960-84a2-4752-5959-08de9f793b36
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:40:16.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGONedpDbk76wFzspUvVHLR1ym3snaJGhchr9LaXA/Ahki8flVxsJtbXmMq2pxV7x4K82UkkJjvIjgp/VoVZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

Invalid temperature measurements may be observed across the temperature
range specified in the device data sheet. The invalid temperature can
be read from any remote site and from any capture or report registers.
The invalid change in temperature can be positive or negative and the
resulting temperature can be outside the calibrated range, in which
case the TSR[ORL] or TSR[ORH] bit will be set.

Workaround:
Use the raising/falling edge threshold to filter out the invalid temp.
Check the TIDR register to make sure no jump happens When reading the temp.

i.MX93 ERR052243:
(https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v5 changes:
  - replace the check errata macro with inline function

 - v4 changes:
  - include bitfield.h to fix compilation errors for RISC-V
  - use macro define for temp rate related setting

 - v3 changes:
  - refine the code with FIELD_PREP macro
  - add errata doc url link and refine the commit log

 - v2 changes:
  - no
---
 drivers/thermal/qoriq_thermal.c | 49 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 297a855311f3d6a8d527794abe17ac86c47bf152..57c712b9b359d713f2ff4926eb890a0641aa96bd 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -3,6 +3,7 @@
 // Copyright 2016 Freescale Semiconductor, Inc.
 // Copyright 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -30,6 +31,9 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+/* errata ID info define */
+#define TMU_ERR052243	BIT(0)
+
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
@@ -45,6 +49,15 @@
 #define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
 
+#define REGS_TIDR	0x24
+#define TEMP_RATE_IRQ_MASK	GENMASK(25, 24)
+#define TMRTRCTR	0x70
+#define TMRTRCTR_EN	BIT(31)
+#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TMFTRCTR	0x74
+#define TMFTRCTR_EN	BIT(31)
+#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TEMP_RATE_THR_LVL	0x7
 
 #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
 #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
@@ -77,6 +90,7 @@ struct qoriq_sensor {
 
 struct tmu_drvdata {
 	u32 teumr0;
+	u32 tmu_errata;
 };
 
 struct qoriq_tmu_data {
@@ -88,6 +102,12 @@ struct qoriq_tmu_data {
 	const struct tmu_drvdata *drvdata;
 };
 
+static inline bool qoriq_tmu_has_errata(const struct tmu_drvdata *drvdata,
+					u32 flag)
+{
+	return drvdata->tmu_errata & flag;
+}
+
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 {
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
@@ -97,7 +117,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
-	u32 val;
+	u32 val, tidr;
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
@@ -122,6 +142,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!(val & TMR_ME))
 		return -EAGAIN;
 
+	/* ERR052243: If a raising or falling edge happens, try later */
+	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & TEMP_RATE_IRQ_MASK) {
+			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
+			return -EAGAIN;
+		}
+	}
+
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
 				     val,
@@ -130,6 +159,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
+	/*ERR052243: If a raising or falling edge happens, try later */
+	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & TEMP_RATE_IRQ_MASK) {
+			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
+			return -EAGAIN;
+		}
+	}
+
 	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
 	} else {
@@ -247,6 +285,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), teumr0_val);
 	}
 
+	/* ERR052243: Set the raising & falling edge monitor */
+	if (qoriq_tmu_has_errata(data->drvdata, TMU_ERR052243)) {
+		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
+			     FIELD_PREP(TMRTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
+			     FIELD_PREP(TMFTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+
+	}
 	/* Disable monitoring */
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
@@ -400,6 +446,7 @@ static const struct tmu_drvdata imx8mq_tmu_data = {
 
 static const struct tmu_drvdata imx93_data = {
 	.teumr0 = TEUMR0_V21,
+	.tmu_errata = TMU_ERR052243,
 };
 
 static const struct of_device_id qoriq_tmu_match[] = {

-- 
2.34.1

