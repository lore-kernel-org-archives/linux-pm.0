Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74C38F926;
	Tue, 11 Aug 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473953; cv=fail; b=NXU8gmATFDVbmo68aRK0yUTfJrwPtwdcZ9OIXVZTLtui76rXA0jUnOHrRAhMaDcEtkUzO1EqR2PW6/oyqCZIM9jX0DqfEgpOsw5wnvzWfREQ96II+oawDWZEWYG05vXjql3LM1sJWzhUqRxacmN/O6x8uq1Sx6sLjn6Fw95+G8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473953; c=relaxed/simple;
	bh=In3Y8PjgH1sHrLn0SxE6acMoHrSWQF0RCVbtnORxjaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fE7gan9AGGBjUExSmEsD4QwgYlxHpj7TG7uUsLEX+Zz2hGk1gaEN/tIrU1qWDw+Nv3ONoP79AWUr659a1A/AP8gn0xvojwWDR7TXYdX8Q6xeTFz1Uh9JtBaSMWj/sdSl2vRmLZbu+TsCubTquxz98Uh1sQg0WXXEU71/VjHx5a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3WPukWfi; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3WPukWfi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJwTWHuQoj/FTU/7WYtZdbZpflutT0Y1v/RwJylle1iokedqQ7Hnf3JAZQs9cNTywwM4QrpreACwgSZGkl7A0mHOTsNfZNKpT8Ko9w7V4o3ISvBxOQO5ogEF0pEVW2wcj4qB2nwsdLFcf6G5CSBYFTRSwmuYGOShNCcRseKyOEeJD69jY/rJi7+8euqM0WWESGEhyejaD7iN1An++1yQ7foJNFptEtEIfqAypUnVrvSYrBKJX8PBUTeOIEl4dYtCDaeOZobNovgT668i3Z2ndCZvMAdah0V/2XbabCfp0RlLFvql3TJ+2AUR3VjSXY43MP+opQREFgpqsCiGn6mpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVeKdOwXuXL+pFaBUzsB5ivGaGIpZg6asOTp5h28GwU=;
 b=yK6z0/eYWFqK0BkFVN3T8A8ok5uK3cs1i0ntWv+9EIS4biwjs1d99S1hgRkC1ngfLpPaIZoLfS0S2sHxN0HDGAPthKNTDV/9NOCWAbynMHtuRQ4vcQgP27hpdoQtRqeY0TAN1U9FK+wpOx3GIz470547+oaPcVpV9gLtAfZGeyZY53W0UFZuAOh/tudsUHvuSe1Ml8048mo0dg8wUQ33rMGWL/XuXSo5YQmqdeQF0jPFF+Wx/7RisMEE6ijA4qy4Z0n1eUmdnsBSSotECW6gB/n0Q4VBmPswhVL7Pedmexny8Oel0x6iks+2lVAyTUOQtdYgAuzIm3z0DySUzCQbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVeKdOwXuXL+pFaBUzsB5ivGaGIpZg6asOTp5h28GwU=;
 b=3WPukWfi345OH/pZ4jRNKB4ARHYx2wtdPJcS95vJz2zy9TBgzdvKaPb/WL22teU5WBCw+G4tmlfTV/IL+QvCEUW3rpQiqnb8UFufjGsUWurFfRjuwArdzvXsdyXzi1wkFPKQRZLmYI5qtkzr37qAD9VbZtianYLg02wbAqYATLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:45:46 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 18:45:45 +0000
