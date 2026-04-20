Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935639A7EC;
	Mon, 20 Apr 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690805; cv=fail; b=gClcPFRojG/S266Blv6Qosp9UubeYQH/sQk2Xa8A/H1bgWHFbohptWfrec00W0fH34tBc6deUmQQ7KOEoZreR2j2sI5GKc+2/DltzdPOMdXY6HwXZnyraft+Tswulgh+SoB7gNqIxEUjmoJiuz1FGLH5vlQzM/Je8lltPHXjcDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690805; c=relaxed/simple;
	bh=UruMHiDpVKWaJgqwmpAAQEc/isjxNugpaqjd58a53sU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dwnnJ6eGl5s49sEavYoqin3ajrklowUYozZUbCFkHMQWCGtaW62qAfEuigKYMDYJqUepSOTl1T3KQgdOrnOy39o7U8OIUKpK/6KTkb/1kiMgxFfw93GnvEZ23HBa0lgH7lmUH0x3wXOma0hSF+LercGhDirV6dOoZVokGNMWrAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f17wxcHN; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f17wxcHN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpcdSo1fxshdrhq9kcHy32E+KvkU2toRawTfsoUZ0LcbV0oACC9cnfbaldj7R7SKE6gMyauxqQklChyBKTctbvp86U09Z5MVGmpyqqwuKJzY+3XomUOE4vbUKQsw3W/J1/L8q2+qS6DifGwBxumVEq72VkPapNjHjRnWw2RHjcRwDQpq+efbEumoIF3DWruIEQboXwMNAm+7zj2CLakzLhk/mvgZxaln7eH+bmQn61Nt1Oy922OErRCF0g/vg7szmK7VgLX0J4YXM4qcx6l6vSXFw4rg8vmIpergT24QVvFN4BX1P7yeh0ObfUV+5XUFGkT/Vm9Tp5agAUcR+cc2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UruMHiDpVKWaJgqwmpAAQEc/isjxNugpaqjd58a53sU=;
 b=He53D9JP5IVePnAgfNYw+5zi4BtcQA+hpY3UPerevUWRwsQo68hB0mwjJfrT5GE7x8tXd53DwlESyme7Wc3/6Imt05Z9g/4GQqWSXK/U4ZWO7WA68H3j2mrZT5lnoRDspmwVcSjvocdf70eDLzzfVbcskBPnhVbIj2YNP+EvoPTdt9AzlVZXKLBF29js69oJj7wHrJ4tszWZkZZkUx6wJ5q9lV4bV4I9xhOuc2sHkp9yhvRIg6d2XaYIp+iDvLVQ1G7G2blHjnNV2gcG6ldI23hRVlnWfbymeeSFrkeLcFy0ZK1j6BEbPAiiI7RWqSZ2D7OfSFS6HREacj6IR7ZrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UruMHiDpVKWaJgqwmpAAQEc/isjxNugpaqjd58a53sU=;
 b=f17wxcHNUDEjKpFpMMekioBzhZ92Yn3J0elEymf8uvS+S9qD65zb7J5NxuxAKagZYTxi0WiYSJQwUqITE5lTFgPUwFwf93bZlEbEgkqXqLguK3XJKulmCmsAg+z5EXMCBSnr9o4EjckehYI+JW24v1zkOdz8zHt/QVtRgm8P/Qrjvl7QinaIBJCunPefl7pqiPTd2MoFpthpOwgUUNQwzxIlAbeJ7h5Lo7qmum/v1a6wkJFTkNiG/WXfYiHPEGhjqFTxjS+ba8SInjR764+9LI/AqEGtm1INq6GmQMzs43CbFRlhNQAF9kOpBBIfREU92xsk4I49lN3gjGDayAjXYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:13:20 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 13:13:20 +0000
