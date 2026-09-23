Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3587379C56;
	Wed, 23 Sep 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187942; cv=fail; b=SnjmTIJUEIktVr4TqOaYlhuZvTkIPp5+3AeBUtsdDaIKgcvS4MX8UNZ1fuqZ8EkwxZmWDzzS8gZiURrCD9d5GTI6nuwbRfKOWxfRic+g0eTmhDgvvuj5uPUULDUuoVfIs1Zro9D6TY41Rq0jH43+V6kwuKRATNs/1OCjmHyOoSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187942; c=relaxed/simple;
	bh=PHinw5NlbcaF/NxDt4OAyQn5e1Ygt8fjviQ440sgN9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/an3sa0nkUl6cmV3FqC/EELL0H9GBlHboRjqbUjKLAVdK021pB//13e0KXVTxDgJ3W/uUzG4GM3bQAAI/rwbp1pMJd4kRQjpmOWoioix8qvRZW3hiNexig5Ez5EsFsPfLDApEAvSli5M0XCoJsmnd+yaIWwG/6424cjRFEx8vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G03Ew9JP; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G03Ew9JP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDHfi2fbo0eXzlsp2aWjy3zYMSOVkHSGSvOag0d7/OC1DYsmOp7q+gjU3G6u2J1M4wVoOazxdrJHyB9DopHgUoI8F/VoAig7VzcmfyBbHEFdfkfymEwFzthfLBk7febM1KsesUmqPyrPjOFaBgNx6+Tc8N5OkFvyfYptQJBe3Qre0jXyXHPuahvU975yW+3I82m7aLS3uzHDLuB6hH0pTsZdLYsZ79Ogt3wUSCcby8KXXpXKb0SDwD+vQ6C6zKqT8x94Hzyk2WgOw1z29wC7/8h9FUzli4qEFZdSy5zsEntfjw2/agET7T+O7hMpaR7AtVYhT0fXu/nydZjt8DFYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgGcNveLJXjczROIDyZvtJycnywscQ+iwVroaUrhVDw=;
 b=QYh94OcHkY83HLX5VUX0daWrtSdib9wrzLGP0fNx7puIngBNIJ835mvgEeTbZuruVlLZH+/Ae9ZEudAmVNp6BJ6bjTo+MvHLClm52xk6wPPI4PQq9wSRCUCO5bWJudo+0SKEfKISagUVEUTgDbx7bIm4Xxw79obnis/MwCCJCjGnHJnnHG22RKRmhbSbukET3wUgche/EELmg/8sL11HEwcKlvWkJ6ymkg158fcx9P1+L1Vh+79i4zQiPrC0OAAy1MZGT++NyUAwMvUAW4v3rRjvatN+qL2psUnh/sZK8+R+s9IC9UWlES5aDBaQvjnf5dLvNhkcCUrvjNFuyfS7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgGcNveLJXjczROIDyZvtJycnywscQ+iwVroaUrhVDw=;
 b=G03Ew9JP87tuLlzy81FQMuyDiQzFfHM2Zyo0xdtXwsPHFKynqzBILrr1wyPzhzXSPxW0ry5yR2ucn2bIRMlGIGZbHF/ib7PLEe/EBL2b1hqiOT7KvCBkwbvR7EjCzEHVsuPAnOaMnKzVJU0Bppm73QQ4jf2l6FTpnsidDC7JGHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 18:25:08 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:25:08 +0000
