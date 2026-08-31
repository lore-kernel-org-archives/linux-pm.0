Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A23EB0EF;
	Mon, 31 Aug 2026 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178017; cv=fail; b=srbpG5AFFqGbLb7n8KUeXv5A1Nj1IKmI1lJ9/F+uYackKMQk5+tKMikNz+bWDU9PJaq9IYCPqRrt6JSO0SfR6FZc++MyR9+3OSkUk2kvquMQNJIWjJwMzYBgzYD4+4LQYcMZcewpiUFQ/bybY6dwp2QQFzaCFJ7/AmEu/L+gTwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178017; c=relaxed/simple;
	bh=0fk4EVb/OthtpZfh6/mG+Lezn5ajgjaRlsnk1U5ite4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/ztz5AqvXpouoE/jtxSc3c1lmCfMmIwvEVzL7VgMbk+BpL4jaK/dC6lB+lQzpI+ASZ4VpNfj94uxN8R4pKyjXRX2vJlREcLvMzGINhOt4x6bH4O6FFLO8DzXe1d+devXexO6h/4xR+MrkaAngLe4siyUTxxW2PA8o4pb1hXFJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvEX1Ofg; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvEX1Ofg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/ifqzi3f1KgPPd7wSMdt6l3BSuM56GOhL+WGwfIK334aBNXVnyeUNg9lcTuYKajK0rEFt4941bbJkQX9SVKbxo7ecrSeFplFCZiFfOrlElG4QMipMxhBmUnnRJwIMvB3KcVP+wJoAYebBnMnsvp3VlCHbS0/feoQt5aaZyL1r6mt/7ARvutXMkJ8zwOLG44NNyBId4tGUn16tzmyE2byMINLyFvP4lIcvH0HwP2ioUAAiqbT2etisR7swl6wFV0lHxfZgjIpUqyJ+vWnbwKTDiIRZLksnLqSjRMTHtDyOlqLxdJXYnUVDU1uef+9fSmlbNK1ZLJYJmfEEtRXEo8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCnxnETcHGHEBFT6iq7BRwnHbP+yavWcEODqzC6Rht0=;
 b=Gut68Me5T1hhLkGbmCeg/8yCS8mwnaCfz5Swe8Ax7kn65onNxiAIgZWuD2SH9HZ+/gu8ckDG7W18wTmmdpol0RT4tjNwLF6OlLiPkKJ+NpjNLOYdrv6IEkB9nQDkPc+KnWhkCmykdzFep9EW+P3FvU/GQqQTDSomCaEuAPCpOyIqGUQTzTPrkh9lCd0u/ixXcrebRwBDaK8p1/7qYOjSyFUFfmOPb4UFTWvJA3fWmiqZYn1tqZ6UScRvvewC0v8iOpmoEZ0K6sJlMbEumi8d7TSI8Qxg+TE7rIWZqwVw4d3bRk46qC+GMUubx4ngmXl5JYH7T4zqGZGwydAcvCaKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCnxnETcHGHEBFT6iq7BRwnHbP+yavWcEODqzC6Rht0=;
 b=gvEX1OfgA5vREPHKgpA8MncKsSM8L3kQdchZh69v0J5baJpa7gaUJnEUh1u/6SnWB60mJwZAGLmkhyR3Hb6VHjUbgKSObyeyduD8U1dD8gReBd0vW/1LT/jWk5KsN7dN5mCd+/wVNX+KJjG58haStN8hxuuiqBT8+OKwUSDZ4iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:06:51 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:06:51 +0000
