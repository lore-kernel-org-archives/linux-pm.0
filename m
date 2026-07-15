Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE83BB112;
	Wed, 15 Jul 2026 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148877; cv=fail; b=a1mFB4XYuECgZqfdc7MzBi0DMBnrDRnpkP+0EpeBrId5GNmEXQFxyvVzN6MXW7tUWUgxYwe8PfLKi+jZiUjonazrt83lNMvxGH+ZkAfHqPKt5CGsa+umhLXSTIk9FVGcOHVMPaD1wtLJ22mOSNftzRr77wTgJZprgHehVwKXB3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148877; c=relaxed/simple;
	bh=jCAeUGJafQ4wuNKFnJRP6K4pzAkE+NVYvSgWoWlMHR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeRGXK03hRzmg/Y4OPd91OEDDTTKBev105Rh87Dz2hEvGq3Q75LhH8+3FhiBNxZC+jVa5hTmysF6S4awjj2zvzT7kS8jRmHl66ZAfTrpjJYeAGaoF01DNEA0qJw6fsFJl89PkIbYjTvCjsnlv3dur2vcwp4VTL9UnUFL+e8avV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ss5Ave2W; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ss5Ave2W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbNZbIHiZhurXCL9J+5z0jv9rD5+mqjd6WdhiUcIuAxIVOBQVXO/W6HF8s9Erb3dYTJqI2wa9YDk/pERTQi32moS9Z2zoSgV4/35wGBS2r9dtKT+K9ZY9drZVCecdwCKXjVr56bcnE175Qcv/mVoX4JR82KebZoWBOBa04MKnCZiIiGzNxERjKbTwOfEeGtCOgo50FanyepdcoDZ2HnSZ0riogLhBZeTg5OsIVNf+qNL919KdafeIrjvnErpBzZXxAIXljn781HwuMJhaFeOICsU7qh6X78u9ETnB5wDNg0H/k3XxsEZOXVnY1nBAw7OpsKS3KSwVYXGf1729GeiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHtwmY4d4Izrn5oE6zIdEy0rlUpbkQ6oopddsdBpFc0=;
 b=ZLaIh5+vmN8Ye8eefgkY+dPFVQ3BIbbVqHXOhRWktUiXqtXGGimNTQ+j2sIELBnofyECBciPXjl2Aya7K+1HzXiPR+ClNY/ajjqSv+KpPH3xk4kXkr03F82cqbIwvHr8zz9XmqyTm3GSxjeDooByegnJLpIfoZ+cQHNp1PEOb0n9rcg5rogIOK96KkqbQhRnpfRBaEame7YAzOJmHm3exqviHezkLdcFvws5IiNM0LcCZJmMFlCBy4zv5LwquIlLiROyDU3DfIYJs2EoBNkUOreIpbcRq9ddjetXe8vYwpgCGg/WCgvWZl+Wo+KzFpsfRb4ecpLJ+NBWiRlJQZ7bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHtwmY4d4Izrn5oE6zIdEy0rlUpbkQ6oopddsdBpFc0=;
 b=Ss5Ave2WMCKccirdSIeDrlonb5WizKr47fNcpQc7mIniXKacvMw1OIJHDioySezHjlT4sJjLSbkj3qYxJdJT97fOTlj/ITrevb6RfSPzd4YAQHR665SV2bgc8XHngJOOGB8Wg1HI5nMecrbafMPB9coiYTsr3dGp85wneK/5c/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:54:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:54:32 +0000
