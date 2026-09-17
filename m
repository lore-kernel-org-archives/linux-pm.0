Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDC3B42E6;
	Thu, 17 Sep 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628896; cv=fail; b=GMtgORiw1WB+QjLi1dsxreWloJORzIVhBArr/LKZEyJ7qsrWVX9nrbmqRbovzw4UaR4b4xInn7GpqzHvaMjQXStUTroR6x7OXT+S5+LIRsjeT3xDL7OjYDQD7TvejtGo/ujKBMoEWbnG9dVczYDDk4/ZOeNNvHHnRrM2vsOOkV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628896; c=relaxed/simple;
	bh=OdtstjUTKym58CQvg6zCrPbChcbAseotgwPu39r/z1I=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ZR6QAvKGtA9Bti0boicCZUs4kqDxlai04AoR7lyLHumjnxFA27f+92UT95f9fQU9Z45Eumi5Wd5fEpWDBvD277LW+Iyd8wwFm3u5nCn9E6qN/GtXvGVBrtfxYfcm580+MZjKZTRH73pxdRbUUC8156ysOc6FzjAtFYjWFRmy9Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wx6m6EL6; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wx6m6EL6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIehevAkIYvlLuJmWSTJ6zbkHtLiE99arcmYwpBc7WsaBM8cOjAyEB7Degy5NJKW1xywHA13wJFImlhsrz2Ng/D2vg+nMNXulvvepY6ijchLhQ4vYAJCHm4cUzOhpc7E1E8pjkPE/mnIdN/oiuhGnZPky9Izz885R18L8igRu4EciXH7kNgUvZTeGZsJWcP9eRN3oIbZ3ksQ+NO88uKaG5LgTY90FuLYcsmBV4I9DAeh/PJqocKE+o+Nom0mtZVR+OaBGAWAaUTfHNuPoHIm491xMcim71hjbPMv2uX0eyqitxDk33XSOyJLFVFBuxiiYMXiFz915bDKRIOahCSFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRpOXH60BHyzsWr977I5r448Wmo4G3kZBAbQ0HK4E+M=;
 b=kZ5dtPZU3trjrR6YZndJAB0igiITgAz1n0Emnki2FwYBJUrtdo1C3JNF/VsF81lTjO6IO1oGseDsgdQk4mXorEoPQbnvmSnRG2XvvwX1T4iuDxa9HlBVm/TsC+Lr6AExktn91bnHQ5aM+o3ADR1m9P8+/e4X5CIOQJfDid3vFpDl7ayxIWnI9VKi4577gqOkt1jSWiUlU3lEBhES1S8VB4iEUmiv+dPcB+D7n29txa6KlP3MMzF0DAfgcDSX058AzYfJmqHs+Ffvmz5zot9FOEdQXkZbFyIkSuYHhAx6kuYEyD5X3ivKsNo2ROHf6Tbc6g5zV7ItnB/POwgyteMAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRpOXH60BHyzsWr977I5r448Wmo4G3kZBAbQ0HK4E+M=;
 b=Wx6m6EL61xGdAcKOCOO8v3shm3yiIHxhjl4EPJA6SEKWKz1yULYUBRG5KmwLpsPrvmHKE1CYO2hqDx+P/fxYd1sM82YoKrvZHift1OcETuL6gq2QEmkSRDXH7g+DqPjVZkzWrd3KMl2EdWkqfWVgX12neDF5MKssgkYTSN6q9EnnvVixMMtjw0zU3lYajTaR7irnaLp26j69LlUUvFPiY+cFNQjYSJqXCGp7eNTG/VsBnTxaI7PopR9/xkJYTGNXt+v4+kcc9PkUcw51hzGl0PgdB+NN90wrCry2sPObppM9Ii97PUejmNHYACmWiQ66064wDaaNgwhO+b4Vey5Fvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by BR2PR04MB562213.eurprd04.prod.outlook.com (2603:10a6:2c8:5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 07:08:11 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 07:08:11 +0000
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Thu, 17 Sep 2026 16:07:54 +0900
Subject: [PATCH v2] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-imx8mp-blk-ctrl-v2-1-81d29e907a5d@oss.nxp.com>
X-B4-Tracking: v=1; b=H4sIAMmRq2oC/2WNQQ6CMBBFr0Jm7RBasEVW3sOwsHWQUaCkRYIh3
 F3AuHL5kvffnyGQZwpQRDN4Gjmw61aQhwhsfe3uhHxbGWQiVXISArmd8rZH0zzRDr5Bm6lKKp2
 niU5hXfWeKp724qX8cniZB9lhy2xGzWFw/r1fjmLzfvXjX30UKNCkJiNFmpRWZxdC3E19bF0L5
 bIsHwbkLtPCAAAA
X-Change-ID: 20260911-imx8mp-blk-ctrl-c46f26783073
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>, 
 Ming Zhou <ming.zhou@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To DB7PR04MB4698.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|BR2PR04MB562213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e277066-93e7-45b0-f44d-08df148a6ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	smYSV1O4RN8IRKA3rMYHDRVaZlODiw+MJuWCaKDt0hL7AO8F+lTUj34tAY5nS2EoNrS7VGMfI0J5AU5OnrRkCRtcjvTP7ShjWjECfKk0CGuIq1oQ1jU+J8SC9UHLU+fZcARuJt4vF3NzM8Y4lamnO9uOpIW2jYYH4CZbYKYO2tw8ZbtfWQec1TlN2JyTsuUzGVLFql2SfYc8bdwlTF1ENtMK/0Bqvn9jW/Z4wDm6hph7yPGVpKQdmGxI4JbMzn+uuhuIFsURbI/qjNVLOQJXytEA/0BG64RSeNPCZo7Pt+hFCHzcq8QUcZJPvGCCNBB+srOgxtwwQqdX3z/rQgLaNaxm01pn8edqNESN+hOuC20JP//8i08wdEcqrwqdYEnBK++mAvJj5nnb0epZ1WI+dCIXf8QDIlAgeWEfVr0EODgJPV1hB+kdMbttwm10j1PTRAAfWiBihI5CTSsFjdTKV2WzrgyoHoCLuEOFwx8yQer7KgTzcHsreuFs1d7dUf/7eL/suxmiutJ0aPqOIMKUnIjV/vI+YFicp7aOEay59h8P/UeIxwICLvWMMnNokisNe4v/go/rlomAb/wyvToN6YB35FvAxGI57oFakl9IpTbD8tcQaNstPtJp6u8iEr23
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG1UdG1Bc1N5eHBkb1ZWTEpPd25WTm9OQWYwMDNEbTBTcVdiSWYwUDdWSW1G?=
 =?utf-8?B?dTJMMVpvVWxPR3YvU3Q1ZTBNRFVWOGZMOWdMbEZ6b2Rza2ZzZjR4R1h2MWs5?=
 =?utf-8?B?bUhQWVVnekc0U2tDdFF1UEJtK3JzbXBtT3AwVE1qemVNMm5NVlljbmltdjRJ?=
 =?utf-8?B?VDVRK2NSbEVndmE1ZVo0MmdKQWI3bTJjNitaOG14bnhua0tnQXBqSGh0RC95?=
 =?utf-8?B?eWV5NjhKWWVxR0ZNdWMvSGY2eDNQSWFMem1HVlFzejBzOVU3djl6NUhhZVRn?=
 =?utf-8?B?S05FSkhub3F4cHlCZGdTU0RoU1RwSkVTRFBCK1krQWRpS0tpTkFOaWFJZVpL?=
 =?utf-8?B?SElLQzRNaVozQ1dtTXRpTmFESVk1V0h3SjFXQ0FFY1pGZ3JGSWNSNm84VTMw?=
 =?utf-8?B?WXVmRjU1RjlIaE9hN0ZzUGJtZldJNndNdEVFQ2crY1V1Z3h3VGNWWHhFYmhL?=
 =?utf-8?B?a1JibURLSFZkMnU4eThYNUMySU9keWtTSzBwb2VTbVdnamlBMmp6LzRaRVpR?=
 =?utf-8?B?Z0wyQXRrRTRocFdieEhnT3BBdG95dFFpbk9sOHdaKzZTODIwUzFJMDR0L1lC?=
 =?utf-8?B?ZmZBQmJISEVneE9TYVhyL29ZblNKM0hWOGg2Sko0M2g3aTJnWVZyRTR5UlR1?=
 =?utf-8?B?ZGlPWXFMTjFLY3JXVkRtQ0lkVm5ySVlOZlNKNW1sRCt5VHRabHMwUi9sc3J3?=
 =?utf-8?B?cVNxd1BGZGdKM2xNYkJaUGQxUjB6Z0p3TDMrYzdGT25kRVNLTzBpNzlJV2pW?=
 =?utf-8?B?aGVhc1ROWW5sa3E4c2dOdG9WNDZYS2tyOHJGU3pCTE9NakIwR1dmSi8rOVZT?=
 =?utf-8?B?WjNBbDM2YTZRMXRkemJXY2NKYm0xU2YxbEtQUkk0aEdrUEkrQm41ZnNtY29w?=
 =?utf-8?B?eEFsa25XUjV5ZzBLaEE0ZklsT3FVVFlvVGtCRmxFY0ZqVlp6TGlvWlVqbk1v?=
 =?utf-8?B?dzJUZWxRMkU4b2FVVG44YlY0UHBWcE1hR05CZGx6bjdackwycnZDTWxIQzMw?=
 =?utf-8?B?N1J1Q0Y3aS8yUXBYengrdzBqM2RIbVMxUUpVakNTSVI1Z0pmdmxJQlpjTDl6?=
 =?utf-8?B?RnJONlg5d1Y5Yno4YVVSNmNTazhCSSsxWkZZOEpxb3Rac1RvUi9SQmZiV0Zz?=
 =?utf-8?B?L0pZeTNwanRPV2I4OVlkb1B0VE9Yd3pMcDlwOXQzSmZSdmYzTlhwS1hqa2NQ?=
 =?utf-8?B?RTZqMHdmNzhhdTJhcGRzR2llTlhSQzBxZVFXQmg1bWZObHBzdHk2Q1QxMnVC?=
 =?utf-8?B?Y05meVp6VENSb2d6eVcwYWRuem9FdTF5THpCZXhmN1Y0emFjVWNTeitTN2cv?=
 =?utf-8?B?QU9BQndtYVBnNkJ2RWNOS2ZyMU56MUhTLzQrSFZORS9vbFpuUG1WZHNWYmxS?=
 =?utf-8?B?MmxqTU0vTDhDeG1oZ0w0UDFPYXhoNm15cURMWFFpZ1NTY1FTdElGdG0zMitY?=
 =?utf-8?B?MmttOUNpdE9FOWlQSVJJVU5XYXNQSUFJUHlQa1hsU2QrTG1LdnFnbFdkOXpk?=
 =?utf-8?B?NXBNUWVpL2tqQlVXKy9PQ01hQ2tZTjZyQ2x6M2t3K2pBMGN3TTl4SVNDSzRX?=
 =?utf-8?B?ckk1MUY4T0UzNWJ2VllOS0VyeDEvMDFPRHNOaG9CUzRQRWluN3k2Ry9HekJl?=
 =?utf-8?B?YTBoOEp1RjB4ZDRZVzBybE5UK1UzZXZ4Z0M5dis1VE1FcG80R0IvY3VtZVF4?=
 =?utf-8?B?cTRnUWt6WlJQZXIrYVZMc1RZcFc3Znc2bm1sL0UxREszSXRaakZVMHpoTjRs?=
 =?utf-8?B?QXE1VEFWSzIxa29hZ2laSGJENFR6TzBWYnVBMENJcnV2U3FvdlB5MXNyMEln?=
 =?utf-8?B?em8wMlJSNHZGSkE1SEVNck9vTHhhbG10YkwyS1laemhxdGN6MUI5clI3bXFI?=
 =?utf-8?B?WGRTdmlneFp5RHpIa3ZTeXlWZmo3ajhNLzlnVDlNak9zZjZURzVldUxvOGtG?=
 =?utf-8?B?UC9WYVg3ajB2VDFnRmRpSUdldndFdXBTSG9xQzI5eU5WUzRMR3p3R1lSbzly?=
 =?utf-8?B?enJVempVTFlrVkVKNk9CUGR3RCtFdTNKalN5SytSSEwzS0ozQkZBa1JZM2lK?=
 =?utf-8?B?WmUwZE1xS2xQNTl1bzRGcUg2QWlyTDdaaHdmRXp2eXV1QTYrTjNJVXRRVEZx?=
 =?utf-8?B?ZWFlZGVqVHFlRXZYNUhkMFFoeFlQR3p1VTIxc3FkSytoS09TelNmeVJKRFFT?=
 =?utf-8?B?b2pIci9rQ1J1aGNIZUk1U3VFbjZySUt5V3hxYkxROG4rczFXV2lTbnNXbGtP?=
 =?utf-8?B?TGVBL0NtRWJXeHlVdVFnQU1oRS9aam9lT2RmSXJ3aTNBckpFdDFpVG9kOVRB?=
 =?utf-8?B?bFdHaHpVRlZZTmM4U1FQM3R0OVlGOUtzRllQRmFSTDF1NHo5SHJsMUswVm5a?=
 =?utf-8?Q?dXSMnxWzRuanfINwMCb8C9/M60lSUiymwyhah?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e277066-93e7-45b0-f44d-08df148a6ef4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:08:11.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/Qiwhvs0DdxUq/YyYkFB+L1qYtztmWXPwxa5vuxxASNqCr02bxnxWkf4k4gi4NajvW8CFaJX/mC49xvkNdaBPRDPMjKazUVqp5QuKH0SyB1yIDkZ3mwngw8eTSVUHJb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB562213

On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
genpds, each serialized only by its own genpd lock, so their power_on and
power_off callbacks can run concurrently on SMP.

The sequences are not independent: they share the VPUMIX bus domain, the
VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
clk-en bit - so it just waits a fixed delay instead of polling hskack. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset does not take
effect, and its block registers read back all zeros: the decoder times
out or the encoder fails its format check.

Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
driver deliberately avoids a genpd hierarchy, so the genpd core gives no
cross-sibling serialization.

Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
Problem:
On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
concurrently rarely and non-deterministically leaves a VPU stuck in
reset: its block registers read back all zeros. A decoder then times out
or the encoder fails its format check.

Root cause:
The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds,
serialized only by the per-genpd lock, so on SMP their power_on/power_off
callbacks can run concurrently. The sequences share the VPUMIX bus
domain, the VPU_NOC and the ADB400 handshake. On power up the GPC does
not ack-verify the ADB400 handshake - the ack only completes once
blk-ctrl sets the bus clk-en bit - so it just waits a fixed delay. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset fails to take
effect, and its block is left in reset with registers reading zero.

Fix:
Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex, so a
sibling domain cannot run its sequence while another is inside its reset
window. The driver deliberately avoids a genpd hierarchy, so the genpd
core provides no cross-sibling serialization.

Test:
i.MX8MP, Android 6.18 kernel, concurrent H.264 decode and encode. Without
this patch the failure reproduces within one to two hours. With it the
same test ran overnight, over 14 hours, without a single occurrence.
---
Changes in v2:
- Replace guard(mutex) with explicit mutex_lock()/mutex_unlock():
  power_on() already unwinds errors with goto, and cleanup.h asks not to
  mix goto and scope-based cleanup in one function (sashiko-bot).
- Shorten the commit message to the essentials and move the detailed
  hardware analysis into this cover letter (Frank Li).
- Link to v1: https://patch.msgid.link/20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com

To: Ulf Hansson <ulfh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..270f43229fe7 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
 	struct regmap *regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
+	/*
+	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
+	 * their transitions interact through the shared VPUMIX bus domain,
+	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
+	 */
+	struct mutex power_lock;
 };
 
 struct imx8m_blk_ctrl_domain_data {
@@ -98,12 +105,14 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 	int ret;
 
+	mutex_lock(&bc->power_lock);
+
 	/* make sure bus domain is awake */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(bc->bus_power_dev);
 		dev_err(bc->dev, "failed to power up bus domain\n");
-		return ret;
+		goto unlock;
 	}
 
 	/* put devices into reset */
@@ -148,12 +157,16 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
+	mutex_unlock(&bc->power_lock);
+
 	return 0;
 
 clk_disable:
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 bus_put:
 	pm_runtime_put(bc->bus_power_dev);
+unlock:
+	mutex_unlock(&bc->power_lock);
 
 	return ret;
 }
@@ -164,6 +177,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
+	mutex_lock(&bc->power_lock);
+
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
 		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
@@ -177,6 +192,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	/* allow bus domain to suspend */
 	pm_runtime_put(bc->bus_power_dev);
 
+	mutex_unlock(&bc->power_lock);
+
 	return 0;
 }
 
@@ -202,6 +219,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->dev = dev;
 
+	ret = devm_mutex_init(dev, &bc->power_lock);
+	if (ret)
+		return ret;
+
 	bc_data = of_device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);

---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260911-imx8mp-blk-ctrl-c46f26783073

