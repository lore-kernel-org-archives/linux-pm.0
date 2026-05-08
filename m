Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84498397E75
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245078; cv=fail; b=QtWjuuP3g+7DF2XJbGxv3mAs1bqMCSOpvVCxKIyutHeowYsCW4IPe1lrbZWIABzbTsXifWRAwgI+hfMKdPAWyVWDL9ov3YDNrHu7xkCqm8Vjb4br4J0zV6U56Kn/nFPRzQK6RMMPX/h1BVW6sN5MlBT2JNJbrezsPVms1ON3k9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245078; c=relaxed/simple;
	bh=igGal4kRFlJZCxpV1mjro8bUHq2WQoo9UNk7CrOx6dk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=inK66tA3N44TdemSQeCmhlQnrOSZ+GLFlsnMrLPLZTG2PbY0UH8gPD4+FbWuyV0m7eG2sr/zEMASB94PWDIMdWGe8lBAKMrSDTYp+2Tuo+uv7zFLfmTxvR7j9wqqTI6sIGRqqTHkxZT0+vUS/ld5cUXGOMZUHPhdW+BP1d8yVxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wyG4JQGt; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wyG4JQGt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgCK99ILIs/iD5KbDwBbOJ+69CT+SJ4L/fiT8jum6UTdT3GKa0pWN1W9mkgnGWu8aNBv9/wcMkPS3BU3PbFT0hpaIhgBfFRCNSsNwUGTxVj1cEAXGKaBsRsDi07ES6sBAph/FrgRF0jCaeBUYx2NeFu1aRaEiZL1hp4CQkC5oROyiI7vUUlOV3Sie2onNmOXUWxEDLi0xE0u6psJuY+7pdKRINsL32/P2TDN1WzWOZwbmX5qQFe5E8QhEg1iZbyzWVJ25hl2et7Xjta1pR9HfHTsCS34MhECF04CcxlGEbCIgj76dvBJopjsSGFjFk3mxRN7yyXvlhTyJOSh1IutFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q0WPZjAJZ4AyCJ8JVkx1S0HAUw7kaBGxtl1kEAkAkY=;
 b=XDxb5Gz6AeKWiRtJCJhHVZ0qGHd98tpy62kpypNC0PQErAuGM3e824h3wCUxwiJxai38an8XrmaYnwsSFyCDdm2EklB7pa/KGTIL+CBjexebVdOeNo046s50zQ2yoCdK4VNxWIEewaz8lHXd5FPHVaa5IqLRHoNM9u7A3N0HRRfWs8QFudwZRS5wbLU4/DOiELwPGleixyOUO4w6qPmStasRaxGqwJYvQyhSGX0Gh7e4lm9Bu2rHrqIfVEyz6PudhIlbhh7mDLpXVIvN9bjVJIcAbnl6/CH6oDEFGXRPm1xoxjI3NqIrGZB41SfnyT/5gzpYJRHSD9HXEnLulQT+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q0WPZjAJZ4AyCJ8JVkx1S0HAUw7kaBGxtl1kEAkAkY=;
 b=wyG4JQGt+A10hKnb6X8sa/MhGx1v5c0vKGyXaUttQuiOxR8/LjWTdUIQdmkfy0yaF3hAT6Rdj1MaDRSB4A8IkDld9Nq8oB2q1xaI84ladkuPRKwBDM8w2oOEVyWSo651RyT6DWgkHEFVfNAo4tyyt4Oyv+5IBYdPVAKawfnW1T4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 12:57:50 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 12:57:49 +0000