Message-ID: <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
Date: Wed, 23 Sep 2026 13:25:06 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::6) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ee6d0-beca-4fcc-6ead-08df199fff50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fyiL8OaAhn2pXHkoK86tTb6AYeHBI0yKCLDscz4U9Jw7A985cmZDAm5+uicDyOiEzcrU+q2oRbPDYfuV8EH4YnhnOslZF7GrMo6iwWzCDpmej9GTrYvNmledMPY8ApW3qrzGoyIdj/aHa9Cnd0FJHUgj5ybLVYdE65nhWtUxBPUYWOqn1InqaBmPx6qlkQrlGA32RAkKuwAU3KjcmvRce0SmKIs+/x5O2b4qLXGVYmEzm/Smn561P1+CMz9P+HTF0abr3FkrxarTljUsxzCqdt4d6yF0gRcg0lTQUHKCWkK6thhLPOo/sbvaZ12aBxQHf5egRWy9OTpdEbVeWZpFo/TBrk2wHKd3UfLUA+OQIdkbHH0kTVOKJbloTZdTBiwUS88wvbo/LjFQ3zh8DPGxqzvIdM9h5IRwGoAQOa3fz/n/A0LAC/TqPhAOLKBEsrkMos579GNhJQU2Hln+luBQklrtEOrBouaPUPvR5ppEolIAHHTJgWlxvdRXEDJlDYpKccVtmWuwmhx7bB2FLWQpiJzTQe6yYH4kDhuSFPijy8Wd5nlOhrCXrv/U/Nay8Hb3T4Bu7ulL0oDI3NTtpgf6fGUNROxw7/oHv4gaOj3fHazhEbpDM3QlaUmumjOMxbYU7jQkR5aNPqqzG4L5PpaL8JUe1gdSA8fQTQHXPR42K0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUM0T0hsV2Vac2JWUVE4MDdRbnJhQjlVdm1zVnBCK0ZIN2xLMlpMK0VKaTR0?=
 =?utf-8?B?cmZ5RXNDaW0wVkxQTkQydTI0aitpZitWN2MxMzMzK2N2R2NBeHZBS2NwVzFp?=
 =?utf-8?B?Lyt3YUpuK0RFWUJ6UVBtZzA3alVmYkMzVUVSNWpoZE9QdGxGT3IrdWVzM0ww?=
 =?utf-8?B?V0I2N1ZHNzZaTkRRbGxoTG9FUzBNNkNFcUhxRDc4aGJIK0NzTXVYT2dhKzUr?=
 =?utf-8?B?NWp6RVZydEZpWmVnTXBIMnpkajBqQkJycVVzU2N0Ty9LYytWUElTQUFKR0JO?=
 =?utf-8?B?cTZtU1lpd3VhZkpKNjRNUU40VDNERzBHdXQ5MzZWdi82UjFqNmJ4SjlTMjlk?=
 =?utf-8?B?c25rSUJScEprQTQ5UklKVzNTS0VvRzNaN2VNTktrZjNrY0FJZVlQVXBIY2Vr?=
 =?utf-8?B?MmFGVVNDY2pGaUtDVkNPL29NU0tnRm9ISmR0akM1SEFrek5uSGcvTS9HelBl?=
 =?utf-8?B?THMzZDcxR21PWU10czN6VnFkbGVHcEJVWjlLRVZXNWdvenl3WmxaOHU5ejJF?=
 =?utf-8?B?dVNxL0JZNXd2d2xNbk11TFBZSEdQUXpMbnRTMDVDUExDTHdCK0hxOHE0MUpt?=
 =?utf-8?B?RVRYTzRqT0Z2Mzh6MnVWMk5TdHJkUzJib1dVZ0dPcWgwcUxhNnN3OGZqMVZy?=
 =?utf-8?B?b1Z5b3dHTDF1S3RDLytjMkJqMkx6VEdXVTVGSXY3eWZDVFVPVHAzNXBsWjFk?=
 =?utf-8?B?OFNTUEVnVy9wVVhBNkhhdU8rVFVZQ3YzMzNmaUd2L1ZCNHBkUktMa3M5SUF3?=
 =?utf-8?B?KzlDUUZXYnJqUWFiQXBEZHFBVXJ2a2lzV2dMVmwzWmtwOFFubXJKUTdZVWRk?=
 =?utf-8?B?ZWp1Z25GOE1QbEl0YzVieU9qSGZYMnpIaFM3MWZ1TDVqQi9Fd2tieE9ydzBo?=
 =?utf-8?B?R2VLVkdvb2pEWkZhM3JKbk1XVkFrVlRhV3M3UVh0VkNwNHp1clVrM2lURTZS?=
 =?utf-8?B?c21IYUgyVGRIMnJmR1dIbXZ5SWF3dE4zTGIzMzI0MTkycTRNZ0RPeW1rbXNr?=
 =?utf-8?B?L09nMG53dkVsUDFyTUF4Zk5MeGp2TC9VT1lpb09OL3Y1dXRWajNxSnA2VUVv?=
 =?utf-8?B?c2RNS2xTUk92ZmJZcFkxK2NpNTd4RXFydytBUFh2WkZuaVpmeStLd0Z2cGw0?=
 =?utf-8?B?L3ZCTkZTVDlEVEMvSHBhakpqbTA1QncxU083aGZ0RTMycXZLa0ZLanRGV0to?=
 =?utf-8?B?ZjF6LzRxSkhTUUlES2JQeWVxaWxNOXhXZWM1Qy9VR0NBZTdxVXNrL2VHNG1Y?=
 =?utf-8?B?MDRGOFNXcXFMNkhLSUs4eGdFRUh3MUdjd2UzSlFjM0p4d29MemdubzhjRUU2?=
 =?utf-8?B?NFRIZkpMRWVGMFk4eXZ3ZmtmVFBQSDFkQ20zWFRWMFhhVnpFQzhSYXAwVmdC?=
 =?utf-8?B?YkJQZXQyK0J6NGc2cjhDQzRjVGZYZTFkVytzL2xiQzZaWnFWSlZNMTVoa0VI?=
 =?utf-8?B?Rk4xQ2liRGVnVFVUMjE5Rk9Fdnh6UEs0ei94Zlo1UDFLbXJlQmNoNi90bENN?=
 =?utf-8?B?TDNBTHljd0FWNVBFaGJlVzFiQVJSYXpzQ1BEaEtDZHZMVUVVVjN5dlV3bVZj?=
 =?utf-8?B?bGJ6aXJaejVHdDlOb01wTDZoRk1zNjlTdW51clVXMC9nV0M5bVdtaTNrRmhq?=
 =?utf-8?B?bG0xNWxnZEZWUDJnc2Q5ckNJdG9VTk5kT1V5NHhOb0xtelJIVDZWZ0R1WWlt?=
 =?utf-8?B?R05UZ2Noem9VYWdhMCt4L2pCVlVxVVlhS0V1ZG5IY25WczhzVGkyY2JVNHNG?=
 =?utf-8?B?SldQTmxTUDlIMnU0TFNYb3VqQVk3aGFKZHRINmpNZllKS0NCTUp4NUpNM1JU?=
 =?utf-8?B?cUw3MXZQTDFwbXFVRlU3c04wbmRmNW1DYXFxN1RwOGI5MHBLNWhjM2xYRjhJ?=
 =?utf-8?B?ajgyZFdnTUppT0Q3ajFYWFUyeXMydjh4Z0RSOEcvL1FYRjF0eHBRWXpXTlNH?=
 =?utf-8?B?cTZDRUVKblZJQXZqZTd5Y2JIMmJPMFVGbGlUWjJ5VkZLR0VjbTZYcmVvK09P?=
 =?utf-8?B?QmdJeEg4c3A1WkI3WEU5UWFxc3VIRE5oSmJxLytyWCtnZ1Q2YkZWZXFCT0NZ?=
 =?utf-8?B?aDFKNVNvS2J4cTJyZ2R5U3FWbzNZNDAwVnRLVS9FdE5MYWFEemZRb2F5cnRU?=
 =?utf-8?B?RDllOGZHMTVYcm5FK3J6UTlRK0gzb242bWtzZ016ek82N2F1M01xRStJM2My?=
 =?utf-8?B?SDlMSitFWG1oKzNZNExGTHlmbkcrenZWa24wMTZJNTVmYzJyWkt4Q1Y4c09W?=
 =?utf-8?B?TUlSdjBIa2N1MmY2dGgwUjNrYmpUTUM1OCs3UjhoS1JzVkJrTjM5VjdPUWVJ?=
 =?utf-8?B?OW8xeW1UbGtKT0F3NVUzbXZMQ3AxRktXajE2bTZqZDltN3QxUGYvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ee6d0-beca-4fcc-6ead-08df199fff50
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:25:08.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mr5WMTaNXD9hvol7PnPJq1oL1v/bHdE5c8eYyJsjCV3vozB4gudDx8i6nBqfSGcJwOk4vqEY/5OV8hi4nJFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633



