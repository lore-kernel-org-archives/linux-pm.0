Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392443E3D8F;
	Wed, 23 Sep 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189845; cv=fail; b=XuVO5Rq+49iztInoRpIwlkKGfIGbRwXxS9qin9xoCegqxnpMZErxZT2o04/cAmjPRWIYHg7RG+C0nO3QQ7bUYNljr9SyBcA2g6NirmDf19NT5iZr+soaAMGwMN2as720Ibl0NKQh7Ab0HXhzs4Jy2kug2QhwZQVcXbNrXUx+K64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189845; c=relaxed/simple;
	bh=pII3oznB+GauxXKh7hFVTpxf3VulEoBffzZcFZ5JaeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YK6dklC3r+01lw7k0ATKkhkYtDLt9mZJ0o0tNNY7kdqTATlJ0+NKrnEBUg8xCHRyiKGSrEL6VV2VmQnjiGMC3Knr+j2Cj+ibzIgAMlyf3o5L43S5FReSRK5zN1UCeObPx/oLsgjy2fKB+B3VIywsvHi2UIB0gjD/Ipz5xmuySdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykwLH+ca; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykwLH+ca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK2KBBHh6Tp/0ePvJYL/hzlCbMHjGhgogFPLBfCCR5vf/GEXuHZ/k6xa666EcVTUjth5m8vioF/rM/3tlvPS/dvWU9fWavtCss96r/n9VXjokL+8VlVYOzK7suUGe3lF09cJX5ASuVSFwUf4Z79ZJm/zz6TYY4+t4jCe1TPB9hWAtMAfg7kYik91EE4tDgEJIOgvGtfzPiv5kw1m02fwKKdzQUaa1Mg0LvSnHJV+aQSXSWoDqVqiZSW184QjtcMv1QJBda0WOdyGaf6ClLm0R0CX9/rd5TeeJavEbbV41e29sUjFaouJTPyEYKQ5ik0iY4z6FNSjQY1LSZvi6JujbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ1jRNspcTkXwKNKfbsFSQlXOqeSoIb7cVqkncg2szQ=;
 b=XbRmdaTFtRyBQWXphEH5gLtmPzvWcZlk6Y2+/P6nZPKDkkCB4wuZFSW7+9ucDMBBWoMp5dCKUW0o394vq0+dGeG1UbzhHj/1eHS4a0EuGD1zKTgf5Mua/isclXuSO/uoz399Dkdp7xKpZI7AQyH7ECMjzMzUOAQ06ZEMmcbgkc21px3dHVNxn2H0rAO7367XMquwwlfFoqvX1cR85PMtVYoshg+H3KI8RJXHGU2/cg89spOYDzckme3n25DhtQcHSDjk3RdICHr87XLWUK/Okk8CrgLJ0Ls3fAtTBFbfyfKKYLuL9q/wPAms/ca1qiVhcnsgYBMl/ACtqaHuGh/v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ1jRNspcTkXwKNKfbsFSQlXOqeSoIb7cVqkncg2szQ=;
 b=ykwLH+cawyaNs5Wxjz6DDZbiG5hMfAG2v8lDMZF2WcSSIFoc1RKLbZe6gRC2GOirjrm3JU9GlOX9LfL0xmaqFd7yv3MwpJOTOPhGqCziLqrt/8PRQRhhOh77GOwx4EwKnO3ZZ3TxfMpw6AI0/egR0IaXAf7Y/a8jMI+x3Y1S58o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by DS6PR12MB801076.namprd12.prod.outlook.com (2603:10b6:8:417::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 18:57:21 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:57:21 +0000
Message-ID: <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
Date: Wed, 23 Sep 2026 13:57:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:610:50::29) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|DS6PR12MB801076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b074d0f-c5da-4cf4-6996-08df19a47fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|6133799003|11063799006|5023799004|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	H6XUzQsROi9Vljy9eE5I6g7DGCVLedpmVC41HaPU00zYVEPIRrc072ktKILJgH7wTjAuUjk8Fjlqqlh0rSLQEz7f8pMKg3itVrI01kA+tCNF5FXjO/EEevQolzvY8Y9gsIlE2tpmRTiCwsUUbjUhJsb8wCRfdy1ilgM/ia4J0YhEUKSm1hn5T9v2YR6bALpvq5tnTuCoagQTBXUn4C9014cMQkhah1XUJClZra6xW8UQysi+Lek+JiFtgijpWPJIyMbMn1hs+A3vKnjtDoYiwv0kcifgT97HkzvHSNPYWWo4lkEBwdeg7w6FEUM2085805JPmhKaJUfvyugVYPg1VPQ9/YtsIOrhVJtOAx8cj5tVCSujU7xtz/l9jjFSM3NYSNznENdK80KBxyx6Ipl2xE8d24Blv/gYQgrAsCB8xAKuLzJ5xqX0wRp/fdh69cQbhoqK+K8rSxWTWuDyWklJPYVAARCwh6GMFlxgDbePusLJDJHgzOGr5VeDahqVhgFYKUqjPMfP5FHsPYSjh+K2PXfPktioqqmJkCHEg24GP/EWTurxq3ndRRiC9xwC6R+k6+ydZbjO71JSXPgLJTSxqsO1tzQehNHadWq41/Q6ZZF36kxOn2WgoaHz9vmE1oTQPRkYRKeLTLO+IR1uzkMTIneYjH1AkOwI5AOfTdwme5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVlGQTRIWGh0VFcyeFprY3hMelU2MjZBQUJKSVdiYVFQRmo4a2h2ZEdEV3BS?=
 =?utf-8?B?eURDT0lIUWhha2cyVDdiSHlxczVmb1R6SVJKQWVDd0EraFk1aXdyb1dVbEZu?=
 =?utf-8?B?aDZNQW53Z1lycHUwTDFDcDBHWEEwZW5ib2tYS0ZlNHFRWldabGh5NjgyUlFL?=
 =?utf-8?B?bGM4M3MyZjd4cmU2ZXVsbjJtL0w1bnVvRThwalozalc5UEJHcklVZWpmMEVD?=
 =?utf-8?B?UUhCcFl1TG55TGloQy95QThxdUVWM0MvUVNxT1dQRlgxTmtXTjRXUk5rSHhH?=
 =?utf-8?B?UFJrVjlURnhKL0NWMGo0RVkyRHBtRFp5Q1JpWlNvaFVPaFAzSHhtU3JmWHRN?=
 =?utf-8?B?VXRiTzh2TTRTK2FSV1kwek9Jc2NNelYrRkJWZ0xmMmc2QWVkTytqSXdKNG1n?=
 =?utf-8?B?M2xnc1E3RjNoYnhyVldPN28wY2xDVUFsbitlTE9ieU01c2lnZXorTHVnS2ly?=
 =?utf-8?B?bWYvSGxoTmJKZVZGSlF2bUhaZUEwQ0gzemplVXNORmFVeTFCMm8yTVpiVjdC?=
 =?utf-8?B?OW4zTHZWODhKWEtiTXZaem5hS0ZwcVcrNkREejVyL2FuRnBLaEhvbnNaS1h1?=
 =?utf-8?B?NmNkYXFRVys2dVZXM1NqTHFwZ3k3Zmh1eFMxRy9tN25tZ2ZlVmNyWkNXd2Jh?=
 =?utf-8?B?ZytDbHdmK3dJK2t4ak56V0w4TmVmSUdUYXpLdHk3UG1keGYyR1dTcVU5bmpF?=
 =?utf-8?B?SWdQVUtrMHNTQjM4Sk1mcEcwWXJwM0NmOEhKc0RmdTVzQUdGSHh2UEcyK3kr?=
 =?utf-8?B?NmJyUU9SNkl6Vk84MzZqSkV1aFhOWkl6M1k3M1ZWMDhOMithQTJnVGd2WW9R?=
 =?utf-8?B?MDhlMkxWaVBrekpTL0ovU3hUbW1jalltZ2hISFEzdVFtUkJ5TERkb2ZPRXhX?=
 =?utf-8?B?R25vaVd2bld6QW5lSXlSV2dsQVlWbnU5Q1B6NEJxTXMrRWp3N29oVzh2UmtX?=
 =?utf-8?B?RHU5OEtwaCtjRjBaaXJZVGdFN0RvbTI3NXhHS0h0VUtCZGlJbFFRUFIyNkJI?=
 =?utf-8?B?MkdTYmVoZGlVTXloVjdwQUh2Z1R3K0M3SzY1ZXBQbzhpOG5xOTV3WE54Nk1s?=
 =?utf-8?B?WGc5em82MVpJRW9zb2JJSjVPSlVodS9BWllnR0FlbWw5WmJBNXBOVkZkRFhz?=
 =?utf-8?B?WVQ5am1yNFpYdlAxL2g3UXowMFhEUk5Dd3VKSHpaK0FFL0lldUg0ME5UVFNq?=
 =?utf-8?B?UVp5Q2dnaXdzVUx6Qk1FYWJxY0FsdnJwbGd4VkpVK251R1BqS3AzRHM0VTRW?=
 =?utf-8?B?QjJIN2M4SnRuRDBrem53QldoMjRVVi9qbjZ6aFc3YUdWZE9xdHI1TThCTVc5?=
 =?utf-8?B?cXM1M2pEVWF4ZGtobFNyR3h1eDUwM3BWcHF2RWwvNFVydmsvb29TQWtCSEVh?=
 =?utf-8?B?QkVTbjc0VjlUWjlhYm9abzN4bzZWdzBuRkt5Q3g4V01wdUxzeEc5OW1iVXA0?=
 =?utf-8?B?a2d3QVFlcUV1TU1heS9wbWk1MC9tZjNZY3VZQWZoME1uZVd2d0tBeUN2b3FY?=
 =?utf-8?B?TlNSOGlKM01HVTdLbFQ4elJuZ2xjSGpBT2lYWDF4WGNkM2tZWDhpaVJ1MTI2?=
 =?utf-8?B?RU8xT01mSit6U29iU1NISGpkcUNtd01EVGwzNFJUQS9mTUhlUjlRVVB5bU9l?=
 =?utf-8?B?ZGF2QkNBbklWQkxkWmJjNVhRb3FIVlZuVjM2RGhzQXhQRGNDcUZNWjVzeS9r?=
 =?utf-8?B?ZjVCYndIREQzS29RK01KOUxDMjFHM25rS0pZejZHU3FrV3VQQWZjbXUybEpv?=
 =?utf-8?B?eFc3Uk5aajJrQU5iejVnU1ZobWpsRGxtOTh6SUpEbzd6dVRjeEtlZWlSdG4v?=
 =?utf-8?B?UUx3dFJtbjk0NW1xRUxxRTNDNWdPRm15Zm01UlNnZ3dDZGdJWHU3bjdJU1Ft?=
 =?utf-8?B?Qzh4R2hkdmZaOUpTbTNuMCs2ZGdZUDM2MkxhUW5FcWNLa2dqa29LTVNpZng4?=
 =?utf-8?B?Qyt1TXRoaUhVLzF1V2cyckIzVDdWNjBKMEpYcnNhamlFbytwUDV0U0ExQjBN?=
 =?utf-8?B?TGpCY0JIWU1FTnUydkc2UEp2Ly9zOVJKQTR5SDhFSVpoR2FPNWl2T1VSbDNm?=
 =?utf-8?B?aXh1b0lQc1ZyeE9OTlErNVRFZTh0S0g3NURDS3IwYlFYNWdsNlJzUldSYWxl?=
 =?utf-8?B?cjFoZ21jUTZ5LzFya2psenBJRXpvOUhscmxUajRBNStra29JMUZjWUI2cDRp?=
 =?utf-8?B?dlhJV2JUWDg2TEpmQmlUVVhmMDhlQmFpVExvRlhpcEUyY3BiWEJHQTZuY0w1?=
 =?utf-8?B?bUxIdUhjUURrRkZwdWRzLy9ncVNnQ3hJUXpxOUtQSkR6YU92RWFqc1Q3MVF6?=
 =?utf-8?Q?PozTRhzT2qVQoXNHyt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b074d0f-c5da-4cf4-6996-08df19a47fa2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:57:21.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whiugDY2hRBcaSY9pFOhJ4Yv3B8f/dV+lQ1Zmc+XMDYzoBdYhGHsEm9zOSxYYuExvHQzY8ncT5jbdA+0aEb2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB801076