Message-ID: <8c39f42a-f024-4f05-8d77-a95e7ca1c702@amd.com>
Date: Fri, 8 May 2026 07:57:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
 <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:806:127::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: a09632ac-6df2-4395-cb3c-08dead016842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CbDf87/bDLkxixd/eNi7/Yb6jtT/aitUEO3KS2Vhqg/fTEQFCvpbSG7Pmui04mBqQxpHG03mF0YHhAbDK0MpDfAxSFyO0PhVNzmOJVvbGE/ePfyM3A5dG/2fXQnmcAR0GhL12H+YJB/5EJtGWq9OePssvXx9+tkTFcs637H9DxtT/6wTW/zSGZRzyvqc3v+1oa6hB155J3uiKZeVJpNU5R9JaIAT3T/Rx+nKJyCqdnHeFgvf3OoUoCDeBIC63DAeoRTsYqOrIc4LWwc/R9RDr8ueoeMhu1k3BJbSqo17anaW8a8d7Qfc1y3ep91UD1seKfGD9z3yrC6wPZ0SvjUY/S07gF5Dwj36zWwwbwQq2edIAeUxb9eQV2Bokq4ofR3dR7E6JUHVn8Tr0AAIoHHkYWgZrHTNeE4BNAF7+2ojSGuly36eiSkcGu1DYwb+oHE6jijfMOa6hbJkmds0PuUbmUJIY2vnU96z+oqborWJrCEYi1DQBNszA4O+4qySSXaFjxdUmOcyrcA8wMUPkZKb9RfQlt8w2eNPSwjJEOktpah5A/YpBfgxAwh2WRJKWZQ91aGnZQMv7rq82t4DUzwx2qXp/fg0P9b7hAByMnGR3VANOGPAiKAWlVKpJfHsuB4LFq9fD4L60kwH2GjGqgJBmWVprqt22SU3WTqxdwtS2TC3Wa9H0xaD4HkoL6L5g91Dzyq7t2jwSjlTiJbp/owiFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2xScjBaWkdmaEZLaDRTTTliQ0dHejE2RGExUzd3RzhJdUYvd3NjWFRPWm9S?=
 =?utf-8?B?V0lFdTRkS3RyNWR6dW1SZTd2clQ1ckd5eTQ0M3pCbTN5Mnc5a0NtZFlJOUN5?=
 =?utf-8?B?d2JJMmFNcU12Y2o1aG1RaDRwS3BxVEsxRUNDWjE3MkdmeEVTVVErTUdRWUF6?=
 =?utf-8?B?bnE5M2lxd0dZWElQSHpETERVVG1DWmlia1dHZE9DdnVNaFF4dkxkWmE2alJE?=
 =?utf-8?B?QTEzS1I4UThJdjdqTGtZSTNydmpVVWNkbkpUc2JVYTd1ZWRNU1crN2lKeVJQ?=
 =?utf-8?B?bGx0VkVoelA3LytzZSsyZURPRmtra21reTBzTUl3SzNudEtHQURWaVF2bDZ6?=
 =?utf-8?B?bTJQdXJqaGJMaUVKUERMY3owakM2MkpFa2NyOFpFSEMrVlJscXp5bzhyeXJ2?=
 =?utf-8?B?TTByR1FLSjRQUzdiOFhZQ1JYUEpNbWwzN3kwcHU2a2ZsaldxdHVTaTJDbmZX?=
 =?utf-8?B?d1BWSVMwakN2N1BaVVFQTU9xV3ZwUC9xOU5MV0NVa3dZMk9ieUlKRklpRTRm?=
 =?utf-8?B?bmVvRmJaemtCakN4OTMyZ1V4cm1tdGlZTWYwU2JZazJrdzV3YkxMVnJKbFF0?=
 =?utf-8?B?N2IzQm1Ld0hJTERmZ3FnMkpqZkpzWnhhSFZCMXl5REJLRFJOM1UyK3VsTzRs?=
 =?utf-8?B?amltLzM3VUlMOW1vcHhRM3ZVZVlIUGF5dW4rbGhkOUdCbTB2ejRjSnVRelJW?=
 =?utf-8?B?WXZ4dUVVa1JqM1FYRzE0c0g2UnF6Zjljbi9rbEVEVnFrUTNoaEhjem52R0t2?=
 =?utf-8?B?UWxuRXhUbnYvdEh1M0MvUGdibHpLMVNEdDBTSFJoYlRjRko1ZnQxeVI0U0hG?=
 =?utf-8?B?Z3dXYUMwTUNzVXRpRjJsdW9jQnc4OWJETUxDcWhiSnpzdTh0K2RxbWNPL2Nn?=
 =?utf-8?B?dkhsdUJTd1B4MjRMRkRRSDlVRVMyMHQ3ZGdEd3dhME1sbGZiV0c1VlR0WlNm?=
 =?utf-8?B?eGRqVnRobVhqbkhRVnYwTllkdGxLaUhveUhucjZrS2lkd1ZjdG8wUGxxeWw1?=
 =?utf-8?B?aW1hZW5sbjdYMkVmK2FxcXgrc0FPTUxqcU5RQmFxeTJFRGVGVEQ5czcyVWl5?=
 =?utf-8?B?dFF4S3NoRTNLRU9FY0toc2lGc3BobFlORnNEYkJYbzc4TFRkTlNHVmwyZmdS?=
 =?utf-8?B?Y2tRRjh3YWlTWFdWNGJTQ1plaXZpbW5pcmdWR0Y0TVFuOS8zMUNJMVh6T3Ay?=
 =?utf-8?B?N05hc3psYmxZcmdmaHpzRUZacTFNaVlpQkRrWkNxYWZCKzNESldZejdIWHRK?=
 =?utf-8?B?UmtXNU5vV1pRVmI4S2dydklpazc0TjY1TSthdllTMmpCZ2gzRDFza3d1Q29H?=
 =?utf-8?B?YTgxWnR1KzlqdEtLWEY5czBjYXNmd2RjQnFHQU1nQ3JqdHVsZ0VPamsybHlY?=
 =?utf-8?B?bjQvQmxkSXFOcVArSXhsbXIzOGpGOGRZOUxxUTljSEcrTnZSamZWeDJBTjhY?=
 =?utf-8?B?MjFaeCs2SzNxMHlnTHlHUVAwc1pYVDVscW5ZbkpEcFVxVGx6K0tuYjhRNSt2?=
 =?utf-8?B?RGE3UVRMWXlnVGowUlhBblFRYTBRTEM1MjFjWUl0WDBuTnc0aWNldlZJaEo5?=
 =?utf-8?B?bkVrZ2c0ZXIxeFEzemxyVTZ2VkZrV3ZSbVl5OTdOMGYwYS9rRytkS25VWlJZ?=
 =?utf-8?B?V0VqTVdqenVVWnZ0eFRlM1FhbkluY2JDa3ZhOE5BTHluS3ExN1ZVRmRLVzdI?=
 =?utf-8?B?SklBQ0VxSTU2Tzg2a3RXVDNGYlZYY1BIcndvcWdoZk5QTm5Uclg5YVNRNk5l?=
 =?utf-8?B?NE81ZUE3VXZSZzREY3RtQ2hGWk9GSlhtZ1NNTDdjTWw4UjZ2OHkyeU5lOWYw?=
 =?utf-8?B?NDBHV3N2Y1BDNEp1MFNaS0JwU29Ed3JPRDY1TjRwc0pwNFlGQWoxZG9VUktz?=
 =?utf-8?B?R1dRMGhTUmRXemt5YkJYVFFwdGxOS3hkeHJlbS9rcXh1ck5ZM1Uwdzd5SkFT?=
 =?utf-8?B?bk85SGVWZmZ0dmpzaHlwWHUwOTQxM3YrWjE4YitjRXFHd1FVeHUrY1lGQzhx?=
 =?utf-8?B?Y3FMUHdteDJyRnNkZzZCMk9kYVV2MlVDQjFuV0FHdjFISmQ1cGlETm9md1Bq?=
 =?utf-8?B?SDZpa2RwQms4SURHVmxKZFJybUY1dXJndk5WWFZNbHpaUDduS1N3cUdVZDhl?=
 =?utf-8?B?R0tsb1FXdEZxU3J3UWlGYmR2VlpnVllRZytCZFkwYnplQmV5ZHJXMEswTWMw?=
 =?utf-8?B?OHVma0cxbzJCSkhHWlcyc0VaUkhaUWgrS1UrQzRsS3Y0OXV6bW9HRTNNWFlh?=
 =?utf-8?B?MjRIVEZ5S2VVQmVKQk1WTXFzWUtLVGpmMTFBWG56TlROdXUxSXZud3NXRUhz?=
 =?utf-8?B?a0pQa0RDOVcrUUtOK2Rvd2NlRHl1S1E2Um9ZNi9TNmpXQXNtR1pkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09632ac-6df2-4395-cb3c-08dead016842
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:57:49.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0bkB21oafyCZDViupd8iVAqyXP1P+QNs2OtVsbeq5YgAMIRrJWIG6ln33NbjGoV+IAgWZgIyTdkLoUNRnjhfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