Message-ID: <d42ac198-9fff-4a3c-a3c9-2f032021c4fd@amd.com>
Date: Mon, 31 Aug 2026 17:36:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, git@amd.com,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-3-nagendra.golla@amd.com>
 <CAJZ5v0gKwxBp=Ajm5_iJEP0GTY5J7SJnHJGCQjfKYgmOHqE0xg@mail.gmail.com>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <CAJZ5v0gKwxBp=Ajm5_iJEP0GTY5J7SJnHJGCQjfKYgmOHqE0xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6544f2-d005-42ba-6865-08df07585754
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UPFsYPMoyWfLgj0bxtDAKNLWN7PDhft0QyjWpLe1vqjZGKGSEShqrQGX0MJkDYDBqxzFOUf4AwuAiksC7iCJsJufx9V3attsBdV+dhHaFOuTsfJYmzUA0bxKjYJvjrcHZHfDfzL0b+FCcf2KqwIJN/m4gyzlteCk2A+uHogQS5+xPqeVgOD4tKL2lHfXHckNyohtNsHFV5j0s4KW8aoSZNsCB/tJUP6YXo3lnWqZgVoKtSaKYIgz+lyEOgjaw4NGRSECEgzagpboj6eUjxRXvt6kAlrf3FRFDT0gaGPbecNebR11X3bzOQ0XXga4iQBZX9jC2wHdxI6X/RLnYOLUiGrQQ4JYn4d0Dn1QClczvWMSKYU3nQfegqPWXAT7ivc/ej+uts+EZFf5gLjHDKkMFIZtXtL2SkjlqO3s5kxu0/aBjxJatItGHWUUUX7+6nzJzptgJVpZuUM03Rzlkd9Z6K+XvnB92tiCR1LqQe18OVLixmdIgxMUWLrjEC3TpJm9UYlyrfv1x4Y9jRtxJCViLS/KmnVnEAJcYWBeiqlZ1F25oLc6ITOrcu3ApfKVsyKHBH0Xe7jUq2dFzaYJvYTxkI7UPqLK2OaTsXlDq+offsZJNrAJzsCOkmu0ji7H0ujW70mzeDi4fF2Fgc52iNVgbxGBFu6nkyhdq0tmoPIu5aI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpTcUgzZ2tXZStqZWpHcFdrZUFsNWFaclQrUXFzNFg5YzRCVExSTmErdkIy?=
 =?utf-8?B?MVdiQzNnTklKdXhLSTRuMlc1MmN6Vlg4amk3QnkwNkRXQXlid0FtdzlRNGlN?=
 =?utf-8?B?RWFoTEo2MERrMHR5cllzNGhTcTdteG9TcDlDSVhkbWFTWDBhTWdMdXZjOGh2?=
 =?utf-8?B?a3dHZ2N2NkZzZ29WTmtJVnQ3cnYzMWJVMGRFS0JZditWMUFtcTdGSEtOVFNs?=
 =?utf-8?B?VGJqd0p5QTBadHJ0OXRIaXRqU1p1bGgxWFY4QVRZbjhEMHVVNnpJL3Vna25O?=
 =?utf-8?B?cE5kMklrN05sYkVhdVUrV0s3Sm9MSFpqb2lCc1dreEhaSTJiVERNNVo5VmFH?=
 =?utf-8?B?eVM1NktGK3RmUmpDQ1owbSt0ZDU5eVE1YVpMTmxPTkFUYnVEWGswZlg5aTVH?=
 =?utf-8?B?RUJhd2FKYVFURk5VOVJESG83OEp3Z1BraWkvMnRyTGJtdVBlenRUektLSkI0?=
 =?utf-8?B?NUZlR2tFblB4azR5WC9kVzNFcWJtWVJVQ2FZSXBwaEhpdHhrVW50di9NTklO?=
 =?utf-8?B?NG5jVWhvTnNMRk5pdllwNUQrMTFXQk9EVEV4OHhnb3dwQWhlZmlMUk9kYUs3?=
 =?utf-8?B?NzI3UGVhcTZrZU5lVHdQZ0w3cTNGdmNjZ0lZYzIwamNma0RiQ3g3N2V3Y29w?=
 =?utf-8?B?c1NtM2dOQmJOQlZaUERWeHJtdW5GaGtFSjBkTjdhcDZTeEMxdmo2ZWRDVEx0?=
 =?utf-8?B?cUY1MUQ5bDhzZmZ2dmpJZUE4RW1oaDJQODYvR0ZuZlBnSmJFcTdzRXlFcGN2?=
 =?utf-8?B?Umx6ZUh4K2VoWDQ4NHpObWVNRTRKSXE0aEo2OWxUby9MZFhOT1dzbHNWSGhN?=
 =?utf-8?B?UkhWNmg2QVU0MldJeTh0MnpPRE4xd1NZR1RKNHdPTCtGUFd2RE91dmkzWFNp?=
 =?utf-8?B?ZUJyLzB4NGFkd2lOSm14Uzk4RHVBR3Z6Z05RSmxXVEo5YmVoTFNKNHdQWThz?=
 =?utf-8?B?S3A1d3lKSnA4Y244cWZqZXZ3ajN1a01kanBxYktWT2UrcC8wZ3pkZE9iMVZU?=
 =?utf-8?B?MFBlTDZkYU04c2xya1ZybnUxMmlYVHhleU5zcnpjSk9WMEVvcVNKb1Z1TDdx?=
 =?utf-8?B?MlgwZmVUZXUremRmNnlXbW9sMWMvNGRJUUUwV0JwYjB2cjNmazU4ZmlZOWtI?=
 =?utf-8?B?UzVLTmFub05ZSFR3c3dHaEdFUXp0VVVrcEtLWFkvRVV6aXJnRzExeWJLZWhu?=
 =?utf-8?B?ZkFlbjVXQTF1UE5oNkM3ZVNpbWRmNzNyUFZOclpIUmdXVzVMZkUzUHNocTFB?=
 =?utf-8?B?bFFnRnllM3VFeFFTNkxwSUhZZkNweTRvMTNNZnZ4cTBPMTI0eEpLcFdMdFRp?=
 =?utf-8?B?QWZnSC9paWRscDliRVg1OUtzR3ZtN1FKTmplOXVuS2ZhcFZWN3JiZ2Fxbms1?=
 =?utf-8?B?QjFwMjJBd0UvZWVSaVE5SnFjMHkxZ2F4dy9ob0hQa1hmVjVOTmVhdXAxT0RJ?=
 =?utf-8?B?akNVY1hIMUZVMlNTYmZ5ak9pRFVId3BzSHBsZkErU0RIbHcvam96cHNRcUZn?=
 =?utf-8?B?Q3R4MFJlMUtseTJhUnJMTmhyOEFxdDRwQTBtdDF4ckNENkFiZk94VEVzYjJT?=
 =?utf-8?B?aFQvYUUxQldEWXBWUDdPMmxtUStkaGZBMGg3WDB1eUF1cHh0OFFVSDdHamNI?=
 =?utf-8?B?QWZsR1ZoUFhwTmVkMlRZNWYyamtYQkdVazRsNEVrN09FN3hWRUppUmlCRU1h?=
 =?utf-8?B?WHJKbklNUTltNm5hL3dFQXhNTHcrTnZTaGJBU0lqSzFqa2JYeTdwSWdiUFVI?=
 =?utf-8?B?SEJ5c2xoVFdWcUlXTkJDU2tha3V6YU5SY2J4bWpJVTRscFhVUEFXS0pBb3NG?=
 =?utf-8?B?OWxLVGZEclVBcWZFOEI1ZHFKMldVQ3JWM25BUDJaMjZsWWZ3WC82WnZYL0s5?=
 =?utf-8?B?MXpjS0Z2cituQ1ZTUHNMWG1FakNBczlUS0VxNmZ6MUxtUUh1RnVzZEt5azNW?=
 =?utf-8?B?eG5CUncvQThBT3VKQjJiQjkvekUvNmZDYmNReTh3Y2p2UFY5TGsxN3h6RnF6?=
 =?utf-8?B?VEJvNGpqZGM5TlYxdFFVaDg3Z0tyRVR4Z01Hb0EyODJZK2JoWUxvMDVtVU1q?=
 =?utf-8?B?REEwNnhkb0I4QnI0cEVHOGcrcVl3U0NNVU1MOGR1dXBMdGRPeWtkTVc2M3NF?=
 =?utf-8?B?SWRMNnNQdENzYnc0M1MrZi8rSjk2Smd5RnBQdldOSTJrM0VOUk9NRld5Y2lG?=
 =?utf-8?B?bEx3QTR6OElYQytiTzZVNzRKUDZaSHFIY3ZXanBIM29MQmkwdzJoQjJzYnBN?=
 =?utf-8?B?TTNNakRpVFh6UVlhYm9SQ3Z5aWFGZys2cDdnbjlZVHJBYW8wVWF5V2ROK2xq?=
 =?utf-8?B?SEtuSjlobkVLWWxJY1ZYNzhUTEpySGxoVEF3ejI3QkI1VTU1N3lVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6544f2-d005-42ba-6865-08df07585754
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:06:51.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+UG/+e0ZnkEx0iksBrrLpAigBycK7/3b+u21spP7g240WQK1jgKmSaNM4Na2/K/Hk66vBu+dyMDU6ZoYcVeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819

