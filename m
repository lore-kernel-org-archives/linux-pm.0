Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0B389444;
	Tue,  7 Apr 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581804; cv=fail; b=TmLUOKASUZ1rW5XrvVDRjzdvRSEl5HRGC++xIycGyGWR43XXI9kzM56nr1up+WZylNqJoutftyCimO9zKq4Z/9hcRIGWKQLHVxXmBIv13J5M2HcLYvFNwHCyma05TC0XaNQRCxsXEcu/jrMZYZGz937PGyN9R4RxnqSYlfrCIV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581804; c=relaxed/simple;
	bh=4pdrjHEQi8pJoQbgMl4EfkwWG+JhMnbLXl+MSQ64JKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCwSZRlKzVnLGIqsPDPJ5re+f8SYN1YIYMkOFZTfq/L6Ry/Gh8/nnWHVHxCxQXcKiXbgnkLxLi2nu67aELq0NI7caKCPvII/g2izV1WE8fNidsBqvyYp/UWL2Wqng7PbyfuO36cCleUr9o1i2urWKz3famPPzjjEGd4EYM6hRWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g4SiekGm; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g4SiekGm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzpWzmksF9j6eCE78qM0w2S2vWmVcmLvV8K+V/z4+/RFo8Yl0hirmcOs3E0v8S4MHRhDMu1vwxyIE9fwacZcrTUI5ojbRorC2N6/7J4mfG0+VPL4T0Ifkws+NRsEO2cb71ocpjOQrQZGVGeSJrhzRu/MT1qWMyJSJAcdHgIvD+OVbyU0DojvfFyvorL8peS3shYhvAQ/Uf/ymodlp7JYGD7l7vnjfqlRuUdhFZxTHFY+5giEq4qRVh78NTHHFfmglHJ2qA93xHRwSYnrEA537YecWL2UwTJvadFL9eCl+PJIdMr/9/hWUlpvWpto+xajtJxvuTGnlsxAK59lcunqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/2hoPYgg1Jkl0rc0rhxEis2S4NijT7GGF89RZdHQgk=;
 b=pXCIeavwKbb4Yn8n4y7vpUDhsAzg1ChlRE9++fakK6jjA3xaFBDe1BLwkv2siYIwpTC2KPn1zY71FzTbZD3ePOfkx+YkFgX7hD1nObafZARBm5rYRXXO78eBLe/bZV64j38GpQ8X3WPOlfO8b8GsqgAejrNiqsbwmau6kvZ1Vn5K07Q3F6aFNUWqkGiJ58oVZrkt/xTXolhpyCOfXRJY+eDrs4ViCevv16FNksbt69lybZM3N34WS/FmUf1gyVaJ6P+VuZMdErMhhG04soGYtQdDp6y0id3BZHIktSuJyhS//GGCHZFn1J6t9A4B4aeUS0AmsCs8gWWztZKKHVmDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/2hoPYgg1Jkl0rc0rhxEis2S4NijT7GGF89RZdHQgk=;
 b=g4SiekGm5Dn4NOlxpvFI1eSpIX7b0L4RQ9qwbDbml9Vu5ESAhfQNaS7XKspUGw2xIuQ5vzNZrM5JS+F+O0vdEND1wtJu+gSPjGcTpvn0ujdmY5fsPmDx8so4AO5RHu+nQfjn7XAAhIgRtjdn5vq8CubtGzofuVky+1V6j1R14UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 17:10:00 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 17:10:00 +0000
