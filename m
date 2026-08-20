Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD53C10A8;
	Thu, 20 Aug 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210210; cv=fail; b=c8+SYAYq1Irz1FeGzl/2oOPaAZItr2XHFqywWc0Vc5OJFJM3pCGqfSMOyXnldVofBIje1jDsgUNsG0HlKGaoXl5MLjo6ocB/N0TLpB/FfQWzLTtSzSsoPyGhhqyS2UtadVode3ZfERZRcv2Dfp6Z31yuHmmJ3V7/9FhgTtF3JfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210210; c=relaxed/simple;
	bh=Dh5p6dsdEmPjsk2SCFStIN5b7GoxVYm2zHm6VGgJ4/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uaNHEEy+iucnA1oGsjmFSEysNSScHFif40TuRA45A2UTeKvNuKBcRIEYpeB6JCa/AOl9SYa175GrYf8xi3f6QRspcKNXze3tPl5YMvMrD9VaF5BApqaxu49B8Os85qi7LvWjPWdAYELVNKuOeCTHR7LfXE1wIMxmn2lDeIlytHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=HH+WeleN; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="HH+WeleN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7HT4ihVyto2ppE9nrLyBlBF2wHqBrn1CarrniCEWOhh18gjNnR+ZJ29WyqZrbLKldC9c5swvGUE6YRvpvL9yxudIru+0t8P1Hs4BmU6+D0PfsCCiPYAVmUHs3e1ZGpfrM92WuWTtJ39htYB8jYTszkucS52U41hKuH5mBANgodfjRvYrJEVBWjaWSiVd+z3si7bbSDq0WIRvRe22lc4JUe9VmbvAk9op3HIEP6DC2w0dZX4fL94KfAT4WaH7x5wFx243ptpy0dr1fXzMuWOkz5kZRxZ+3zgbGnU2cxEa+wUEAlgjpUwxk/shrh+tLBDiVe1eU2803innArWj6WFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIqsH1g76e9owGbBonrZZzsDN/aYRlRrWA1CAQ0TMqc=;
 b=MqroaBcGC1E7Y2SfOxk1GB01w/gy+TEWhLQRtG69l5WgIj8cbfYDb5FS4Px75UcuyLWK6HYZzgyau4/zzzW06t5WyFNaWawtD51ceZs9PYfH6eozkty8/gsk0VlUllEDzaMi9f2muIoHcXwhgjYMD4fKt5peUfSORHER5RFPXbPjnQVMHA4+euAZJVZKo71tRqUeGyBwcSzNpQ5ZmKbFJL7h4OTk9A6wOJH+SV670rCSUlOUe4+sjpaVONKl8jugAu+mEzsyT/ezZzPfATxQDJ8Giqumax0RVWW6yVrPeVQhMwg+J0o+TcAfhGjzXyGaOpRozme+4xTb5HEcmVhyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIqsH1g76e9owGbBonrZZzsDN/aYRlRrWA1CAQ0TMqc=;
 b=HH+WeleNhQin4jAsX8eMP9yS+4XGyHeeSWeY9eJj/DlnFRnBjx2UY6kSNGa7KpPiayBxVMQBFx7KyBeTj4WDgFyoxqDAKvLexUnnrJVMY2DN9C+/9pzf/nENiHRqR/4vv0PjOcYE4QNJ0XhylgtMM3B0NzYADawBG4BjynMuNqv2SGOVuwkG71Ew5w/eJtHeVwyK7vJtUHC9Fltnph7bnzXD9+dcDvV9l9z40gqm5qlSR89SnGds8S/vDX+u0f+jqgb/wOeD++uw186bwzsUg2UILcotuBH8fvySkvb8m+ap7iMmHqGXibGHAhr1wcUgQs0sMn7MMTEoDQ6/xdNt1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OSQPR03MB8484.apcprd03.prod.outlook.com (2603:1096:604:27a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:16:42 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 07:16:42 +0000
Message-ID: <d259882a-fdda-4336-bbd7-ff1b8bbaf8af@amlogic.com>
Date: Thu, 20 Aug 2026 15:16:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811-a9-thermal-v2-0-7ddc33b11b9a@amlogic.com>
 <20260811-a9-thermal-v2-1-7ddc33b11b9a@amlogic.com>
 <20260813-international-optimal-limpet-dfb06e@quoll>
 <114b6c15-2975-44dd-8593-2fd23422b254@amlogic.com>
 <7e4c40b5-e156-48fb-af0c-3c2d9271cb02@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <7e4c40b5-e156-48fb-af0c-3c2d9271cb02@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0136.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::15) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OSQPR03MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a340b-8a70-4f9a-1752-08defe8afbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|10067099003|3023799007|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	25Lcq7ITtEaoN2f6dDwuIahPb7QcTSH9hlm8ObXcgNo7jYpTPxw+O9HIaX42Ockh9dDBrUiGzXB7pu3AQzosZvaiOrHqkqKxEnRbhzSRh7AmukjmtbJ7SIuGX91VkbvH/eZ1/3Q4gC3Eklcs6Kko//rxGFT634z/U3xSwaai/fqla1qDCtb6qibmZn2ezI0/g7qK5vYfyLDm0TH0hmRRsTl2p5U37fc5TaBPn7dQ5+JkXbrRQTgS/+Err3v7ao2H6zTtX+qM+CX5PSivL4XW5hcg4EsXlh4lgBhxceWx4XKrVDbUNdAAwS93Grmg9ansC3MN655u84fhjo/Euo2WQGt8I6NvRvNS1NSkW5q7+k/BjKFgfeniciD6RWd159m8MKyhht0jQnHKh+ZECfjPqYR0iCKaUaYcvZqWHbBhi+oMm1MvmpYzmTos+uoznD+gh+zWj325Yqjk52ciTL8hSDMc6+7tGHpjPtO6QNKoXn/RwipN0ZKAVIh5hfBpVPDxIIEipnjgqCDC0+e6N9Cit2VaiQbrx7BLToeqSy/RPa2WX6lM+iLbDgJb42jEu0wQ3rfcF3ukVsGfgVLqnOkRDG+rc33MbEkb1NzwBg+EVnGPWan/1XvpmtJ5qsY0RQgPtvaOjIJuIkd+DAvV0/UOqw0sFfBmRjTCIZ2UJIBgv2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(10067099003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFoxR3g4WS90TXZmSHgvYkM4NXEyY052T1RJaVp2WW5lcVFCckM4ZzRXNVhj?=
 =?utf-8?B?cDdxWnlGelBGRFc1U2Z5VnQvbUkwUWRtcnJTUXpXUHM2bExGVUZsRXFiT28r?=
 =?utf-8?B?RWZKKys3QXV1V1VtMU5NOHJWcFFxSkdXUjRuMUdWTk9KK0pnV1I4Nmw2NWEz?=
 =?utf-8?B?NnRkRWtOYVEvVEdXZjA3REhBRTIyM0xLK281dE4rTHE3QWw3MVlEOXRrcVJJ?=
 =?utf-8?B?REVVQjRJcXRzcUVncjE4VGM4QnU1dmN3SjhZeVpaQjB5bHByU3ZxNUFXbG01?=
 =?utf-8?B?RnV5SUsrbTYydTdSbXAyTjZHenBDazFvZ0ZxL21IemdQQitYWE5MbmxZK3Y1?=
 =?utf-8?B?aFpITXlLRU85dVRjZjh1R0hqbUd4R2tYSm5HS1Q0YzRtZlcvbmxSWjJrTHpZ?=
 =?utf-8?B?TXhubmhVNGU0eHRmMmVYbDh1MVU5VXJkaXRKVjVvbkd2VVJRcUpyRkdvZmxP?=
 =?utf-8?B?dkIvSytKVlkxQXRzVS9XcnExNk0xZ1pUUXJOK0JFaTB2N0ZMQjBscFJsaXd4?=
 =?utf-8?B?TWozdUx3VFIrbU10QUYvVUozVmRpeEJLd2F0Y1o2aE9FbU9jYm9UK2k2RkVv?=
 =?utf-8?B?UXZxcVhOTXlLcTNoUGhZdWthUUVoQTRlZjB6NitKWlgzY0FlSDZZTHZKSU9P?=
 =?utf-8?B?LzJWYXYweHYrNVE3RU5NNi8wSkhrUTNkRzFHRDVOakJoOU1nc0hHRHhhMktk?=
 =?utf-8?B?Tmt4Nis4YVR4Vlp4bzBoMHFPSE50TXNrS2t0Y2piVXArUTFUaTd4bmNVVmZz?=
 =?utf-8?B?dDNxT2J6M0Y2Vlk2bUYvQ2dDa0cwNVl4K3pZYU5uSEV4OE03MWZIaVduL1Fj?=
 =?utf-8?B?eGdLTkU4UURaSEFWRGVNUUNSUVduNE9rZ2Y3ZHVZRmxUSWRjUVVudWd2QnIw?=
 =?utf-8?B?OWRNbFhvblV2ak1iMy9qSFk3cS9PbXgwREdHZkVWTlFmR2tSajhFOTdocVRv?=
 =?utf-8?B?ZndYWWpsYkNGUytKZlJqcGRUQmU5TTJ2OU9JSFZJbVdHOGVoR3VvMFEyN1BC?=
 =?utf-8?B?Zk9nSVgrMWNUZTNDYWd4RkVvT0QrbTFQL2dITUpCWnpRby9VRUNPRmJkQXBl?=
 =?utf-8?B?VUZlN0J5RjZxeWYzOHZRMjk1czgxWXk4MlBMVFVMY3JKdTljNkxRM2tBTS9u?=
 =?utf-8?B?djFMalhoNkY5aEw0YzczV2lvMk54TEpnZjlzOWIzb0xaalZZUDYyR01pWmIr?=
 =?utf-8?B?RmdVN09wSVdhL0dTSTZ5WndJbWRGQkxMMGIrSThFdVI5eHJpcWdmUU9mS295?=
 =?utf-8?B?MEZYb2dSUzMySUYwV21PZmVhWlhzTU9Oa0d1SE9WTG52YXkrNU1QL0hnOEhX?=
 =?utf-8?B?L0VXWmZOZlVwNlV4eWFiTEZaemJCU2praXlONDJ5ZTUwWlFCM2pIU2lzaHBi?=
 =?utf-8?B?bXJxRFlYeERrU2dZQUJ2Z3dibyt4c2ROVHUwS01IaUtzdDNtN3hhZHg3VlFS?=
 =?utf-8?B?M25vYzhTMDBvZ3pEa2lPS21YMUtmSllaMDhyOEVXdjk3cU90NVp5TEF5UHc2?=
 =?utf-8?B?R2NjZk1NUlhOT2RBdDd6MFp5Wi9KeXpqZ3JjZGk1cEd5Ujdmb3N5bFZxRGly?=
 =?utf-8?B?ZSt1Q1NHNEt1Wlp2TzI2Q0FFVTgvVk9qOXkyYWZEaXZQMEpjbzlTeG5lelpW?=
 =?utf-8?B?MEpMbWJIY292MzVVYlg3N2tQcXVoTE9xMS9WdTBRejJLdkJTT1FOWkhnOU5a?=
 =?utf-8?B?SU5Zdm1iNndxM0Y3WGcrdU14S1dOMFNVU2pISlFDT245YlN6VXlUU21VMmhR?=
 =?utf-8?B?WDNodjF2OVlZcEJZdXE3UjFFZDVISE1HaTJObEdXUEliYnNqV0YzQytGbmxS?=
 =?utf-8?B?cTVTTlNBQVBWY1E5M3hwWWFpUjhmcVFzUllVY1BDTEI2RzJvUngyWWhjTjZa?=
 =?utf-8?B?TWFpQkNZYW1DUndQd1RhVi9LN0tUcFJaamkvaGVNUVhLRnZmMlYvMSt3WTJu?=
 =?utf-8?B?a1NaRFhmMnE3ejZuckF4YXNYUlJJTXZqd0JWR3B4RFZjRFlrcnZuYm9DNDhz?=
 =?utf-8?B?MDhVQ3o0SmNpUnAyV1ZyYXJqY2ZuYnoyVUJqdmVaT250ME1OVTA1RHhGckRI?=
 =?utf-8?B?bUZla1lWRk9mMFJXWTQrS3A3Tk9uQkxaZ29jK25iYnlpQUFmWDM5OSsvYTVv?=
 =?utf-8?B?d2tmOWlDdkxDQ3BMN2U3OSt0cTZBMk13eXhpRU0vWUJzZzJoR2g5M2NLT2h0?=
 =?utf-8?B?UGM3d2ZvSEpJMktWUG5ZY2xoSDA3amF6L2c2cFhCamVzRmRpdzVoSFFOTDlL?=
 =?utf-8?B?ZzJXVk4vUTV1VTFUNjkrRndFM00xRGhWb1M0UjBsUnhBNHhhbkllc3d4VTlv?=
 =?utf-8?B?OHVjWkwzNUp0MXNSOEJUcStYRzlmbW1pVFVlTjZvWk9ybHpIcXk3dz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a340b-8a70-4f9a-1752-08defe8afbe9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:16:41.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0gu+kPQFvwJ9df8eoGCz4hvA3J0ichEL1zZII+PFen/7nyr+nCc+8kQHLOPARWXf8h25Qbj1JX6Vajik+8aV9iKZUcE5YDFGu0QxYELiAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8484



