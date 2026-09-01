Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDF3C5832;
	Tue,  1 Sep 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281072; cv=fail; b=WrQoT7wzM2a/ct+0C2euE7l/bjQWu49LY35HUHY8dfU30HzR+0dW2t2X1Uyg5PbGzUvXmAsFnprYalz3ONJuXjnrP/fa/t0aqfVU6Efm4PhZ19VbGylljmWtaWwd4gt+yQBKThN8MHfCIZlPKcP/gzaNh8AIV2SKuXgaNjkQddU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281072; c=relaxed/simple;
	bh=ABMhIl97KCWTAUw7hgy9LFJz7pnLxSaaXsi6VVja6ZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=may+IKCxgxzBM81CE6arPlt5ujQRui2h/nYvaxIqsMCi168ySR4y21NxXOrD79wNhJvIiVfFsc8+Q4p3n92IBsXf8jRWcl62dJqLK3eGd0KRJLSLJYAA7RCBOdEiZO5kpSIj5mm/J1F4+/3Ot7MdxVsry8/PG1plBFoKwZnJ/7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PPNInpbr; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PPNInpbr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoQNpSQjHIfS9MkTqEE+XlQSPSFzl3GNrZsDTD7dcgqIXkuWl9cA87h4IxXJ+WSIWaYYHafzL9hXyAJJdPtcNlDNjrhfLcpdID70KHQvMAOIuTFpqC7MJ2riot5EIPMWYxtRRQRswYgu9cNXV3hdhRnmn3CCLkLSsdfmsk1U5yUs6qd7XD5zLoPgjO/tNdZ3xM1EOEdS2xXNimRCBD5qqKG+jbiQe4A2bENzGK6VJwbjYG/CNaxe8TxXXCexbRSrtBWZQtw7HGWKKZ25937oWbi+/ue4+VZAA3W/C2A/i8KKussCoFR3pyHC2/Q7HLfgYr7ajxlOVptAKhE4zJYJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xA4ynvccotJM4KkSI4EDwemRLq0k6QQpmLbV7QQmjI=;
 b=rsPNCQnOuhUe6NRDPRqjf0mBOr8KFykEWtXR7yutlUb83qQD9a2L8WujqRUvpSFqrynmrbGur+8YFNEEEjlE5rFJ9GWwM3o2HwZ0b81amDRyvInjSQgB2ol+PQMHSYkPEpTmSblt5dK6IXwXTdXchD4zWpJ4WZT31VwtukM5qaj4UbemPfyqllhlsJ9lXFko6waeAoorP/LbSF01B6KHuE4xX1mDVGI8xE3EIz8N7I+0YsIWHIR0345QbGYQPi+Pz2Kubc/JXS8akh1pc4h737sACNmDe5CLMGTesMx5djW7QY0M+e9bDcH8RG88WPLNpNW3QyZ0ynKlzP+oVCuyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xA4ynvccotJM4KkSI4EDwemRLq0k6QQpmLbV7QQmjI=;
 b=PPNInpbryTqhhGzAM/ZyPeDBWKhjQAjeUGiOMcW8c68Wkw09U64Woni8QQkRMZ5Ku6r32vFmmVB7D8YtRNHOBQT8LUJJAXxXBduTC5gIfuroET1deeLF2+7xK1aEPzwJfC2W/dN4ipfWDLtsM/fwfOzlSwNxEF0I91OZrfhKh4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:44:27 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:44:26 +0000