Hi Rafael,

On 8/24/2026 9:48 PM, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 10, 2026 at 12:11 PM Golla Nagendra <nagendra.golla@amd.com> wrote:
>>
>> Add a pm_runtime_if_active base guard and its _try conditional variant
>> to pm_runtime.h for drivers that need to conditionally acquire a runtime
>> PM reference only when the device is already active.
>>
>> The base guard must not be used directly via guard()/scoped_guard()
>> because pm_runtime_get_if_active() only acquires a reference when it
>> returns 1; the destructor unconditionally calls pm_runtime_put(), which
>> would underflow usage_count on a suspended or RPM-disabled device. The
>> base guard exists solely to back the DEFINE_GUARD_COND _try variant.

Thanks for the review
> 
> Which is not nice and confusing IMV.
> 
> Is there anything like that anywhere else in the kernel?

I reviewed the existing guards in pm_runtime.h and compared them with 
the if_active guard design. No existing base guard uses a conditional 
acquire model like this one, because all existing guards follow the 
"make the device active and then access" pattern - when they make the 
device active they hold the reference, and the destructor releases that 
reference, so it stays balanced.

But this guard's use case is different: it follows the "access only if 
already active" pattern. In the IRQ handler we must not resume the 
device, so we only proceed if it is already active. This requirement is 
precisely why a conditional acquire is unavoidable here - the reference 
can only be taken when the device is already active. The guard takes the 
reference in that case and the destructor releases it at the end of its 
scope. However, it does not take a reference when the device is 
suspended or when PM is disabled - and even in those cases the 
destructor still runs and releases a reference, which causes the 
underflow problem.

