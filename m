Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA893A873D;
	Wed, 16 Sep 2026 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528002; cv=fail; b=M1SpCtFsFXKfvCe5Rd8NYOQ6PDG67C5w/Buprm35M4i957WKMrq5lh4RNi5yRwtAvz/T/DaotXQZ7IvpGo02NocgqmxgQx5q8nrgkesKbqifx6/VHQQbYKPxMHVufvGdSUlwDdt7s0keY1w9OwAuWjWWT5StI0pOF8S/agv/HBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528002; c=relaxed/simple;
	bh=elbhOKqWL9wtLsvmuVzwRCRefylz57V33uGY/iGjkg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=trpRxyAJWExZVtRukLmh90rLpp+sAuoqeV+B/1z+2+59mEzsWZCD/NM3GZh4tmgjScg+e4YMlvJl0qgpATrbG1+ftlsk2PP4FOAgOLucBT/VZQNPt9ZBczQi467MQA3+rD5QGZoTjz8H23cSC3/SLslZlw49k6PJnL5d6IPWDjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZGLhur45; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZGLhur45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTDF18HbZsYmcn++5TpHeZ0LODmXAh/nGCcZbPBfQqF09NOUkmbNESAwt0ZriEd4gVgKJI00MS+4ffBvnwcXWMD/5GfH5qLsS5IEscc5jca89kkXkIk3BoI08WYA0QBGluTQaj+cC4hJyjFgncWcBwO79NvQctv42DKvMWYK8j3wVZnnitvoyxWaiTLUrKfLQvD5sJrL8gvmcLxZu6ndHm73TG+0lbQpZjV/74fElmQPUKwSDmfXST8NT8DugIOSBx4lQhNawzzHcQrKUO2TPbjOoRO0pxNpL5XAADGa9J5yJXw5ty0eqTuqFq5SNWXPjapjq3Gd1iqAHZfEyz78Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgQQ1ieDrz14jHVjSOAFgvrUNMC3OQ4cZc63yBFnDZ0=;
 b=kvO/6AZ5Am1XEyWveVN/BitWlBU1Mho2tISqf5TLNLaQTKtlbDvqe5KynprhVcRvJhEDtRxyPrSnOdnX1kYcmrqjTgwXZkm1GNGNs4SvE3l2UjUPRp3x0H8CQ4IXNfG5qcTizlbGkOjbkd2Ks8oVZUifL54txPYM30rgQGIMLi5CIGgLIeuL2b6vA8aXXCCfH1t4JZuYMSH2QuQQv9JK+apSYS+uRSnt882Fj2UG+kOb9vDBlSrzA43UpxPwqdXGMox6K/CM7ShlXeRy8JxpC4PBfPSaounxTagFzFRwo5rUJANFVP44yKe/xOjXxBYF2J9irumyiRwuAf2fAj2KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgQQ1ieDrz14jHVjSOAFgvrUNMC3OQ4cZc63yBFnDZ0=;
 b=ZGLhur45DQYweG+F/t7wkpOb8E8SNwNqaCncE42DbXweKPwCAtHYiBd+7FZRh3TyKbV4+dfQLKK5vhsfB31nIUJv31iIbM/58J/+X0FMewgnjOoEP4ypwFOFT7QHl9693MW5xdj1ZTyJM38i6ratnhgMgd0GyRKUtN2Ta8wcsXH/wrtfk2iIneku4Oyade+cmUT9ioWDuXAigf0LEo3ioF+OwAkosM8ugRmz5KIXzpXzTcaA3Va2w4Iq+KVfwhg64IOkb0DYm1Rk2hIyjNKFyRLS3aSG3pt2ZBNn5JurCHGPaL49Xgvw86k4eAgEFGS5aICUUQCeD9dtW04BASMfNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB827909.eurprd04.prod.outlook.com
 (2603:10a6:20b:788::6) by GV2PR04MB11935.eurprd04.prod.outlook.com
 (2603:10a6:150:2f1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 03:06:35 +0000
Received: from AMBPR04MB827909.eurprd04.prod.outlook.com
 ([fe80::1fe5:6183:37cd:b5b6]) by AMBPR04MB827909.eurprd04.prod.outlook.com
 ([fe80::1fe5:6183:37cd:b5b6%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 03:06:35 +0000
Message-ID: <ed3e2377-7a1a-454d-8031-ac1834977584@oss.nxp.com>
Date: Wed, 16 Sep 2026 11:06:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zhou Peng <eagle.zhou@nxp.com>, Xiahong Bao <xiahong.bao@nxp.com>,
 Ming Zhou <ming.zhou@nxp.com>
References: <20260915-imx8mp-blk-ctrl-v1-1-b3b4e6e7e676@oss.nxp.com>
 <aqlSerHyjCB-03IR@SMW015318>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <aqlSerHyjCB-03IR@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AMBPR04MB827909.eurprd04.prod.outlook.com
 (2603:10a6:20b:788::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB827909:EE_|GV2PR04MB11935:EE_
X-MS-Office365-Filtering-Correlation-Id: b1389e62-6ffe-4bf9-23c2-08df139f8439
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LDVrO8hLDIDQqE8+9VhoeXAz+0mg70j8uloDMXh+/ckI99ZqVYPV5xsPmrc4zYn+Ee/w31o2NPy1gojxu1KEOTBKnNPKPJqPvKqeAi6ud3a7iV4wy2HKYSH+J33c6mKE2qxGzeZG5lJ8y3G4+G24yTOnlh6mnQyVO/ggb1MQrMAYH+zBtXlUFq4pPUHcv3qfV0zGTbIzx7k0O76qRiB7hvs2+EP3p7FfJj/54w1jWlUBmR3reY7brB604cPfmlaBuu7HdndjI0jXMVwcpXK1AER914X/Kiqxpssj934pW43z9SQCcvxftjHQF2BlaXq2rhCXTAvd9/1WaEdhE72GApFAeRzfQBOzvlg1CfuDLMSObXEDNTSkWMS4ADAiUNC90wfca2jsCDnQQtyCZ4o4Bcryq4biB5hvsopZkeyW4PNJWjq/pEQNq3DbAS3H5SPfOc69D4DhfLvFsDkiu1tHocWBiDoHOhH00rglIwH9FPfdR9pPEQJQfz5tMuT+BrZhPuKuudKe8/FHZKrBdRibIeb9+xxsQI6b7frC4ixBam3MuXVV99n4OW4KZGIqX5twNTjiuVlRdOKvghRr63USFIHV/2gFisFrbV/9ICWTDcnaJxsm0Yd20TuQ83MNBQueDmCrGxQnQUIvWnUTv+/NkH1snTCXarZeBy0h9pUpDSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB827909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFA2WGR3TTUzNWJlSnV0R3k5NUVDRnVZNG5uVkMxbG9DL29hS2VibC9sbHNW?=
 =?utf-8?B?OEY0SkIvR3hDN2hhRzlWZzVKdkNzcEpQTHZpMWU1R09OVC80YU1VSS8xSjNl?=
 =?utf-8?B?T3U4ZUtuL2tIUTNhRVNKd3RSTENaV1U2SFd3TjBOZ1ZobzBBZWdYZ0R5UlJX?=
 =?utf-8?B?SUZ3UFpWU1YzYWNQV0JWL2RRVjdRKzhUbXVXaTZBUGYyYVQ0Y3M2WndyQ3Ni?=
 =?utf-8?B?SVlGNWRNWXZiM21WSFlqS1lFZWhBSkhEY3JDcCtpOGEyR3QxMWUwaHJ4YnlQ?=
 =?utf-8?B?dERZTGZjR3AyWm92VDNuMjg5UkR0SmlyZ3YrVXZNd2ZyckE1N0RlT1IwaGlz?=
 =?utf-8?B?OEc3YzlKK0pmczhrNE5vR3d4QnV5UVI1b052RzVsTTJwRCtkM3RLcmJRR2ZO?=
 =?utf-8?B?eFB4TW1oYW1HT0tjRTIxbjV2OExtM1lXU0EwU3VMNU5jaWhYckNWc2gwbmlm?=
 =?utf-8?B?Rzc2RDhoUVROYzRQbEtEa0pKeFY1ajFhRWxTRjRvTmd3MFVkQS9Wb1RXak9X?=
 =?utf-8?B?WHd5R29RUkN5L1J5MWRXT2I2elJpeWNzRVppakVYenMvclJ4amhnQ0pPb200?=
 =?utf-8?B?VDNPVFNwRU1GKzJPYnczWWtCemUwMGNlZXZlM1hSVG9hVGI1VTE2SllmNFRy?=
 =?utf-8?B?aFVkb3ZwTy8wSlpmSkFLMnMrZ2ZZR28xeTJWZnRMYWEzNFZvLzBDbVBST3ps?=
 =?utf-8?B?T0Vla0hPNUcwa1puUGV3TDlaTjZDajVLS0NyUW5WTVFXY0JDRnpwRXVrN2pl?=
 =?utf-8?B?L3RQS0xoNVh5Uy95WUxmMG9ranRlV00xeW5hY0ZKNDE2Q3JQM0p2alovbFJH?=
 =?utf-8?B?eXZheHg1NDZCU3NsZmVWcUZIZXBpVEFoci9PWldGbkhsOTBzYnNBSVRjM3Uy?=
 =?utf-8?B?MVVYWGpXMWdhUzJ5M3RBbmRnWFE3dkJTLzI4VGtQaUg4ZXFPS0V3a3ZmaUZa?=
 =?utf-8?B?Y09BT1pEMkovblkrbXgvWlV5Wk5vVC9jc1crTUVHeDNGL1k5NEZ3ODBhZHFn?=
 =?utf-8?B?aHBQSEtqYXBuaUsydDNsOC9uckdHcFI3RWFKZ2gyOVB6SWxud0kzbmNlYVFD?=
 =?utf-8?B?UVVXWjdaOW5ieXpTb0R2MlV2TnVoYmtHazdNeitJREdNaEgyN3ViMHlmbGVZ?=
 =?utf-8?B?elNwRVI1bE1zL1Z4OURVeEkxMGxadWRqbVBSemNDRUExQ1FweVJwd2hrR2FT?=
 =?utf-8?B?bXhmZVVtcmdqckxELzJPS0xMUURaaEJmT0YwWFhlQ3RESmRhN3NGL2tQS3Fu?=
 =?utf-8?B?Z2RRWi9PU0xVTG82aVF5NGdCbFczYUFPTVVwNmREdTEvZCtWMFdIRzdVUGZk?=
 =?utf-8?B?SnpRMEdnVXNDRGVySEhnTG94cjJLd2F1V1ZkdTNkeVJYUnFpTjlzNTdVOUdv?=
 =?utf-8?B?M3dTZGJTNk43Tkw1M2tmYno2MldQcVRJbk9KY2xkOWROZmlVTHZGbVFPVzBs?=
 =?utf-8?B?VEs0VHdOS0U0NHFDZ2MzR1RVZjVPZzJCb0pFUlNQU2tHVDRQeWdZMDI4b3ds?=
 =?utf-8?B?dWp0ZDhsaHpZSW9DT1RBY283cXRrb1B3dTJIT0hjYzVNbnBzVWRiQ2g2RVRX?=
 =?utf-8?B?WXJwRWJsRFBCK20rNVVBM3JVVkZVL3BnV1BPMnRuQVRYZDNmTVBUR0M5cDBY?=
 =?utf-8?B?KzZFTFp3azJZakdFZ1dCSHVMWTdaNnJsdnpNT09iMWVuZnFlRE1iL2F5d0J1?=
 =?utf-8?B?Nm1ERmtXTWR4V1dWM2EzY3ZZOFRvb2twSnNCRCtTbWlzSkpSMGc4TkhJS1Yw?=
 =?utf-8?B?ZE9DdXV4dFQyckIyNDhHZFlZYmFWRGpERGVsRXB6d1dnbHRIS0N5eVBkemRO?=
 =?utf-8?B?SGxnRzRUUUgvbU82ZGgrbXRhcGw5ajJza1VNaVduRzNUZWs0WlZPRlNLQ3BY?=
 =?utf-8?B?dWZsQmdzcHRiR3VhOU9XN0ZkVlI5K1lHcmNxVFFTMEFmT0dNa1E4M2IraHJh?=
 =?utf-8?B?RFJXVXdaY3ArS25EY1NrbHk1ODhBZGFlbE9EcDVtNFJLeEorOHQrZDM2RmMz?=
 =?utf-8?B?VmZOdmVEZFY5c3dqVWVQQmtCTVZyNnVZZXZEclk1d2ZZQ2pEZ0ZNVFRwRjVj?=
 =?utf-8?B?ZE44NGxBUm1iL2pHZUNCQXNpMkpaY2pacWxqZXNnUGd6R0R4eFJYazhaVVR6?=
 =?utf-8?B?clRGTFBNMHdSWHFMQXBSWm5oYWNsUmtCV245bVRFN1FFZnp4cS9FcEszdi8y?=
 =?utf-8?B?d2dobXpIdzJENFNWeW04NkhvZnpMV3hscmZHYWRkaVZxYXcyeDlEQzRDc2sx?=
 =?utf-8?B?a1dSRERTTEpPRU9rREF4NFJWYVhXUlRKV1JLMEhXVGU1Ri9xRzV3TS9QMTND?=
 =?utf-8?B?L1oyV1ZOQ1NSNFVHZjhiV01ZNnNFUzVPL0lrY09idUFJZ3ZRckNKQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1389e62-6ffe-4bf9-23c2-08df139f8439
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB827909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 03:06:35.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPaXKstl3YT6V+nxsqd8m0d1TJK40nd71lKDt/mHG0gShbKkGfk8DUejAZ0/lCvazjCKB64wke5Xu3qNsy1IsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11935

Hi Frank,

On 9/15/2026 10:13 PM, Frank Li wrote:
> On Tue, Sep 15, 2026 at 07:09:43PM +0900, Ming Qian wrote:
>> On i.MX8MP, running the VC8000E encoder and the G1/G2 decoders
>> concurrently rarely and non-deterministically leaves a VPU stuck in
>> reset: its block registers read back all zeros. A decoder then times out
>> (G1/G2 reset failed) or the encoder fails its format check reading a
>> read-only capability register (VC8000E reset failed). Raising the
>> runtime-PM autosuspend delay hides it, which points at the blk-ctrl
>> power on/off path.
>>
>> The VPU blk-ctrl exposes G1, G2 and VC8000E as three separate genpds
>> whose power_on/power_off are serialized only by the per-genpd lock, so on
>> SMP the callbacks of different domains can run concurrently. Each domain
>> only manipulates its own bit in the shared BLK_SFT_RSTN/BLK_CLK_EN
>> registers, so this is not a matter of siblings corrupting each other's
>> register bits.
>>
>> However the sibling power transitions still interact through the shared
>> VPUMIX resources: the VPUMIX bus power domain, the VPU_NOC and the ADB400
>> handshake. power_on asserts a domain's reset, enables its clock and
>> releases the reset after a short udelay, relying on the reset propagating
>> through that shared path. The GPC does not ack-verify the ADB400
>> handshake on power-up (it only delays), and per ERR050531 the VPU_NOC
>> handshake is timing sensitive during VC8000E/VPUMIX power up/down
>> cycling. So when a sibling's power_on/power_off runs while another domain
>> is inside its reset window, it disturbs the shared VPU_NOC/ADB/AXI clock
>> timing and the victim's reset fails to take effect, leaving its block in
>> reset with registers reading zero.
>>
>> This is a blk-ctrl defect: the VPU power domains' power up/down sequences
>> must not interleave, yet the driver deliberately avoids a genpd
>> parent/child hierarchy (to meet its sequencing requirements) and so gets
>> no cross-sibling serialization from the genpd core.
>>
>> Add a per-blk-ctrl mutex around the blk-ctrl register and reset sequence
>> and the synchronous power-up path, so a sibling domain cannot run its
>> sequence while another domain is inside its reset window. The GPC
>> power-down is queued by pm_runtime_put() and still completes outside the
>> lock; serializing the reset sequences is what fixes the observed failure.
>> The bus domain's GENPD_NOTIFY_ON notifier runs in the same call stack
>> while the lock is held and must not take it.
> 
> Thanks you for detail descript problem, basically it is power up/down
> reset, clock have not serialized.
> 
> Can you help summery to cut message shorter end emphase most important
> part?

Thanks for the review. Your summary is right: the power up/down reset
and clock sequences of the sibling VPU domains are not serialized
against each other.

Below is the shortened commit message. Does it look acceptable to you?

On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
genpds, each serialized only by its own genpd lock, so their power_on
and power_off callbacks can run concurrently on SMP.

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


Thanks,
Ming

> 
> Frank
> 
>>
>> Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>> Reproduced on i.MX8MP with an Android 6.18 kernel: running an H.264
>> decode and an H.264 encode concurrently hits the failure within one to
>> two hours. A VPU comes up stuck in reset, its block registers read back
>> all zeros, and the decoder times out or the encoder fails its format
>> check.
>>
>> With this patch applied the same test ran overnight, over 14 hours,
>> without a single occurrence.
>> ---
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 479789009c7f..f8105e87ea3c 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/clk.h>
>> +#include <linux/mutex.h>
>>
>>   #include <dt-bindings/power/imx8mm-power.h>
>>   #include <dt-bindings/power/imx8mn-power.h>
>> @@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
>>   	struct regmap *regmap;
>>   	struct imx8m_blk_ctrl_domain *domains;
>>   	struct genpd_onecell_data onecell_data;
>> +	/*
>> +	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
>> +	 * their transitions interact through the shared VPUMIX bus domain,
>> +	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
>> +	 */
>> +	struct mutex power_lock;
>>   };
>>
>>   struct imx8m_blk_ctrl_domain_data {
>> @@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>>   	struct imx8m_blk_ctrl *bc = domain->bc;
>>   	int ret;
>>
>> +	guard(mutex)(&bc->power_lock);
>> +
>>   	/* make sure bus domain is awake */
>>   	ret = pm_runtime_get_sync(bc->bus_power_dev);
>>   	if (ret < 0) {
>> @@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>>   	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
>>   	struct imx8m_blk_ctrl *bc = domain->bc;
>>
>> +	guard(mutex)(&bc->power_lock);
>> +
>>   	/* put devices into reset and disable clocks */
>>   	if (data->mipi_phy_rst_mask)
>>   		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>> @@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>>
>>   	bc->dev = dev;
>>
>> +	ret = devm_mutex_init(dev, &bc->power_lock);
>> +	if (ret)
>> +		return ret;
>> +
>>   	bc_data = of_device_get_match_data(dev);
>>
>>   	base = devm_platform_ioremap_resource(pdev, 0);
>>
>> ---
>> base-commit: 6e30287eaf3e41b86dfb86df3b811526693d74b4
>> change-id: 20260911-imx8mp-blk-ctrl-c46f26783073
>>
>>