On 5/8/26 04:31, Thorsten Leemhuis wrote:
> Lo! Mario, what happened to this? This lookes stalled.

I got caught up with other things and forgot about it.

> 
> Side notes:
> 
> * another report about an issue like this was filed here and contains a
> patch from Mario for testing:
> https://bugzilla.kernel.org/show_bug.cgi?id=221473

Yes please see if that helps.

> 
> * there is a whole patch series with fixes for the culprit:
> https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/
> 

I don't think any of these will help; but that would a fine surprise if so.

> Ciao, Thorsten
> 
> On 4/29/26 20:34, Viktor Jägersküpper wrote:
>> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>>
>>>
>>> On 4/29/26 11:20, Viktor Jägersküpper wrote:
>>>> Am 29.04.26 um 17:54 schrieb Mario Limonciello:
>>>>>
>>>>>
>>>>> On 4/29/26 10:38, Viktor Jägersküpper wrote:
>>>>>> Am 29.04.26 um 16:25 schrieb Mario Limonciello:
>>>>>>>
>>>>>>>
>>>>>>> On 4/29/26 08:54, Viktor Jägersküpper wrote:
>>>>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>>
>>>>>>>> Am 29.04.26 um 15:04 schrieb Mario Limonciello:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/29/26 07:34, Viktor Jägersküpper wrote:
>>>>>>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> when I boot my desktop system running with an AMD Ryzen 9 5900X using
>>>>>>>>>> the kernel 7.1-rc1, all CPU cores seem to run at ~1.7 GHz constantly,
>>>>>>>>>> i.e. I don't observe any core frequency boosting under load. This never
>>>>>>>>>> happened with older kernel releases, e.g. with 7.0-rc7. I ran
>>>>>>>>>> 'git bisect' and found this first bad commit:
>>>>>>>>>>
>>>>>>>>>> e30ca6dd5345c5b8ba05f346a8e81105352fe571 cpufreq/amd-pstate: Add dynamic energy performance preference
>>>>>>>>>
>>>>>>>>> If you compile with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=n (instead of using kernel command line to turn it off) does the issue go away?
>>>>>>>>>
>>>>>>>>
>>>>>>>> No, and still nothing about amd-pstate in dmesg.
>>>>>>>
>>>>>>> Can you turn on dynamic debugging for amd-pstate.c?  Something like this:
>>>>>>>
>>>>>>> dyndbg='file drivers/cpufreq/amd-pstate.c +p'
>>>>>>>
>>>>>>
>>>>>> Both kernel builds (with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y/n) have the following config:
>>>>>> CONFIG_DYNAMIC_DEBUG=y
>>>>>> CONFIG_DYNAMIC_DEBUG_CORE=y
>>>>>>
>>>>>> Booting with the above dyndbg parameter gives me only this line about amd-pstate in dmesg:
>>>>>> [    0.844066] amd_pstate: AMD CPPC shared memory based functionality is supported
>>>>>>
>>>>>> Do I have to do anything else besides booting with the dyndbg parameter? I have tried
>>>>>> both builds.
>>>>>
>>>>> You shouldn't have to.  I think there might be something silently failing in the init path now.  Maybe platform profile registration is failing for your system?  I haven't reproduced this on my side on any of my systems unfortunately.
>>>>>
>>>>> Do you think you can sprinkle printk()'s around the init to figure it out?  If you need me to write a patch that does this I can try to whip one up.
>>>>>
>>>>
>>>> Please write a patch, I am just a user trying to help.
>>>
>>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
>>
>> These are the dmesg lines concerning amd-pstate:
>> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
>> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
>> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
>> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
>> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
>> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
>> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
>> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
>> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
>> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
>> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
>> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
>> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
>> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
>> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
>> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
>> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
>> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
>> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
>> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
>> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
>> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
>> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
>> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
>> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
>> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
>> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
>> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
>> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
>> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
>> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
>> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
>> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
>> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
>> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
>> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
>> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
>> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
>> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
>> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
>> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
>> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
>> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
>> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
>> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
>> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
>> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
>> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
>> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
>>
>>
> 

