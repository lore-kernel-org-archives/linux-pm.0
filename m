Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E83CF699;
	Thu, 15 Oct 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060311; cv=fail; b=PWsAUOkakV0W3ZlfkXu7D/iT+4LdN2J2UPhZfmUPzRaQR4TCN09XM8pdeHZ2/HP0bx8dT1aV9vaE2+6eSZz6vbbtN/s7zYx1rS2DkwWPO955zBHZG7Jz2MAYULrdTMgRRC/P11O7TqY71t1UvjugKhR6YUH4P8gvpwcYhsmCpFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060311; c=relaxed/simple;
	bh=t9qJFJAG/1OywTZDcIJnpd66zy3FAjm8g4Ah6bD/sfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NncrGg/xNFHtrHj2fY2qUeT+RqzxWYpF/UORHaohNMQp5e/t/4W4yGd0vwh+JQxNPoNTukrbN55EYL3p/TD8EOAN/Ym2MqPfzNzL6VHB4qkJDR++WT4yP2SbLlfpeQx8f0MyCrzTE/Sd78CJA1kY93B79cbCkgIQs86ygl01LcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WjjOFqOZ; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WjjOFqOZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuEqCCeyOVnDFJFoo/lOtvJaIEmnsaNOwA7rsSgaQxNug3krt1KIrLGgbtkTYVs6FyiITM87504KKVlQTi0DrHBRTgVZD51TSaUXqf+PbHDnYtCfjT1wIeeWrI/8a9Q3Zq580t5QPkSJIy3j+7JlV1T52Iu3kT/MTY+1EciHDkSlNwpxrP7ZpWgqxUGYM4bIOLJuKOsAOEvIWzQK/T67mKl/py6lvU9jcYBlXzpsH404RQpao0jrrcs1bdBe7pMZuq2obe0UhODw1sElsS+/KqwpDSQaRaJsBVyvf1i1VNTKh7PAHw9tX5JhgScHo+2VcNRlooQtMDaTWgMXaBD23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnLdjhs1w6KV5JeNDCTbfUuOilejwswuviaitp2ZMvI=;
 b=f/UmyT76fzQAIseYmm4+2rdg7QJXudIDPH5RQ1MUIESqdzRHTj030c3AzhMClavJ+/KwvZcF4FSiuwBnevCC6bs0BB1r4BdW50plgDGXpR8p/m+qa2H4FfigZBzAW0JBZmOXXpgr/VArrsTHyOf88qIChvQ17C+aq63dh1Hh1hW3+37PA3wSwnCrZNMJwK9fMiGimxDtuYmT7JVHX5BvNuzarwulVJXt7C6w5EUtNDokLMqNTKZUd6fenaOKLcjXGuzFZJs+WfzaxJ6E9wXnWDC8TSuK8oM9T491MbOmOpFGbczL2nJ1e4LxXp+fMn5vBfhjhUBwtXHNMkuDwbxt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnLdjhs1w6KV5JeNDCTbfUuOilejwswuviaitp2ZMvI=;
 b=WjjOFqOZD+5roNf8kwVHRP7MdNEjPUT/C2HAptiiaxY0a+cVgEykRlD+4NcKkjLpf/FCYOkxEGfNZVU4M7vZQLC8hZQvw/t1jut+Q8z54E7Q0sUutmR9hh3ZKh5otk+hDx4wGw9Wf2Ms1JPhNlv7icgh0SBcculGhKsxiud787Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:31:44 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 10:31:44 +0000
