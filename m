Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3B13959D;
	Thu, 14 May 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763974; cv=fail; b=Bi9Qi9CR2LF4mL7YGZRQg27RIkBxfqSQkzNJsEN3yOBsD/bufZ09dSdUDW7FX8ocvqjVBXzJlBVIbKhDGcy5B/qjznbf3xskpGCw2z1P6oisPI0YATEBp3X5EiTaOygYFlbXNFTPNGbozFpVZ4zo4aU0kQe2pS4wg/ii5sbAg94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763974; c=relaxed/simple;
	bh=GIna8VHEUygm5Ql7RDIC8PBaFryhS4LxRjkAiWvC0oU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQR+Q4SlMpvBJQOMzYviOvT4YmgPuTcRIVybzq7WBZvtYW03pDm7ARe7aUrAg5yIO0L+hx4O5T1gC6EI6Svu7fs3TMz4eNbF4JlHZZttDNYiKjKpq5tIwT1rijypV9g1lUI/a0SmaMAhNmB0W+mNUZAqi2YDhw3p6XdfNwpNovU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yujg+e6O; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yujg+e6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+dXTdZaq3Vtz0y6YdDNDPwIFZohUz2dIwrwFTTmz6V3lH1NpOkA5kA46m3smGAtk9uAA5rHs90MNPLA34qTbJgwI2+TqMXfCev8xadGEICgNfhDrdZl/TAC+4s0BUC/9fRJnLCgX5smtUVbfNEqdzU9iR+jtAMi49B4oefJpnUeMPDyY/x/+nwEz1H5WU8k/4RGWAtmUbgOTS3Ybvpee0XwJo6QMFbNyG6vvPU8SjOhCr8Or4uWfNihtQC7DAGKd02vNsoTqndumn1yaRiFwxwj88RknnZUI61D8TES9R0+xjZ2iuHOuzxmEstCaJW6/H/LXjX9a8LqjwfHBv5C6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzSAaBmge8DoHA3PIBv72FKKcLhnODM/pKtjEBQOgYg=;
 b=XLR9nj3wt3KbUNN3NPE0PmtTzT2zPAAkCyvm8eiKcV+TuhpkJvt0iOeGTnPww02V33mLRoE7ZJNeew+ICfPEwd6nFx7cGNxR4D7RttThL7twRDl30sRVpr6eLny3skcogJiAj7uJpx8drUS/3K4h7FTs5e4J5NMFKZLFVSViBFfTqlsH0Ndmj2vaVUBpQxzaWqdLWRQyt9FXG5R1VsJ0tEASeDH72knHEzeNvAn2xya7xEU2kFJes6GwcDH+B7NikH72+Gayr7Yeox80DlkIVzRzNna52ia/W6jzUqgqmfVrXAOyB3+6ItN4hM/RxRtPA11CB58E59SXTRHp4nyR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzSAaBmge8DoHA3PIBv72FKKcLhnODM/pKtjEBQOgYg=;
 b=yujg+e6OasolbOkLLE5ipYkZZcg5BJ0ki+ajC4vT7E1kEiCKqkFTS2ByLYAYkVMEfbvhXcSK1pzmlxZZwfTzynshVBjO6iMfx6knvPxEFdaGJ4Dbakn/byiFLkSonwJQ1fdZ9ouyXtHy1ZsZYqqeTCOfX6fATLbgrWEVd9nXucs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 13:06:06 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Thu, 14 May 2026
 13:06:04 +0000
