Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD064C77B0;
	Wed, 22 Jul 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734371; cv=fail; b=Tz4V4iqU32jdMLnO0Vud9mvH+63B7SbB6+aHI7FefII8EZP+dCkEEKmN9bkCvz4iNwpx15EDT9Zfj2rgMYSX40GHBn/w4r707keZFrSTikybOABFWxTdAtYiaiic11rHwTu+Nx9sVNG/6PyX018H2fff4DjWSI+wn3UacxHxsXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734371; c=relaxed/simple;
	bh=q3rDY9O82mv0ipQjeiX2fgoV+MtdDvstaUpkKV5wFg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDhFSvlo+CoFCDgRLjorfwgCa1kqz73lRfHPPXSrFQLBM9LBKGF4tfEaf6SDNwafp9pdzyvisvxdmIeS+/MBD7GcVoP3qPsKRyrfDl1vh12NMv4fVgYFZMHiyB8t/R9Brgtq1zvzXbBL3CxoHL9CwybDl0Ax/fOSVfwk9pC1HSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/alsO3g; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/alsO3g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDYU6pu4G1nRqrgEKFLXcCSaQWVqlmOJvgG6ByG5wDmktkA3CnRNe0iq5wlQDNvhR8iFCWRr+P3ztOn3gFPhZpC+Nac8zL+Ocy2s43P/HSvqnepkzfyxy6xmAt92zkJ7sMq9gv2SA0Ygaqp8QAEmI7f8rLFYQCF25R4qWjT39IiNKtwZau9sUrYO8RP/2g9YSI0C5Z7jz24M/p+wVSUCfeDiq+ZK2BM7AlUUTYYu26G7qw8PVbfGZcoUfIOxhnxFzNXpH7/SPt4lFXy/6zfUmnXhZKVNJx6dBTARChL6eSxLG/QDUf6pDGo8HNsyieVY5KaYuNzv74s3cRFsZ3vFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohVxJSj/Sx/pxrWpxjvZ+oirzAmHNAI7ijdD4mwKZWI=;
 b=APPUfkY4DMt7hn6o1Pwt/AnxdBNgLrG5fO5CNmbsfXAs4QtiDQiHUwDgW/+Dt2UwSVgWOxN81xLt1ArSbaRcomb6Ji26JPlNECaJZq/gei9lD00WRkbdqpeGdtH3iXBcT2BUQZvk8UhAzUKJpOOXDA99frcd00IJXkox5PFVOWoQORE2l3dNga2K4GLYwbLVM0s6stvRhrVQ6YONXnYOK/zY8uGD+JgSSrq9VbjK81YKTjoqk2GOeif4Rvty5NHjeaqffaIGlRyUeAROE/1g9EBPi38i1LOl38QEQk8C9AEvO57ZCIiXBIXq/OD8NNpsQKDj3i5W84vIM5ZmjGxiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohVxJSj/Sx/pxrWpxjvZ+oirzAmHNAI7ijdD4mwKZWI=;
 b=a/alsO3g8gH52rF2tcB5Tzj6Ly4M7N1gak0EUDAWkIXRe0QGxqnUSKBKES7J1IraaiAmK50ZeeF4OdSbZ7HwUqZfG5YmqVz/3YWIF0qCGCLHUru9c6GdgfMZBZwpb6u8IyLw2yW93iyCbbU6DPjSf8iJOb4y1wDxSYbqTxPYm60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:32:43 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:32:43 +0000
