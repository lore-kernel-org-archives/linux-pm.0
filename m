Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022098.outbound.protection.outlook.com [40.107.75.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1D530E09;
	Tue, 22 Sep 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066666; cv=fail; b=dsdepLpRXqyQUrGjin4gDC/zxxgHESn9nvPxx48OK0JpArwj97cXa8zVRjMSUyfdLAYbCM1nB66nUSrc/hnU74w2a6E6jbVEiKQwgylAI6b5EZ7zAe0sUh/+t6XU3U9gymQcM2F09XPI2r5gSskn0TDYcuMsRlZzBeQYrwEyK88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066666; c=relaxed/simple;
	bh=nA/yjDV5Jd2dZmy/gLWSQgXkAjJ9dxN5yKPYf14B5pk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lK0631TDPy0zVKoaNshhfJ/YuzSbFAOo3MgWzsIkUo/ts2ssPyCCXNGGniLaqw93YzZpaqwbKZRTKE3dPbM05Gv89TZNG8c5U9DiCkOBWWwlLcpTp0kRdM+y5UAnp0zMDJy/C1ZZeQPWT8drf6K9f9dgCxE+lcwF/rG8l6wk0sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=KOSc34d1; arc=fail smtp.client-ip=40.107.75.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="KOSc34d1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFvvbbuC27l5zr5yoK1Q1T8Mjjeiz6Uzyvz5V+mJd7obMjvi2nPNosnwtQK+cK5nfTsNp0lslCmidQj0kptTRMzkinhSkHyr4+fZO0KDp6fs1/3T1RtKuioeq+wPNG1b8NJyI0FugoQNfW+N3+2VpNWEWx1ao4vVYleOlfmvAvczykCAJmyg7cyNVrABmNf8riUPyisMiInGQdm0W9/LM3yyGVuhgasq/r5aJo1pTLMrrms7usOHtkau4pnChASzVUgI/MjQQBxKYHe/ZHFuVS9yQG7qf/7CRF73ZK7IBxZUp+tUsVzaeWz72wVqNLq33DVfrs+GBLxXCDAy33nmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5zJl0gGGETHWu3U5rcJmI1eY+ktAKf3KrxZ/OniHvk=;
 b=moroVeFNKa39Zz0EHZnCaHk3sLHomWeRzB0t0Sua1hYYu6jy5kEKb4y8ytP4a32sfkPlyeb33g1CWq1rtVgQXi3Yo2VlfNoa0FRHXOakjRCiJauwd52DYwQh7l2kqk9jxyoS/pcL6cwPG9kM3/0UH87+2Zz015jMz/DmCFfIHYfZDY/uMf+AVapX0169zVTYAN89hAjjqcV9DNl6vdQcus+/Kf1lv5nx+GkxTgefeKC5COnuLXnnr/kvRIvqAWR79xJxBZ6r7PJrKDpoxBwc9F9B6Qp5AgBc+JiG5U+VcHkxLIBIMXlmacegb4wWxmS00V5l2hglZx6Q9kAD9pmH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5zJl0gGGETHWu3U5rcJmI1eY+ktAKf3KrxZ/OniHvk=;
 b=KOSc34d1CvLs+vkZG0+z+zTG6BEB2VgaIjz5ZJXWzNosFNKNde+6XB2RCjpdK10ODKBFV0Ra/E8t9TrdnSQ/iDOGrgTxZDZczOem14RsD3GOgwDpOXZk8DUTzYpK0HLOvb1JvT+QWyi9kv8p5othjWzORPsPiCSu03df7d4lP3coylkZNhJgdWoi6KGyA5srHmnYzOmC1OKgvaWo9F1Vnh7/m6u9Scfph4oBHLSJtKIPfNhm3LI8Tso580HUxaMHhRuzjZV7qI4Zac4+yZzZ4y0KZP2skl5iXk5FXvwUpbDNzOVqRLzYKwniNaC9J4udonnfjnmJ7JGeoXTPI5y7NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6416.apcprd03.prod.outlook.com (2603:1096:4:17f::12)
 by KU2PPF5FB3746AA.apcprd03.prod.outlook.com (2603:1096:d18::412) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 08:44:19 +0000
Received: from SG2PR03MB6416.apcprd03.prod.outlook.com
 ([fe80::e7e9:94d6:830a:5222]) by SG2PR03MB6416.apcprd03.prod.outlook.com
 ([fe80::e7e9:94d6:830a:5222%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:44:19 +0000
Message-ID: <5cae3485-47cf-47eb-9757-de765b485961@amlogic.com>
Date: Tue, 22 Sep 2026 16:44:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: amlogic: Keep Amlogic A9 ETH domain always on
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 xianwei.zhao@amlogic.com
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com>
 <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
From: Qingpeng Yang <qingpeng.yang@amlogic.com>
In-Reply-To: <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To SG2PR03MB6416.apcprd03.prod.outlook.com
 (2603:1096:4:17f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6416:EE_|KU2PPF5FB3746AA:EE_
X-MS-Office365-Filtering-Correlation-Id: 34026580-adb6-4210-0128-08df1885b0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/12evLpMKtTMNiJgGnxp6w4kaMUFDUstw53sysa/6efUjX0giTIkNH0p6n0CM9k+FRAJYO1WsQlPzMz3tzPpgIE0CQJgpRDwB+NOO2a2AIveLMKsGrkXOAtxeKimZp6Xo7XKEHjVAih7nXxvEkMp/RWBL6mdflIY7kI0Yyy+tEX/RbQWvVTBYUrst5O7ET1wdEDBHzVpVc/+8qb/waH/rxtcHBk8YYf8zEuTVigMr/CgKOOk6QZ+vJ+RUMeVCROp5djo2y6pm8IwqZaA0/tnR3+PEzMLGya2mgB2808vZ4D24cGTBQmwSfk7oW26eiOy4ezdQz2XgkcPhGnU6JbcgH+Bg79BNMoyMhrW2uS+YjHGFh0dYO30wdpWNSLp3fDcSaimdn/dWl8aQggqON1a0GWPZTiql3BFnXP7KkXEXgNvpIcPjOtUDhGncZkn1w/Mlkr6ewNhUmV5J9elHDjZ9W7FqLaxgBr2jygMguA7fGjL4y1/euv/xrM5LFnMMh9cRvsqT+WbHslpk60J701Jm8wEAG9JnGh+ULuyZaAPuBHJ3bjGP+9l9ojMw+X2ocJhWuij0NqT0R8L5tKhrzdcwCPP+gkAPS1JZ6lgrcx+T4PcQnbrBZr2bIi1DQzvywQO9YS9qO7WVpZgZES40tA2yCglYyeoQif+gwf/Te36e7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RqWGlCVEpjQTlEQjlwcEI4YldxNFpPNG5vbWxYT2Z5QmM5cEpxbjdabjNC?=
 =?utf-8?B?ZDdrWmlNeWxPWUFyenlSWXVIeHB3akU1ZUxYUDhoblZ5K2w4N0NHVFdMWWwx?=
 =?utf-8?B?SFU3NEk5cklKSTVsSS9Kb29weEVFT3ZZQ2pGSDJ4SE5TMlVRUWdqenh6akp6?=
 =?utf-8?B?RllDN0NVZWI0RitrSmd5dVpPbDQzNEk1b1FRc212ZzlzZGZ4TkhUeHR1NUY2?=
 =?utf-8?B?c1lkMk1sWU9OWkswRVc4SlRPbDBYY25NNUZ5YW95N25NYXlzVk1ibHY0cEU1?=
 =?utf-8?B?UnB4NFhrY0JaOFhSSGN6YTJCNTF3U1B1ekZTbjA0YlZqZWM4dDV6RUo0ZUJH?=
 =?utf-8?B?NTAxUTVHb2FHa0dSQTJ0ZnlWRStLbnB0QXFjQW5sSG80eU1tN3pWT3orYjJy?=
 =?utf-8?B?NldSZ3NuU2VQeU0wM2FXdVJabkpEZlVlNGRTNGhuZzJrK3B2WjNpTUVNL1Ns?=
 =?utf-8?B?djN4ZktMNXBadDZ4RURQN1dtY3p6aG9YZ3RtaXRGb1paSUoxTU94ZkM3YW00?=
 =?utf-8?B?bjNsdjR1Y3dzNE5LejNyNENKZEZCYUtWQk9ybWFabDVHMStWTkcwYXNaL1p3?=
 =?utf-8?B?VXppRHQ5MTVQQVZIRldWcG1sbjBrV0Zkak5mUjUrSlV1ZFBJbTQ3eFlBR2dw?=
 =?utf-8?B?ekVqNC9wM0NUNzVpTXpFelE3bjYrb3dqMytrVFhvRDZSS3k2QWR1b0ZUYjNX?=
 =?utf-8?B?TkgyL0dtS1lWeW5Mc3B4SHI3dTJTODBZSE1GSHUvSEkyVG1qeVRic3lTeU1a?=
 =?utf-8?B?V3VUWHB6Q3l6bFpNRjAxN0RLUlVGQ2FvWGFoY0dOUS9QRm0xN00yQlJwZ0Ur?=
 =?utf-8?B?UlcrUURPbW45end4RzE3OGljckxkME0zby9nZnh2ZUE1aGFUN3BXVU0rT1Ji?=
 =?utf-8?B?TnJoMkVSOVVkKzZCd0VvTUczMzFZZ0VqVEpOSytHWW91djNYYklmbVdzKzJx?=
 =?utf-8?B?WDJWUUZzeVJ0VC9jN0twSWs0MFZXS3JqSWsxK3FJdGhucTlkbXR2N3FjWE16?=
 =?utf-8?B?V0xrWTlmcXpiaWZlRXBFSmNVcll3SDJlWG5TZ2I0dWR1MUJhNVcwcSt2WE9D?=
 =?utf-8?B?TkxXS0FKVzFMamtRU0orU2hRYTE3TTRCdmVTRE4ya05wMUk3UmZHUk04NDEv?=
 =?utf-8?B?RE03R3BzTXQvNkladTBjRlJCR2ZZa2g4bWxwTE9jTy82MDVQRTVKTndsVFJR?=
 =?utf-8?B?dVEvbTZobnc2Wmp2cHZoYW9BaDFSWWlJTzNlb3JxUStNOEs5QU5iUE0yWjdI?=
 =?utf-8?B?YTQ2SHFueHpYRSsyL09PdGZVamt1eEJaMlFYR3dYeGU3TnZjK3E1dkk5YXc2?=
 =?utf-8?B?b2s1ZmNpVDZEbjIzcnFmRENudWlEcHM1OFc1b2NRM3dUQ2t6TW9ISnQ2S21k?=
 =?utf-8?B?ZVUvbDhHSUtUN2ZCVFVYWmVoN1FSL2FYaFdoQU13cXJTOGxzUlFIM3lvUmg2?=
 =?utf-8?B?aTFLMmFrY0dpQk4vc0lxaVNjR2VRODd2MEk0RzdRalFJTmxuRnU2TXR0Vm1v?=
 =?utf-8?B?M0xRY0JaOWxBVlpvL1ZobE0zaEF2bkwrRVlzTFppTHdwSGJHYXBoVTBZZmc5?=
 =?utf-8?B?NkFDdjNtelNWcHZKc0xoNG1VUUhuelhEcFBQSHd6RVNTQlA4TS93a2JKRzFt?=
 =?utf-8?B?Nmdlc0lONkFjdjV4YnRuemlRczR0RkdhMm5kS3loR05FMlJLREVGYisvaXg3?=
 =?utf-8?B?all4WWxGcURMakZjaENaWWkxMjZhbDFWcTEzSXZ6WFhlUUgydWVrKzM0bWg5?=
 =?utf-8?B?OTUyU2RNczBhTFg5ZGpNK1BaWEVidFB4Q2NFcXJ6OC9Qa3duWW5zeHBzcDZn?=
 =?utf-8?B?OUVSY0p1VmVScUdaenYzdkZ6VTBqM0c1bFlJWStIa0Z5Z2ZWQmZtVHNTaUNw?=
 =?utf-8?B?Z2MvdDZmUngwNFZ4WElzWlVRTUZFNlRVU29LYWlLTGJwWjl2ejMxdklGS2hD?=
 =?utf-8?B?TEhKZmRHM3kvV3orSXZkOTZ3Zmw1U3Q4Z0NTZWEzY2dDTjVZQTUxdW1oVlFl?=
 =?utf-8?B?YnZTbHlZTUhXSXVFNXFJNFJCQnhlRi90K2wzOVFHZy9QN3BYZUI0UHREaEZ4?=
 =?utf-8?B?bzNzbE1VNzFwNk0wamZaeS8xTTFiYk1LMkJwUUFWS2FGYm1hUGQvK05USmtR?=
 =?utf-8?B?R2xkRm5jdkZmNHhHOE5TeE5PZ3MyblN6SUMxWG9HbWlabVEwZ3pHZGhmNGF0?=
 =?utf-8?B?NXBITXBWNS96ZUdZVi83bnY5VWxOaVREYVNiR1VUdnBjYXBqditUUVgvQlY1?=
 =?utf-8?B?WVNkMXFzMVFZK2R0cFhZQjZpYXN6ZVpUOWxaSEJTZ094VXc2V0RMVjRWUkxk?=
 =?utf-8?B?alBTZHk0aWtvR2NocHg1TWRIU01WYkRScDhVbURQV2hRRTVPYzk1cUZZWXRr?=
 =?utf-8?Q?Pytnbr/lYdly6jBM=3D?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34026580-adb6-4210-0128-08df1885b0f8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:44:19.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOOoBCxEbSw1WRqZ2Xt+CcZCB97lejEjUM/fhU/5oGSOKDnRZGJFtMtelLbbcadWNPZZWGprjDvqB9r2NlXQbOextdOt41DURQHHQi1m/W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF5FB3746AA

Hi Martin,
     Thanks for your review.

On 9/14/2026 6:40 PM, Martin Blumenstingl wrote:
> 
> On Mon, Sep 14, 2026 at 10:56 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>
>> From: Qingpeng Yang <qingpeng.yang@amlogic.com>
>>
>> Mark the A9 ethernet power domain as always-on since it is required
>> for ethernet online wakeup and must not be powered down.
> Is "online wakeup" a wake up from suspend?
> If so: is the Ethernet controller listed with the "wakeup-source" flag
> in .dts{,i}?
> I'm wondering if the pmdomain and/or power (wakeup) frameworks in
> Linux have other ways of managing this case (e.g. only keeping the
> power domain active if needed).
> 

Yes, "online wakeup" here means wakeup from system suspend.
The Ethernet controller is not currently listed with the "wakeup-source"
flag in the .dtsi.

After internal discussion, we have decided not to support Ethernet
wakeup for now. So we will drop the always-on change for the Ethernet
power domain in this series.

> 
> Best regards,
> Martin
