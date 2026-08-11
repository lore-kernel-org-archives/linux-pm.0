Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022104.outbound.protection.outlook.com [52.101.126.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF023BD17;
	Tue, 11 Aug 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428137; cv=fail; b=K6zfmklqVlpHJHGX3IygLJyNwtx3a9v+DkE/Vty8oCwonA4nEjtftMewcGoGPjGmEYeq95x00qRk0ECBjG7e0zSViStuWHhDvw9VoKe2GYCzTEJ7dzgIfd4dRQQYDZu0ZB/4EIutRwP+Gjgn5+276FkcE+dA9DDxGIVMwGtOq/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428137; c=relaxed/simple;
	bh=6sGJ6eeYAwgoh+JStSbdX6ZLUQY4vPIZlIKuxfyQNe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XF+Pvp8zDlZOY/QH2GS6TDGuW5VT1ugkAIxdNo8xe6pdBipiUGglJktmuyP6dUf4ChKzCnST7txlv0l/ziI8/NeB1AIbuQmFbtY/ExR/fOPf14CcFfIEmBS075ezIna3tEjqnBObm9OJNBJ5Zs9xqkfzfyM7YaSoayrZ0QrDPbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=NY9lzCcu; arc=fail smtp.client-ip=52.101.126.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="NY9lzCcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC8Gf/xgzA8YIHaqzLvppfpFB3q1a0INzU53e95fBuosC901HydAL5mrRo0QQLnDZYaR+vZZ6PeThVHzjwVicXrI9uqoVvY6N0Ys68pSV63AAv+XK5V9cBgUv330Gt8fkdsRlT6dtR2IQCDDZip17ZJUKxSch0iaupRQCYGU8D5ptO4fEMiE/QeCFm3FPyh2B5v2vWJ1Q2vUeSiyr/qrsdCGT9wSlNsluIhHBpDzcPSz4bk3oxX5GpoDF03zzyX76mtN/uZk8BKMhgUfgn8l4Q2SSCqkG24Nm1gI19+/wuD3kVK213LQT+vTox0bfNB7sSxTKCJ0qEe/5iHO/4+LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdwjFw3hgIo9TJKe3FgOlhC9yBULSqX4mzDSQ6wPNBg=;
 b=BbH1UAES6T7e7E8Vq7ICBme4aDpqJlxxgakSRyUH+GuhpVgYuuK8xsQwQ37KD2QP9lGum9UO/KQoaBrefwv1JF7AyAFwsHRETPfQrE1UQlSqxMya1vDj+pDP/DIA1FDpcpyZOXwsdu2Gq7epEKUEQkByFV1tQVFN1UYRegf+rbDJs32ujd+vsWW6089GMSza0perRteMXqpviKrKqu73+bLQOkyqkcwfHMnl6GbC6UgM4I9TLVdE9vmDT4NFKnb/I9aHA6RR/27ETTMeqMpPGVp+VLgj/cehDnC8ldZtpecQ7aq+Eb4qHRJf8hr9HWs8GlZpRbCVXNUpoY1+gwZebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdwjFw3hgIo9TJKe3FgOlhC9yBULSqX4mzDSQ6wPNBg=;
 b=NY9lzCcurU80v3a8zHp93teKfFrsJ0J5rPR8aS7wM8AJjI4uruEsHVLzYe88JZMhxbYfUJyzZW2aQna67+hll5TXuRdvjQgiY0m6QAHZoNoF03IP/aC9gbL+x/FP7mo9whw4P4fufdDRk8keBlfqQJ4wAE/X18UfquaFfhESvb5tqr+a7aVNjPhwq/3ZwnjqsRXtQmPiyDSlo7RotV43QdyBYaCtFwbNykUJbs+YGgWQgb6FQnELDtDVYM7IGO1vrA9JnYY6Uv307/VXVqF1GxH3lJP2JRKDBWCDuQA0M7xNF2CcU56YTmKbcl3PL2Le6FbVIJ84EiKAYa8JTYxyBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB8470.apcprd03.prod.outlook.com (2603:1096:101:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:02:10 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:02:10 +0000
Message-ID: <9b765345-fa16-4457-9906-e56874922317@amlogic.com>
Date: Tue, 11 Aug 2026 14:02:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: amlogic: Add support for A9 thermal
 controller
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
 <20260730-a9-thermal-v1-2-d786d37cba58@amlogic.com>
 <727d6bc8-4682-4fed-97a1-e16efab8fbb2@oss.qualcomm.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <727d6bc8-4682-4fed-97a1-e16efab8fbb2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 56236df8-ad3b-4bc0-604c-08def76e1511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o5rnAdxr3YPT4CZ1/ZFB+SFcAxAONZrMgvnYryxa2DefPR159MPKNsBLbK4yuoqbNM3Z+GpP25k0BJbZwDGtySobGMh4KvFDVLkpVkke2fhnThfds8LQ2ViYfqIoX48lrB0J0RxN33tEvlqRzZFcvhYadpc5Kqc20FwbfF33jCWlM5LlR1Ii4Pewr59RDMjQUYPnBZAORIjqCiFOnHnIAOhNKtNSx5Z0J85mAod4VMxbrdhJxv8xp5Hx5Zk+7Qavv7+iSvoftGQuIBUrlUc+SZzoravY1SX3wWi3XZd+rDMDCCKJnCzFX8Wl6Ptb8pPFNGe5doMhY9JYh1l/Vzr8+ksPwWmDWJcawetl0QPYWUp1yMwB+XuqGtuzTC0oYGiLkiNYT3TaLuSoifHoJG3mLdo2myxodIfwtPzDLIpAs269iLE/PxsVMOBs7YtZFCd6itbW+uzNbnxUhro38oANw7lw5Joku6GiRukkHZVRibKx2sIzZHM4KzlDp21/dK4Bqy2yNu1ROIfgUYvygR877hCZhianSxy7qaHtU9WvUns0SrEMRB0uVPyv7v325sLMf4QZ5bA4ElazV8wUdBBcPq7No7x+fUqvXPI2YWTJ9q4P/mLZGeObXTtWypERkMTONNtHgS/mBViZpjOibLxjENOF+K35ZbVENzTknuVHbaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2VVcWNMVGJmZ2twUzlvUFVRWEFoMTdVTFk1cmZucmg3bTkrbEJOQkZYaHRO?=
 =?utf-8?B?c3NKSDBFK3NWYngyc3JEWVBrdmt5bWQ5aVYwU01BRzY0UDJpVlgxZHJvKzE3?=
 =?utf-8?B?NmJTQ0h1bVY4WGl0S0pHWHNDUXo3NlNKbnVCanh5YWlLTzRIRGhIc01Od2JF?=
 =?utf-8?B?ekUwNHVCSmN5ZWxHTVlZNTIwVXBmR2UrQkhvdTlJUHd3ZVc3aHRIYy9VOGoy?=
 =?utf-8?B?YkxwTUdiMW9QY3dzNXdaYU9WdVY2a1ZCcE1PcHBEeEwzMHduSHB2S2tLRzU0?=
 =?utf-8?B?cDZpMFJTeW5QSzJnZzd6VnU4Nm93WGIyYWM5Mlh1bVY5djNwSTVwSnlHSk15?=
 =?utf-8?B?bUg4NFArSWxrUjMrL2N2U1hTT25aVjJ5NnppdU12Mm5tUDREMGVFWDdUcXVZ?=
 =?utf-8?B?VnRocFE1TVoyc1VtTTJVbnp4RGNGNnhDRE4xMW1EK2x6NlBpTkRKd2NsV2FM?=
 =?utf-8?B?T3RyNFNRbCtWU3hvR1lVbmdqWjZpKzRERXNGdk9SUnlrcVJIcUxFTzBNU0t0?=
 =?utf-8?B?Sm4xNTIzL0d6c3FucnZac3BOTlV6ZEIrNStUR0dBSGZJeUdvV2tiMHBvQ3Z1?=
 =?utf-8?B?WTF4TmFUeUpIbXFkcTErbHo5VS9lcVpCb1U3aUIwSGhjSmlUOU8xSnZ2aGxZ?=
 =?utf-8?B?Sml4aXZLdHRyTkJybW1OZ0h1NUlSQ0NlRmNLYWhZZm1WUEFNTWMrWGlicFVE?=
 =?utf-8?B?bytjNEdxbG1jVGp3NndxVmVqVU9xVEhBU2t1czhDbVFDa0lHMlJEbkNhRGcr?=
 =?utf-8?B?aGxQazNDL1hDQXNTZUErREJUOGNtblRkOGV5TVNFNTIveHZVUXBnUGRtR08z?=
 =?utf-8?B?ZWtvVTVISzkzYkRmMEJpemNjQkE2Q3U5b3lPWjJUQ21FNEZNbCtkam0zYjhu?=
 =?utf-8?B?N1FFS21DL1Z0cS8rOTlmV2ZEZmNPVjE0NzBJK05GZkNxSGJBaXdkUHF2Q3Zj?=
 =?utf-8?B?NFhSbzUvSUl2Rklia242UzFETHdmZVBMa1pMRzU2R2x5blJQZnZseEpab3Mv?=
 =?utf-8?B?bndVbGJYaXVpc3VFWEdoQzhtZU9rMlFNV3l0VEN4YVV4UXgwT2ZLeG9oVkhQ?=
 =?utf-8?B?T1I0S25aWEJ6b0w5SFdaaG9jeEhkU1JVK2RmMmVsTWJrNFpiYXZWK1pRalU4?=
 =?utf-8?B?WkY4N2Y0WHhoY1BvYm9tOWtIdk1kaVVkSjFOWS9mazhzWWs4dWc5cnAzM29v?=
 =?utf-8?B?bDh6REErTkpYdDdDOVZTY2xVTDZ1OGJxOWo1NVZSMXBrTnZsVW02eElZY0tt?=
 =?utf-8?B?K3RpY1VCTGt3L0NnQ0J5WVFrRzEyeXFDdkhVTDhYUWZ1WEw2dFNmUGJ0UkNR?=
 =?utf-8?B?emcrTGdQUW1wZzlzbkRlVG9TSEN0dW5neHZsMDU4Qk1KbnF1SWtsQkZJVlNx?=
 =?utf-8?B?TGNXRFVnTVovTVU5OXBxeTdMS2NLNFdMMFVrQ0VuSVoyRzZFSjZsa1ZTV3Zy?=
 =?utf-8?B?LzNXMHZDTjgwUDliSDYwQ3Uxa3NKWmQvd0h0OEhnQmtyMWpkUVRndmdYdmQ1?=
 =?utf-8?B?Z3NaQk5mQW05V05EQ2xEL1J5SWFIWVRuc0p3c3BNLzFDMDdySXltVmEyV0FC?=
 =?utf-8?B?QjZ1Qmpldk9pYjNRZGFxUmsrNHoxQTlORmcwOEFSUnpCdDlnK29QeWh1UVBE?=
 =?utf-8?B?YzlqLzNYYWQvK3NwMC9teXhIM2tHUlQ4MjlHaTFQQ25GdWpySzVuUENEWmli?=
 =?utf-8?B?RFRvc2tuRDAxL1V3dWJPT1VpRzFFL2FrNy84dzF2djUvd0hIb0tmaVZwZzc3?=
 =?utf-8?B?TDZNZ3lLK29aUjlUb2NZckhrMUNzOTRWTzRWdWxIaTVUQ0dUeFN3M0JINkZa?=
 =?utf-8?B?c0RESjdUVDY5WVc2UXNFV08wUU9ncjV2NWJ6RmVHSURQZTd5b1VJRDNvUE5G?=
 =?utf-8?B?VWtIRno5eXM3SXlzSi9DSCtYMllRajFwWEw5b3U2UnYwcHJrZUUzQWd1dXk2?=
 =?utf-8?B?VzhEUHBIcmhqVWVGR3Vzak05WEZlNEdSRmdYUm5ma0dyTjlmSWlGN3JpRHVQ?=
 =?utf-8?B?MzRHRHM0R3gzSUM0akhsOXV3bFlzVTZUdnA1VG1DdWF5WE9kSTJMMmtudmY1?=
 =?utf-8?B?RTVYcG5QT0kzWlk0WlRCYVRuZzNLZVVPZHJPVTY4TzFOYUhXQ2FWdEdaQTYr?=
 =?utf-8?B?NWFOZUlmaXdtT0FEZ291TkRIVlVXMlFLS3kweUFocW9Rc1hXdTNoVlpNQVVO?=
 =?utf-8?B?cUt1R0lHNUN2R2JIeFo2bHpaWE95Tlo2Q2VMNVlrd0FNajVITnBZeWN0Mnla?=
 =?utf-8?B?MDVoMWdmWi9LWmdVT0JwV3JaWkIrdWlxYy85SmZQWmhobW1KSWtHeWFLakVa?=
 =?utf-8?B?QVlxdmpPemNlR1JtNHFmM0IvODU1TVU5WFR6Y0EyVjZaRnQ4bm9Ddz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56236df8-ad3b-4bc0-604c-08def76e1511
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 06:02:10.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGpzWLeV7l9fXQd17utFsKXcVxJ/xofPmknex1UR9rfyHNtGzTmDn/JOHnILUc8HcgUwrEJhdrf6HalFG5qNpvEcYhazIw0YEVR9afN8umA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8470

Hi Daniel,
    Thanks for your review.

On 2026/8/7 20:27, Daniel Lezcano wrote:
> On 7/30/26 10:34, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add support for the Amlogic A9 thermal controller.
>>
>> The A9 thermal controller uses different calibration parameters, requires
>> separate core and bus clocks, and supports a hardware over-temperature
>> reset mechanism.
>>
>> Add the A9 calibration data, retrieve the clocks by name, and configure
>> the hardware reset temperature through the optional 
>> 'amlogic,hw-reset-temp'
>> DT property. When the property is absent, use the default reset 
>> temperature
>> of 110°C.
>>
>> Also restore the hardware reset configuration after resume.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/thermal/amlogic_thermal.c | 107 
>> ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 104 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/amlogic_thermal.c 
>> b/drivers/thermal/amlogic_thermal.c
>> index a0b530624b60..c9c351496653 100644
>> --- a/drivers/thermal/amlogic_thermal.c
>> +++ b/drivers/thermal/amlogic_thermal.c
>> @@ -45,6 +45,18 @@
>>                TSENSOR_CFG_REG1_DEM_EN |      \
>>                TSENSOR_CFG_REG1_CH_SEL)
>>
>> +#define TSENSOR_CFG_REG2                     0x8
>> +     #define TSENSOR_CFG_REG2_HITEMP_EN      BIT(31)
>> +     #define TSENSOR_CFG_REG2_REBOOT_EN      BIT(30)
>> +     #define TSENSOR_CFG_REG2_REBOOT_CODE    GENMASK(15, 4)
>> +     #define TSENSOR_CFG_REG2_REBOOT_TIME    GENMASK(23, 16)
>> +     #define TSENSOR_CFG_REG2_ENABLE         \
>> +             (TSENSOR_CFG_REG2_HITEMP_EN |   \
>> +              TSENSOR_CFG_REG2_REBOOT_EN |   \
>> +              TSENSOR_CFG_REG2_REBOOT_TIME)
>> +
>> +#define TSENSOR_TEMP_CAL             1
>> +
>>   #define TSENSOR_STAT0                       0x40
>>
>>   #define TSENSOR_STAT9                       0x64
>> @@ -63,6 +75,7 @@
>>
>>   #define TSENSOR_CALIB_OFFSET        1
>>   #define TSENSOR_CALIB_SHIFT 4
>> +#define TSENSOR_HW_RESET_DEFAULT_TEMP        110000
>>
>>   /**
>>    * struct amlogic_thermal_soc_calib_data
>> @@ -93,6 +106,7 @@ struct amlogic_thermal_data {
>>       const struct amlogic_thermal_soc_calib_data 
>> *calibration_parameters;
>>       const struct regmap_config *regmap_config;
>>       bool use_sm;
>> +     bool has_sysclk;
>>   };
>>
>>   struct amlogic_thermal {
>> @@ -101,8 +115,10 @@ struct amlogic_thermal {
>>       struct regmap *regmap;
>>       struct regmap *sec_ao_map;
>>       struct clk *clk;
>> +     struct clk *sysclk;
>>       struct thermal_zone_device *tzd;
>>       u32 trim_info;
>> +     u32 temp_code;
>>       struct meson_sm_firmware *sm_fw;
>>       u32 tsensor_id;
>>   };
>> @@ -138,6 +154,46 @@ static int 
>> amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
>>       return temp;
>>   }
>>
>> +/*
>> + * Calculate a temperature code from a temperature value .
>> + * The unit of the temperature is degree milliCelsius.
>> + */
>> +static u32 amlogic_thermal_millicelsius_to_code(struct 
>> amlogic_thermal *pdata, int millicelsius)
>> +{
>> +     const struct amlogic_thermal_soc_calib_data *param =
>> +                                     
>> pdata->data->calibration_parameters;
>> +     s64 factor, uptat, uefuse;
>> +     u32 temp_code;
>> +
>> +     uefuse = pdata->trim_info & TSENSOR_TRIM_SIGN_MASK ?
>> +                          ~(pdata->trim_info & 
>> TSENSOR_TRIM_TEMP_MASK) + 1 :
>> +                          (pdata->trim_info & TSENSOR_TRIM_TEMP_MASK);
>> +
>> +     factor = param->B + div_s64(millicelsius, 100);
>> +     factor = BIT(16) * factor;
>> +     factor = div_s64(factor, param->A);
>> +     factor = factor - (uefuse & TSENSOR_TRIM_TEMP_MASK);
>> +
>> +     uptat = param->n * factor;
>> +     uptat = div_s64(uptat, BIT(16));
>> +     uptat = param->m - uptat;
>> +
>> +     factor = factor * 100;
>> +     factor = div_s64(factor, uptat);
>> +
>> +     temp_code = ((factor >> 0x4) & TSENSOR_TEMP_MASK) + 
>> TSENSOR_TEMP_CAL;
>> +
>> +     return temp_code;
>> +}
>> +
>> +static void amlogic_tsensor_setup_hw_reset(struct amlogic_thermal *data)
>> +{
>> +     regmap_update_bits(data->regmap, TSENSOR_CFG_REG2, 
>> TSENSOR_CFG_REG2_REBOOT_CODE,
>> +                        data->temp_code << 0x4);
>> +     regmap_update_bits(data->regmap, TSENSOR_CFG_REG2,
>> +                        TSENSOR_CFG_REG2_ENABLE, 
>> TSENSOR_CFG_REG2_ENABLE);
>> +}
>> +
>>   static int amlogic_thermal_enable(struct amlogic_thermal *data)
>>   {
>>       int ret;
>> @@ -254,6 +310,13 @@ static const struct 
>> amlogic_thermal_soc_calib_data amlogic_thermal_g12a = {
>>       .n = 324,
>>   };
>>
>> +static const struct amlogic_thermal_soc_calib_data amlogic_thermal_a9 
>> = {
>> +     .A = 9164,
>> +     .B = 2747,
>> +     .m = 370,
>> +     .n = 270,
>> +};
>> +
>>   static const struct amlogic_thermal_data 
>> amlogic_thermal_g12a_cpu_param = {
>>       .u_efuse_off = 0x128,
>>       .calibration_parameters = &amlogic_thermal_g12a,
>> @@ -272,6 +335,13 @@ static const struct amlogic_thermal_data 
>> amlogic_thermal_a1_cpu_param = {
>>       .regmap_config = &amlogic_thermal_regmap_config_g12a,
>>   };
>>
>> +static const struct amlogic_thermal_data amlogic_thermal_a9_param = {
>> +     .use_sm                 = true,
>> +     .has_sysclk             = true,
>> +     .calibration_parameters = &amlogic_thermal_a9,
>> +     .regmap_config          = &amlogic_thermal_regmap_config_g12a,
>> +};
>> +
>>   static const struct amlogic_thermal_data amlogic_thermal_t7_param = {
>>       .use_sm                 = true,
>>       .calibration_parameters = &amlogic_thermal_g12a,
>> @@ -291,6 +361,10 @@ static const struct of_device_id 
>> of_amlogic_thermal_match[] = {
>>               .compatible = "amlogic,a1-cpu-thermal",
>>               .data = &amlogic_thermal_a1_cpu_param,
>>       },
>> +     {
>> +             .compatible = "amlogic,a9-thermal",
>> +             .data = &amlogic_thermal_a9_param,
>> +     },
>>       {
>>               .compatible = "amlogic,t7-thermal",
>>               .data = &amlogic_thermal_t7_param,
>> @@ -305,6 +379,7 @@ static int amlogic_thermal_probe(struct 
>> platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       void __iomem *base;
>>       int ret;
>> +     u32 reset_temp;
>>
>>       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>       if (!pdata)
>> @@ -323,9 +398,24 @@ static int amlogic_thermal_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(pdata->regmap))
>>               return PTR_ERR(pdata->regmap);
>>
>> -     pdata->clk = devm_clk_get(dev, NULL);
>> -     if (IS_ERR(pdata->clk))
>> -             return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed 
>> to get clock\n");
>> +     if (pdata->data->has_sysclk) {
>> +             pdata->clk = devm_clk_get(dev, "core");
>> +             if (IS_ERR(pdata->clk))
>> +                     return dev_err_probe(dev, PTR_ERR(pdata->clk), 
>> "failed to get core clk\n");
>> +             pdata->sysclk = devm_clk_get_enabled(dev, "pclk");
>> +             if (IS_ERR(pdata->sysclk))
>> +                     return dev_err_probe(dev, 
>> PTR_ERR(pdata->sysclk), "failed to get pclk\n");
>> +     } else {
>> +             pdata->clk = devm_clk_get(dev, NULL);
>> +             if (IS_ERR(pdata->clk))
>> +                     return dev_err_probe(dev, PTR_ERR(pdata->clk), 
>> "failed to get clock\n");
>> +     }
>> +
>> +     if (of_property_read_u32(pdev->dev.of_node, 
>> "amlogic,hw-reset-temp", &reset_temp)) {
>> +             dev_dbg(dev, "using default hardware reset temperature\n");
>> +             reset_temp = TSENSOR_HW_RESET_DEFAULT_TEMP;
>> +     }
> 
> Old SoC without the 'amlogic,hw-reset-temp' will now default to
> TSENSOR_HW_RESET_DEFAULT_TEMP
> 

This restart temperature setting is available on all chips, but it was 
not supported before. Here, a default value has been added.

>> +
>>
>>       if (pdata->data->use_sm)
>>               ret = amlogic_thermal_probe_sm(pdev, pdata);
>> @@ -346,6 +436,10 @@ static int amlogic_thermal_probe(struct 
>> platform_device *pdev)
>>
>>       devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
>>
>> +     pdata->temp_code = amlogic_thermal_millicelsius_to_code(pdata, 
>> reset_temp);
>> +
>> +     amlogic_tsensor_setup_hw_reset(pdata);
> 
> Somehow related to the above comment, should it be only for A9 ?
> 

I will add corresponding commont to describe it.

>> +
>>       ret = amlogic_thermal_enable(pdata);
>>
>>       return ret;
>> @@ -355,6 +449,8 @@ static void amlogic_thermal_remove(struct 
>> platform_device *pdev)
>>   {
>>       struct amlogic_thermal *data = platform_get_drvdata(pdev);
>>
>> +     if (data->data->has_sysclk)
>> +             clk_disable_unprepare(data->sysclk);
> 
> Not needed, devm_ is used in the probe function
> 
Indeed, I will remove it.

>>       amlogic_thermal_disable(data);
>>   }
>>
>> @@ -363,6 +459,8 @@ static int amlogic_thermal_suspend(struct device 
>> *dev)
>>       struct amlogic_thermal *data = dev_get_drvdata(dev);
>>
>>       amlogic_thermal_disable(data);
>> +     if (data->data->has_sysclk)
>> +             clk_disable_unprepare(data->sysclk);
>>
>>       return 0;
>>   }
>> @@ -371,6 +469,9 @@ static int amlogic_thermal_resume(struct device *dev)
>>   {
>>       struct amlogic_thermal *data = dev_get_drvdata(dev);
>>
>> +     amlogic_tsensor_setup_hw_reset(data);
>> +     if (data->data->has_sysclk)
>> +             clk_prepare_enable(data->sysclk);
> 
> Shouldn't the clock enabled before accessing the register in
> amlogic_tsensor_setup_hw_reset() ?
>

Will do.


>>       return amlogic_thermal_enable(data);
>>   }
>>
