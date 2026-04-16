Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0599365A03;
	Thu, 16 Apr 2026 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319114; cv=fail; b=UwDL3PadShyWstHkR4kVsdwDrNl2mP6WbaTDri8ZO0n+IJlDzOU9kTunqBPeou54ZyNXqDYCQDpv3OyXru9oOrpEzUZ5s7Scv5+qKkoATz0FH0CKxuua8NzkpnMXwbhLBU9BQtK4SIUSgO3iRRLACrMP8UlzArC1T0bcwgIhtaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319114; c=relaxed/simple;
	bh=OIYAhIZWs/Nr3mKkQkUVPeFxJjDZUegw4VfXxH7MoQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LiqS/a3QpGpXYJbpvNFq/fTpuFQa17cmAxCdMbjf0rGxqvnRFNecyo0cW+VvRspdEH67qwTQIoymt78xhJZGMy5DT+XFlmODlGXqNWAA/hZ0Vptu6eBYx/Mfe7WmjYqfmeIVqoM8OSAhhr2Yepm2aGot+V9NEuNxd8YaGc3oGVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L6eq8JtL; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L6eq8JtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqN3Runj98hJNVpVeCTKWs8gad5JO6rLyqm78Zs8LxbYLKvU+PIbSF4dzfYbwwZCzoJ5ydRaI10UFojd/EHDUHNi+Zee69vwQXVSw0iQCCie82Wk09GUe4U4sFj2vevEwnhFKqJTm2CG51pSrvwlezSVjHRTo2a/f9PrYWJXs6vHr5iFB2/I3jzIW3nnJ0WLzVGSoG1UPYLa+pb4trAoHb1upAg5ZNBmir/s2/CPUh3PgRGO/IEkHxn8cftga7aSHo5SL/LyO73DzGitsx6hi/fnW2NI5vUqdN1BHT3w+L1WkAbFNcSxYAYnDAch1OBTw9XEn389ckp4+JuHArHQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVg2VUkN1zm/7PUJkWHvkn/nhtebsJZJjszckkhPq1A=;
 b=Hq4vhsFNaDwB7Mc2Ylq9HL4XhiVRI1HaYD/hOjQ9PTaAo7CdpW7LM0KrpfEzvkUEP4UpHi89xDU2j0caOTI2AJSArnb+w2clUD+71Q+AorOmy33mKB6sJAymNk/lYZz1d2FKc/C/fUcFS4AYCFmot9sXqap25boHzREHo/kmr8aqNJ/OayC846kLEp3ljUPo/Vx9/p6AISoL9NLIAY3oNm406tUaoyY/yX+1OfjCsfGweH1wPBInuv8fRQdaYIaje/tTFBagat+9u9jUQ6W4USeM4J55jwjpCHAHeBFhXoLZxkWiILsbtiXs9YzVKL9vTfZZL2qqVbE9Ts4f+IlTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVg2VUkN1zm/7PUJkWHvkn/nhtebsJZJjszckkhPq1A=;
 b=L6eq8JtLad8NIORjn3oeRnrSK3AYZKDn06tPKwC7uPpwRmFpdNYv8Hpzj7gkEzjU+ntEiWxBbl60/mxIupRlAOl6Zv21LkdOnjey8q5prDcY0nBGofq0DbKeJp5ipqy0iPSiLo0YHRIiekgmpQVqd5uvyNUOZ8sCcDQkEHCO9/MPe4dvv2PGNtqWljGtWTtGz5lJjYYrH3dmGWWg35Cu4AhsFHbexfcH1o7HaV5lW8CwuhUDma5w4LxnLNS5BklIwxmwcI8WCMyonzPUNMdcRpYMGcdbUvrsowSh3hKWFY0gWrcwKexrv7iHb46BpWSHsQJAvOGwcQ5PJkwDgouz5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 05:58:28 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 05:58:27 +0000