Message-ID: <e2c30baa-4994-4d4d-9c67-d9e4389dfb4d@amd.com>
Date: Wed, 22 Jul 2026 10:32:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power: amd_pstate_trace: fix help path dependencies
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: ray.huang@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260624123135.7193-1-alhouseenyousef@gmail.com>
 <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
 <d4839dda-75c3-4a82-bad0-8ae29e67c16c@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d4839dda-75c3-4a82-bad0-8ae29e67c16c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 90649465-b612-4659-93ca-08dee80678d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sU5LTG7DBEJsvLBFZufcciHW4Gy6/9FbPxpzeBo1d2cINTryFZztXaxuEuN8YEPRkJPnbt92fFXw80Ox4B/ZhJdl9CtqpldSU2InW8lt4IeMjGtnK7jki3YiBudrtMx+vqFxyKnd94aTQ37vyzQXEzOePiAl0Dcq+X5hHj00w30bEfkZnRkoRXxuuxBM9yJrwddYbAf7Zaz4oZbuJ3heJQW+qXDm9pEE5UuJ1UrPrCOkbwFJE0eVSxlZaym2D0PlT3LwQAxbbf6YGNSHaLxFLWGIYItpHb3jXyalNzVCWdgHRy+hO3IM3VP3szbSzxs5lhGErIdk5RFtVg52j8vXna+Ujc0VfdaJ3wm4tC4aJfTyI47PZ/24llnHtIqP78U9X5jRmabS68pbB1l1efhsT1QxGtIO8qLJXfGAs+4PIJfFNnb1XW1cefOx/UcMMBYz49ANCv+sOB8o3pY5qQBdDPgNOn3kZ72QhPHi3kN4ctQguoBpAvRuKbPS/xBs1BZfJK4awZLjaFggJ4pyPfqaoYUs21xY4cu57QwmEGdePP8y37MfMhaAuIgMSaZ/qdngRxJVSm+L0mhHsjpkwujIGjWtx/Um5ZiCEFHP7S4/JdPxBBHOrFqJvzrehvFGcqpw3AlH3/ZIkqdoDYz/MeE0MfXdo/geyc3rew9vHktu1fQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmlTa3FXZ2pTSi90REtKaHVUNm5yekFlT0E1dUtSYkNWbnZPRUJza2g5Q3BV?=
 =?utf-8?B?NEVSSkZSOEJWS0dYQ0RORjNSMmF2TjFkcTc1WlZrUVdkaVRqT042dkozVmhP?=
 =?utf-8?B?b1IyUkt0RmZlMHRrd0xUbVlINmJrSmY2Qnl2bEVmOHJQdEgwdHQzSkhNUGEx?=
 =?utf-8?B?UUc3dGRkR2M0N3VvWWdROEpsRjB3MlphRVFFcURhSytJSStlc2o5VU16MTcr?=
 =?utf-8?B?cllMVmJsOTlsL1hxekpyM1FZMzV4czdOSysyM1NTQkN6V0t1SDllK3Yvb1pZ?=
 =?utf-8?B?ZDJCcEFFUXZOMENzcGhSRkJHVVk4eVMrQzArWVk2eTRCdzc0RnhiQ2RqQTdI?=
 =?utf-8?B?dTE0K0czczN6Zm5CWjNleGRqeUZTTm82Vi9tR0ZXcVZQdmpXQlF6aDk5c0Vq?=
 =?utf-8?B?cGIzVlVJQVJlQ1hBc2JPcnh6ODhGUnd0SC9iVW4rTm1lUkplSmZSRjBXaVQ2?=
 =?utf-8?B?VkVJVFdyNnhPSW1jL2lYdjQ1N2MrZkYvMmprMVJoWWNINm5CK2ViYmdNVFN3?=
 =?utf-8?B?b0tBbzNHQ1FER2NmOTVyVEZENmZtS29LVUpDL3A5RmFsWXRiQmViZGFHdFdk?=
 =?utf-8?B?cXEvMkRkTmZTRUFZc2lpSldtMDZjYXFnV0FsVDZlTHh3V3RvZ3VZMmsydGIr?=
 =?utf-8?B?OE53b1ZnL040VjVtdEQ0eWlTY0lTZ0lpVjl3UnVpUWRxR0U2YlBHYlp0eTl4?=
 =?utf-8?B?Zm9yT2VNNVBEK2k5L1MyN1NJb2VERzhDT3hMR3VPR25xTzVuVU9TdnZTN3NT?=
 =?utf-8?B?RHA4c1AxRDRKb2FLMEMrbjc3NlVvVU1TOWdnZVJZWG1YcDNiMVF2ZDhDeFEx?=
 =?utf-8?B?eTR5SXRlanlINmVRbmVYcHJTaHA4ajlvUkdQVHlVZS94VHdIWTc5byt2VDRu?=
 =?utf-8?B?Z283cWtRSy9YOTB3VDFJeCtuVE55bDZlSEV5UGhXb2tvQ1d2cEg5dVlaQTM5?=
 =?utf-8?B?bG44TFBVV1RNZ0V0UFlBVi9HSmFaTVRISEg5SjlDUXhZby8zZzhnU2l4WmZk?=
 =?utf-8?B?U3gyU0kvb1BOVE9vb21xTmZtRXEvZlJOOGk5VFk0bnc2aW1RdngvTlU4MjlX?=
 =?utf-8?B?TmhwcmJQUDRlb0t0Zk1VRHgvVDNiNXRKcHA4K25NbWZ3Z2E0a2FzS09sS3Jr?=
 =?utf-8?B?alNhakR6RTM4N0xGYndIcWJoTldRZE9CMnd0Z3NNMEhKRytlKzlqQnNCTU9O?=
 =?utf-8?B?ZDhVTU5WbjRiQ25aL0Qyb2dWOEZTZVQ3cEx5STRISWhTTGZZcW91ME9kcDRI?=
 =?utf-8?B?TlBnVkNZMkkyMkUreU5uZHlnUm1NSUtmdmlOd1VCRGVKUjdiS0RCSy8yMzRT?=
 =?utf-8?B?aDcyWmw5MjBybitFNytYeGFWRVZXWnFMSU9PUkhmbmJMZ3ZGQ24rK3ZRSG8v?=
 =?utf-8?B?RCtuZTVFVUJ4U0xKV1I0WXM0T0RGMTJIamdPcElYdmpRSVVVbDZtcy92ZDc0?=
 =?utf-8?B?VXBtWjN0bmJqL2RxWjdMSi9uVTUwcktSWElMNk9RNnFYdyt3WkptWTIxcmxK?=
 =?utf-8?B?ZVZES2pLQTRxbDlLOEJCTGM0UjArdmVKK1F4RW5ZajNnMjVhMXpuQ2x4ekZy?=
 =?utf-8?B?aTdEZTE5SDl6eXV3N2NHQWpwVTJpMzhSZmhmRC9tUU1URnNPeldFY0ZNNXpT?=
 =?utf-8?B?NldyT3RIdklUQlVKSHpMeEtPbnh3VmhlbkhMbCtqRVNEbEdKQWwvS1llMzZO?=
 =?utf-8?B?Mk5UVTBCbkNpSEswZVM3a2lSd2UwMnA5UDBVM2V4ck1sR0Znay9XdlB2RmUr?=
 =?utf-8?B?a0laTWp0R1lvRmw5a1VLenExQzFHcHE4RU9nUW5qL2M1YWhqdGU4ODhsSXEr?=
 =?utf-8?B?Q0I4cmEyRHVwdE9wdEMwbkxDb3JIcjhrTmU3WVo4NTNKamxSanR2V01qS0V3?=
 =?utf-8?B?S0hldWVvZjY5aDZWNmozZUNKRFNFZUk3SjNscHVScURjS0t0RitkVGVDRDZx?=
 =?utf-8?B?SE9ZdWpkRVpSbFNuQ0dHSW96TUFtQnZkSllYaGF0OVA2TS9NOW55bHF6d3ZU?=
 =?utf-8?B?TXBkTVRrUDNzU3FPZ3Y4Y1BHUnltcjNwWDJyZHVTYmhkUjAzaGNZSE5CTW8w?=
 =?utf-8?B?WURNOVc3L0NOZTZlZWc2VjhtbkVYUXpDSGFxU0hZTE0zVzZIdjREUTZjWVpV?=
 =?utf-8?B?WFlaZHRnUXJSSUdtSjlUVDdJbWFqZEFIblE5MDR2RlpYem5HMUVSRFVoaU5Y?=
 =?utf-8?B?bGZkWXVodDgrZDFvcGUyZ2l2QUFwbm84U2ZpVjdwWWkyenFzRWpCSnlkZk04?=
 =?utf-8?B?YWo1R3ZmTFRFejZ4NWVsOFQvejFYWGVRK3lmYUovSCtjRnhSb2lkVFRkNVJ3?=
 =?utf-8?B?d2ZpMWpjdkFYNm8xSU9GRmRSZ3F1SFZCT1paNEUvWEFGR1RiaUZVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90649465-b612-4659-93ca-08dee80678d2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:32:42.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWiIOIX7FV986wjw3u3NfkoO+dv0dzpYYsUSSdT7ol6fYB5TP2fseW97FFT2itLxK7XxP8k+ptXP5HpxI0VJMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624