On 9/23/26 13:14, Fourhundred Thecat wrote:
> On 2026-09-23 20:11, Mario Limonciello wrote:
>>
>>
>> On 9/23/26 13:02, Fourhundred Thecat wrote:
>>
>> < snip noisy LLM interactions >
>>
>>> I will boot amd_iommu=off next and send the same counters plus a full 
>>> amd-s2idle report from a cycle that actually resumes, so you can see 
>>> whether that configuration reaches hardware sleep or is simply 
>>> failing to get there in a way that happens to stay recoverable.
>>
>> Please attach it when you have it.  Hopefully something stands out to 
>> me what could be wrong with the IOMMU here.
>>
>> Another useful data point will be whether this can reproduce on 7.3- 
>> rc4 with IOMMU enabled to rule out a backport issue.
> 
> 
> amd_iommu=off with all 24 CPUs online does reach hardware sleep. Full 
> amd-s2idle report attached; the relevant parts:
> 
> /sys/kernel/debug/amd_pmc/smu_fw_info after the cycle:
> 
>    Table Version: 3
>    Hint Count: 1
>    Last S0i3 Status: Success
>    Time (in us) to S0i3: 427925
>    Time (in us) in S0i3: 2066740
>    Time (in us) to resume from S0i3: 255153
> 
> /sys/kernel/debug/amd_pmc/s0ix_stats:
> 
>    S0ix Entry Time: 11245218037
>    S0ix Exit Time: 11337753680
>    Residency Time: 1927825
> 
>    /sys/power/suspend_stats/last_hw_sleep:  2066740
>    /sys/power/suspend_stats/total_hw_sleep: 2066740
>    /sys/power/pm_wakeup_irq: 9
> 
> amd-s2idle summary line:
> 
>    Start Time           Duration  Hardware Sleep  Battery Delta  Average 
> Power  Wake Interrupt
>    2026-09-23 20:07:28  0:00:07   28.57%          -0.02%         -10.29W 
>         Disabled interrupt (acpi)