Message-ID: <5e06e26f-7eab-4814-a075-f2e476af3180@oss.nxp.com>
Date: Thu, 16 Apr 2026 09:01:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>, ulfh@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xuegang.liu@nxp.com, jindong.yue@nxp.com
References: <20260416015605.3536244-1-zhipeng.wang_1@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260416015605.3536244-1-zhipeng.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ef359c-050c-4c0e-fe33-08de9b7d2dcb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cGibRJUaKmtKaoWt8d6Sb1UEHpE0tGA2HPzLd2JkNqsbHgNj6Hd4bZwDlvr7MNqh763lWCZlGziSHaS82i/aTnLZ+zYRAIlqcRbuby+0hK0kJS8Bl77RUHuYpDesm3vJbntJb8r3LFasuIq5jWS8tA08YyQsFILV/aFATGc8AqhwpWdPlv7vvySndED2H1peUZQkrE8H7X9hZLkZnIpubHGnt392VMVo4WSSDqmdgJqGkSCrRu0JmLRfxWQdzUemy2MiOtCAv0vJiVIdAzXCmWUNJxTpMoU5zwBm88vUqEOV9/QpsXYJTwWnHfcZomz+atg/t/GFaLwMx7L4k9f5zkEq0ourG1to53IEF+3Z7al7QUsxF1HtSaFYjfDcy1LpBoc3A9l1zA+hY/jS9Pftx6yzR9bV4fpy8ZjD4yVqw3nWqlsIjJOsDcBJVz/z4sKgU2kr6gTQoZc1eYO5MDtUTn8IiyMUTz7FFXtVJaKSK/maIYA4EWdtjkKtqHQ3BdzDv8yXjJ4ep8xmyzI5iyYU5W+7DU/kxda3BCknSUJtliSI7Gpa0Yz8i92nGtDUmTyTzE7MzKMJBCiBud0yqNd9yEiVEc7N5IxM+I5qQk2147we50yFYqWsoIOADGaV71uBo3oZXnA8tGLb7T1ETqjvVmC9Vc21z20NEuF2Z1MEuEEhtuUyscxHn7ogM1sCrnV90gZPdD5DIwSyUX8sQzcfpWiySrHH10UvjGL3mXkmevY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpLbUxmYUxjMzFwS0JsVkkrdkF3RVJJc0xDd3N5TWlTUWxxSnh3SGJiRXc0?=
 =?utf-8?B?cXJWbU5GbTcwMVYyVEFJOVVrUlpYOXdlT2VTV1VQNTlUUmdRbzFCWHFOVEpa?=
 =?utf-8?B?VXRFak9tVm5oNXRmd2pYblhTNVBGTW9rN1hlTjhPRHoxQmJRSll0NzBrdkN1?=
 =?utf-8?B?NDBhK0JqeW5MWi9lamxEcXdvekFZQ3NmeFNSSkZib0xMZHNwU0NON3BseDRm?=
 =?utf-8?B?dXZ6VTJYZXZ2MDFXUm40Uk8yQ1BFTWhId21CQ2RCa3MwS0s5Q1lVNUYwNzZB?=
 =?utf-8?B?TzdMOGs1YTlLb2txNHZobFlLY2d0RFpnYkJCaFFMMUo4YXI4WWRxK3ZTZG1x?=
 =?utf-8?B?R0NaQXpxWVloR1lIZ2lZTEhmOFBQS0R5VDBWeHZDc25NWVdVd0w2T3pEQWxs?=
 =?utf-8?B?S1FOTE56Z3Y2RnF4UFM5V09Td0ZDa0Y4Q2xKSXVONko3aFdaSjIzZ1dIaURr?=
 =?utf-8?B?L2RCNEpxY0NwVG51TG5TVThqNElQaE1OYnQxS0NYQW4veG9tWVdlK0IyL3VW?=
 =?utf-8?B?eFMyRjNSNFJEeisxVDVhbEJLMXB6cVNZR25ZdTFjN3RLZkdpL3VINmxLRzBu?=
 =?utf-8?B?eW5jcC83R01EYjJ0c1F2aWFCSWxvNE5wQ2gySS93cTdWcXhBUERFU2tRVHhs?=
 =?utf-8?B?bVpZa2NCZDBkeUg3WHJIdk1VOFdZQ2ZOK3NRaUpvU1QvUHFxMVMxRWFoajZN?=
 =?utf-8?B?YXVLaVpBWEdXQm5Gekl4aWtRRG5uZkdVMG9CanJuL3Z6MHJOQW9Eb1B3SHlu?=
 =?utf-8?B?NmZFQVdKdnVpWkUrVDIzdXZYQm9TUHorc3UvbVZXSjhXZ2RYWjlOUk1ZRGRE?=
 =?utf-8?B?NG5obFRFK3BsR2lOU0tyM0F5ZHFlV2J6dlljdUJ4TzVpNW92eHpzRHFyMmhj?=
 =?utf-8?B?RElnNlYzUFlxS01vcWQwTWlCbFF2TmxKR0NRbEpxMTJGbUJjai96TTVPQkN3?=
 =?utf-8?B?MmFVNi9KVjFVQzRJaVYzTHZXSlcyWXRGOHQybm0zN2p0dW83a3hkOFlMNjBZ?=
 =?utf-8?B?M0JxUjlLVkMyaTRHUnhVUDdMMFUzY25PckVoMHFaZ2k5N1RRNmJBOVNOQWxQ?=
 =?utf-8?B?RDFrNERhSi9odGJNcTdSQitVYVVtK3IrZEw1dzFmajZDUzdiU0hVR0oxdHg4?=
 =?utf-8?B?b1o5bHRVdDFuYURVdm03cFhzZHNlYXprTHRFclRWK1ZwMjJwaHlnNEl0ZndD?=
 =?utf-8?B?M3FBZXlzNmxWSlVGcDdFT040MmNKVWtYdktaT0hKR2tRSlJyK2dqckR5TDl0?=
 =?utf-8?B?b2lmVXNWc0F1K1RsckIxZ3JSOE9ZRUVUK0dHc1p1b3RYMUhoUDhrYXl1dk1p?=
 =?utf-8?B?N2grbVZiSWxlbW9OeTRjOGs5dVI1bk9LNjJXeGE1bkRRelNHUW5kOVdpc0JZ?=
 =?utf-8?B?NjJKNHBkeCthNUVaQ3Joc2JJdkdDUjdxeFZkTGFHRU1DeGR3NVdSS24vOUEy?=
 =?utf-8?B?QnQwUGlCZEJzNjJuR0tEZFBHTEVXbmJrNGJQb0pCM2d4R0R0SkF6NlEyRjl5?=
 =?utf-8?B?OGpDVU5UMGQwNW05OVdkaUoyVGpPUjlMdlJ1NGVQa29WZGswZVNpRENiNGg3?=
 =?utf-8?B?ZTBtOXJRdW1MVjdxZXNqM2NnSmFrb01EdG56S1BCUGRLbE1PNmptbDFGS3hS?=
 =?utf-8?B?cnFvSmhock9wZVFwWUdqa0tLMG5YRWRGKytKMkZhaG5KNmRDbzZzU3Zxekdl?=
 =?utf-8?B?UXcwc012ZTFoMzhCdUlWZXJHd3psc2VRcm9mVXZrNUhMT2t5UGQ4VEQ4YWR4?=
 =?utf-8?B?NzdKTlRJOUI5eEVzVjNjZjBtYndieHlVRjc2bDdoQklZMWkySUQ4OGx2aHZk?=
 =?utf-8?B?d09HcFFBd3I3Y2QyVkIrLzE4NFVKOUtpemVLbExHa09JcXFOakJraU1ERmRO?=
 =?utf-8?B?SzA1L2tmektHN3c4clVTbDlHTWVrMkc3eFdCUzkwN05WbUhpWTd4U29IVHlT?=
 =?utf-8?B?WXlkSFprcmV2YTF1dWc0M3UzL0hyeGlzb2dVQ2tsdmdJVVA4MGRtZ0JUSzl6?=
 =?utf-8?B?b3pjYWFkQkh4alRtUHNPa25sMlJlSVhNUEp5aEhmdlRjd1A5cVNpM0FndnY2?=
 =?utf-8?B?bzA2ZWRwQnAxd2pTMGtHSXhSNVZqd21JTTFucXpwOGhIMUlXNWp6MWZhNEx6?=
 =?utf-8?B?R2NkKzhYazdBVG9VQjFaTGE5L1dLVlVmWHZ6OVA3OVVmTGNlWUJJeFpDdktu?=
 =?utf-8?B?eXQwL0FuUHJBeGdVQXlrYlRZcFhoZGFZalQ0ZEg1U2hJUHZFdkkvSUgwTVVQ?=
 =?utf-8?B?b0Z2Rml4TkxRa1dzTzNOSmpQaFNEandxT1c0SGVIOXQ3d2dwUkZHbGVMZVBv?=
 =?utf-8?B?VC9tSkxQdEpxWUk4QnNyZXdsOGtOaWVBWWw3b09Ta1BqSUlQdGJwUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ef359c-050c-4c0e-fe33-08de9b7d2dcb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 05:58:27.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkuSVwJILT3zXyDpcQ86J1oykv7oYY8gnC2R7kT7cdznaflg1hmavQwpynOaKs6a0xR/EG6EK/0zw0U+8l8zCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925

On 4/16/26 04:56, Zhipeng Wang wrote:
> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
> to allow building as loadable modules.
>
> Add prompt strings to make these options visible and configurable
> in menuconfig, keeping them enabled by default on appropriate platforms.
>
> Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
> This dependency was incorrect from the beginning because i.MX93 uses a
> different power domain architecture compared to i.MX8M series:
>
> - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
>   management, hence IMX8M_BLK_CTRL correctly depends on it.
>
> - i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
>   have GPCv2 at all.
>
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---

Please always add a change log here to help reviewers.

Change since v2:

* fixed typo reported by Frank