Message-ID: <c4ab14b5-7e33-487a-9fbb-ec57ea3955b2@amd.com>
Date: Wed, 15 Jul 2026 15:54:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Content-Language: en-US
To: Jason Andryuk <jason.andryuk@amd.com>, Rong Zhang <i@rong.moe>,
 Borislav Petkov <bp@alien8.de>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
 <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
 <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
 <61a141cd-c72a-4ee5-8273-ee721aa13f68@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <61a141cd-c72a-4ee5-8273-ee721aa13f68@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:408:141::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 08809f7f-9adc-4d7c-f14f-08dee2b34584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QDOxc10EM0GbD2/TD2uc0CFbpzaselwkXwSDG8RDWFzDdEasfjnlfv9OS4vqzq4Kdcnh5l22DliZOeoqSqokfEBgWUmMcj4Canp0kDcz3gqFvkFhX4WGan7feIMraidLgg6Up6kEJtdT4Od4eNFyKwgUYZgPbOPGBhjOsE2v6UgpbURaxz6SB6IPsiVIRiOEmz4hx7OYtaM+C676wLxuowxBwX/Kw8bEsktIojgkWua+40a9IYjtFdTb+ChXwKUQ01YX8prHTDMsM4ld8kgY2i3VtJ7i3vwMzpF3VJrobrxFrg9ew8XgzR1e6DxAIteQmVAHov/K+ZWiqUFiZ/Xj9n0S8ckenp5OPQd/vpPp+Qh6f7mHq/3/IJaXucD/XWx7lNfD966Pos9S0lEnv0MVz9XGvYLQ3P2um2T1xsXVFX7g2RRlNkCD1kwYB/8YBY9/Zkn/o0w0Oq7Mn+ChiIo3mYDOAKQpYck9uGzzEtygmY51MOFx0Ro92YPdmU1uNU/TUNAHcDg49STRSburiDsx4vsfoeBEt2ahpSgvRQRqxGbCpY2dwX0GCqjetMN6lgxsDyMmF5XreHLAJmihz1zglkl+ePONJRZCOKqeaWpSNuxi8U65sN6hsqDY5u0oGJOtKqbdXWns7IVcuquisTzkREDDIFxMVASFTia+pjcpHeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG1pY2c1NTBJZjVOaERHZlE2bTRoSVRSUkdZVnJuWlFZS0FpeTBQUU9oSEFw?=
 =?utf-8?B?MTJJT250NmdJbXAybnFxK2Vhb0xRb2R3WXJhSGgrWldlbTlxL3Z2WDlsRURn?=
 =?utf-8?B?UUd1WmJiTmd5V0lBSU1ENE10QXE2Y2dhMTVjNUdaTzRXNkRxdjlTVkx4VmZw?=
 =?utf-8?B?TGRXQ2xiU1JTdFZOUWVmaTJDeStta2JiUlF4TTJFY3BBbnhubnE1bHg2cWRJ?=
 =?utf-8?B?TTZ4bDMyeWZwcEU1ejRzYUFPV3JRRFpjRXJudHZ3d3ZzVmVHZEQwZTVEbVdj?=
 =?utf-8?B?YXhMQjE3YzF5M0dsbEY1YVVnZGhsbkJFUjY2SjVNWDlrZ3hpSGNzcEhHU0Qw?=
 =?utf-8?B?eVZpS1FiS1VWOWhQaFZLRi9mUE92bE96cXFYVmdMejFtcHc3cXJwUVYyYTFR?=
 =?utf-8?B?WVRuVW5kcUxCQ211U1JPbzlwbytmcUFQNlVoMEhycVdtM0VQUUtIbVg2VVVH?=
 =?utf-8?B?MEt2TDFlYWRvbWxmZit4eHp1UUR5VEJDNk9zMXNXNnNoKzNTTUQyaUtCMWdz?=
 =?utf-8?B?bE5ocTVmVzc3aTNOakxmZDUxOWxaVlJOZ1ZWMWNzUzBNYk5qYkl1ejNXQjF5?=
 =?utf-8?B?SmFlaGZLVEJYL0kxQ3puSU03V2gyMTc3dSt2VkdiNjlvVjdWeTNKN3JJNVUy?=
 =?utf-8?B?YWlCMmdNbzNXSmpGbVNJdTZyVWxlWTJKSGRYMjd6WkJYUDdjL1JVQ2xHL2cw?=
 =?utf-8?B?bVFFTUxqUmRZaDJQbzllcTF6RjQyelBkL3R6bDlLczYycDVLNlAvZDdSVEg1?=
 =?utf-8?B?K3c3MWxWcFpLY0szZEQ0VU9HNXBEN3l1T2hoOVZseXdaRWtwT2lkanJWbVV3?=
 =?utf-8?B?cFhtM0JzcVl1MU5WeDdnc2tQKzFNOCtna2UvRlVhTm1yUklOSHVLREM2SDR4?=
 =?utf-8?B?dWhlYTk3SGh6bFVqcTNWRUM0SHVNcFJDYmFQUStsaVQ3QktRbWtnQnlOZDM1?=
 =?utf-8?B?R3hkamhUc2dHOWlZS3d4VDh2WFhIQlEydE5LSDBSaVB5N1drcWhJQ1pWNEg5?=
 =?utf-8?B?YlhHd240TVVOanY1R2ZPdVFzZjk4VjIzSGUrbmhrUGJvSG9wZUpDVVZKMFp5?=
 =?utf-8?B?NHVaSGJOV2JheStTTkpXWnM3R3drVGZId0ljOVM0Vnh5OE9FaG45a3lLRWxp?=
 =?utf-8?B?VHJQUDdDcFp1dE0wdmNWUW5FUXNiQ3c5T1pZL3RTUllUNDNTbWdRRWJzU1pW?=
 =?utf-8?B?MHhwS0JudTd1OHYyQmRMcHVxRFA1aGlrdWNQUjRJOHAvYmdTYnorY041dDhv?=
 =?utf-8?B?cEdxNzY4MGhxeFBmQzJWSUtXTlN1bTNkUHFhTytibGtZQmpYbUxEU0xvODVE?=
 =?utf-8?B?dERkMC91cGhST21oSytiSW5DTVBSM0xnL3pYTUxiR3gwR3pPYVV3aDBiems2?=
 =?utf-8?B?Zlp3eWlUQkoxYUgxbHFUMGJBU2Nsbjl3MGVZTkI5KzNTYWo2YnY2NEZVUHV1?=
 =?utf-8?B?WVR3SktMK2NrQmk0a1c0bHB1K3Jtd21wdmdFRW1YWHdiY1dRTzJOWklhOUxt?=
 =?utf-8?B?RExua1BKVGRmaHlTZkUyTHc5TitKNkdYdHVYbXF5aDBSTlhuTmlyc2ZaWkl3?=
 =?utf-8?B?RXRZVEVtSG9LVUt1RkZVam94TkpTaFQ5UmhiRy8rOEFKVTlSbWtUczFWYVV5?=
 =?utf-8?B?VjQ2VEdDYUgwa0c1elh4QmVIdC9oVk5JWm1OeTAvWFZ1TUpsM1lUYVloeDJE?=
 =?utf-8?B?YjB5VGZjaXRKK0JOV0hwd3pJdnMrL2src1p1Kzkya1lCM25McWNySEZEL1BJ?=
 =?utf-8?B?TFNIc2oyVnd2RHdLTzlBSHF3TFN3SitJaDc0K1BLcUtaZkErYTJNNElCbnNm?=
 =?utf-8?B?N2xDVnpRMEVlbHlDRTJHQTB1RUZ3UWV0dkJnTmxnYW0wNHdZOVBrWHZkL3Y0?=
 =?utf-8?B?UUcyL1BZaEhBVklWeFpBVzJJMlVYNE1qZU4yaVNQVElOaUtIWE02UVNSeFBQ?=
 =?utf-8?B?c08wTUN6UFZpUjFEcGZhSHRDb3k1RDZ6d3NWbnBKRGtkQks2MVdWbU5ZeGk2?=
 =?utf-8?B?M0tqUEF2b2lYd3hXUDRUeFJ5ZkM0UFhGZlJZQlN2TEJkU2RSYm5BalpzOW03?=
 =?utf-8?B?d1RsOFRJNU42V3FSZUd0MFNDR0Y4MDBnSG8vOU01ZG1Wb0Y3L3ZOWWNhYmVy?=
 =?utf-8?B?NWRzdU5oSWlESTVyYllSRDNSRnpHNElHdjFaTm9yN2UvdFp6ZXBDQWVPOXRG?=
 =?utf-8?B?T0xFbURCVzNiNnlDWHVHcnJ6bEVMNGwvZmVNNExTc1YwQVRkQ2xtczQyayt3?=
 =?utf-8?B?bUpTOFFkUTQxTjhFNEY2Vy9zRDNWeEpielVONzF2VUhDbFpCS1NjYTFwTzVk?=
 =?utf-8?B?UW4yYTJ5Mm9KSldKRkt0cTFOdWFhUHRBNjBYOFR1dlRpWlFpMUs4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08809f7f-9adc-4d7c-f14f-08dee2b34584
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:54:32.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b77fBHy/kt9X7clr1AIR8ISq+OI+t6E+pN1ar3FeOKD1o0qGAdaaVkb6Rdb1/8e3Sr4gKLd48j5RF6VL2mgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494