Message-ID: <7d907b85-2f57-488a-adea-1a947c7224e0@amd.com>
Date: Tue, 7 Apr 2026 12:09:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Add POWER_SUPPLY dependency for
 dynamic EPP
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20260407145458.163727-1-mario.limonciello@amd.com>
 <50b3313d-aa85-4cb8-801a-e40e3168383a@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <50b3313d-aa85-4cb8-801a-e40e3168383a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0979.namprd03.prod.outlook.com
 (2603:10b6:408:109::24) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2430c274-8731-4807-95f9-08de94c8803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	INaGQW54brTvmEocqbeV09EMdO1g4kQlgK3MHn8C7bHcojU2ktOygnVnWiu002LjV52kJf6f0E6WgIc9xT2hjbkbUmUpqii48o8bI62R/sKMHrZQxyUQ10xgFVgzl9BDMrx27qSPcAvBoCnkHCtCGhFibB0TV1XvnCATfwZmflkxH/1qqMa7ZFAlHvi/0un3+TI8yoPc65x9/Q+MMH9rzb5E+ghD0vxcnB3aTo8eoeZv+e7cwBDkZMvUjVMBJjUElRNpC7YHey62nyVwfh1eyxoxMqkeq3aQhVuGv49ZOvIIzfzO5UEnLwnSk/y3zNnBCyq51Po/IaSw0GojN85t25tmlBsThr2tH9iTaVm2DLXOfdlGYIj42yZ2VdjfV293ybjG+NYPT2hWhrrbFvOZnBRy/rgtGpJ0fyrV9KK8CyIYGtb58UhrdQj660e+5OuAZromqlDq7RrC7qC3YcSeCNhOI7AnrG8nG9ctWBNXxLueQq7AmSeYMCKkfB3IYsyy1xOvhe7XqjLHCLEXpaEFcg6DVlEJfl+fMm0pk9j8WoEEWEgGKoKJ9+tsws7xAmhHV15q1zc8P2HleDgzzod2DNrbgh5OfZ7MBpPVNpu5+eX88KQQMiPDH6zLU2dYdIHC8Re5wGlV3rMoA6tq/U70axEhAO2mGN6LgSs5WPHOpn7M6/8RDa06LTaTuSVT0P+f7zKImM88n7hMOoJnzo9PGO3hkqB3z0jZKWGx3O9OnGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q05UUlowazIvd1JUeG5pMm4zTW5yUjVCaTBXME00RXhJNjZnNFpyY0w3eHdC?=
 =?utf-8?B?UWZOMlA4aDdYakptZ05uQ0VBTG43MmQvTU14UlZ0cnkrb0VabDVIUXJQMHVN?=
 =?utf-8?B?T2tZT0gvMW4vWDBBVEdvbGY2UXJqY0cyUDU3ZVhucGJYeVMxRWljRFdsL2JJ?=
 =?utf-8?B?MUw2MXloZHZuZU5USDJMaGJJOXVYTWJHbUFEaFNveFFUTG5tYlpobHV6WWVm?=
 =?utf-8?B?VmNXanlNMVNFYW1YeExSWGtXcjBWdDFORW8xaDRKOHZYUHJXRHB2ampONG5Q?=
 =?utf-8?B?QU9pWXdaOVdCOFh5KytKbjdITGpxQW5JQVNnZkVicElPSnVaYlVsR0xYMCt1?=
 =?utf-8?B?YkdsYnluVnE3UGZ2bG1UeWNzNTBHYWZhLzhOWU04T0lJU0Q0T05KZ0hiU2JC?=
 =?utf-8?B?MVNmTkNkRk11blJPWXZVT0J4b0VLNjcxd0QzV3hwNVM5NEF6NmNnNlhteFFL?=
 =?utf-8?B?cUlxSXRQWUFMUHZwUkhpL29HU1ZCM2daT3ljN2VlZUg0WGpOQlNGOEVyZGVN?=
 =?utf-8?B?N0xxem9nNHpMZjJESi9HU25ITElvYUUxMmRoc2p6Sk9jQUwxYyt4c0M1cmpH?=
 =?utf-8?B?YXJXZzVJWkJHNmc0R2JiMlRyTmFRRWdHbUhnQVYzRGNrbll4MkFORFJ1ZEJU?=
 =?utf-8?B?eG1YbGxXWmJsYnNWSExTTXI1OGZYbTE1ZnlWRm83NTlTaVd0WGJMeEt3ZGJx?=
 =?utf-8?B?OG9aS2FkczZPbWxONUF4RmRWTjJHT2N6LzUxWXU0azFJTllYbk1qRzY3ZnpX?=
 =?utf-8?B?cUlkQy9hc1ViMDFNMEJ0Qld2TFZITlpaUmY3VjdHWVdjTi9RSjJhVktHRGdq?=
 =?utf-8?B?a0tib0tvenZKRThYbDd2cDVaSmVJcHVqOTBidTZOWStTTVYrZlpBOUZ3NHRL?=
 =?utf-8?B?WWp1S2VoVUtOK083MU5RMmVjT1FXTUZRcFJNYmFNRWQ5eTFiMlhLVGNwT3U2?=
 =?utf-8?B?WnpUUUtyOVJPT1BaMGpUbUxSVWsvZzgwcDkxc1cyYzlURzBJUGI4a1N1L0tr?=
 =?utf-8?B?RWJTcHBPVnIzd1dZaWFVYVF3ZlFhZ3VDdmdvQmF1MDh1VFcrTGVkbUNsdGVY?=
 =?utf-8?B?MXZtVkFnaGFyaTBiUHNEWlBWMjJUUEtzY3lxZHYrS0RxVHJzLzQzZGNYYjYy?=
 =?utf-8?B?a2NNMjlsRXdFL0UycXlRL1QwTDhLdDZBUmk1NjRLTERJeDNIMTJsRkxlM0JE?=
 =?utf-8?B?Ynh5WWk1R3F4bTJTUGJkajJqTjdWdjNPNTV0VkVVclkyckFMbTR1cmR2RVJZ?=
 =?utf-8?B?UWgzakNpeldScmNEZmM1enlWZ29sRTBYMDN6Q2N1NzE5QmEySVdOdUJvc2Na?=
 =?utf-8?B?NkN4ajdyN0hXR2VTcGRuWXNJZE13VUN6WTVRL1BUaURERENZZnJrdFdZQmJ1?=
 =?utf-8?B?SGxZOFJjekV6aXU4Y3hIcHVzbVhLSE5DV1VhS0ladnRrei9hd0ZEMVRVY0M2?=
 =?utf-8?B?a2lUcWk4R0xTRWloU0RYS2MyWDhBUjcvL2JiSFB0MWo5RitQRTV6anBWRmxP?=
 =?utf-8?B?MytrZFY2Mk10dVprM2hzK0ExZ2hxb3UzbTVia2NyOHlOM1UzTjVLKzROcWN0?=
 =?utf-8?B?SWtnT3ZRNHRpQWp5LzV4TCtyU0F6OWFCaVVFV29wUEh1T3ZuNmtDY0pZVUFo?=
 =?utf-8?B?OCtGNVZYaVNCUmE0Z1dzRU81WFV2OHM1NmxyQXhqVjlEUVFIOEQ1UmEwZGRv?=
 =?utf-8?B?WXY3RjVNS3JHUkNkdWg3clFKdTRBYW8zbTVLUzVibnBpNVQ1NkpEK29wWUZy?=
 =?utf-8?B?K0RHRHN4Qml3SmdDY01RRVpNVUwyZXVZdTM0SFJ4M05LZTlaaCs3S0dYaUhT?=
 =?utf-8?B?QW1YL21sUUdXZEFPSW8zNUFCbVA3ajhCb00xckx4VVZnQVgxSkgvdEtmdkh5?=
 =?utf-8?B?Tnc4VjV6V0l0a0d2eVRmZi9PS1JiMWFNSElvVml2OXJtLzJXdG9hUysxb1NR?=
 =?utf-8?B?bUxTTjBIeTRSekNUZlJFTkZiUG9nRVBxMXZlM3kvMnEzczBpdmVMaGxsajE2?=
 =?utf-8?B?WHNtbUtGWXFBdWZML3VWR3RMZktYVS9IeU5uNGIyVjlPSGJJandWTzFLTmJO?=
 =?utf-8?B?b1Zad05SRERLcmlVeFZDYThsVkJyY2xHLzdSUEMvMG9pNkk4eVhKNEZKK3Bh?=
 =?utf-8?B?VHpScmsrdTVwL2ZZUzF2YlUwOHBJaXhxeVNjUUpJaGtYYlFYS1JQK0kxdTM3?=
 =?utf-8?B?R0NHQXZzNlZIZWo1TVlUaXhmZnI4VXJUeVBEWFp5THZoK2ZaN2NWY3AzQjRa?=
 =?utf-8?B?VDFkeVBuWkhCc0J0by82eG5wR2J6ZU5ZQTBsOWkxRGs1YkhqeTNxalRsZjA2?=
 =?utf-8?Q?QwglchjZYo7GJu1qUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2430c274-8731-4807-95f9-08de94c8803c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:10:00.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiOCRdsgE7R0rvXYObAQUW1RrvstXySenlKW0SzNseAU7CnVMAsIBJEK/2lf7PQObwj/jmwF22uNWQBQ8uiszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571



On 4/7/26 12:08, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 4/7/2026 8:24 PM, Mario Limonciello wrote:
>>   config X86_AMD_PSTATE_DYNAMIC_EPP
>>   	bool "AMD Processor P-State dynamic EPP support"
>> -	depends on X86_AMD_PSTATE
>> +	depends on X86_AMD_PSTATE && POWER_SUPPLY
> 
> This config only controls the default selection right? The offending
> power_supply_{reg,unreg}_notifier() isn't guarded behind
> #ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP so we'll still run into this.
> 
> I thing X86_AMD_PSTATE doing a "select POWER_SUPPLY" should cure this.
> Thoughts?
> 

Oh that's a really good point, thanks.  I'll send another patch as a 
follow up.