OK looks good.

> 
> The only failure it reports for the cycle is "Userspace wasn't asleep at 
> least 0:00:30", because I woke the machine by hand after 7 seconds. 
> There is no RTC wakealarm on this machine, so every cycle has to be 
> woken manually. Not a real failure.

Uh, the hardware does support a wakealarm.  You might have disabled it 
in your kernel.

> 
> So this settles the question you raised about nr_cpus=16. You were right 
> that it was never a pass: it showed total_hw_sleep=0 and never reached 
> s0i3. amd_iommu=off is different - Last S0i3 Status is Success, 
> residency is real, and the wake arrives on IRQ 9 (the ACPI SCI).
> 
> That leaves the comparison as, all with 24 CPUs online and no other 
> changes:
> 
>    amd_iommu=off    enters s0i3, resumes normally, 2.07s hardware sleep, 
> wake on IRQ 9
>    IOMMU enabled    never wakes, forced power off required
> 
> and from the earlier round, still with the IOMMU enabled and verified 
> applied:
> 
>    intremap=off             no wake
>    iommu=pt                 no wake
>    amd_iommu_intr=legacy    no wake
> 
> Combined with the pm_test results from the previous mail - freezer, 
> devices and platform all pass with the IOMMU enabled - the software 
> suspend path is clean and the failure is confined to entering or exiting 
> hardware s0i3, but only when the IOMMU is enabled and more than 16 CPUs 
> are up.
> 
> attached is the full  amd-s2idle report

Can you please share your kernel log from this run as well?  It seems 
that your distro dmesg tool didn't pick it up in the tool run.

And can I please see dmesg from a run with amd_iommu=on too.

 >  🚦 DMI data was not setup

What is up with the missing data here?

Does your BIOS offer anything to control D3 behavior for the storage?

And this other point I mentioned: another useful data point will be 
whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a 
backport issue.
