Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F3381AE3;
	Wed,  7 Oct 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402364; cv=fail; b=PkIxN2flAlZlea/o2z/oaI+4vs6uAiRSPQijcmm9T3CnIQdEwMMlBCwjvdr5NXf9+twjmBGcPjyuzuWWLF5K8i8nc4E0TCG4i2lUMf9wmo72C4poHhWp/nLuOK7mhssTI/WIMFAyulhHD5NBaUqvGRmS7BWkKYG3daUOQXOME4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402364; c=relaxed/simple;
	bh=RdcufiJMSobrj9er5pjnnhFUuoR8ZI9+q3I8gqifpIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uhy/oor5pRNIiSUeOPFoMulGzM7kPHFHEUay++YfvRLlCMkE1AESlUUye0Ugif8g3xT38iGiJFKJJCExaILA4g57qjZqwPYMSv0oj5/no8JzJB40i+ddkSQZIqpHMz+cqUxF+kE/5cOtKeUPEPP2g55641zryLdeUzjymVbjo2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O1MSYxjm; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O1MSYxjm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvfEnzyby+JHgyp0ZY1YF4QHV4NquITwFdN5cINHg8gQW3H15mPZLOQvvjj91XVHdAg8VyNzL+jUS0L/EZnsrbpgEUvWI81kJlA+/xgDkNeKcuzTb9ngoylBp951xvg2CiySWOKqJnuvG/bmNMv2FaMSNcvu4+PmdfP7U1FkNgJWdMgVtqXuRzrMEjP9RiWq78Bcu1T7cv8jDL87vayxvLpa5x6q0h1OXiU2whfd6tBnJ+o+63P7IwdVy6bkQZUKqyDixS/SdYtgx5nMjiXF0kuz1WJ22HXE1fD0Qi4HRbLDckS3DX/qjR+hTdAQaafTXVuKuzFOWgvXWJIyGBZJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUdUURuep7GxgUuv4oR43saYJEiiBRSsaw8FWat9tl8=;
 b=wtbquYAeEsRZOqXW0LWcPrK8fRdj+DbJdPMPSHRFxNljqycTlIFHsNp/xlGCD6FXEODZLeyKTw6F1Dqi4XAMtODsq1rJN3oUQsGVV35DLE8+7tO5c9wpyhbfqjmsTjjDqiQ0sMvwXOdHFTAYcWB8QPTB9Wn9/8G1gizbaiegywp8iFYfyo9Ot8eA1/YmFZhhIzLaCP3J2z2O+/Osft3M5DACUCBNW0kbSpkDYfPJac+9dOcJ1JLqvAJDfak7plDSPJxQ1Qwx/3k8fljQcyPoh2ff6BI93GbSc9+ke5PehhD2JkETcPYL5zaDacygBw+OMTfn3kk46YNfISHaRK197g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUdUURuep7GxgUuv4oR43saYJEiiBRSsaw8FWat9tl8=;
 b=O1MSYxjmd1NTu1LO7gTwc+aY9D7YprHCy2e7v9EEWcc2ftZIJAz0SSBCRO7uqCAMcgV9xfxOIn2y6bxUkxtQjydy99LiHLGjfqAwiqUSHf9vpFjpKsbFcneqqqiRioZZlP1S13CPUyf0thOtmQmV9KiE3xtMRtIJRyni6SSGcu8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 19:45:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:45:53 +0000