Message-ID: <202252ca-4456-461c-9097-2e66d79d3a71@amd.com>
Date: Tue, 1 Sep 2026 11:44:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org,
 Vishal Badole <Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com>
 <f18fafe4-f873-4080-8ddf-72fb6abec557@amd.com>
 <fc724887-fbad-4433-85b2-27dca6da28dd@amd.com>
 <CAJZ5v0ipHi6DFbd=kCnJvxQ4qzsdANHou6uAPXbhFxUrLpdmuw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0ipHi6DFbd=kCnJvxQ4qzsdANHou6uAPXbhFxUrLpdmuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 97db4b61-e317-4447-01ee-08df084848ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R5PseLw+EfA6O6JHaSpCXkljZ+eAOIOACnjwzz4IWw5T3doxe6GIPWE+6yYmAT3TlNuceBkRewUE1W+Qt4MyTTai+ju6eB76j0zEJoTeNGacops65e933Aoenf8xCsCJjc0nPWP1077iTNL2MUeVpbWm15z5FBIWvZTQjg1T2lg7krz3UcJoJY5A5NrwTtb8yR5LFka8tgW31oTxNBK9uxFNbD+qNLPuurmmSiIa1Fx+ntQ0O1r6dmf0eb/ueGzzcmYigE9TbyW2Pea4IvfPPZQWZBGo+++KZWBi3wviXkSkVA9KEkpibZ529fD/ho8HTIb6jpOzwE+Y7FOgyqK48BlEC25a9gMilOMNeEnbqS5oD3dK1973yhKuIq6Tsi4oGN8zWHEJ0gALONAHs5EEmyCOxvm/A+hqpixxFXyL2xOuzDKT2qQTem69xzpgvovY8PJbTIibIv46Iq+7NQTG4JLIKVSWOKW0zfodMhcQL+B+knKLw+8hFw24bOJfS4cWnhkJFgQmLphEFX6yrWrpsLNhXqyBVpKm/0BwMK3ZPFvB+zbLWUtkoC1Ap0RGL3JIDJpPoAOkt1XumcUjEI46jR0aiGAGuJ9zGLUNl3SanuhVIINl3UD8D/iaRB1dIi1cGOALhRwF2NLClYv8Pt0pLwC1f0fODp//MagZpSG0HGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdmQVk0ZW5kK1BKQ1lkSXFjWG1kbEUvMGpFNG41T0lKYzdFNGZGcEZjdytS?=
 =?utf-8?B?eEpSY1pqZUNMYWdFa1RiTXlSeEp4S3BqZ0dtSy82cU9MQVpQSDQzVXhDNFdJ?=
 =?utf-8?B?ZURzR0ppTUdGSjVUSFJiOTF6eHkyeCt4QjIvcEZtR0gwVGJNS0UrbjJGV3Nx?=
 =?utf-8?B?VTNlMUZCdXBsbEVkUlpLL0ZwOXpOYzVUUDBKV2JYV1c5ZnNmUmp2MkV2d0ls?=
 =?utf-8?B?WHNJa2xSU1VOR04rMUx4OG9QeWpRNkcwWHNSNFZ0ckRURUlpN3Z0dzJYbVBi?=
 =?utf-8?B?NVBwUTA4ckhLNVRhUzVjYUUvTlhGRXVkNTNjbURQTmVHVUgzUld5SCs5K25U?=
 =?utf-8?B?b1N5bmVnMzFNZXo4d1l5bW5rekM4RXhzRzVrajE0NFFlNTZFbC9BZWNmbkxw?=
 =?utf-8?B?OWpkVkJJT3lnUURmblltWUhCamY5YW9FNUVFdjJKS042TWRERU12YmtXQ0Vs?=
 =?utf-8?B?ekV0TFp5eTdEM1FKU0JBeE91QStZTERKNDdrZ2xsekRjRlFOSDAxTzB3aGdx?=
 =?utf-8?B?a1F3VFRVdU54bG1Qc0xJVWdtZGs0cy9id2RsME5zQmFLd1VpWW1DZVpWbTlz?=
 =?utf-8?B?cWhUS1NlMnA2b0laeFY4VHJuWTg4MVBRVmhwYXBKOG5BTmxrOWFXQUtpQlJB?=
 =?utf-8?B?Zi9yaEh6NEUzT2dyMjMwUU90anFoaW5VU09PMFBLRTFlQ21IMVQzanROdjI3?=
 =?utf-8?B?YURidVJWekJURHJWK2RxRjMyQ24wQ2lvVUpzUm5iNHg1NDJlUWt1T3hBRUF2?=
 =?utf-8?B?NWlsWTlhbUxVZkF2SVdvREREeEp1a0RuVWs5U2FwZThUYzg4amJaZGxHdFJt?=
 =?utf-8?B?Z0QyZUJmbXJPdmY3MHRzWEE3aHdoUzBRcHZ0amRXWHNuMlo5NkVuS2x0MGkr?=
 =?utf-8?B?T3QwODc5VEtseTRiWjNoVG1KR3ViSDYxb0ZkYVgvaERUYnhZV0l4SUVKTHM4?=
 =?utf-8?B?ZkZVbk1MMy82eVF2aHlLcU1SS0t1UUJaNE53VkdHOHRTOXY2bWhaTGFLOFVj?=
 =?utf-8?B?QmRObDJGMTY2ejVSaktha3d6cTAyUG5nOXRpMzZvRDkvTXFtbDkzYiswTnU4?=
 =?utf-8?B?dTl4N3E0L3Z3V0NaNG9QRUJwQko2V0IxM0czcXpVYmpFSU8vYTlldTFmUnIz?=
 =?utf-8?B?b0hBTGtPMDgzMmhBejZwcmJJekpMRCtjWmZJLzJTbVdOT2FCQzhIZndMRjlX?=
 =?utf-8?B?d3dxeW9UR2VGdmo3UEI1SENPR01PaVFCTlRZcDFXbkFWOFd6SEJ3YmdHeTFy?=
 =?utf-8?B?WG1iazZHb0haZzhBSmZuSHFtUkdudTBzeUNuVVI5bko5S0pWZGRPNUFaMzNH?=
 =?utf-8?B?YlNaWG9XT3IwSWtIalhuU1JndkJjN21CZ2ZER2xnclRoSDh2RXpPbUR2Q1F0?=
 =?utf-8?B?eFg0R1VSblZRNjZ6ZkhMSE1JeHRiV2Y1QWFJaTNVbXBPaXFjNzZUdXpZVzQ0?=
 =?utf-8?B?QUVOWVA1cTlHazZkYk5UYTNaRnpSRzJVY0FyUnlLSzhXT0NxeHhzRnl6NnVJ?=
 =?utf-8?B?MHkzdU1sL3l3T1BrN3ZuRHUzWUtEQmxBZ1dXam9Kd2pIVkRINW5tbUQvUHQ2?=
 =?utf-8?B?RGNQL2hGVkVYTHNoRE9iV3hGTlFTYlZjM3czUXBZR2hlYzVKMzN2ekZPcHZG?=
 =?utf-8?B?QzA1VGY1SW1hY2V2TTV1Q0k0bnRZb29CcGQ0NEI0Y1MrYnU1VWNVdVVzNUY4?=
 =?utf-8?B?aERuWG1Ea0ZZWm45bUlXcytVVTZURk11Qk9xbFMxcWQvL3VIS2ttSGVkUGpU?=
 =?utf-8?B?Qk1RZFNoZm53bkJxV3dWWXE4d0cyQmllb21xUUQzcXJIK3ZvRkV0RERxelU5?=
 =?utf-8?B?Vyt1VDFRVU9sc1AxdlM1dld2KzNXdUR4YzdyOXVpVVE4TkJRZG5Ka3dhTnR5?=
 =?utf-8?B?YmtGbkk3VFpsL0Y4NzVTT2U2QWRBSXBPQXdLQ3RERzdNMUg3ek1ST2JHTEVS?=
 =?utf-8?B?Wk1LbnBRdXF0d011TU5kaWVocHFnZFkzWTdYL1VzTHc4S2s4VDZzVU1uUElz?=
 =?utf-8?B?bjFYYUQxZmpuaWlkRlFiMHBNcEhNZklZWVB3WUt4TFQvWTZHbWRkZmJCYlpP?=
 =?utf-8?B?cVdvejR3U21QWVBZZ3NNTGdBUS9XMnZWV0ZNZXBGNlNhcmZWSUJobFlZNzNh?=
 =?utf-8?B?WmpIRTNvRjk1MGtidVoxUElrbHpvWGpWQmZacitFeSsrYkpTRlJrdWFNZGpt?=
 =?utf-8?B?Nmg5aVpUUmwwT20rbGlLOEtLRHFZcWtMdkxVWUVhM3NTTmFzODZOSWZiMWpD?=
 =?utf-8?B?RmY3TWhXRUlZZFA4UC80cGQ0YmRsWVEwTXdhWE13aU9qeEZvUDl3WVhwRXMr?=
 =?utf-8?B?bzdtbHl2cUk4QmFSNzQ5YjFQbE1SWjhYVEo1WGMxUUFFWnJTUVJyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97db4b61-e317-4447-01ee-08df084848ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:44:26.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Vu90Q5qmyjoZZwovsJkptHJqAbWrl3RW3wO9ec732Lbl4WSZelC31GNFcluJB8tOqQI+UFS5QFhPFWPiqhm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815