On 2026/8/20 14:49, Krzysztof Kozlowski wrote:
> On 20/08/2026 08:38, Xianwei Zhao wrote:
>> Hi Krzysztof,
>>      Thanks for your review.
>>
>> On 2026/8/13 16:28, Krzysztof Kozlowski wrote:
>>> On Tue, Aug 11, 2026 at 08:37:43AM +0000, Xianwei Zhao wrote:
>>>> Document the thermal controller compatibles for the Amlogic A9 SoC.
>>>>
>>>> Describe the required "core" and "plck" clocks, add the optional
>>>> "amlogic,hw-reset-temp" property, and update the schema constraints for
>>>> A9-specific thermal controllers.
>>>>
>>>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>>> ---
>>>>    .../bindings/thermal/amlogic,thermal.yaml          | 28 +++++++++++++++++++++-
>>>>    1 file changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>>> index 8cfa44dcda58..f73ee66bcc47 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>>>> @@ -23,6 +23,7 @@ properties:
>>>>              - const: amlogic,g12a-thermal
>>>>          - enum:
>>>>              - amlogic,a1-cpu-thermal
>>>> +          - amlogic,a9-thermal
>>>>              - amlogic,t7-thermal
>>>>
>>>>      reg:
>>>> @@ -32,7 +33,13 @@ properties:
>>>>        maxItems: 1
>>>>
>>>>      clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: core
>>>> +      - const: pclk
>>>>
>>>>      power-domains:
>>>>        maxItems: 1
>>>> @@ -52,6 +59,10 @@ properties:
>>>>              - description: phandle to the secure monitor
>>>>              - description: sensor index to get specific calibration data
>>>>
>>>> +  amlogic,hw-reset-temp:
>>>> +    description: The hardware-controlled reset temperature value.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> Thermal zones define that, not custom properties.
>>>
>> There are some differences here. The thermal zone goes through a
>> software-controlled process and eventually triggers a restart or
>> shutdown. There is some time between the temperature reaching the
>> threshold and the actual restart or shutdown. In contrast, this
> This feels like Linux problem, not binding? Fix Linux.
> 
>> attribute configures a hardware-level protection mechanism that directly
>> triggers a restart when the temperature reaches the configured threshold.
>>
>> If that's the case, do I also get it from Thermal zones?
> 
> Thermal zones define your hardware temperature constraints, not custom
> properties.
> 

I will remove "amlogic,hw-reset-temp" property.

> 
> Best regards,
> Krzysztof