Message-ID: <1192083d-62f9-4cfc-bee5-251d9dabe011@amd.com>
Date: Tue, 11 Aug 2026 13:45:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Rhodes <sean@starlabs.systems>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
 <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
 <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
 <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
 <CABtds-1wb1zt4cP9jrUhivRZKEqG6Geq5XtK4j3R4hr-6nMkfw@mail.gmail.com>
 <f4ec6830-6d7e-47a0-8839-f7e50c8bcce9@amd.com>
 <20260810213309.GDanpDlS1IcRhHKyWK@fat_crate.local>
 <95a0c1fc-4556-4f82-b488-90c5377737c0@amd.com>
 <20260811184044.GAantsrA_ApoUksCiu@fat_crate.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260811184044.GAantsrA_ApoUksCiu@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcd2099-a569-40a2-f373-08def7d8c0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ebXZCtdwQN0MJNcJh1uAaNA0Pm4iPxLAx2eSplCRNG6rn5+CrTAUtzPyCY3nDkO8QCnB2sq8A6XROh8cLs3+QYYXwwOcDlp3TmT6PEOtvYzLyu458LbjxDRaZuN4kRKKuLI2bm7pUXb1i3HUTRaP/0Noey/X4sGpANQxXaoa4vAvUSaD8un6kjr2L8rUQuTHhdPDGfVly82uj72GzD5b7dRtG16ZWh0R080DzsxdP02cu+hnQM+CSzoQFvuoYKXsxiNbnhhNYBDGI+XecvyNt9UqZuFL0wxV+Cwqbc65cWzRh76h7guucZJ7MFjiKkiXowvyQMF64cMMU/x+GhhAzj9eoJXP1qnuWGwsnL1538Y4RXm+0x/38OB8xzhcKZ4jgccuHPdUfxP8Drb+KHk77kTk/7GPBadZiqrFyHz6e6YReN712yA5rfgvMjk6uUNa4ZqWJTMfoJTlj1k5NIHR4Hy8ELJFD3R6ID/ANAWDRyOcwaxazOcVMTf0uYi/vtd0Oth+QPU3md6Ip71SsrLCi+NnjOweQQKs2lcJ3S+bA7h8QdMOpWLEn5XxsNUKEQeD8Zur5o0kK3FREsKl+0DJRT/JI7yQwz9n9emORzTK5Md64FdDWduNIrZi7NUnwRbXRNegAH6bUOVTwjKL7EyBQCLPWsC8oLwcK9qXnFn+R0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVgvT01WVnhzR0VNbW1CR3p1QVV1TE53eXNndVk1UExGUGpiTU9lU2FaM21x?=
 =?utf-8?B?WG1rdjltZXg1UVM4cEg5NGhwdHpZelhHa09QKzMxQkJBVytMM0Y3dlJRRTBa?=
 =?utf-8?B?b2VJUkdOOGhGYzZrNS9iTms0TmVRdTM3K0h0Mm5WMmExRXBqc01lU3pHd2ND?=
 =?utf-8?B?RUYrRTVVUHZvN0xqWU52dTFweVVZU01rZndSK3ErVVRaS2xUdFpvM0s4Ukt5?=
 =?utf-8?B?NmhXYUdjcElFaFFQcm9xN1BoVHNwcC95ZEI4aytNMDZ3Mm5kak53VEhKaEEw?=
 =?utf-8?B?M3ZkeFNkTFpDM2VCWVBrZVFtak82WjdqR2JHMVg1WDJOdmhqWFZSczVSUGdB?=
 =?utf-8?B?cngrYWpnMm5hS3dvdHR2TjVpTFpPQlhIelIwd0tDeUx5blhvMWkvTDFMWkhs?=
 =?utf-8?B?T21QK2tHZTlFdlFMNi8zQUljK1Z6S3kyMXVIbWFFTVZDRGxyWDlWVFdCTGlC?=
 =?utf-8?B?UlRNa1MrMkpPN1pCcXZYaGwrK0dLc0hZdzdhODNlWVlseDA3d0VHVTdlbEwy?=
 =?utf-8?B?SVk5eklZd08vcS9Idm8rOEUzTEpuNXcxWGlJSnB3eENaRkhJTHRuUnFZL2lh?=
 =?utf-8?B?cEFUQk83NWNXNXJ0VlFqRk1KUmYvNUVKdlhubkNhT1NzNWNkeWxCdS9pZmox?=
 =?utf-8?B?VkRSbFJSYVdaTGJRRVorcGdBUkNPQVlDem52eCszaGx5TmhUc2k3ZVBYTWNF?=
 =?utf-8?B?SnJmTTdIbENkTlpvREIzQVJmemJMQ20vOUFkYXpkTFVzWXFrVDFkWEF1eDRS?=
 =?utf-8?B?ODYvTmJrZU9jdkFYU25xeVVCTnlJNlVBdUtCL2NxSkcrVTdmMW9CQWJOTGQ1?=
 =?utf-8?B?YWJEMytyZFBSZVRZZ0ViN1NQaS9ueGFrR0pNdGtnOU9SY3JHdGw4M0Vpbjgy?=
 =?utf-8?B?MTgrUVI5QXBpZW81OFAwekdxdE9NSlUzdFJkWmFndGp0UWdaU3MvR2krYk52?=
 =?utf-8?B?SkxydlBxSzJaRldzcm9sdmc2WVlVdVVlbHFPMmpIc0YxSi9nUW51Wk5MUzZD?=
 =?utf-8?B?SkNYZHhXQVhsMi9mdUg2WVJ3TDQ3Y0F4Y3BHTWRFU25nUHNMbi9mejhrSUl1?=
 =?utf-8?B?S3RlQVhQYW5Ici9UUFlLYWxVR0c1amRpZmhHT2lhQW4wQ3VScTk1K1BxS3ps?=
 =?utf-8?B?SkJ0MkF1SUgxUGx5UEVtYU5uR1lFMmxEN01Ibk04YmhiMjVSUGdiQ0hDNENm?=
 =?utf-8?B?M1B3KzJBKzgxN0xuVFBMTkpFQXYrMHlhVVl6YkwxRytLblozREZYbko2eVoy?=
 =?utf-8?B?Z1RKVkJRSmVveUpuaGlPRGsxYjZvY0RZRG9YRWJGR0dCekZtN3ZTQlo2eS84?=
 =?utf-8?B?Z3l3M3pEZkFLVm9jR0pLOUo2NGkvaWtEUCs5WU1GQXdRa0U1aGs1RHBVWTBM?=
 =?utf-8?B?YnlOTThuSzAxQlltTmg4N2N0emU4QlB2Y1RwYzJPSUtWWTBLN1dDa1d1TU0y?=
 =?utf-8?B?cXpzM3lmWkpqb2lTYlhhT3JnQWwxUjdFWU5QY1QyTGRRYmNyUXg3M2xaNGpv?=
 =?utf-8?B?OHl6alRYSVJKRStBSVQ2eTd4YWZxSXBaNzUrTjNFbFl5WFRIcmFWd1kxRmo4?=
 =?utf-8?B?ajFkN1NmRm9kd0RPSVFJcWxWVGl6Yy9pTlUrNi9aM24xVUlxLzVzRk0zZy9m?=
 =?utf-8?B?ZmF3WElXdDBQcUNyNWlaQmRqY1FnTFdpVnZENzN3SDZEQTVyQStFS3BoUEJw?=
 =?utf-8?B?UmRwMFArRlk2eGxiWmVBOUFxb244VnhKYlRNZEFwUkpSUTRCTG1haWVGM0Nu?=
 =?utf-8?B?Y25LY1lzRG5IMjZqNkVpTVhKeFBRQUFlMmdmODRIVFZwd2k1WmVEbmkyalg5?=
 =?utf-8?B?NjgxYTl5eVNPVDFNMTZsTWFaV3V2akRpdU5vOFRLYmhwT3BpNDNzUmtocmVj?=
 =?utf-8?B?RWlBSFpud2I3VU9kMTRLYjZNTHBRYm92VHNPL3ZRZ0l4SHlHdVdaQTFjVmhx?=
 =?utf-8?B?akozUTh4RDZiYUE3Y3h2cjFweWw2c2lTZG9LdEorNVFIOWpjd21zSmVQTDM2?=
 =?utf-8?B?SDBucVJVMncyNjVuSFZsTUVnMTJldmhaTVRuTENZUW0yVmUyc1lwOHQ3WFEx?=
 =?utf-8?B?a1pPL3pxcytCWGIvRkhYdmtwU0cxeXJyY2l0dXZxOHp6UUVxUWdYeTdyK1Y1?=
 =?utf-8?B?ZVVsU2FPUnRoU09FZjVHSUxxRXdYYU5zZ2NxVTdIdm4vZzh2V3A5d0c1NjlK?=
 =?utf-8?B?cXI1SzVmbVpWVXo4OG9zbzIrVGZRcHp5N1JxNFZscGYvNURXOGcrWjY3SDkr?=
 =?utf-8?B?Vmt3RTE2RnRrbUJhUzIvd0oyNllCYlAyRE9Ib2lvYVl1RVVTb2hjdUozTFNQ?=
 =?utf-8?Q?9WQCwGoodmczjAZ5Rq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcd2099-a569-40a2-f373-08def7d8c0d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:45:45.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNpK/DrR+QxEppeQkKZLcCCx+vthUn6PgEVzcwPibREuHsHnvt6Wvfb4j7z9E2VRmApZzfdHv1dZruVFmyYobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554



On 8/11/26 13:40, Borislav Petkov wrote:
> On Tue, Aug 11, 2026 at 01:25:27PM -0500, Mario Limonciello wrote:
>> Well the fact that they could also reproduce it on the CRB with UEFI and the
>> latest firmware tells me it's most likely any system with this SoC and using
>> S3 for suspend is affected.
> 
> So S3 is the problem...
> 
>> I guess the same thing might be doable in coreboot ASL handlers for S3, but
>> I don't know how well that would go over with coreboot folks.
>>
>> They might say "It should be fixed in FSP" or "It's the kernel's problem".
> 
> Definitely not the kernel's problem. The kernel gets to fix all the shit all
> the others broke.
> 

Sean - Can you move your system to s0i3?  If not, I suggest you draft a 
coreboot ASL change for S3 handlers, and see how it looks.