Message-ID: <f9bfd24b-60fc-447d-83ed-5204efc60626@amd.com>
Date: Thu, 15 Oct 2026 16:01:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Harini Katakam <harini.katakam@amd.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, git@amd.com
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
 <CAJZ5v0iLOJ49Zn_vPbpbqhPQ_F3W5PCpFN1VnxOzoxL7Y4PN+A@mail.gmail.com>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <CAJZ5v0iLOJ49Zn_vPbpbqhPQ_F3W5PCpFN1VnxOzoxL7Y4PN+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::17) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: b59d6280-6688-452a-a3c5-08df2aa78240
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|10067099003|4143699003|261009221227099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CYq0SatA0EgRyols2TsJBU9Y/GX3kYIWsqfSggMYXlaZqc/9uCRagUT33N9zyKEKjrZJpszli+C6vgI5/vgi6JXBVQfMFaYYfOyd6dJpEZrog9Kwzu+qSfVXFOWDo5osSOUPE9ulEIOtjVv+YKtOXIyhBoby8uO67k9M3H0Xlf3UD6xrsHKOWK1ny6wgh/458bj8UjvDV7vd4qBA3VStwUZ5QEo00Mgd8MrSPkKY99ivlbrwlIdLwAczcw3sl42OyZLCEob31C11yoESe1aRMKM7bEVctXmhjij8WmXatl9HCYvb8T/rF0Ga7Qf81NptUsPkfqTBRS5x5WDKJ26gYuO+dpCU24rVw184VV+j2fE9k3kzF8rVQ1Gi1U9mrZ3z8ZjkZwuvEkHhb0CihMN3v5OealjZJvVMgY41pv0GvXjzI/BxyTH/t99gam7zYneHJR70fB78uv5J0tRK5URq6CZ40MetolxmycGqVzpoDqF7pJu4oEy90Kffb973cQYkbqcjAx8mt6dfnGXCsZnrM1bF0CsddyloUjb8q5+L60sFel98Y3jOLGXkXuOm1BGtMPmBqKsuPuEoVsKzcRr3uVmv0QA+U13uYEqYsdqMeuONof3tV6+2H5CJxUW29zKy9buBBHUmWdl0UkmemftEn73ek3TCft5/MO6v9bJQgrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(261009221227099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndUWGF3SER0My9Ib21JUXFxb2ZZQTVrQkJOKytVcXNLaUxFTUw3SUVZOTBC?=
 =?utf-8?B?WUVHV3kyK3RsNTJSTWdWZDhycnRxQm1qbzB5aTBlL1VMUzAvclFBelBYTmlx?=
 =?utf-8?B?bTJBV1ErNHYzR3Qybk1nZnRZcWZTekl5YzJjbXJhanpDUGhZYW5UallMRlpu?=
 =?utf-8?B?K1BhNzJXWE9zYWFBbUh2MG11SFVOVjFHeG42SnZ2NklkaTJSTHhQUk9HRGVy?=
 =?utf-8?B?b3ljdlppYXZrV3pNSG5PbzZMQWxUMjRUUFU5bmVyTzRGNUNmT21oYTdXbVpG?=
 =?utf-8?B?bjVlUThKRktmaTI1dlJZcHcvam9kUlNubkJmQmgxSDc2RnpoVFg3OEtYbEph?=
 =?utf-8?B?cnBBQ1JHOTVpbVl6MVNERWc0UzVjZE1rQ2F5dVlPdkVZcFpiaFNFZzNIVStQ?=
 =?utf-8?B?TlRnZmZ2U283Uk5HRE1OSWl1UXpxcFVmajlQbkYvUi9HOVRXTzFoajIvNFB0?=
 =?utf-8?B?VmQ4Q200UmRPVUhRMjFxL2xqMHlQTWJGcUVKUURsS0l4Uk11UmRkZ0JWM1Ru?=
 =?utf-8?B?T3hyOXFsR1N1aVEyL3BEdmdBaUFGbDI1R29yYXlzbG1BeDRkdjY3NEI2VXpr?=
 =?utf-8?B?SThaUllMWEJHRzl3UTdZL1FSZCszckU2bWlTalZkdlhZRlFLWTlzSnkvWXVT?=
 =?utf-8?B?Ky8rYnBoY29SdUROR0VpbS85WTk5azFwamlQVDNHSDlZZTBnQmtUWVlnQklC?=
 =?utf-8?B?cXZXQWZIQkVCVnZrY3c1ekRYdXZqMERpbGppemhTYW5iV2RDdW1GaVljU216?=
 =?utf-8?B?TkdMZk9EVnE5OURrcVZxeVZHT0htbk9DUHNZcjlwMGJiZUttKzRQNE5CQzFD?=
 =?utf-8?B?MkExMVJRdjlQM2c4TXFLeTVtZjdTUEw5a01EN0xCQm1WQWp6b285dnB3YmJa?=
 =?utf-8?B?Q0NHK3hFSGdYZVJSMk43TGJEREZuN2dUbGFOOEZpK2RDMS9wOFFJTGd5c3pQ?=
 =?utf-8?B?RDMyeUMwRmFuK3FoWmhZVk5HaHJnRjAxeUIraUg2UzlDR2ZXdnlUSDlrcjhk?=
 =?utf-8?B?bFBHeEZVY2I5a0VveDRmZDhoUWhNZHl1RmZRSTRKcE10M3NLRU9ueDlVdWdk?=
 =?utf-8?B?MXVvdWYwSG44TloyV2RUMW9kRmFMU2FzNTZlVEJ6NHFRL2E5VXZoa3g0aGF1?=
 =?utf-8?B?TlJlaS9SYlhrZVVYL2NsRHl1SWsxN3NyVG5jTXJ5VlFWbVQxYzNZdko3Rk5V?=
 =?utf-8?B?Q1RuQ0NsOGUvUktKVDdEcmlYYUVuWHJPN2V5K0ZjS3R0YTUvNldQREkyZFpQ?=
 =?utf-8?B?dXVBRi82SjBSN0dKN2tISU5KTy9VSzRBRnJlTkozUW1RYzlPWC92dlczN3FW?=
 =?utf-8?B?SWRXOEQ3WFhFTGp5eHZtTFBDK0E3QVZkUG5EU3g0N0p0QW9lNkZaMzFJNXhJ?=
 =?utf-8?B?b2tNT0haUjNwRFBlU2xScFVUaktCVkZ1cmhZSURUYUI1eEtCeHEwZ090VFpT?=
 =?utf-8?B?cTY4aUpKSFM0V1VLVkszcWloRzh0RkhnS2ZDMFpQSjRYZTI1b1lPSXFERHAw?=
 =?utf-8?B?bnVtb3d6UHJaZVFWYWo2NFdwMFJSMDd6dGpnaitLZFZTbUN1SzdISDVlRFo1?=
 =?utf-8?B?RGdvZS8vSkl6V2c1V0FncG1JS1BMUmx3TFFLWG5USEFVNTQ3R3ZZT1JQZjEy?=
 =?utf-8?B?MmNFMUlkYm1WNUJMZnBvSnFPR01pY2JDRGZUL3FyYTVRYTZwdytrZ2dRKzNt?=
 =?utf-8?B?WHo0dklsbDI5bVVvSlVJT0tGSnNNYmh6djcyZlY4cTdleTlTemZtcG1MU3JX?=
 =?utf-8?B?blYyUGt5TjJyU0lwWERoU1JIb1ZwMDB6Sk16V05BeUFDVU52MXRsUk82cFlV?=
 =?utf-8?B?bUU1UzlOa0dxVUNINGhKMWtxbzJDZ3ZWUDhiTkFUNlhuZGNyVU5LWDJhNkxC?=
 =?utf-8?B?dGJSQ3pUbUFQSElpemNpdHhYMzFCRSthNllrVkVSSURDa0VJVlhrTE13bXhF?=
 =?utf-8?B?QnN4YVQwbnUrWG1zZktVOVl0a3RtZ3JyeTRHNCtOVEp1SVBhTXNUSkxwMVI0?=
 =?utf-8?B?dm44czgwaGYvQ0hMTnFqTGE5c05iZVp6aGpjZHNpUU5ZNEExeldVaFAxZjF5?=
 =?utf-8?B?MDUwZVBENmFFckd5WkhXSHhjNGRsNWppeHRiMDdOVUJTelBqV3RwQ1JIMnAx?=
 =?utf-8?B?RmptbnlUMG1OWHpNNlA0NE1OM2FtNTlodHlwRTZ0YUc5QUhzUlFHVlc5aWpZ?=
 =?utf-8?B?S1NOdWp3bGVyd3d4TWFjQnFHVkh3ZllXZHZ3bWZoRkJTalpjUGtPTGdWK0NF?=
 =?utf-8?B?bC9abUNHU2NIUW15cFB2cnpueXhGTU1oUWUvUUZUa1F4WlpmNGVMdzU1Nk90?=
 =?utf-8?B?a0ZScHdIcXhCWkExaGc5dzlMT3czbGJyYXBHVmwxOHdqVHNuWjF1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59d6280-6688-452a-a3c5-08df2aa78240
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:31:44.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEJX/7ipv4BaOUxLNBSCpMl/jm1Zo7JxJzM5eaypamxziTsfX941cn7zWs/ikivUbu2tJUEQ+lUE1JnfsARtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737

Hi Rafael,

On 10/13/2026 12:14 AM, Rafael J. Wysocki (Intel) wrote:
> On Fri, Oct 9, 2026 at 6:00 AM Golla Nagendra <nagendra.golla@amd.com> wrote:
>>
>> Add a pm_runtime_if_active base guard and its _try conditional variant
>> to pm_runtime.h for drivers that need to conditionally acquire a runtime
>> PM reference only when the device is already active.
>>
>> The base guard must not be used directly via guard()/scoped_guard()
>> because pm_runtime_get_if_active() only acquires a reference when it
>> returns 1; the destructor unconditionally calls pm_runtime_put(), which
>> would underflow usage_count on a suspended device. The base guard
>> exists solely to back the DEFINE_GUARD_COND _try variant.
>>
>> The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) satisfies the
>> _try API contract that guards must not produce an error when runtime PM
>> is disabled for the device. When pm_runtime_get_if_active() returns
>> -EINVAL (runtime PM disabled), the expression calls
>> pm_runtime_get_noresume() to pre-balance the destructor's unconditional
>> pm_runtime_put(), then returns 1 so the guard condition succeeds
>> (bypass). This mirrors the behaviour of pm_runtime_active_try which
>> uses RPM_TRANSPARENT for the same purpose. When the device is genuinely
>> runtime-suspended (return value 0), the guard condition fails and
>> ACQUIRE_ERR returns true, allowing callers such as interrupt handlers to
>> skip MMIO accesses.
>>
>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>> ---
>>   include/linux/pm_runtime.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>> index 64921b10ac74..ae2a8740ffb3 100644
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
>> @@ -624,6 +631,23 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
>>                    pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
>>   DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>>                    pm_runtime_resume_and_get(_T), _RET == 0)
>> +/*
>> + * The _try contract is that no error is produced when runtime PM is disabled,
>> + * so bypass the guard when pm_runtime_get_if_active() returns -EINVAL: take a
>> + * reference with pm_runtime_get_noresume() to pre-balance the destructor's
>> + * pm_runtime_put() and return 1 so the guard condition succeeds. Interrupt
>> + * handlers then keep servicing interrupts when runtime PM is disabled for the
>> + * device or CONFIG_PM is not enabled.
>> + */
>> +DEFINE_GUARD_COND(pm_runtime_if_active, _try,
>> +                 ({
>> +                       int _r = pm_runtime_get_if_active(_T);
>> +
>> +                       if (_r == -EINVAL)
>> +                               pm_runtime_get_noresume(_T);
>> +                       _r == -EINVAL ? 1 : (_r ?: -EAGAIN);
>> +                 }),
>> +                 _RET == 1)
>>
>>   /* ACQUIRE() wrapper macros for the guards defined above. */
>>
>> @@ -639,6 +663,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>>   #define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)  \
>>          ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
>>
>> +#define PM_RUNTIME_ACQUIRE_IF_ACTIVE(_dev, _var)       \
>> +       ACQUIRE(pm_runtime_if_active_try, _var)(_dev)
>> +
>>   /*
>>    * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
>>    *
>>
>> --
> 
> For the record, I'm still unconvinced about the guard definitions above.
> 
> Please try to reimplement the series without them for the time being.
> 
> Thanks!

Thanks, for the review

Sure — I’ll drop these two patches from the next version (v5) and
re-implement the series without the PM guard helpers for now. I’ll keep
the reset-related patches in v5,and discuss the PM guard work in a 
separate series later.

Thanks,
Nagendra