Message-ID: <ab7921dd-1a28-4df4-a4a8-718e1489ec33@amd.com>
Date: Wed, 7 Oct 2026 14:45:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <93531c5c-5638-4a20-919a-8471a7222218@suse.cz>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <93531c5c-5638-4a20-919a-8471a7222218@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: caa8e99f-c971-40bb-b345-08df24ab9895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|3023799007|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zhLYcPr2DzuI71MPaKSfF0+pDYlx1Su+uIeK48+Bfhv+duAftq5wiL2c7AJWCk8vrdSVF5arOrHdxLWLauRnq3DC7mvQ0OVVaVP9L7E21aQBTIFr70OwLblq0atKfKNRxlXNcYShbDzPr3HHhKURGQUmLa54JxiPfe332FbTbgAUV+wqdgn2PpGBy4xhBcZpN45ScheTP3dqTLlat480yzkToU4Xey+n+hkJ9EGcArWw8yOos9gtE2OWeK8oRX8vSlcbpEbEntvuE7nkgiWIKBDVvNwbw569lqMZpzHK/RnWCOu82cpXIqhBU+em3XbOxkJWw9RL+0stDmGTvY7I5S6cGhkk9tApw/uq3RmAbb0dJA81RTTSQaNZHmXe+sRtHqIay+96WxUZH6icnBiOJSgMHOmCrxLelJLhamSJduYLh+2Q1T9P4nbid3DfyxDRY4cfsqcMwmYCbuRuspN4J6pkdLdcte6n2asMHTeykZS6AcwoL7tc5pQ+pyHczDz0z8FXSlKbGJ89XVjH7Kvg17VV+gLP0EvY5cyZgzOJlUIcrPL+0guFIst1d5Q1yHsrMuZDmQGYg5laYUmgd+Q346knm0tKpZnwMYu/GFO9PSP307c/aS6FsgBeI6q1S6tsGeHhzamlptvdPDjTZtp4NDUcNflm0+fW3GGlsdJmTGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkY4RkRYNmpheVRxOC9vYmg5ck9ENEgyOTVpR3hiaUJIZ1FhbTZUYmpzV2hR?=
 =?utf-8?B?aFBOMWw2OGx5dTFyekZ2VFdyM1ozUktzNXdWdGJjcXdiMENTdHFlakJyWXpB?=
 =?utf-8?B?Zk5QMkN2OXRSSjdyV0xaZ0pBS2IyQ1ZER2dSL3l5czc5Smxnd3Bpd0hveGE1?=
 =?utf-8?B?WXNOTTk5S2dCUXAzRkQvNFBBTlFZbXVmQlhkOWtNTEVMdHU0d1VmdFJjZ0RM?=
 =?utf-8?B?dU5Sdi9nRXdUbmhzbDVnUlZSU04rbGhIczRISk1FUjZtNmRDbExycXMyYzNi?=
 =?utf-8?B?WC9IYmFhZFdiTHArR0p5MXNpVCsvOWF3Qk5wVkZ0VUtmbmdvUFQ4MVIwd3Q3?=
 =?utf-8?B?TVlxWHo0blF1clpya3JhVXdnQWJERTlvQW53cDhPbHZMc0VEVjNOQjRVTk9j?=
 =?utf-8?B?QmhpVEJSWmNHVTRZZWhVVUQ5R0MvdHZEZW96em9Odjd3dUlpazZvSkJTK0x3?=
 =?utf-8?B?clRtQWFUK2VLYXVVYjB6Z1pJbTZzVXU3UnNWYjRBbDEzSmRXQ2UvMERpaUds?=
 =?utf-8?B?SDJxSGN0WFVBaE92R1RNVXVyUDRsTDcvaTlQYUtqKytvbjM1VW03SDRMdExW?=
 =?utf-8?B?WTBIZzFmYW5Vd3k2ZGg0Q1ZBb0UxMTZaa3pYSnF3VlFvMEl2YUJ2YXNvQ2Rs?=
 =?utf-8?B?Z09PRDdGMHZyRU85OFJtaFVHVW9vSzE1ZDc2OW5ueDRpZFd4Sk95anFsZUdK?=
 =?utf-8?B?dGg4TUtqc3p1ZFh6WW52NTJjdUlOTWZNOG9QNzBXZkwra1dHdlA0V05tcVNJ?=
 =?utf-8?B?SUp3bWM4MmNSWUxWUXg2V3A3QnloNWRWTXJCOXJvNlNxSFB1NkJualNVMjdu?=
 =?utf-8?B?cFZlbkhtSGJBRmVTYUU5YUxiQUl0SG5NME5HL1JJWnpJOTRqbzVZc212eWRt?=
 =?utf-8?B?RTNWeTZ2RlFMSkVYSUFVM0RZTWh0Mk95VGMvYk90VmNHNWtUcFZiRkE2dGdl?=
 =?utf-8?B?aFZZQng4WXozZysyekxxNjJxaWY0TUtLYVVlQzV4a1BGRXdPTmtjWmJoYXZK?=
 =?utf-8?B?VHFseWN3Um5LWjJONk5mQlV3TXhITG1wbXJyUU1mTG9OcHJUSjNDZTdjeHBn?=
 =?utf-8?B?L1RlMEZadUVNNisxUnV5NHpmRjkyWVpRY2hLcDh0WDd0SldScW1HakYvYUor?=
 =?utf-8?B?VkhRbWVuWng0Vy9Wck5ZaDdCSGpST1FuZmFUcFNIdGhld0xYTG1YTlMvRWw3?=
 =?utf-8?B?cWU2bUJTQ1V3TXY0YTk3eVpFWTgzeUhEckxoVVFCYm5NSXFtZTVKVVA4NUFm?=
 =?utf-8?B?RHpYOUlFQ25RUk1zWEZlUG53MSszWGtyM0laUHlqNXY5QzQ3TlNtVEk2Ulli?=
 =?utf-8?B?a2tJRXc2UGpjWVNnUlpQQzVqSlZMbEhFUmlFT1NmK2pyMEwwUDVjQ2NPbTFp?=
 =?utf-8?B?M2FmbnVoMFNwR1hNOGxzdEUybys3MEY2NjJ2ZnZWV0c5SmdKS0xRcXduUGs4?=
 =?utf-8?B?R1NSWkdHdks1b2QzOEdabjJkTzRYd3pnZFpidWJlTmxDb3R3a1VCanFYOTdF?=
 =?utf-8?B?N2IrV1I3bWlURWFlVUhsTmUydUpuRVYzVStwWkJ6d054NGlPM1I4K3VwbmtH?=
 =?utf-8?B?eXU2UC9kZkV1SGVIcnVBYW5XQk81Y3E1RGI3ZXpBUEVJQmJBeVk5OTVlOFdU?=
 =?utf-8?B?akUzQUJlM00wS2NyZk11L3B0RGZmckhsaDAyQ1FGV2hKeitneDJQM2c0VzlH?=
 =?utf-8?B?d0FFUmkzcW9CSWdSd05uWDRYTzhpWkgwMWJidUN0OXh4bUc1THQvZWc2OS84?=
 =?utf-8?B?S09rYnVTMVNXL1JpQ1dVc3VFSVVHT3U0WlBkaktENW50YjZMZ2taUEEyNWxX?=
 =?utf-8?B?ZTVSTVZ6clBMdENoSythdUJ3ckU1RmVMcFY4MFJ4Y2t1ekh5dit5b1M1QVNo?=
 =?utf-8?B?MEJqdUxZYi9QU3VxM0JFQmIzNlJCaWtyR1ZOSDdkSktnNCtMYnpDMlNuTGp0?=
 =?utf-8?B?TlBPMm5NM3BWSndxN1hjK1RwYlRiNXJlc3dxYUM2TDNKTFY5bUp2UGtKdVFX?=
 =?utf-8?B?UERsa0o2OHAyK0VlL1gwYVdFVzc5K2JiUVMydWdjbWNuZ295LzB6RS9LOHZ3?=
 =?utf-8?B?SDVpU2lBdEhhMTRkSC9FMWVQM3QvbW96UTRPR3lKQkY1T1hRZ005U2VhdHZE?=
 =?utf-8?B?SHdWRWVheGNzWmNhbTh2dHpXN2E5NWEvRVNQSUg3RElDVmJ6N09rdHk3Umt5?=
 =?utf-8?B?VTlGU1hLdnVCa0QvYnhGOWNJRGFibEkvTkdQQU1RMlM5UDg5eTZ3cS90a0kx?=
 =?utf-8?B?WUFVK2xOR1pSMldMd0RrZVQ2bzFzN0t2blF5VTFDakpqQXZYdlRwY3FNV0xs?=
 =?utf-8?B?OFNzVldUbDFyeVlQNzBoOEpGMFFkcFBZbGY1QUNwTGJQSjJUeUg5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa8e99f-c971-40bb-b345-08df24ab9895
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:45:52.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzKp3Z+iSAtLPvRcWxyX45Ovkf+sGUj+6n/maH3xDOCzgSDf7T4hZgMMia7c9V9reCz2igBGlDNacn0MQZI8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881