Thanks,
Nagendra


> 
>> The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) checks the
>> return value and only runs the destructor when the reference was
>> actually acquired. This is useful in interrupt handlers where the
>> device may be runtime-suspended and MMIO accesses must be avoided.
>>
>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>> ---
>> Changes in V3:
>> - New patch: add PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard and backing
>>    infrastructure to pm_runtime.h so that drivers
>>    can use a structured guard instead of an open-coded
>>    pm_runtime_get_if_active()/pm_runtime_put() pair
>> ---
>>   include/linux/pm_runtime.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>> index 64921b10ac74..bc6de97e6111 100644
>> --- a/include/linux/pm_runtime.h
>> +++ b/include/linux/pm_runtime.h
>> @@ -609,6 +609,13 @@ DEFINE_GUARD(pm_runtime_active, struct device *,
>>               pm_runtime_get_sync(_T), pm_runtime_put(_T));
>>   DEFINE_GUARD(pm_runtime_active_auto, struct device *,
>>               pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
>> +/*
>> + * Do not use directly -- the destructor calls pm_runtime_put()
>> + * unconditionally, which underflows if no reference was acquired.
>> + * Use only via the _try variant below.
>> + */
>> +DEFINE_GUARD(pm_runtime_if_active, struct device *,
>> +            pm_runtime_get_if_active(_T), pm_runtime_put(_T));
>>   /*
>>    * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
>>    *
>> @@ -624,6 +631,8 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
>>                    pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>>   DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>>                    pm_runtime_resume_and_get(_T), _RET == 0)
>> +DEFINE_GUARD_COND(pm_runtime_if_active, _try,
>> +                 pm_runtime_get_if_active(_T) ?: -EAGAIN, _RET == 1)
>>
>>   /* ACQUIRE() wrapper macros for the guards defined above. */
>>
>> @@ -639,6 +648,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>>   #define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)  \
>>          ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
>>
>> +#define PM_RUNTIME_ACQUIRE_IF_ACTIVE(_dev, _var)       \
>> +       ACQUIRE(pm_runtime_if_active_try, _var)(_dev)
>> +
>>   /*
>>    * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
>>    *
>> --
>> 2.43.7
>>