On 9/1/26 11:34, Rafael J. Wysocki (Intel) wrote:
> On Tue, Sep 1, 2026 at 5:28 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 9/1/26 04:31, K Prateek Nayak wrote:
>>> On 9/1/2026 1:14 AM, Mario Limonciello wrote:
>>>> +int amd_get_max_frequency(unsigned int cpu)
>>>> +{
>>>> +    enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
>>>> +    const struct x86_cpu_id *id = x86_match_cpu(amd_zen6_client_ids);
>>>> +    const struct amd_max_freq *max_freq;
>>>> +
>>>> +    if (!id)
>>>> +            return -ENODEV;
>>>> +
>>>> +    max_freq = (const struct amd_max_freq *)id->driver_data;
>>>> +
>>>> +    switch (type) {
>>>> +    case TOPO_CPU_TYPE_PERFORMANCE:
>>>> +            return max_freq->performance;
>>>> +    case TOPO_CPU_TYPE_EFFICIENCY:
>>>> +            return max_freq->efficiency;
>>>> +    case TOPO_CPU_TYPE_LOW_POWER:
>>>> +            return max_freq->low_power;
>>>> +    default:
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    return -EINVAL;
>>>
>>> nit. Since we don't really propagate the error codes returned
>>> by amd_get_max_frequency(), maybe we can return 0 instead of
>>> -ENODEV, -EINVAL and the callers can simply do:
>>>
>>>       max_freq = amd_get_max_frequency(cpu);
>>>       if (!max_freq)
>>>            max_freq = /* Fallback */;
>>>
>>> similar to get_max_boost_ratio() pattern. No strong feelings
>>> either way.
>>>
>>
>> OK.  Will adjust for next version.
>>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(amd_get_max_frequency);
> 
> Please note though that all CPPC-related material is gated on this patch series:
> 
> https://lore.kernel.org/linux-acpi/20260830115644.2056983-1-christian.loehle@arm.com/
> 
> and there are other multiple series already waiting.
> 
> That queue needs to be flushed I'm afraid.

Thanks, I'll rebase and test on that series.
I was just CC'ed into it today too.