Message-ID: <2b3d59b4-dc9e-4ef5-8cd1-9095cf5aa0a7@nvidia.com>
Date: Mon, 20 Apr 2026 18:43:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, zhenglifeng1@huawei.com, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ionela.voinescu@arm.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, zhanjie9@hisilicon.com,
 corbet@lwn.net, mochs@nvidia.com, skhan@linuxfoundation.org,
 bbasu@nvidia.com, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 mario.limonciello@amd.com, rafael@kernel.org, sumitg@nvidia.com
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
 <208360b1-36a5-419d-80f4-431914407f61@arm.com>
 <zfoorh6tza4taswyr5zhxqn4rhcqzq4rtvz46eigoy25muxfls@tlbuypuwocvm>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <zfoorh6tza4taswyr5zhxqn4rhcqzq4rtvz46eigoy25muxfls@tlbuypuwocvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::19) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f8eac9-dd7d-47c9-144c-08de9ede976f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UXZxEICYNX5Cw24W7Y0pmvfc/okPqcTycj+i3M/tiX9mcISg5Xlqp3GxWaxHIeGOtt6aTzbU4s21uCVR5oXg6OIloS7zWtt5C5ziZD5cydPujsWBtbcPyFKWHxhIaFSFaCbownH7TEHsAw7AWOMviOet1PeL3fZpyT0svId6YwLkuDMLsWlX9TgvrZP/xhjLkcG6+vq1Vpb2a44raGcAqz2FF/eQtu2AaXLJwql/NL0qQw5NpAlFzaPNVzFDqLXPV36g64/23HQixGX0NIYb2DayPuo7SfRAFTD/spzOnpxX/AyDadaj02pXXSNq70VMUF2jn0A+nR5wHqbKTHotqMz0nhoNP54rFAZC9JdGYP5EAQTQ4gwtPJWYU93AryyWVWJlxx7NxobUIDTohQv/os1t6loWXroNNhBlcTKCFHiw7mYHarvUSBNMQ6aPECG592rldxgGDLWyP54LtsBgosGmzxgNj/KcQRqA1nSgcUqvPp3M1Lhu2Ubzfo78mbD3Jipb7TQAjHXIUsAfY3P+5F5A64dyYWDuNg3nTDlj6hzsGeS41PmEGUrLKe4hbj2uEItZ4yyE29hEKo9oXAz1g0iDOt3qse0cnYim5LRfk3AGd+luz+X+fesUl1SzKzj+L3qAQa77eWuh3Vf9REwQzen9KugHHQR1FqXZffUwLIyF7drYnuYVAs09VvVU1xsfDEuiZiEeAAVODVrQ7SLfC6tZ7X9DqzOZnm4V7XQoHxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRIaDQ2M2I2aVYrY2lxYWpYNDhwTUZFWU1OMTE1VktYNmpRU0kwemErOGhj?=
 =?utf-8?B?UW5xZWhpUVJBTUhHQ2xzc296cE5hdGRRbllZZWNya0NOalNpMGpLblZ1USsr?=
 =?utf-8?B?aDFZWHFWcTZLaWpyNTJERmRUOC9BcDd4eWxYck9TYkM0RmFMb0I3ZVdsMkg3?=
 =?utf-8?B?cHJzWG8yd09CSlc1ZXJpa1BtcnBjN1hZL2NLYVduNXFMKzlvNExqUnhkUnU0?=
 =?utf-8?B?QktSald4SGE5VDV0SElmQzhjMm4xa05xeHRBR1R6UVdDeCtwLzMyelRvMzZu?=
 =?utf-8?B?OEpXL05kTEFZdk1Bc0xEb0FpbnlvUnQrNEpmRW1qbDNrL2hkWk9JOGNjMHZP?=
 =?utf-8?B?RDB2TEpsbXVCR0VMMVE2ckQ3TWFFYlBxYVRBb2d4REJPM2FvSDJaY1JJa0VM?=
 =?utf-8?B?VGhlVU55RStwMEYxVzBLajE1cElCbXg4T2tFalpndWtnMWw0VUgyZHNGNDEx?=
 =?utf-8?B?a0dHK1VjU0JEWExhcUlDL2E3eDJxME1PL3hqOWI3RkxrZTkwdVhHdFY0aHBP?=
 =?utf-8?B?U1R6WmhLcUx6dzZYV09UVlE1eDQwUGhNVDB0d0JUVDBNTmY4MjdwR3RYdlZu?=
 =?utf-8?B?MmRhRUp6UVR4VW91Nm84TWhCVVF1K3NlZWtyK0pYcUdVTzdvUmExL01ha1I2?=
 =?utf-8?B?SUgxT0pxbHRiVm9uZzBMYUc4ZURLSjhxRkkwWUQzL2JVTkVtMWcxV0VVbEcy?=
 =?utf-8?B?VHpFdlNCZCtUVjlDRFZvUVczMCs5MnViQm1OTm9PWm9mUXdvMkw5V0lSdjQr?=
 =?utf-8?B?Q1BBamdhVzd5SDlDRjlEb05vUi9JanVoS0l1VmlTNmJiZDFGSHRjOW03aGFE?=
 =?utf-8?B?MnFXYk16eDQwMmtCZTlCUlZsd1AvSjhkaVhxTG5ZeCtHWmNGcG95VVJtUmRS?=
 =?utf-8?B?NjJYL2VXM2o3SVVvZzJsMmI2Q3M5ODBVK3VnMk0xbWJLempQM21KOFJsRU5m?=
 =?utf-8?B?d0s4aDY2WW1PU0FRaFN2M1hDUEN4em1uQ2JjbHFadHptb1I3WnFTcFVRMC9p?=
 =?utf-8?B?clJoaFUwTldlMlpTWWlwbHpOYjVSWGJSa3F5RzBtcGtqUEtCUHBZMkpVV2xj?=
 =?utf-8?B?VWhUUWo5WXo3WTQxUDJPY25LV1d3NFRTYkExWjMzdkt2N3pxSXYwNFh3azBm?=
 =?utf-8?B?cHNPNUZ4MmNzcFIvZXovUVBzZG85Q3hrS2h0MGR0bmFKWHJrUFI5cFRGRk9j?=
 =?utf-8?B?UXZud1JRalN0VU1HbnNQbll5T25GK21XZWIyV1VxcitlTEZhL05WV1BNb3A2?=
 =?utf-8?B?TjAvQmV2TkxST0JpY0JoV01HbEo0dGtza1FFSXI0OXVFeVdMWFZxMzE0TXEz?=
 =?utf-8?B?YVYwWGdNYytIdmZhZ2x6U0xwNkJBaDZ3Zk5Rb3JzSEU4bmRpRnpQK0k1bEdV?=
 =?utf-8?B?SGJ0c1NjYkFRZUhtSWlrd2IvSkxORS82eW9PU2hPaWNCZnVHbk8xQWQrUStl?=
 =?utf-8?B?S1QvYnZjZTNWa2ZXTkhINWRsTlI0a05BTnc2azFwOUU0S20yRzJwQ0pjL2Nq?=
 =?utf-8?B?cjkxaTAyVFFLQm5Fd0NNZjV2UUs0a3JNTzR0cHFuUzE1eFk1c2ZZWWxYVlFi?=
 =?utf-8?B?M25ZSFFHTHRRZ29oeCtUK0w4d09DR3hVZzJOalBpWm55OENaTXZTSk80dm9G?=
 =?utf-8?B?blNTdDJZNmtVQzVWRmhBcHJGT1JLMHA0UVUrTERFdGRjNzBxbUk0cTczVmVx?=
 =?utf-8?B?ZjBwRlNhTzYra3ZHWC8rU2xQVEd6RnU4T1VjNEdrbDRmTjhjM0NPZDN5T0VE?=
 =?utf-8?B?ZXhYQU53dnRwcThaazNrZlF2K1pkeWNwM1lyeGUwMFFWY2JoT1F1dXVycDFX?=
 =?utf-8?B?SnBZWS9oRk5LRUs2dnVzQUg0UDNuRWUzNjk5SjV1UklxMGo4VTdzUWR2N0Rq?=
 =?utf-8?B?WEx2MkQrRjdaL0hwSDExWEdjZ0ZjQS9aQlc0blFBWXQzVTI4ODhrUmJKajh3?=
 =?utf-8?B?djFUZU5ROTZ6MkJEdkN3QWpDNUl0QVVHNmxtaXZOVUNSdFBWU1BEUnp2Nitn?=
 =?utf-8?B?TUpYQmNoc2t4SXdLaWQrejRUWlZ6ZzFEN3NjdXE0N0ZBVkJ3NWQ2RnloY2FR?=
 =?utf-8?B?VTRieHBFWll6aEg1YUhHMUoyVjRxeGRmdGQ3MkdoZUY0WTdjajRvOFFEc2FF?=
 =?utf-8?B?S2VSQ2N1VUxHaG0xY3hrc1ZZVmRDYVVQYzg4bEMyT1VDT3hlYXZpTWw3STlD?=
 =?utf-8?B?K3BFTkVlK1hUSzF1VmM3NFRnUStaVlh4bXdrSng4bjI3dkdkdkZRRFEwWTJW?=
 =?utf-8?B?eE5mTVVKOXlpOHhOMjRNNGJUbmJscHEvVjlsTkNkekl3SVdROGpJQ0ZUSmRU?=
 =?utf-8?Q?tIuvTqw1qFOEpkkTfq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f8eac9-dd7d-47c9-144c-08de9ede976f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:20.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkBrD0d92bgRcQoB8SsSHjx0YrSWAOvnuIzhQgU/67FPDLRi/ldVLat/0SmdttXmL5yt30TML/NI+yWNeL8cVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082


On 13/04/26 11:21, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
>
>
> On 10-04-26, 15:47, Pierre Gondois wrote:
>> I need to ping Viresh to check if this is still relevant.
> I think its okay to clear the min/max state in the kernel once and for all if
> you think it is not done nicely. As discussed earlier, try that in a fresh
> series which only does that part.
>
> --
> viresh

Thanks Pierre and Viresh.

In autonomous mode, the min/max_perf HW registers directly control the
frequency range the hardware operates in, so the values programmed in
.init() need to survive through the governor.
I verified this on a platform where lowest_nonlinear_perf != lowest_perf,
the min_perf register ends up at lowest_perf instead of the intended
lowest_nonlinear_perf.
Pierre's QoS seeding patch would fix this.
Happy to test once it's sent.


Thank you,
Sumit Gupta


