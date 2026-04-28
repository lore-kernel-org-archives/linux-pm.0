Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8544B67A;
	Tue, 28 Apr 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380848; cv=fail; b=ZEi+axC4y+SxGjrPuem428NxmcK2ldMgzr0f59/zKs6AWD0F714fYVHiEX1mmsgLCpIC2hRVZHu62Dimji83p2Ksg3tUDRQXbESko6pz3hwZKoO4aPUqwAZmQ9bWUb4PmUiNFZJVjrJxu6UfX7ZZv//UMyRKDcieOH96AlBqasE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380848; c=relaxed/simple;
	bh=SjGxX3z9XKB1hoCOLiwBxF/9j/u/xzUik29IGJVhXeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cvzPVtrSGFr/pGPiXEeEhuVcig7FaIXEudjLeDz5g9gQ2ufzHlm5OxB2UjsdErSrWu2vvshmfMfzpQfo3QU3EBUSF9ZGdxDgV2V8fbQW3JBztbN6blvrPc4QuAXyfm83OeT06HnA4ResvxmAPeqCKvysG3oqN1UQ2YDbjVab4tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHkWyvIh; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHkWyvIh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb35xm8wP/odcC4KFtPNMvh/Oe1M8aQZt31FJOkqzYU512OQhbSs8Jnpu8WtdG7oniZlVYXgUyTlFLtMh4Je1ZjmIWfYu2rFu3cIRbXGwZ7m83UyFmNIrklDXZz1fhbidq3GAujt9vR3RW/FpCITda0NXJqNCwfJ+XCczWlko9FUWW/Qvs/YIaP6OpXq+pXzVmy79a5l36DyRX5+6rt/K3i1WnCqC4GKvS7Ohb09MU9im7+T2QdGElqVmRiaM6VbYsK5Wm6u0irfxgqNwQymbdek94/c1se8GnBJKLuFDi5NW/P/EfXdmskAw1RS2lMrpNqtekUkrfU2jxfIqTcg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofxHpXs5ud7dKjFujzjYoBxux08mj+8bj0aEV7BD3M4=;
 b=kd6PIGN5wJbiGCSbw+NvibvluvERj2AlomMmF6eMehqBNQEuL7ngWQ0o5ytzeuOV9/N9dD6McSoMNIowUOv0jfHCzSbuuHoADDX9eYLueyvhX3VhgHiErb1lrT1FRnvmIEhu9K0SVpt1aJwVWb5eN71lK3AFVOPzSfWbjCpptEUYyJhF4ew1/luRPW52C+AegyNMvgh0gVXMWm38iolVyAFQr4qX++vP3UtioARslbYxylB3I4t5ZvT4srSDjeDtUFRdU/vvjjmbGtew1lz3xBs2Y6IcjPwpC5LQiIRoiKuPVUOdCvzjrZeXGdA7sbylJYXgJgp2kgrvHeBLb3sh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofxHpXs5ud7dKjFujzjYoBxux08mj+8bj0aEV7BD3M4=;
 b=iHkWyvIhqI0gYW91amLFl0CvsOQWGkT37QmkQNGAZPjCBhgA06gf3VIJGLb3nogRfpyFSDnAnMHbXHcR7RGi0MybMtj+r4ff7FedvSNsvj9+4sGYR5c7O0DvOfvb6ECc6atKpoDgh/fprBUILP3hUncfTENcyfeqAF0Izl14nzFFrrTtw8jMqSG2jwj6QpRarI0DrFBNbzZ2Kqog3Wxn9AxKBzEW5fIbH+ibQYE1HDGtHQ1FuL7b9bfgc60VB1FxEunk7+Psi6wVGS6drzqebCTXbykLKxxG5jalgNtze1ZyJ/lq0f2sESf7Bup8rs/3KZVloi4Hte5uWF2vzMRSUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 12:53:55 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 12:53:55 +0000