On 10/7/26 14:38, Giovanni Gherdovich wrote:
> Hello Mario,
> 
> [moving Kyle to BCC, I hope it's OK]
> 
> in my last message I forgot to reply to the rest of your questions;
> see below. In any event, next step for me is testing the latest bios,
> as there seems to be an update.
> 
> On Wed Oct 7, 2026 16:56, Mario Limonciello wrote:
>>
>> Can you please add more information about the vendor/model of the MB, 
>> etc?
> 
> right.
> 
> Motherboard is MSI, model is TRX40 PRO WIFI, CPU is AMD Ryzen 
> Threadripper 3960X.
> https://www.msi.com/Motherboard/TRX40-PRO-WIFI
> Practically the same system as Kyle.
> 
>>> amd-pstate requires explicit knowledge of nominal frequency, so it
>>> can't load on this hardware. The driver already has a mechanism (the
>>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>>> tables, so here we use it to match against CPU family, model, core
>>> count, and BIOS version.
>>
>> Yeah; it's intended for this specific case of really old hardware that 
>> the BIOS isn't going to fix it.
>>
>> I don't understand why core count matters though.
> 
> My thinking was:
> 
> 1. I want to make the "quirk" to match as many chips as possible, to
>     make it more useful and worthwhile.
> 2. The doc I have, "Power and Thermal Data Sheet" (publication #56736
>     in the AMD doc library), is for family 0x17, models 0x30-0x3F
>     processors.
> 3. Problem: these have different nominal frequencies, depending on the
>     core count. Specifically:
>     24 cores: 3800 MHz (like the Ryzen 3090x I need)
>     32 cores: 3700 Mhz
>     64 cores: 2900 MHz
> 4. Thus I decided to match for family 0x17, model 0x30-0x3f, 24 cores.
>     Without the core count constraint, I couldn't tell which of the
>     three nominal frequencies above should apply.

If there does need to be a quirk I guess I would actually say there 
should be 3 quirks then. One for each core count version.>
>>> @@ -174,6 +179,22 @@ static int __init 
>>> dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>>       return 0;
>>>   }
>>> +static int __init dmi_matched_trx40_bios_bug(const struct 
>>> dmi_system_id *dmi)
>>> +{
>>> +    /**
>>> +     * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 
>>> socket / TRX40 chipset.
>>> +     */
>>> +    if (boot_cpu_data.x86 == 0x17 &&
>>> +        boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model 
>>> <= 0x3F &&
>>> +        topology_num_cores_per_package() == 24) {
>>
>> Does the number of cores actually matter?  Do you mean to say if you 
>> swap the CPU to another part CPPC works?
> 
> No no. It was either wide matching (models 0x30-0x3f) but constraint
> on #cores, or narrow matching for the exact CPU in my motherboard, 
> (model 0x31).
> Since I'm hard-coding data into the kernel, I figured wide matching
> would make the quirk more applicable to potentially other affected
> systems, hence more useful.
> 
>>> +        quirks = dmi->driver_data;
>>> +        pr_info("Overriding nominal and lowest frequencies for 
>>> %s\n", dmi->ident);
>>
>> The BIOS bug specifically is lack of values, not invalid values, 
>> right? Just want to make sure I'm following this right.
> 
> Correct, BIOS is lacking the values. That info message "Overriding"
> is taken verbatim from the other "quirk" in the source, but strictly
> speaking inaccurate. Values weren't there to begin with.
> 
> All that said, I've asked the openSUSE user to test the newer BIOS,
> we'll see what that gives.
> 
> 
> Thanks,
> Giovanni

Thanks!  Based on the findings from the BIOS update everything in this 
thread should be enough to either make a v2 incorporating feedback 
(mostly making it clearer) or to drop the patch.