Message-ID: <e1f2d095-68a1-4edf-9f10-b5fe84ca5de2@amd.com>
Date: Thu, 14 May 2026 08:06:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Drop Kconfig option for dynamic EPP
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Stuart Meckle <stuartmeckle@gmail.com>
References: <20260512221947.1652988-1-mario.limonciello@amd.com>
 <3633a2df-73a8-46d0-a430-8f9502cfffd9@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3633a2df-73a8-46d0-a430-8f9502cfffd9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0109.namprd11.prod.outlook.com
 (2603:10b6:806:d1::24) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b12a26-6da3-44f6-5fd7-08deb1b98dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|3023799003|56012099003|4143699003|22082099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/h/PKSvmgCZf/vH6LHEtQrjXyvwHK3JZ3HcTFvq+iXfUVijDUt7IrrZgDcftHvvSf/2DBFYJAL6J/ztehmFoOk18KbYn1zpync6oabTa57Px/jD4EbvkRgeR8LK0QBNSVmgHBwMN2/uclxHIigN8cDg27C9PqnHmqnnnlJorkQ2TcYx0nZbAYAIbk9gX6XO/00N+oMSI4oaM00DduqxiUhfpK5iSv56ofu+swUexMIrdieSkqEgDIPqrnwdvhWN18ly/slrOA7h04YHUdXx0AT/Rj374w5IYpEvSm/xDT3x2JeQpQsRmV0uy+NzccqoOlGoPoI3NjD+AgQ6q6QCi5tnIhWSaXuk8mD53QOE9PIc1Q9IzIdLuqjNEWXXNqGwr4/rGjPouGROGa7q9ri1+iWNmbINBHQYzhDudjDVXeqWZm0A2OoIH8qyO9wy+ow4oA5bAOPjvf6GqhU1KejOIHjM4o6qTthhQVRPnzo2EkGtOk7oAqBF4+foA2lEG/yo7cJ1T8eGXwgRQvkPyFZzmG31KfM43yw8arPJnHjzhyoP4SHRQAkoTvl+Po0R2TKcuojnFOPORCOX8EqtbB98g6zcktS/DeUHkl0O9EZT4kpDqR3vZWg8D1X2rOa6Gvyf5b4qfvITHMcmsjPyHaDIpSYWd+8ufCKB+XT2mwKH3FuqpefsKaWU8b1anQMVerefs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799003)(56012099003)(4143699003)(22082099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmF2dS9kOU1iYWdqaGQwWlpVYVhzbkZBOUljVnJmSjI4N1licERGYkFBczRQ?=
 =?utf-8?B?TVdBRStJUWFBUEVxOENwSjB0UTVJNHNRaW9CekllWDhCc3JTSGV4OEM1S3Ru?=
 =?utf-8?B?Y1Nka0hWS0R2TGNFOWNYRkd1T0Q2OWtpa0VtN1RVSFREZy9SVEVWUEZibytJ?=
 =?utf-8?B?bFZhUFhNMUNuK1diMEpDNU4veVpCNlNxci8xSjB1c0pjQzNJR2FiaTZiLzRy?=
 =?utf-8?B?YXhybURjWUY3YUdKZDZSNFoxUjFRcDhzdTNJazc0Z3RmT3hxSWIzU3hrZ1hG?=
 =?utf-8?B?V1ZmMHpKZytmYTVXS2RFRUtucW52VFhUOG1CSnBaV1RGNW1BalpOMmp5aHlL?=
 =?utf-8?B?OVN4YXhPVGRSdUxGUlB1S3IrS0NjdjQ0NjdYTS9PREZCRmFFQi9OVExlbllO?=
 =?utf-8?B?QUVSeG9kQXZKMGt4Q0xVVThrK1IyeHg3bVRnWEFvUHEzVXJSa3BlVUYxWTQw?=
 =?utf-8?B?aENDMS9pcU15bEFUbEEwSWN4Q1N0WDdtM0NKdW51alZlKzFNOHpmT0xLZmZQ?=
 =?utf-8?B?OFV2RURpNHpML2R3NjBuZy8yMS80K3g3L3VoSFlWaWxOdUdqbEZOcDVjajJU?=
 =?utf-8?B?aTdxV0RPeXl3Z25kY1dRRlQ5aXFXNDNGdzRIN2dIeEJudEE2ZXdUcm15Nkpq?=
 =?utf-8?B?eEtHUmp6TVB1cGRuanIxbkFRRE1RWnl6Q3lRYjZSL2IwNFBjVjFWVU5xZzRv?=
 =?utf-8?B?NTNRRU9ldnY0NEp6SUs0YTlyNFlIeW9veWJseko3TWtkWldtN0duM0lQTU9W?=
 =?utf-8?B?cUUxNXRjQldxODF2aDJLYkxwMGhid05ZT0M5bGdkdjgvbklLSkw3TVhjYlFZ?=
 =?utf-8?B?bzE2RFZlZHdXSFEyQ2xtVmt4NU1EdWlnb3BZUVYwWW1wbytMcTRHKy9sZm5U?=
 =?utf-8?B?S0VTdGV3cDRvc0ZTbGZTZEh4R1ZsVXkzeDN5aGFLQitzR2ZCM3QzdkdYbnJv?=
 =?utf-8?B?K1FsWmFEQmZRS0JScDlQcFlOYllCanhqZURRZ2gxbmFwVmorUVhDRFJsTUtx?=
 =?utf-8?B?S1ZtV0FKTFphWSt3ZzNEeVcxL0RsSWJsQjFTNEorM2RzejRmZjRtaDlUWkxS?=
 =?utf-8?B?b1BjSzRMWW90dkdGQWtYZzJPcUF5aEpYNWtMRWZOTGpLVitON2dtcGtXV0Vq?=
 =?utf-8?B?QysydFk0NTVOZmpmMTVueEtjVGJJU25OVFRpUnN5RDdhdmV1VXRzV2R0a2sr?=
 =?utf-8?B?Nk1xNllxa29HYUFmU1JLY0s4dU11ODBCU1dWWlA5WEEzWjU2RVpnYlp6c29P?=
 =?utf-8?B?cUF1VXIrN0lEK2poZXhkSWR3M3dFU25iUTRmMktjajZyUElkZ28veG9qd3du?=
 =?utf-8?B?YWlqQ09hamlYd0JHMWtsdDVmZkV4R0lVTFJ2MWtnY1ZOZ2hEbUZoOW5aclNL?=
 =?utf-8?B?R21iR1JsNUkwcHV0dXBvck1aSjkwZDZtY2NnRzNxa25DV3BSQ2ZWUkVsQUJx?=
 =?utf-8?B?Mm5uc1VDK21LOXNaekF4UHg2ZC9Rc1pqN2RERlNGVE9DNHMxb012VjA5UHRV?=
 =?utf-8?B?WDZBblovTzA3QWtsTHNyMHhSREVZSDRmbEFQZXFPNC9oTjJRemRyK2svcmtN?=
 =?utf-8?B?MythSWtZTVAwazZLRTZ0dWt2NlVMb29RMmlIMFFXdkN5NkUvSHlpaC9qUmdr?=
 =?utf-8?B?ak5LRGd0anYza3NpRVRpaDFXR0ZRamtLMi85TTM1OVNLNWV3Sk5vYlIvMzQ4?=
 =?utf-8?B?L1NaOG1hd3V3YWE5eDZBU3kzbWVPT2VXMFo0RVF0cVFVbVdZR29UcmtVQlNJ?=
 =?utf-8?B?QmFQblRTTCt4RUFEYURNdzhJYmxSOXdLaFJtSlNSSldwZ0RsQTZLQnFsRXR6?=
 =?utf-8?B?Si83QlJYUFNYUkw1RVZ6dWNSMW9ZQktlOS9oc3JLWjdyRW10Q0VMSFVVeFVD?=
 =?utf-8?B?Z2pHR0J6Rm5zWkZjQUFacWE0Z0hJMlRHL21SWVRRUzI0a1RXbGZ0Q1FnaXFz?=
 =?utf-8?B?U0NhTndvbFRIaUJVbHFGMnNHaU1rTEdSckJlQm8yMHhITno4M2FrTmlvTGpn?=
 =?utf-8?B?YkxkZ0k4YUV4SnBoQ2tqRUwxU2trNTdZZm1EaTBmYStzN1RPTWZlUlFaRStu?=
 =?utf-8?B?NzdDa0FCNVBtNVhTSkRjblRCOTF1UHZPaDU5aHNPRU1FR3piVno0eHhPeUFm?=
 =?utf-8?B?M0YwWDd0UXEzWFBCNDVUUXp6RzJZeENFM1d1WWQyK0dHZ2ZtNUtiWDFNWjF1?=
 =?utf-8?B?VjdZTkhEcDRQVktWVEI2cEM3MHpPU3RjQXJoSngvd0dkNWJJWGsreUxZcE80?=
 =?utf-8?B?aHI0MnU5M2pXQS96T244b1dHZFpxTXRGTFAxMk85RW1GU0pJSFVaMytlOHE2?=
 =?utf-8?Q?qcyrs9M/RDgLhT1y4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b12a26-6da3-44f6-5fd7-08deb1b98dfe
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 13:06:04.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/SvHMCTrB4JTfb3Glvqkepuf+wOTmJ2dNC7rPZBGhkWYd9SIlRNhOwn6r+XKKgWed5PU1hVAajmOk7KYBFfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905



On 5/14/26 08:05, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 5/13/2026 3:49 AM, Mario Limonciello wrote:
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -358,8 +358,8 @@ Dynamic energy performance profile
>>   The amd-pstate driver supports dynamically selecting the energy performance
>>   profile based on whether the machine is running on AC or DC power.
>>   
>> -Whether this behavior is enabled by default depends on the kernel
>> -config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
>> +Whether this behavior is enabled by default depends on the kernel command line option
>> +``amd_dynamic_epp`` is set. This behavior can also be overridden
>>   at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
> 
> Unrelated nit.
> 
> This file should have been
> /sys/devices/system/cpu/amd_pstate/dynamic_epp right?
> 

Correct; thanks.  I'll roll that in.

> Apart from that, feel free to add:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Appreciated.

> 
>>   
>>   When set to enabled, the driver will select a different energy performance

