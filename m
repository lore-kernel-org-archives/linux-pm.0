Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17964519BD;
	Wed, 29 Jul 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352257; cv=fail; b=kvvhKsokERyTfFZ+8QwarQlnp8ZetrUeS2pGlsnTDxU32QZ8wHQAFQEO3BhBqbYHVNGVoDnc0ABoC/xPAyr7v8pN7mZcW6/FQFuiM648uvTS5176VwaXTmzs2ECmqmfNWAKGF/XVbac181mXWM3XHW3cHvscJHyBxNPWCTyiEXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352257; c=relaxed/simple;
	bh=6JAW9YpF8imCMfkvSC0pU0iZRAcxEj8IuUo6B3nPqc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4GzCduyojRsK+DyPyIduFLtLTpMOfZMYfy6M9h8DJTdrG4Y4uJ5bAbTpXiJ2drGf5gvRWb/OR+s3Z7uGM+LhHGu7t19cB9q7xG5vHajNddOvMKHruktLwA26sx45jMW/wFtjN9sk1nmZSr/q0SdhNMxl27Fvf6HIBavKQssp3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lX6hCp49; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lX6hCp49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2Vpknmsgu68UcJU9eDEFq/QJTfxB+OASdb2P9tAkJN4K4G0LjqDmjMLujTtsh3KG0F9TAf1SqX81/uZ9uy7JbIMCEoI0PxUlIHxWFxB4tv5sdF39kj9TWnDo6XRlXBA8n2J1qojEon09rgFw8C4po4Z1p3QfTgjV9sT01e/WJafq67S6aZs4ewISNs5o5z2YCibOPoFKMQNAZudt+4eupSbXV49gnH5yKCcCpOZhc497YRpSSj+6xessQUcK3Gu6wQUYaDN4U/zkF1BbsnKGnjW5QVpxFw3+2crk2IySY5znPBslIKw1PLFm5wXf+5bD1BPEmGbD/CYU7z/sd0yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BotRfndZVPXIZQUb9cLgKWNijf/xDu8Hb3Mog8/yWao=;
 b=TgbWAKmS5v3tkcT5Coi6oLwrX9ttN+LmsaMwC2tFY/h+1O+SL56m3IYtcsmtk9Uf+ENorXqDJgiNoC6ZJhv4uCjrLQu588dgVfulSzJK3GDFAbiPFoWwCVVgU8+CNMQUueEd9GC6wPUlKMpBERIYAD/eUX5+sGD/rEW1u551eRukHB91MCR6i2i2kLf+V1nRbp1UBydX8sp9Usv/oRVsyy8G4zRSDrwR/8fIf2Vq9oRdB/7monKEw6mt/xIL4RszSNevzLV7mj/+xPiRfKfQ9weTerQaoT5ExduoGwOGZac8NwqV6xyC0TfN37kXYx1gQERLY4Ug6V99hJngPbEOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BotRfndZVPXIZQUb9cLgKWNijf/xDu8Hb3Mog8/yWao=;
 b=lX6hCp493bT0mQjhy9l8SSZEmEVk2SY55Z26siI0fYE27ZldN4qX3v0ItVQTJF1OrQutvJ0B1/WjfbSL11NZXB5KsF+g6cASleyYJdT4YspApX0ZdeR2PRmq8/L+zEDT7buKtbd2ToSlU38FyqldKxBpzJGn5nAU9lagozJ0Oxy20aEXslW62AqsTGI2v968XwqL/XpD1Eiuuu2+n1HW13GhgrCxogy4N3yQ+qWlZ4jhrXZM1Yf7YdQproBwFRyICRfmV9Op1m5MDtqy1p9oQJT0pE0kautqCVx3eJxCdrhgKRIblPNEn5LiZ70B4iP+Hpoa6qF7B8QscKkmRBhRFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 19:10:51 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 19:10:51 +0000