On 7/22/26 10:21, K Prateek Nayak wrote:
> Hello Rafael,
> 
> On 7/22/2026 6:18 PM, Rafael J. Wysocki (Intel) wrote:
>> On Wed, Jun 24, 2026 at 2:31 PM Yousef Alhouseen
>> <alhouseenyousef@gmail.com> wrote:
>>>
>>> amd_pstate_trace imports Gnuplot and numpy before parsing command-line
>>> options. As a result, even "-h" fails if those optional runtime modules are
>>> not installed.
>>>
>>> It also handles "-h" by printing a blank line and exiting. Use the existing
>>> help printer for "-h", and move the numpy import to the path that needs it.
>>> The direct Gnuplot import is unused, so remove it.
>>>
>>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>>
>> AMD folks, if this change is fine with you, I can take it into
>> pm-tools, but an ACK (or equivalent) is needed.
> 
> Sorry for the delay in reviewing! I have some comments below for Yousef.

Yes; sorry this got buried in my inbox when I was out and I still 
haven't all the way dug out.

> 
>>
>> Thanks!
>>
>>> ---
>>>   tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 11 +++++------
>>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>>> index 875b08655..b1b201b2e 100755
>>> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>>> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>>> @@ -27,8 +27,6 @@ import re
>>>   import signal
>>>   import sys
>>>   import getopt
>>> -import Gnuplot
> 
> We don't use Gnuplot so removing that is fine ...
> 
>>> -from numpy import *
> 
> ... but we want to keep all the imports together at top to easily audit
> dependencies. Afacit, most python scripts in tools/power/x86/ follow
> that convention.
> 
> There exists a big fat comment on top of the file reading:
> 
>    Prerequisites:
>        Python version 2.7.x or higher
>        gnuplot 5.0 or higher
>        gnuplot-py 1.8 or higher
> 
> which is a good indication of whatis actually required to run the
> script. If users prefer, we can add a requirements.txt that pip can
> consume to install the necessary dependencies and make it clear.