On 9/23/26 13:39, Fourhundred Thecat wrote:
> On 23/09/2026 20.25, Mario Limonciello wrote:
> 
>>
>> Can you please share your kernel log from this run as well?  It seems
>> that your distro dmesg tool didn't pick it up in the tool run.
>>
>> And can I please see dmesg from a run with amd_iommu=on too.
>>
>>>    🚦 DMI data was not setup
>>
>> What is up with the missing data here?
>>
>> Does your BIOS offer anything to control D3 behavior for the storage?
>>
>> And this other point I mentioned: another useful data point will be
>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
>> backport issue.
> 
>> Can you please share your kernel log from this run as well?
> 
> Attached as dmesg-iommu-off.txt (full log, 1082 lines, amd_iommu=off, 24
> CPUs, the cycle that succeeded). The suspend/resume portion:
> 
>    PM: suspend entry (s2idle)
>    Filesystems sync: 0.010 seconds
>    Freezing user space processes
>    Freezing user space processes completed (elapsed 0.001 seconds)
>    OOM killer disabled.
>    Freezing remaining freezable tasks
>    Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
>    PM: Triggering wakeup from IRQ 9
>    ACPI: PM: Rearming ACPI SCI for wakeup
>    amd_pmc: SMU idlemask s0i3: 0xffff9afd
>    PM: Triggering wakeup from IRQ 9
>    ACPI: PM: Rearming ACPI SCI for wakeup
>    PM: Triggering wakeup from IRQ 9
>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>    ACPI: PM: Rearming ACPI SCI for wakeup
>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>    PM: Triggering wakeup from IRQ 9
>    PM: Triggering wakeup from IRQ 7
>    ACPI: PM: Wakeup after ACPI Notify sync
>    OOM killer enabled.
>    Restarting tasks: Starting
>    Restarting tasks: Done
>    PM: suspend exit
> 
> For reference, IRQ 9 is the ACPI SCI and IRQ 7 is pinctrl_amd, so the
> SCI fires and re-arms several times and the actual wake arrives through
> the AMD GPIO controller.
> 
>> And can I please see dmesg from a run with amd_iommu=on too.
> 
> I cannot produce one. With the IOMMU enabled the machine never resumes,
> so the ring buffer is lost to the forced power cycle. Streaming it out
> does not work either: dmesg -w and sshd are both frozen by the freezer,
> so over ssh the log stops at
> 
>    PM: suspend entry (s2idle)
>    Filesystems sync: 0.011 seconds
> 