Message-ID: <826bd942-4e6b-4e4d-9292-04b5614aa91a@nvidia.com>
Date: Tue, 28 Apr 2026 18:23:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
To: Mario Limonciello <mario.limonciello@amd.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhanjie9@hisilicon.com, saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-2-sumitg@nvidia.com>
 <bdcc0785-9930-49e4-9918-c1255bd296a4@huawei.com>
 <8badf464-a44b-4636-9202-6fcf00fc50eb@nvidia.com>
 <d76e7f9d-f418-457a-b08f-90f929bfe71b@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d76e7f9d-f418-457a-b08f-90f929bfe71b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: fd26b214-a9d3-441c-e5f0-08dea52534cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mVYqJpvVEN0PrLjcyuYJfDFBzEDof1VYXZ9gixr5WNvmJTNy5F7r/MMDVYksjpZhVOkylZcb2U37g6E/JAtCrX1p1eto5XIom+i0y78FRrei0U+Fr+qLEEGVKRXRCWUOrzrFdNP0uDNHoFROZrOZcbR7fwBiLqCtj+p+CRwLNWQb+senxNSJHLeR9K0VWE+lWR9C9sg0KeBYa20cXvxyevcKDIGL08tc5TW04zUiSqBHzZgyoRDA2SqJqDLMP9zcl2SA8mb6Sq8yzfjQRN+Zzws6WS/xsAl8M4yVzUuleJd7QzzL/1mPgnLj99ZlhcI3rARBnct1uoW0gA18JN4pht3sTXGBqm9IbHsosHOA1Y68fYZnC8ATG1wZefn+pHcFTsucE9Jbouta7JeuR8vDwgminNmUoKfjxYpQRpProMZfGYmO2KQCatrN2sf5addbquELlngJW6wccGLSOCwcvdZu5Vk8+KuOGloTqSjw66xq8c+qYA/6l6eIkkWrtHlwfPdJzbe271dFgeQZpz8NnWbzSdEfI1ZI58BWIn00/SlHRr+SehiKGym2rAfHfObUBfiYezqve4g7+hc6p22wCJc2UNqtDJo/I3eqE63Yx6Ubk3OvnsH13V2h61DjZsZKmgDNrhXJ3hVMZ53NVTjquDTCkysp6OzKmfSdEe/0p91yAJrwWn2gqvt5VbtYr/1eihb8aJq/KaRBOPTtKNJK3b6yuWIdpqWmdZo7Qv9l2BbXtfTy+6Bv+KNrfw5IPA4O9kNiDGJP+3B/VbVraX4ikQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NElRMWpGejlla2ZEVFhDeE9WRTJtMllWZ3p6REZHOXFWWXZqQ1VXQ2NMdWlr?=
 =?utf-8?B?eVNLQUpPRFI5VExaSzJ6WTV5OEwwak9YQmozOVhtZ3dnZ2VDV1pJa3RGQlJo?=
 =?utf-8?B?NFhaMUU0VzVkaEt1S2FZb21OSkZUR1ZPVWZIMHdUWWx6ZStweDUzRUNLMGdI?=
 =?utf-8?B?K1BOU1lFMC9UT1UyWU9INUtTNEVkUVlneGx6WHdRMDhZQWVzQ1IxdVhtemdr?=
 =?utf-8?B?UHpqeStXUmZ5RVhuNzlTYndKT1NrWUxUbDN2Q1YvckVkOGxpSW1OM0ZITG1D?=
 =?utf-8?B?S2F5d21wa0tWVGZRTjZpTVRnNnZEK3FvbzdERTNObzhCMVdUZ0JFeXdZcmVr?=
 =?utf-8?B?dmdMYlB1ZlpHc0ZQcWtodkE1MlR4QXMzak51emtZT1ZqSjdiZDZ4RzlEL05P?=
 =?utf-8?B?QlFqdm5aRE5mMk1nN1grTGR0SjVpVDVQMjZyWUlTZTRMb3lMWU04K2FadHJm?=
 =?utf-8?B?TFhlU2FGRmpmVzFWaDZxVHl3YlMycjBmMFVNbnhHb3lHK0RpdDVxcVYzQmRO?=
 =?utf-8?B?SEhHUE45cTM1Zlg1L1ZaNDU1Y25ON2NyMzhpeFM0M3hhM21DdnVJQlE1OWtr?=
 =?utf-8?B?UzJ6WDhobXpLV2d1cHZWUXVabjlrUXZwa0dNcUNxRG5wV3g4ZTQxSWxZMGN0?=
 =?utf-8?B?Y1ZrZCtUY0hrMlZGZUtRcWRnWk9sU1pTY1ZTdUlNNGxkZndVQTJuQStTekg3?=
 =?utf-8?B?d1FrTDQzQXRFcHFTUmdhemF0NlJQUU1PK0tLVTdZSGJLVnJ2Q0pjaFVpd1Fo?=
 =?utf-8?B?aGlTUDgzSXIyb1VrQ1VZNWJkOXJ1T25uSm5jb2JmLzZGdG9wdnFkdzkveURD?=
 =?utf-8?B?Y2xmcEUzTXVTTlBJUGQ4VHRCSG00YWpmZ0d1TXcrTEhrRmZtOE0wVnV5SWZn?=
 =?utf-8?B?NVdlZDlLUlIrM043cjdpbHhoeXR1dUswM1VVUEMrdWl5OHo5MmJQTEZXbDJO?=
 =?utf-8?B?NjVmR24wNld6REZPWXlFUTIzTlF6U1hwUlN0L0tVK2xKenVwTU44MkVXdExp?=
 =?utf-8?B?aklieUJwWkYvZzl1dDdOQXV1WUlvTklYSU9oRzZRUWlQRGRoWmRQeUxDa3JC?=
 =?utf-8?B?UVBPR2pQZmRaS1EzUWlodi9DZ2NxM1RtcFlHWU1jSXNjb3RLeFJEbVFrNlJs?=
 =?utf-8?B?T28vMUhHNG9CaVcvTTM5TDJwaE9INDEzeUdlZFk0ejcrNWxYSmcvalZ3aEdo?=
 =?utf-8?B?b0YwakE4RnBQeHg4Nzd6Z01KakpXZXBTbUlCOFp0djlhckVuTi92MitteFlT?=
 =?utf-8?B?eVZ0SHFGMERNanZzYVJUSkw1d3A2eW55NkdKLzBRQm45eTl2eEZ2NDlVNGdm?=
 =?utf-8?B?WVVGMDBTWVFTQW9WaUxYZC9idG9ickY3Y1ZYalRnLytKUDhyUXV4SU8wRTdl?=
 =?utf-8?B?dEZ6VFBVUGlwWnFtNktnRHFCcUV2Mm1ERjRiemZyK0tpWm5jOWU1WHd1WFZr?=
 =?utf-8?B?RWpSV1ZPRi9MSHk2SWtYd3RtSlFnQmlmMVNpMWZ3Skx5SkR3aWpaL2hpWkRX?=
 =?utf-8?B?NnJGNnEyVjZHdDZUVXJ0WUJnRXIxRllrTVZNQVc4WEZYaUo0Q3dzTnQ3VmhD?=
 =?utf-8?B?Q1RXVnRNU2Q2d3VQWVlNZHE5ZjdnN0hFMWtMZkE2c3d1RVkwK3JGSjZNU2hK?=
 =?utf-8?B?NkNUVU1zUFpMc0FJZW5ILzB5SFVxWGlyYmkxaFVoNFdvQzRZdHFyQXBFcmo2?=
 =?utf-8?B?OHFER0tEUk56WE1uQU5DaGNTTnlsY3ZSUkE2aGxhQmVXM0ZKSDh2TW5OMlp1?=
 =?utf-8?B?dTZud1kzOHlkN3hSSU1BS3lFaUd5MTlDWEtDVVZXcGx1WG5xSmpndW5TN0Qz?=
 =?utf-8?B?djZCRzZoUVV3ZUpFREFGSEdCaXNpRTdQRDd1SE95SE05bngrWFlRT3RLQllU?=
 =?utf-8?B?Y3NFUHgvUm02SGMzYm4yMGRrOTIwbEFiczdmZGNkZ3BybXVZYVJrbjh4MmZE?=
 =?utf-8?B?RUpXQ2NTMzZZZUMyZWtmejdzUW9zdGlHaEZwSHlhUDV4ZmZ0a1dPbzNHWXhv?=
 =?utf-8?B?U2I3VWp2ZXpFLy81NXA3OTRPeTFqNVFyZG8zTDJmWFBNazA0akl2M0xyQjBw?=
 =?utf-8?B?Sks4U0xIK08yNFNzL3owMFdtUWJiVktEY2pjcEdVeHM5N3ZqdCtHL1kyNUh1?=
 =?utf-8?B?RHZmb1B6Wm9OVTRmbVpkS1JKTTZZcmJVZk1CS0wwbDlWVTA0Z0l3OWY4TkYv?=
 =?utf-8?B?SHhsbHB6RmpTQ0NXUGl6NVFlY3A4UVdjRm5TQ0hiSWU0bHZLRVQyYWh5OGF0?=
 =?utf-8?B?SGNWMUxxeGNkb3RvOTM1ZWVueEdmVXYxMXRoMWdldit2VUVOcXhORnJkT0hS?=
 =?utf-8?B?Y1N0b1hrUmEvVUhzaXJQZ2NYYWk2U3RhZTRxTDI0bEJjaXlBUnhIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26b214-a9d3-441c-e5f0-08dea52534cb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:53:55.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf3LYbcXMXH8rbc1Tmr40LpfFvler3CHL3EtbDHEsfeWiEkGPPMGlZsdSKSNpNyBYZgAEjyCdk2zUGbVwQ70qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151