I think a requirements.txt and a quick few steps of how to start a venv 
and use it is a great idea.

> 
>>>   from decimal import *
>>>   sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
>>>   import intel_pstate_tracer as ipt
>>> @@ -260,9 +258,6 @@ graph_data_present = False;
>>>   valid1 = False
>>>   valid2 = False
>>>
>>> -cpu_mask = zeros((MAX_CPUS,), dtype=int)
>>> -
>>> -
>>>   try:
>>>       opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
>>>   except getopt.GetoptError:
>>> @@ -270,7 +265,7 @@ except getopt.GetoptError:
>>>       sys.exit(2)
>>>   for opt, arg in opts:
>>>       if opt == '-h':
>>> -        print()
>>> +        ipt.print_help('amd_pstate')
>>>           sys.exit()
>>>       elif opt in ("-t", "--trace_file"):
>>>           valid1 = True
>>> @@ -291,6 +286,10 @@ if not (valid1 and valid2):
>>>       ipt.print_help('amd_pstate')
>>>       sys.exit()
>>>
>>> +from numpy import zeros
> 
> Having it here needs users to skim through the file to know what
> external packages the script needs and we don't want that.
> 
>>> +
>>> +cpu_mask = zeros((MAX_CPUS,), dtype=int)
>>> +
>>>   if cpu_list:
>>>       for p in re.split("[,]", cpu_list):
>>>           if int(p) < MAX_CPUS :
>>> --
>>> 2.54.0
>>>
>>>
> 