On 7/15/26 15:32, Jason Andryuk wrote:
> On 2026-07-15 15:21, Rong Zhang wrote:
>> Hi Borislav,
>>
>> Thanks for reviewing the patch.
>>
>> On Wed, 2026-07-15 at 11:04 -0700, Borislav Petkov wrote:
>>> On Wed, Jul 15, 2026 at 12:46:24PM -0500, Mario Limonciello wrote:
>>>> Conceptually this makes sense to me, but I would like some comments 
>>>> from
>>>> others if this is the right way forward.
>>>>
>>>> Jason, Boris,
>>>>
>>>> comments please?
>>>
>>> We don't care if someone "passes-through a relatively new CPUID" - I 
>>> am not
>>> sure what that means -
>>>
>>
>> Sorry, typo here. I meant CPU model.
>>
>> I usually boot a KVM with `qemu-system-x86_64 -accel kvm -cpu host
>> <other_args...>' to test various patches. These messages is a bit
>> disturbing to me as they are KERN_WARNING messages.
>>
>> FYI, my device is Zen 5 based and always triggers both messages.
>>
>> I can also reproduce both messages with `-cpu EPYC-Genoa' and `-cpu
>> EPYC-Turin'. It's just due to how amd_cppc_supported() is implemented.
>>
>>> but we won't patch the upstream kernel just because it
>>> dumped an error message in the guest.
>>
>> Well, the reason why I decided to send this is not only about how noisy
>> it is, but also about the correctness.
>>
>> The first messages says:
>>
>>     The CPPC feature is supported but currently disabled by the BIOS.
>>     Please enable it if your BIOS has the CPPC option.
>>
>> The CPPC feature is neither supported in a KVM nor disabled by the VM's
>> BIOS.
>>
>> IIUC, it's disabled by kvm_cpu_cap_init(CPUID_8000_0008_EBX, ...), so
>> the upstream kernel both disables it as a hypervisor and warns about it
>> as a guest. What a paradox!
>>
>> At least the first message is nonsense in this case and the paradox
>> should really be fixed. If you prefer preserving the second message
>> ("the _CPC object is not present in SBIOS or ACPI disabled") as an
>> informative hint anyway, how about moving the virtualization check into
>> amd_cppc_supported() to only mute the first one? ;-)
> 
> I think changing amd_cppc_supported() to return false for 
> X86_FEATURE_HYPERVISOR makes sense and can remove the message.  The 
> heuristic there doesn't seem relevant when virtualized.
> 
> With Xen, the Xen hypervisor itself controls CPPC.  dom0 
> (xen_initial_domain()) doesn't need the amd-pstate driver.
> 
> Regards,
> Jason

OK, Rong - please send an updated patch.