On 27/04/26 21:03, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 4/27/26 03:04, Sumit Gupta wrote:
>>
>> On 27/04/26 12:36, zhenglifeng (A) wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> It seems that mario has sent a similar patch:
>>>
>>> https://lore.kernel.org/all/20260427035520.1427080-3-superm1@kernel.org/ 
>>>
>>
>>
>> Thank you for sharing.
>> Yes, both look similar with below two change.
>> 1. REG_OPTIONAL needs the 0x1FC7D0 -> 0x7FC7D0 update to mark
>>     the two new registers optional. This is present in my [PATCH 1/2].
>> 2. For Resource Priority, pkg_data added to cpc_entry.
>>      This is present in Mario's [PATCH 2/6].
>>
>>
>> Hi Mario,
>> How would you like to proceed? A few options:
>>    (a) Let both CPPCv4 patches from this series go separately.
>>    (b) Fold the REG_OPTIONAL update from my patch 1/2 into your
>>        patch, and pull my patch 2/2 into your series.
>>    (c) Anything else you'd prefer.
>> Either way works for me.
>>
>> Thank you,
>> Sumit Gupta
>>
>
>
> Reviewing yours points out that I totally missed updating REG_OPTIONAL
> with the two new ACPI 6.7 fields being optional too.
>
> In my series I only add in CPPv4 so I can build on top of the changes
> for CPPCv5.
>
> So - I would say we should let your patches merge for v4 and I'll drop
> the relevant ones from my series and rebase mine on top of your work.
>

Thanks Mario.
I will proceed with this series and add your Reviewed-by to this patch 
in v2.

Thank you,
Sumit Gupta


>
>>
>>>
>>> On 4/27/2026 1:18 PM, Sumit Gupta wrote:
>>>> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
>>>> _CPC package:
>>>>
>>>> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>>>>     lets OSPM inform the platform what it considers nominal 
>>>> performance.
>>>>     The platform classifies performance above this level as boost and
>>>>     below as throttle for its power/thermal decisions.
>>>>
>>>> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>>>>     Register Descriptor sub-packages that allow OSPM to set relative
>>>>     priority among processors for shared resources (boost, throttle,
>>>>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>>>>     yet supported; such entries are marked as unsupported.
>>>>
>>>> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
>>>> mark the two new registers as optional.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---


....