Message-ID: <ae4e72b2-36a6-4d2e-a176-83384c0292d7@nvidia.com>
Date: Thu, 30 Jul 2026 00:40:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-4-sumitg@nvidia.com>
 <c8f62b1d-4ab5-4d85-ae15-b5fc9ec2e3bc@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c8f62b1d-4ab5-4d85-ae15-b5fc9ec2e3bc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:260::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebe1194-03c3-419a-8545-08deeda51aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|921020|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dLIA3jRiTIEVxlmX4ckpxlPCJjOlKfzkOwpdPMXjAPndUxOx+ycObjWk8pTE+eHPXsChNXYJK5cA2a2gwBG4eVdYc/w9/x0sqtX1ceBzVHP/Ee9pK+z8z1nEvZRGaF5Ir9WKeH5HsfpDdN2sRYX5V3gFoomlaENOhPmS6WBLenlLt8ojIy9uz//daB/UIZ0TmddkONudM4iZvREgWzirpawkIhPSm7Lx1xtIRmLbtdd5369pGXO1eemcMFK2ruFQQGDfOef1kgxYOhDcS+MiwW4tGmLl4kxjRm8BtRLbkiZsA0K9N0/S2h3QoAn4IPBRWAZpy4cAoAsIiOAWGMcvOKKoqY5u6H78AvfRTcfHT4uouBCNATkDeLSED4KwRlPBnuJf1hqUFVteOOyGX/isE4uY9FOrkHLIfIM6bTwm2Kf8iQhvwcxCtXk1zp+SwxiKdeBpCebMJTi3qg+bFGcFynTP4K0eCaMW73jREDXYtcizBJDSqgXL5H+Oo8DDiKXGmxi+VZIa1J6Uimtc8gY63il/D0dYVMSzQa3tAN280Y8kvyVoY+OCxr2TEeH/Rzd0JrEvZL3dN4Aamcy6nyhOaMRSvzSj9R1bOWslMaBvLM3SGzh99k2hRxEIEH9h7WAM/13Q6jXzGIenVdyViMzhkj8Gge2lWMf0xFrgOya5tttQcuBcreAKxc0Drwq78mtLWxFdMfCDEBm54B/jrk+jWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(921020)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1Yd01lSkVHWGlkK0xVV2IxSTlQNmFzekdkY3R4QTBQU01vUVhsYjAvL1RM?=
 =?utf-8?B?N2pYNWpXeEFLSEY5M3ZTSzJnZU5IbzhaM1U3cXA4Z1ZWQ1BBdkI3NThsUUNu?=
 =?utf-8?B?dzhSeHloMldCVWk0UG11RTEzbTZJZUoyTzFMU09LWUR2U0tyV08vUlBHNnZy?=
 =?utf-8?B?SHc5bVZadzBzN1E4Nlh1cWNwVlRkOXluNDFKcXIxZi9MN0ZuNXFlRDdlVTgw?=
 =?utf-8?B?OGl3THpDbVhtNGM0MEhtYk9QVzJxWGY4OCtlOXN6OWdNbFBuR2dwZE9wTEJp?=
 =?utf-8?B?cmowZGZ2Tmk1QU5GQW5KRG95VU40SUw1Z2RDbGFIVFhhNmgzd2tuSDltaWpz?=
 =?utf-8?B?SmxmNCtpaFFrelc4dCtVZDRVZWF6cVk5SEo3OGp3MXRLUTBjdVNDdit0ZE9i?=
 =?utf-8?B?UmgzYllLUmQ4NzhFVlJ4ZkhVeGFNdWx0T3ZEdHN2SGEySnhrRVUraGV5MjAr?=
 =?utf-8?B?d3lXNkhlK1BKbGxHSkgxV0hoVWdVeWJDTUo3ai9Ia042dnJpUEZrU1d1R0ky?=
 =?utf-8?B?L1NMUGhpYW5hSE1LNTRDK3BXSURvdmUwZkpZMURsSTY5S0d2dVJjaUpaNzFv?=
 =?utf-8?B?YkZPZVdQVHJlTVg0QnQxdldHd1dVSnJSNUIwK3lYdFFsVTZVaTk5WHlCem83?=
 =?utf-8?B?QjljNVRoRVc2aWFtd3lwWVhSUmRsM1J5TVllZmZXd1ZUaHpRM0tiQytacVF0?=
 =?utf-8?B?UnNPekpnbDBRSWo2eENGSEM5dEJ4Vjk2amVqOEMyYUVKN1pXa3lTZHZyWk1t?=
 =?utf-8?B?Z2svNnM1SktQajFWNVdlWjBzYlZ5Q0xNVEpSc1c5aGZYNEdidmtLbTBRWG9S?=
 =?utf-8?B?aGNGYUtsbXFyUk10WmdrUUl3eDRvY24ybHdLbnd1dDkzYy9aMDRvTm9mdTlF?=
 =?utf-8?B?NEFZUFZIb2ZhTkQ0VGVJeW41N3R4SzNKY0ZZQzJ2RDZ0aWNKTWJjclFWaVow?=
 =?utf-8?B?ejBmR05mN2ZEdktzUzgvQzNZWFkrVUFTMndIb1lnNlFJUE9wYWNyYnpvdWxa?=
 =?utf-8?B?UkY4L2tMam5SdGlSaTN6NDNmYWJhK0orNTc1NUtxY3dwTkFpNGlub2EwbjQ5?=
 =?utf-8?B?ZmVqd3czc1gxdkZhWjdJZ3dtbVZnV296TDJMK2l6c1VUZWMvc2dsRk13RmpR?=
 =?utf-8?B?TTJ3M3BoZHhBR0hzREgxNXlRZnlLdlJWUG1HTENaWVJFdUhZd1AvVTdrOVlF?=
 =?utf-8?B?b3JpVEFjQkZFbS9ISFpDVU90SW40eFZRU20zcE4yeVBsZ2N2UFBRSnY1OUNS?=
 =?utf-8?B?V0hWNG0zcGpIeVRRdUFkNkxUb3BVWUZTUWJWZDZDenMzNE00VUlqTWxrNlNB?=
 =?utf-8?B?MzF1cTlENE5JSFJOUTZDOG55bEJyZkJOeFgxdll6SUZZVDdaUUQ1OUU5cisr?=
 =?utf-8?B?U2lja1FEUVV0U2x5b2srRnA0SC9OZDFIeG82SlVvalUxbVlWaWtTcjcwYlBY?=
 =?utf-8?B?K3Q0bmdXMElmS3pCMGsxYjJsOFF1M3lYQ3lwRSt5QzA1aTNZaTlMQytDNmwv?=
 =?utf-8?B?S1QwY2h3RGVSUHUzcUdEazhmcmg3ay84czN0dmd6SHBrRDFQMXNxMXNDamgr?=
 =?utf-8?B?RzQ5akJoU2s0NG01eThpVVB4VDJSQXFpTHBXMkRtNnltbXZZUjAxWTZUYlE0?=
 =?utf-8?B?TGtzSXFlS2V1Y0JBNW1SNzBpbGhGWkptWTkwZlhPYkZXRE10MWF3Y2ZOVkFt?=
 =?utf-8?B?MjlNUWRmdk9MVmFkSnh1d2g3M3dJZm1HRUVhV0J5K2haSFRxbWNvWkhncDhn?=
 =?utf-8?B?MmZ5UXRBRm9yV3dwUmZkSGVPV0dzL0hDcCtCOEZVblpqeXFFdmZJUFpTTHZW?=
 =?utf-8?B?MmsyQVZqQXJORTdrNnhoTE4wZFpWMVhzNEY5ZER0UytwUWVlS09MQ2x5YVlr?=
 =?utf-8?B?Y1A1QlRjS0NHY2FrUGFHb3RUMmlUZDhjbFZOSFJhb3BTQTNDQW5aWmx4UTFo?=
 =?utf-8?B?OVRyWW9wdEJEYUVwZ081c245Ri9ib1FSeENzbEY2YzB3Ry81ditYWnVBMld6?=
 =?utf-8?B?WmdaYU1seHlzZW9iL0dCMkVYVVJoaWppTmF1YmJBYUVsMWFFek14ZUd5RHN0?=
 =?utf-8?B?dVVSUTJRWVYvWHk1MDloUlpsZ2x5bVpnc0pYcyt2aVVGdTIxZ2E5OTNBZFdk?=
 =?utf-8?B?YTNmem1KcTBqTXF6b1c0QnVPbnRSQlNOc1FTOHhteFROL2o3UmMwN01OTjhF?=
 =?utf-8?B?SGxsa2FjSUdDdWwwMXZlYzlNSHk3VHlkNHpCVEF6WVdvL29ZVzgzWklxKzRL?=
 =?utf-8?B?N1RiUnpkbU1ESkt0dlFpQ0lsUXQ5ZGlXSFpxcTZrcm0vcjJPL3g3enIxMXRF?=
 =?utf-8?B?b0FncFl0VlVxeXJxOUg2SUxUL1p6Z1ozRjBqQzFWZERIQkFNYlJZUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebe1194-03c3-419a-8545-08deeda51aa9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:10:50.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTSmqV5uyNtId1P/oYvWwajs5OzCmHoBUdClndqcS7M2oDMTjBujq0aWcrSD/RlOpcGwmqJH5yF0XtsAjHV4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615