I don't need the full run, I'm looking for how it sets up differently.

I am specifically expecting the message from 
51c33f333bbf7bdb6aa2a327e3a3e4bbb2591511 to come up and want to confirm 
that.

> and nothing after that ever leaves the machine. There is no serial port
> on this laptop, and since it hangs rather than panics, pstore captures
> nothing.
> 
> What I can send instead is a full kernel log with the IOMMU enabled
> using /sys/power/pm_test=platform, which runs the whole suspend path
> including LPS0 _DSM entry and returns without entering the idle loop.
> That gives you every device callback and the platform prepare with the
> IOMMU active. I will send it in a follow-up unless you would rather have
> something else.
> 
>> Uh, the hardware does support a wakealarm.  You might have disabled it
> in your kernel.
> 
> I checked, and the relevant options are all enabled:
> 
>    CONFIG_RTC_CLASS=y
>    CONFIG_RTC_DRV_CMOS=y
>    CONFIG_RTC_INTF_SYSFS=y
>    CONFIG_RTC_INTF_DEV=y
>    CONFIG_HPET=y
>    CONFIG_HPET_TIMER=y
>    CONFIG_HPET_EMULATE_RTC=y
> 
> What happens at boot is:
> 
>    hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>    hpet0: 3 comparators, 32-bit 14.318180 MHz counter
>    clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 133484873504 ns
>    rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
>    rtc_cmos PNP0B00:00: RTC can wake from S4
>    rtc_cmos PNP0B00:00: registered as rtc0
> 
> and /proc/driver/rtc reports HPET_emulated: no.
> 
> As far as I can follow it, HPET is registered as a clocksource only and
> legacy replacement is never enabled, so is_hpet_enabled()
> (is_hpet_capable() && hpet_legacy_int_enabled) is false. That makes
> use_acpi_alarm_quirks() return at its "if (!is_hpet_enabled()) return;"
> check, so use_acpi_alarm stays false, and use_hpet_alarm() is false too.
> ACPI does not give PNP0B00 an interrupt resource, so
> is_valid_irq(rtc_irq) fails and cmos_do_probe() takes the else branch
> that does clear_bit(RTC_FEATURE_ALARM, ...), which is why there is no
> wakealarm attribute.

I think you're missing commit e9f850ba66cdf6b77fb4f005e46c4b605c4de434.

> 
>>   🚦 DMI data was not setup
>> What is up with the missing data here?
> 
> CONFIG_DMIID is not set in my config, so /sys/class/dmi/id does not
> exist. DMI itself is scanned normally:
> 
>    DMI: LENOVO 21RXS07D00/21RXS07D00, BIOS R2XET40W (1.20 ) 05/26/2026
> 
> so dmi_check_system() quirks do apply. I will enable CONFIG_DMIID in the
> next build so the tool stops reporting it.
> 
>> Does your BIOS offer anything to control D3 behavior for the storage?
> 
> No. I dumped all 96 attributes exposed by think-lmi and there is nothing
> for storage power management or D3. The only storage related entries are
> HardDiskPasswordControl and BlockSIDAuthentication, both access control
> rather than power.

I don't know for sure if Think LMI will export all BIOS options in the 
BIOS GUI.

> 
>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
> backport issue
> 
> i will try to test 7.3-rc4  as you suggest

OK.

