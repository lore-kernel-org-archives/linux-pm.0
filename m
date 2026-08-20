Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023099.outbound.protection.outlook.com [52.101.127.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AB3B0AC7;
	Thu, 20 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207903; cv=fail; b=ippP8lUqZRKpWDNmv+maBWudfMk6QworOIH6E6en7bluJOmpPtnRrv8gkhNrH7AHSRhgB1VDgGQTpnhUhJLKZI/RkkeatM2SHg2Jwbxm+VuJBdg80bz7+s/HPJt58dyDDvdjhw203ECEueeUDlKcAyFx+us2PubsUtQZTv6woh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207903; c=relaxed/simple;
	bh=zZObH7qsiFL7V7bI6b0EmObZxdKQy9xh9PvXZjtWvzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qkFknXARx+fYVw5MooylvZ4sDJuJkna31loJUVSK4glnyvVQeenjENU3LMHcLRVq9z07l3MI6DNvOK17GHVnvoLDP58eC+x4EQsOK5zH+9Qe4RoBqAp2eowtwux43u5D2QRMOrvJCIqxJkz6fUDoWn1OYyIofCjynsL8dzrQOwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=p2STbYpt; arc=fail smtp.client-ip=52.101.127.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="p2STbYpt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okr+/rpx6qwMVQGH58rcDrv1A/7ypisljh2PhdSD2X/VpQV/eYZ3SwAOb/m138mQX55OB/iCxKhRRIcMRwjMeql8X3MdaASg+hR7WJk4OIf75VL3ZahRF99AnhnB6BKVC6tAktZCv0rY9pXGOfqzwdofs7lUaVoF1G2L6asRBhnjZDoY97JuD+BQ7Mpt2o/+qBj90E8aO7SFpbrlWTCQJRB/T8rb684co+A47ToHat1vXJcWzBiXjxoLrqNv+gVuWTsnjUCLzo1bmibfckMHvp+Qgl6CiM8zu6ptFPnrnoBSqNKE88Vt4uu31a5l5oHyebTfacRIk3aBtDorDb9pYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iebM4iC9OZyt8TSlwD9R7uM7uw36XWtckaIiJu0BTU8=;
 b=XukC1QyAGHPNFBKbI5i5iaeii6T+Exdu1ulKIapfyc3OXuSbAuIFN4YUEJoiDZ1vq0v7a6iGGJnijemvofxB9jJUaRnj24+4IX+mYbBCZ6fBAF4YTektRJq5+sMr1iAjdLujsrPPlrxB1I228PzsXCryjjFNDSCh00wDwhPZdRnK9vdsEFoAtV5kKe+8wOQdITtwjHn9OwEAsT5cksm/lzqno/ojAUXFDTYaZL1Qh0XM+1u4FhD+XwygYtFdhUPpA0UmyqQzC+VOQx60f3KhHKRBS0HV6VAiEVLGhuDD5LIaCeML3ZPrSy3h8bNuZbiXsL6qETmcF8rYIwWWI3tbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iebM4iC9OZyt8TSlwD9R7uM7uw36XWtckaIiJu0BTU8=;
 b=p2STbYpt5xkKCWmdbhYtTrCwexjmdVfI6/+SjipakJtEx1gBB5zzwZeDBc668yGT8JDjl+2sh9dkfJA2jGyXu3envFkc23Pb/BnziqvaQxzVwZId7GB4OOENh0wC2SJUg74UxrGMEeqmjwfWmrZCjGst0hw7CJ+4JroiNDc7JyA0M36e4shDu+JrAfkBjfufHhCZakmc9mXwDm8v7iAQFdYniIVSIdoZzPIHn9Jds0U65T/inBfscFACm1U3Z646ef8mAws6bN1p187mw7ANes3JvQKkO8h89BN6sZbVawfPoN2HKI+FlZekbd1/vbcMaP6RWoQFfnGwZzEh6ewG5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB8456.apcprd03.prod.outlook.com (2603:1096:101:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 06:38:16 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 06:38:16 +0000
Message-ID: <114b6c15-2975-44dd-8593-2fd23422b254@amlogic.com>
Date: Thu, 20 Aug 2026 14:38:11 +0800
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
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260813-international-optimal-limpet-dfb06e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2aa961-a91c-4bf4-7d64-08defe859d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3O8WrXjCOpN7eRWVYR929MbRiSE/aFicypdp9e+jYODQBYld5wObhxPDJeZnrqmVF8n/XvoVkuRRgiPLW2cEg3hOeufGOgKEAmrvDbNVWRUB8xbZefHd7X5OBRSILA95FST5y6tonbNFUgnrTOZOKxMhjDytP61pRcuebRIkBPtFfMyAK11QwBz36/haYZqq0TR7uJvFmshXFEjWUIcnI3fSJ+gT5hVRqOCAHSfjg9N5WYOQ6nz/QCcUkLrSDyfNKXYvfAA9kIYiO5TaF/d+sHSsTHIMlWHkdhLqNvFdspx7y8YBYMLVuMj+K3slqRya7Fq4HFkw6ry2o7f7/swTIjzPv5wCqzp9AFdYmrHpEdG0osYfGVYxFH3rtS3C26jDC0kiNW2R8b0+rZw4C+ETJzic/qFihupwElROQg/BdtRfRgpjcdLj1hb6rwMmnyA+uXX8uU/W0o6xZN7ARHjMv3IeHhsK70MI+26NFhbawCudlSiPzovN5m6vxaHt8zi8FF2zQ7fDBliHDQQfv9iGdhvdBWY+oo7YBAZEgM4Ov2qPlWnoyBZkT24Fhv3AwIDXF2e6mKkujDvRDoaOe//A99bSXrswyn6l5Zp5dpu9XID3eMkHaSm/qYa6JYOCuoAJYqBlGcFq36urSJtetBGfTUZQsEkcPW/BaMqGva0zMi0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHlnNTVhVFJPNEJuQmRqLzdJTFR2SC96SUZaa1BHTGtDbWlYU0wwenFXSDhR?=
 =?utf-8?B?TmJSbGZZTlN0Vm9vdmlaUkV2V0kvZnNYYnVPZGg3c2ZuSnl0MVJWTW9LZUE3?=
 =?utf-8?B?bXpwdm8xYzRWNjRiczQ5ME9qRnZramFXL3NxVkZTa0ppSHhqcHEzaG1CZlIw?=
 =?utf-8?B?NE5IZlk4dC9PaWxOa09md1Z2bTJyY3A2MXYvMTdBUmw2c1p5NFplTGNuaUZ0?=
 =?utf-8?B?N084RnJ2WUNYd0VJSUU0WW9uTDBkNjFOeHlyT0QvZk5jbGtaSm1KTGJSSGNj?=
 =?utf-8?B?NGRLUHdDK1FFeHVtemQ3OGxaRUVyODZOcmxEeDVRbFlyVkNSSXhyeTNFWFIz?=
 =?utf-8?B?cGZiekNMT2tiZUdteW5sdkh1MittNFBkV0YvalJoM2RZK25aQXUwREZkeWRX?=
 =?utf-8?B?ZEcwZGpySTF0dVhUcWpRRy9zY2R4SEZhVzMwRm1rQU1VMkloVHAzK291TWZG?=
 =?utf-8?B?SWpVZUwrdW9HdDJJejZEOWEzT29VMXUrS05RZXY1UFNyOFZybGR2NGJRVGlk?=
 =?utf-8?B?S0dlTTRzN0U1aFRSQ2tIb21ReXRyN0lHTXRyOGltaUQwdElBVkRrenZ0VnFX?=
 =?utf-8?B?VktZemtFaGZyLzdDejY5OTltSkJPZkxoYVdaY1RRN01OYXduK1E1Uy95VVRQ?=
 =?utf-8?B?ZFo3MlVvbzRIMFZRaFpDYi80RGFEcGcxS1A4OWF3ck1MN1RQOHJISitnYVBG?=
 =?utf-8?B?aDY0RkFoUVM2bFNFcjYyWjF1Umh2K1cveTRsaGQ3aFcrbUx1clI0ajJTTXlv?=
 =?utf-8?B?SWRkU1ZqbmY5eFVVMHhwenM3Vno4cXUvNXpGRXNwZ3gvdU5vM0kyOGsycnNH?=
 =?utf-8?B?RHFFQlFHbkRmc1JhL0JoMithQ2ljaGFjbk5JTnZvc1R2d09TdE5wbERmNm91?=
 =?utf-8?B?T0dZTWMwWHkxUWZlU3g0Mkg1dVRJUDljTVhjZmdBYXhCTzlscTZBZzBDVGJn?=
 =?utf-8?B?Y3NHVlRjWEZpMjI0TXdCOFJFdXBJUTM5dDhaMmh6elZwRFNwY25wdEhZSURk?=
 =?utf-8?B?Qm4rZjEveWJLTUNpc1FKRVU5RTNyQ2NSZEZ0d3FpNWU1YWppeEE5dXF0OHU4?=
 =?utf-8?B?SERkUU5GWnZXQ0hDakc0RWV6S0w3SThKSXNhZkpQY2p0OTZzUC9xVEFxaG9O?=
 =?utf-8?B?dVlpUnBQNk1CNEhMUlkzeUxOSGJqRUZxVzJGVFdPSEhHM1h2cDZROGF4a3JV?=
 =?utf-8?B?dHdNcWJVaVhIcGdkLzRjdk1ZVVJnUTRxZ1Z4Y2xGTWhWTnB5bW11UmJJR1Mz?=
 =?utf-8?B?ZHZsSTd1Tk9YcmN5emVla2dSQTZuRStFcDlmRFpubllkRGRsN0JXOEp6Wmtp?=
 =?utf-8?B?aUhEcC91b3hDbzVqWEEvMTJBTllzelZDZEVFNGwwMnlXeS9aWXhhcUFMUkQv?=
 =?utf-8?B?dFg1WDJwYzNXUVlGWDlLaHJSVzc3dzdJKzBhRUhLVjlqbUkyMDZkdWpXVlc3?=
 =?utf-8?B?akxQWElLUzZteU5vbUJQMWdZNEdIOWR5ZUJqWmlidVNPbndqVXY4RUU5YzBO?=
 =?utf-8?B?QUk2NDJka3pURlgwSXlWUG9sT29ZY05ScUNqSXdWckZsNXFKanB5a3hYaWJF?=
 =?utf-8?B?V3Nsa3pqUTFKWTVZcGJRaVdCeUI0Q1Q3NVc2a08xdzdON3FySURPNEdXeHRq?=
 =?utf-8?B?VnUrUVIxQWVvUE8wMjN1bG5Dd0xQL0hMZ2lJODV3N3ZUVUFPamlJZjhKc1ht?=
 =?utf-8?B?bVRSYmJBNDJwTXdrL3g2VGpxNTB2YWsycTdVNVdiY0RSSEwwaTArendJQ3Ry?=
 =?utf-8?B?MW9VS2V6T3R5UTZPdXM1anJtSTdoUS8xa0pRenlQOWhGZG5SZHJ6SjNjNE45?=
 =?utf-8?B?VEtiNXR6MCszcGNEWVZTeERKQkN1aTVXSldua1gzZHMzZVZaejB0UzJqQ1JS?=
 =?utf-8?B?MDN3cWgvbEltTFlmOExFNUp6NUtlMmx2VGYrOVh5M2xxQlgrVHVDUGZSOHNX?=
 =?utf-8?B?UjQ5cGNsZ2FnWG1PeG91WDIyQ2cyc3lteGF0V0hvUkdzUVBDZGtDYk5mcVhu?=
 =?utf-8?B?UjNESmJhZ1JBMThmcS9mNEMrRkRBMlFFOHRuSDlBMmluUm1ocDB5Y2xVMHU0?=
 =?utf-8?B?VGd5M29yeG15aVNwcEJDYWFoRjgrbnVFQTYwZElCM0VyUFhOK21EM29FU0ZN?=
 =?utf-8?B?blVvR0pPajJrRVkrM1J4MTZzdFp4QXBOV3lsMXpuVEloS280VkhEdi8xeDhu?=
 =?utf-8?B?TlpZZEFnWkxxNjMyL3MrZ29MaDZmbGYvMmt4MjJaOVZyZUdkaC92UFZvb2d6?=
 =?utf-8?B?NXAvQXdhQW84eUhlbnQ1RGhMNWtQczhtaWFwU1pVbi96MkVDN0xwTjE1QUNs?=
 =?utf-8?B?MmV6eE1lSTNlaklGLy9BNUFpSW4wVGRtSWRUV2VIOFdWUEdUUHQ5UT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2aa961-a91c-4bf4-7d64-08defe859d9f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 06:38:16.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuS7gwaBBqtnhM/lcBX5dVigghpGjnaU6pAZcQhhJtKYtr8ntnJOpbkOh/gwBnFXds+xC42YH4v9bwpxTC+eloPXWxJNf0f1fkBfjpsR8Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8456

Hi Krzysztof,
    Thanks for your review.

On 2026/8/13 16:28, Krzysztof Kozlowski wrote:
> On Tue, Aug 11, 2026 at 08:37:43AM +0000, Xianwei Zhao wrote:
>> Document the thermal controller compatibles for the Amlogic A9 SoC.
>>
>> Describe the required "core" and "plck" clocks, add the optional
>> "amlogic,hw-reset-temp" property, and update the schema constraints for
>> A9-specific thermal controllers.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   .../bindings/thermal/amlogic,thermal.yaml          | 28 +++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> index 8cfa44dcda58..f73ee66bcc47 100644
>> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>> @@ -23,6 +23,7 @@ properties:
>>             - const: amlogic,g12a-thermal
>>         - enum:
>>             - amlogic,a1-cpu-thermal
>> +          - amlogic,a9-thermal
>>             - amlogic,t7-thermal
>>
>>     reg:
>> @@ -32,7 +33,13 @@ properties:
>>       maxItems: 1
>>
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: pclk
>>
>>     power-domains:
>>       maxItems: 1
>> @@ -52,6 +59,10 @@ properties:
>>             - description: phandle to the secure monitor
>>             - description: sensor index to get specific calibration data
>>
>> +  amlogic,hw-reset-temp:
>> +    description: The hardware-controlled reset temperature value.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> Thermal zones define that, not custom properties.
> 

There are some differences here. The thermal zone goes through a 
software-controlled process and eventually triggers a restart or 
shutdown. There is some time between the temperature reaching the 
threshold and the actual restart or shutdown. In contrast, this 
attribute configures a hardware-level protection mechanism that directly 
triggers a restart when the temperature reaches the configured threshold.

If that's the case, do I also get it from Thermal zones?

>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -73,6 +84,21 @@ allOf:
>>         required:
>>           - amlogic,secure-monitor
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,a9-thermal
> Why is one clock valid as well for the new device?

The new device requires two clocks. I will add restrictive conditions 
accordingly.

> 
> Best regards,
> Krzysztof