On 27/07/26 18:45, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/24/26 22:59, Sumit Gupta wrote:
>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>> boot parameter) can be lost in two ways:
>>
>>    - Across CPU hotplug: the platform may reset a CPU's registers while it
>>      is offline.
>>    - On driver unload: the value the driver wrote is left in the register
>>      instead of returning to its pre-driver state.
>>
>> Add a small table-driven mechanism that handles both:
>>
>>    - On init(), capture each register's firmware value before the
>>      driver programs anything.
>>    - On offline(), read back each register's current value (whatever was
>>      last set via sysfs or the boot parameter) so it can be reapplied, then
>>      restore the firmware value.
>>    - On online(), reapply the value captured at offline() after the
>>      performance request is re-established.
>>
>> Keep Autonomous Selection (auto_sel) last in the table so that, on
>> online(), its saved value is reapplied after the other registers that
>> shape its behaviour.
>>
>> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
>> (EPP) and Autonomous Activity Window (auto_act_window) registers.
>>
>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>>   1 file changed, 157 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 34cdba00e61a..8a13ec49eb9d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,150 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/*
>> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
>> + * the autonomous boot parameter is reapplied from online() across CPU
>> + * hotplug, and the firmware value is restored from offline().
>> + *
>> + * Autonomous Selection (auto_sel) is kept last so its saved value is
>> + * reapplied after the other registers that shape its behaviour.
> While that would make sense, unfortunately:
> "8.4.6.1.6 Autonomous Activity Window Register
> Writes to this register only have meaning when Autonomous Selection is enabled."
> I think restoring an inappropriate EPP/AUTO_ACT_WINDOW temporarily is okay though.
> AFAICS it has to be:
> 1. enable CPPC
> 2. restore a valid DESIRED/MIN/MAX
> 3. restore AUTO_SEL_ENABLE
> 4. if autonomous mode is enabled, restore EPP and AUTO_ACT_WINDOW

Right, the ordering depends on the auto_sel value being restored, so a
single fixed table order is insufficient.
When restoring 1, auto_sel is written before EPP/window.
When restoring 0, EPP/window are written before disabling auto_sel,
allowing them to take effect if autonomous selection is still enabled.
online() already enables CPPC and restores valid desired/min/max values
before this sequence.

If autonomous selection is already disabled, the EPP/window writes may
have no effect. Temporarily enabling it to force them through would
introduce an observable mode change and would not work where auto_sel
is not writable.

Thanks,
Sumit


>> + */
>> +enum cppc_saved_reg_id {
>> +     CPPC_SAVED_EPP,
>> +     CPPC_SAVED_AUTO_ACT_WINDOW,
>> +     CPPC_SAVED_AUTO_SEL,
>> +     CPPC_NR_SAVED_REGS,
>> +};
>> [snip]
