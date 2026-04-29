Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1640F8F9
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482893; cv=fail; b=d+lfOeyktNXcCGVmb9jtS7x41ONd3BUvVizMQtbH2bIEtdbXHmip5uSc2tbXFsoit5JE/7XylmUXt2Jv111qJ/dIePVl2ext0VsMKYfcDUOxq6xMtaU/qGDX2H1IuCC3IMDCAmF9p3sqjkLZG2G6lo4Hss25fbtqTSAMh1aKPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482893; c=relaxed/simple;
	bh=3L703eCjj46+5RcTlL6hvGJCVmXFJH9Yc1YepqO213M=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=LWUHsvVYfcu5dv8SdezExJMW8kZjMSzqR/kxoAzHYNafWkOTXJnD7EFZQLs9gAh05USCgoFObmfA5Fs6UMdnu+C8HPlFglhi3czwhCoRZCy/4BHNJ6Fd6Qe682Qpd/kZ8Dw6HoSE+H1Rex9z4Pp3JwYQI0JzWIft2IrNq4jw394=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xQ7WsX18; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xQ7WsX18"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIocGSXjGL3U48Kq75M4ZJYy1F0Wnss35VBsKNeT8P413kvEQ0Pe6ogDGmdfmFrr3vLzNd+Osyrr/65OM5FCX2cP8OaEMW3kLncF1X8kHASd7gZxGGct/9yvOtPMW37Gd9Odhj5AI+46qYNKcxqQZJmG1gKSOYTIrLXCBQN6ydTJz6g45QXfBPF4VhaaHBAPsx4RXH9kDjYL0uowesNKrXzIOQLiRbgjni6aU9TUes3ZPIhQphcf4tHaciKeGPDgsw5Z4ffmA787FUMgcBV5pxfKlgqQXMburNJ3iyzeqW4+2UoKsHbkD2tBPPKSWBGCdmaZJ1otx7RurTk9KsHz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwFO+8aBUCccnYa9/WgHNlaLPoTiYjeZ2zbym26n+lQ=;
 b=iwxc1YXAod6uX9+y52rlByCtTJg1X1f4ZWbpZkKJ4bg8lUf7Kij/51zvR6APbvQIU8znQKK9dN3BBYsRk591DcwmXmFkNrHNqKdNAGltbi3+AV17ai6C5p3aA6h7C404DGNEZ6AbD3TuYgc79ibPOrnVL/KhBcyd7yrykcfpC6XYtJ0LUHfDfAlsbk91vw3zXUG2oXtyzfWb9zHv5VMRnyTVXYMtT7GI8tMxYCKzLPvCvpctAeHEhtYqv+6Jp8A+305FV9L98whqFwEBRxKYPAW6fJRyCUgy1mUljWFA1p1jwy0anw8cjRJIvd9Upg4HxO4h8TjPHsuGulB1f5wS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwFO+8aBUCccnYa9/WgHNlaLPoTiYjeZ2zbym26n+lQ=;
 b=xQ7WsX18g7uTsy8VORAdpmVMukZzkJir9Ue6H2VUNeFTeIOK0O+5omfaoXtHbh5uZvQFr6sKVvvVch8VO4bWUXZ5uxVViL82I0lUEMKE1r+BTnzBBOOHHXkgpToqNNa/GebDCwV5T404rOqZk4y3y3U5Ccu5eBWT0ZOpna/6YDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 17:14:44 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:14:42 +0000
Content-Type: multipart/mixed; boundary="------------65083R50yxQp9sKkmdrJ0LXK"
Message-ID: <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
Date: Wed, 29 Apr 2026 12:14:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, Huang Rui <ray.huang@amd.com>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
X-ClientProxiedBy: BN9PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:408:113::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: d2be0982-3b84-4155-ab5b-08dea612cdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|6049299003|366016|376014|13003099007|4053099003|4013099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x237divzDxbW7x9KD2vmV323izC2wKPXPbauDzK7wKeZKLeIyjdV9T+3BZSzK66/nLW2o90u6OiQO/SAYQt2RzlelHbZxAxXp+zlCsWtz0USoGJ3fitaOZPhc4K+fc7xU9FB6/8hLz6j4Gv29yB2UmojTh28Gsl9j2gYNTWWdH+heQwMsSsAcN7Oz7ZyUOFUA8M6f9iEJX4hhu8ibfXdC4OyZ9Dx3Yy4JQ6prfrLFBo4m04weOv/iWQsHtFjaOyx6jn4w4sRCxbXazbtSPiqnyplyQlJJU6a/L5wC60fzzSSzzZXDfwjiQazb8k9CLC3x8ByzbAD2kOOFGJ/8bJK+j+hzy9CXqUjr7llwTOBglOTZSeSAgph1LcKuyd3AR9apEHrnIo82fRRHvvC3VR03y+IeyuGppXCuMtOYEYSgeriBW8UMN8ghqEL6dgiufbCaWBPaE9p9grsS6A984RSSR1sqHmuPVAvs6Z8Bf+rfCCOy/S8enq1HrhamzTP0HHHIRzd+UFemMiQhs27Ojsko2YCrpZJuxnnY05fU6BMnGQ/Tm4vvBXLVvFzv2namF8x3sh+/Bd8G1XUNpiOco2GS3ZEUYbwE9zBS5Who5aWpxi2wrzZAdytEI6CZ5gFR8dYx96fVqGct5B6k7x/2aTGv8BgZIfHPQgLQJS2m8bX9xlZeK/ZhexmUJa55LcwTSDOdsnax0xCCv/70SDMEI6jl6CdTpn7h7TXdDMvjdqkpfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(13003099007)(4053099003)(4013099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlJcFlGOUVuR1NCdFRNL2FJL0dwUkdvemlTc2RYeXZPdUs5T1ZjeE1QamZw?=
 =?utf-8?B?dFgweC9VN3ZYV0tPeW15MlZaNm0vMTY4SjZibHdlWjdlWFQrS1p1dCt1dUE4?=
 =?utf-8?B?bGpqTDZTcEN0KzB6Mnk3OEdjMEkrODlnRExueGJGM3BPZG9QSURqZHBUL1NV?=
 =?utf-8?B?emNRcW1LYUo3YzV0S3J3Q1lrV0w2VHNwazRkekZ4cm42UlVtdmd1Y1BDbCs0?=
 =?utf-8?B?VlF3TFRsUk9aSjZKc2hIZitGNmNYV3h6NnJDQzI0TWczanRwbWtGb01IdUhO?=
 =?utf-8?B?bmFEUlQvZnB0QnM4ZDdlMzhaM1JTbXp1enFBVndWSzZvdmJ3UFBJYUhZZ0lR?=
 =?utf-8?B?RFQ5VXZIeXd4dnNwTTV3VFN2Z2J1djNXUWt1YkpjRmlodDB3WTZYOUN6YTV2?=
 =?utf-8?B?SU84ZEVqY1VGZC9ycWtpVXRpb3NDTE04Qm1WRUxoelkrUG02Z01uVUZaY1Yv?=
 =?utf-8?B?c24xdVkzaXNreVNHQW5ISXNyZExwMDhheXdnVU9XbER0SDAwdUNvQmlsNWpr?=
 =?utf-8?B?cW5OczlrMXNZY2lPdzF5Mzh0bDJwZWZydjIrdVVvQjhWSHV0KzZKSHdQK0Iz?=
 =?utf-8?B?VGlZc25ZQkdycExXYzd3bmU2dElNdVN1VytBeTRIbnpFWldWWTVyc29MZnJm?=
 =?utf-8?B?UllHRkhNd0MraDA2NlBPNi91Ykg1Rm9wVVdsWmZiOUs4c1hYVFA3Tnd4S2RP?=
 =?utf-8?B?R3dlOEZRRDhBU1ozVnVVUFRCZENVL3hJdTBsalN1N3BvbW4wUHplSTFEWTUr?=
 =?utf-8?B?VE5POFZYbzJHcksyd0xBVThZbXZSVGdsVUpMNTBSUFdpMDdMMmFKOXhudE54?=
 =?utf-8?B?OVpkd0V1S3dVK1pVZHZqdGJXUzBDWmZma2paRENJRVpRNHVLY0t6MmpKSVFm?=
 =?utf-8?B?NW9kRFozanFZN3RwWmZRYnZ4eFp4TUpGd0o4OGtDaHY0VlQ0a2EvRzhkczZ4?=
 =?utf-8?B?YnF5UTNNaDdLMm1QTWk0Y0FHTVhweEFJZktweTI5YStwYS9ZRmVOUDQ4SmVO?=
 =?utf-8?B?M0NOUFZYMXZsem5wbGpDeXFUbE9jL09DUEVkWnk4aXgxb1NwTUZUL1ZEOUFy?=
 =?utf-8?B?M3luYURzeUtNbnNweEdidjg4cXFZdk1GSjZrc3pkUzlHN1V2ekNQU3FobEZJ?=
 =?utf-8?B?K1AzQVB5akJBclFMcW5XcjJoOTZSNk4yb2NXN09YK0NwZ0x4N0RUTmk1Tm9w?=
 =?utf-8?B?REd1T2kxSHFEQ3dGZi8zRFExdzRHN0hoSm1ZaUdXbUJIRXRrek5yK2RDZnFI?=
 =?utf-8?B?UnJ1anZvNWtqQmkrREJYa2tPdk5Edk5MWDFQU2Z0RDVhd2dvU0hjZnR2MDJ1?=
 =?utf-8?B?QklldW04dzZGcVdxWGpnM29XZXpkSCtqbzBvRGpOZWtlb0dGWmszNm9iaWx5?=
 =?utf-8?B?TTFEMnA2MFQwZkxwWm1YNUdhTW5yY0pzbnY5bHpGYmkvU3ZiQ09SU3hqcWpT?=
 =?utf-8?B?a01JUU9oOXRLUC8wUzhqMlZQK1FQajJrTUFSU01nbUQzS0xGMjBaNzZLaTY1?=
 =?utf-8?B?SmVSRU5NNDRlYTdXU1JlUWtVYXhPZ1BqVXlxb1VTK2hvek5uVG00dC9GTlBM?=
 =?utf-8?B?Y3BWRnd3STBxZUVoeTh0Z2kwKzVBdWtKTi93cVY4NFNtd2tIVTVxWUlkTnVy?=
 =?utf-8?B?ZHdTOUhsS25kR0hKTk5UZXFhVmNsRUVyR3IvN0o4UXAvTlh3Z0dmQm9JT05S?=
 =?utf-8?B?QitMOEM1MExmaFZLbFlIcERET2l2bVhBOFBqVmdaaTZRTUVOaER5T0gyTmNo?=
 =?utf-8?B?ZmUzNFhMZmlsOXp5d2dwVkNLTzVPUG4rVDgvOURIWjFkQzY1SnZnN0o3dTNj?=
 =?utf-8?B?SU1BRUZxMFRoUFdKdy9hMjR1ZE83RFpYMTdsaFFIQUNmd242SXRabUxDRUFY?=
 =?utf-8?B?a1ZzekpHd0VVY3locXBGcm5EcmxpSGNBeTROaU9QQUc0ODR2dVlWalQ1VWR1?=
 =?utf-8?B?RmpEdUJQSlkrc0VIckRzTDN0Y1l6cUQ0NXUrRTE1ZjFDSTJsZnVHNVNTTktl?=
 =?utf-8?B?MnYzSkI4V3VXM2h3aFRUU0ttRkZZN3RvYnhIbkozWTZXT2dkZTlmdDkxU0cv?=
 =?utf-8?B?QmpBOEh5RVFTZFZvdElOajVtSFpWSUp0MWtVemYvYkQzSE5uSFNZdk1YU0NR?=
 =?utf-8?B?YVJ4TmtIVWVDZ0tnanhwbngrRFFvNFd5elpDTTZzSVFac0NRWkRxMXlpWXBI?=
 =?utf-8?B?T3FDb3dVUDJTeUpRelBUcHlmUjRlM3k5VXZ1RUJHSkxaMlZITmIvTzM0eWhS?=
 =?utf-8?B?djZVVlZlajBVYjUxM2NFa2FvZm9FTUJOWmVNZC9WYi9rZlZMRkZoeDhsMXMw?=
 =?utf-8?B?elpzbDF4a1RBR0cvbnJ6ZFRteG1JOEl6bThCTHVnNE1aTlI2MjF6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2be0982-3b84-4155-ab5b-08dea612cdd0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:14:42.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wg30+7hk//tBUXF/mfM6kjAgkAiCQ0j7x1rI7DGTj80x35sXZFnwV3XbBFTY6W0aD2sKSRd3rG7Yg6W4moiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

--------------65083R50yxQp9sKkmdrJ0LXK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/29/26 11:20, Viktor Jägersküpper wrote:
> Am 29.04.26 um 17:54 schrieb Mario Limonciello:
>>
>>
>> On 4/29/26 10:38, Viktor Jägersküpper wrote:
>>> Am 29.04.26 um 16:25 schrieb Mario Limonciello:
>>>>
>>>>
>>>> On 4/29/26 08:54, Viktor Jägersküpper wrote:
>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> Am 29.04.26 um 15:04 schrieb Mario Limonciello:
>>>>>>
>>>>>>
>>>>>> On 4/29/26 07:34, Viktor Jägersküpper wrote:
>>>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> when I boot my desktop system running with an AMD Ryzen 9 5900X using
>>>>>>> the kernel 7.1-rc1, all CPU cores seem to run at ~1.7 GHz constantly,
>>>>>>> i.e. I don't observe any core frequency boosting under load. This never
>>>>>>> happened with older kernel releases, e.g. with 7.0-rc7. I ran
>>>>>>> 'git bisect' and found this first bad commit:
>>>>>>>
>>>>>>> e30ca6dd5345c5b8ba05f346a8e81105352fe571 cpufreq/amd-pstate: Add dynamic energy performance preference
>>>>>>
>>>>>> If you compile with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=n (instead of using kernel command line to turn it off) does the issue go away?
>>>>>>
>>>>>
>>>>> No, and still nothing about amd-pstate in dmesg.
>>>>
>>>> Can you turn on dynamic debugging for amd-pstate.c?  Something like this:
>>>>
>>>> dyndbg='file drivers/cpufreq/amd-pstate.c +p'
>>>>
>>>
>>> Both kernel builds (with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y/n) have the following config:
>>> CONFIG_DYNAMIC_DEBUG=y
>>> CONFIG_DYNAMIC_DEBUG_CORE=y
>>>
>>> Booting with the above dyndbg parameter gives me only this line about amd-pstate in dmesg:
>>> [    0.844066] amd_pstate: AMD CPPC shared memory based functionality is supported
>>>
>>> Do I have to do anything else besides booting with the dyndbg parameter? I have tried
>>> both builds.
>>
>> You shouldn't have to.  I think there might be something silently failing in the init path now.  Maybe platform profile registration is failing for your system?  I haven't reproduced this on my side on any of my systems unfortunately.
>>
>> Do you think you can sprinkle printk()'s around the init to figure it out?  If you need me to write a patch that does this I can try to whip one up.
>>
> 
> Please write a patch, I am just a user trying to help.

OK thanks.  Here is a debugging patch that should show what's happening 
in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can 
confirm root cause on your system.

--------------65083R50yxQp9sKkmdrJ0LXK
Content-Type: text/x-patch; charset=UTF-8; name="0001-debug-dynamic-epp.patch"
Content-Disposition: attachment; filename="0001-debug-dynamic-epp.patch"
Content-Transfer-Encoding: base64

RnJvbSBiODEyYjJjY2IyOWY2ZTA1ZjY1ODFiYmMwOTZhNGMzMzIxMjEwODE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogV2VkLCAyOSBBcHIgMjAyNiAxMjoxMjo1MiAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIGNwdWZyZXEvYW1kLXBzdGF0ZTogQWRkIGRlYnVnIGxvZ2dpbmcgZm9yIGR5bmFtaWMg
RVBQIHBhdGhzCgpBZGQgbWluaW1hbCBkZWJ1ZyBsb2dnaW5nIGZvciBjb2RlIHBhdGhzIGludHJv
ZHVjZWQgYnkgY29tbWl0IGUzMGNhNmRkNTM0NQooZHluYW1pYyBFUFApIHRvIGRpYWdub3NlIENQ
VSBmcmVxdWVuY3kgc3R1Y2sgYXQgYmFzZSBmcmVxdWVuY3kgaXNzdWUuCgpGb2N1cyBvbjoKLSBh
bWRfcHN0YXRlX2dldF9iYWxhbmNlZF9lcHAoKSAtIHBvd2VyIHN1cHBseSBkZXRlY3Rpb24KLSBh
bWRfcHN0YXRlX3NldF9keW5hbWljX2VwcCgpIC0gcGxhdGZvcm0gcHJvZmlsZSByZWdpc3RyYXRp
b24KLSBzaG1lbV9zZXRfZXBwKCkgLSBBQ1BJIEVQUCB3cml0ZSBzdWNjZXNzL2ZhaWx1cmUKCk5P
VC1GT1ItTUVSR0U6IERlYnVnIGluc3RydW1lbnRhdGlvbiBvbmx5Ci0tLQogZHJpdmVycy9jcHVm
cmVxL2FtZC1wc3RhdGUuYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9h
bWQtcHN0YXRlLmMKaW5kZXggOTcwM2I1NGVlNDgyMC4uMjRlY2M0ODEwNjRhNCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYworKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jCkBAIC00MzMsMTIgKzQzMywxOCBAQCBzdGF0aWMgaW50IHNobWVtX3NldF9lcHAo
c3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIHU4IGVwcCkKIAlpZiAoZXBwID09IGVwcF9j
YWNoZWQpCiAJCXJldHVybiAwOwogCisJcHJfaW5mbygiYW1kX3BzdGF0ZTogQ1BVICVkOiBzaG1l
bV9zZXRfZXBwOiBzZXR0aW5nIEVQUCAweCV4ICh3YXMgMHgleClcbiIsCisJCWNwdWRhdGEtPmNw
dSwgZXBwLCBlcHBfY2FjaGVkKTsKKwogCXBlcmZfY3RybHMuZW5lcmd5X3BlcmYgPSBlcHA7CiAJ
cmV0ID0gY3BwY19zZXRfZXBwX3BlcmYoY3B1ZGF0YS0+Y3B1LCAmcGVyZl9jdHJscywgMSk7CiAJ
aWYgKHJldCkgewogCQlwcl9kZWJ1ZygiZmFpbGVkIHRvIHNldCBlbmVyZ3kgcGVyZiB2YWx1ZSAo
JWQpXG4iLCByZXQpOworCQlwcl9lcnIoImFtZF9wc3RhdGU6IENQVSAlZDogc2htZW1fc2V0X2Vw
cDogY3BwY19zZXRfZXBwX3BlcmYgRkFJTEVEIHdpdGggZXJyb3IgJWRcbiIsCisJCSAgICAgICBj
cHVkYXRhLT5jcHUsIHJldCk7CiAJCXJldHVybiByZXQ7CiAJfQorCXByX2luZm8oImFtZF9wc3Rh
dGU6IENQVSAlZDogc2htZW1fc2V0X2VwcDogY3BwY19zZXRfZXBwX3BlcmYgc3VjY2VlZGVkXG4i
LCBjcHVkYXRhLT5jcHUpOwogCiAJdmFsdWUgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+Y3BwY19yZXFf
Y2FjaGVkKTsKIAl2YWx1ZSAmPSB+QU1EX0NQUENfRVBQX1BFUkZfTUFTSzsKQEAgLTExNjksOCAr
MTE3NSwxNSBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX2NwdV9leGl0KHN0cnVjdCBjcHVmcmVx
X3BvbGljeSAqcG9saWN5KQogc3RhdGljIGludCBhbWRfcHN0YXRlX2dldF9iYWxhbmNlZF9lcHAo
c3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCiB7CiAJc3RydWN0IGFtZF9jcHVkYXRhICpj
cHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsKKwlpbnQgcG93ZXJfc3RhdHVzOworCXU4IGVw
cDsKKworCXBvd2VyX3N0YXR1cyA9IHBvd2VyX3N1cHBseV9pc19zeXN0ZW1fc3VwcGxpZWQoKTsK
KwllcHAgPSAocG93ZXJfc3RhdHVzID4gMCkgPyBjcHVkYXRhLT5lcHBfZGVmYXVsdF9hYyA6IGNw
dWRhdGEtPmVwcF9kZWZhdWx0X2RjOworCXByX2luZm8oImFtZF9wc3RhdGU6IENQVSAlZDogZ2V0
X2JhbGFuY2VkX2VwcDogcG93ZXJfc3VwcGx5X2lzX3N5c3RlbV9zdXBwbGllZD0lZCwgcmV0dXJu
aW5nIEVQUD0weCV4IChhYz0weCV4LCBkYz0weCV4KVxuIiwKKwkJcG9saWN5LT5jcHUsIHBvd2Vy
X3N0YXR1cywgZXBwLCBjcHVkYXRhLT5lcHBfZGVmYXVsdF9hYywgY3B1ZGF0YS0+ZXBwX2RlZmF1
bHRfZGMpOwogCi0JaWYgKHBvd2VyX3N1cHBseV9pc19zeXN0ZW1fc3VwcGxpZWQoKSkKKwlpZiAo
cG93ZXJfc3RhdHVzID4gMCkKIAkJcmV0dXJuIGNwdWRhdGEtPmVwcF9kZWZhdWx0X2FjOwogCWVs
c2UKIAkJcmV0dXJuIGNwdWRhdGEtPmVwcF9kZWZhdWx0X2RjOwpAQCAtMTMwNiwxNSArMTMxOSwy
MiBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfc2V0X2R5bmFtaWNfZXBwKHN0cnVjdCBjcHVmcmVx
X3BvbGljeSAqcG9saWN5KQogCQkJCQkJICAgJmFtZF9wc3RhdGVfcHJvZmlsZV9vcHMpOwogCWlm
IChJU19FUlIoY3B1ZGF0YS0+cHBkZXYpKSB7CiAJCXJldCA9IFBUUl9FUlIoY3B1ZGF0YS0+cHBk
ZXYpOworCQlwcl9lcnIoImFtZF9wc3RhdGU6IENQVSAlZDogcGxhdGZvcm1fcHJvZmlsZV9yZWdp
c3RlciBGQUlMRUQ6ICVkXG4iLAorCQkgICAgICAgcG9saWN5LT5jcHUsIHJldCk7CiAJCWdvdG8g
Y2xlYW51cDsKIAl9CisJcHJfaW5mbygiYW1kX3BzdGF0ZTogQ1BVICVkOiBwbGF0Zm9ybV9wcm9m
aWxlX3JlZ2lzdGVyIHN1Y2NlZWRlZFxuIiwgcG9saWN5LT5jcHUpOwogCiAJLyogb25seSBlbmFi
bGUgbm90aWZpZXIgaWYgdGhpbmdzIHdpbGwgYWN0dWFsbHkgY2hhbmdlICovCiAJaWYgKGNwdWRh
dGEtPmVwcF9kZWZhdWx0X2FjICE9IGNwdWRhdGEtPmVwcF9kZWZhdWx0X2RjKSB7CisJCXByX2lu
Zm8oImFtZF9wc3RhdGU6IENQVSAlZDogcmVnaXN0ZXJpbmcgcG93ZXIgc3VwcGx5IG5vdGlmaWVy
XG4iLCBwb2xpY3ktPmNwdSk7CiAJCWNwdWRhdGEtPnBvd2VyX25iLm5vdGlmaWVyX2NhbGwgPSBh
bWRfcHN0YXRlX3Bvd2VyX3N1cHBseV9ub3RpZmllcjsKIAkJcmV0ID0gcG93ZXJfc3VwcGx5X3Jl
Z19ub3RpZmllcigmY3B1ZGF0YS0+cG93ZXJfbmIpOwotCQlpZiAocmV0KQorCQlpZiAocmV0KSB7
CisJCQlwcl9lcnIoImFtZF9wc3RhdGU6IENQVSAlZDogcG93ZXJfc3VwcGx5X3JlZ19ub3RpZmll
ciBGQUlMRUQ6ICVkXG4iLAorCQkJICAgICAgIHBvbGljeS0+Y3B1LCByZXQpOwogCQkJZ290byBj
bGVhbnVwOworCQl9CiAJfQogCiAJY3B1ZGF0YS0+ZHluYW1pY19lcHAgPSB0cnVlOwpAQCAtMTk0
NywxMCArMTk2NywyMiBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfZXBwX2NwdV9pbml0KHN0cnVj
dCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQogCQljcHVkYXRhLT5jdXJyZW50X3Byb2ZpbGUgPSBQ
TEFURk9STV9QUk9GSUxFX0JBTEFOQ0VEOwogCX0KIAotCWlmIChkeW5hbWljX2VwcCkKKwlpZiAo
ZHluYW1pY19lcHApIHsKKwkJcHJfaW5mbygiYW1kX3BzdGF0ZTogQ1BVICVkOiBjYWxsaW5nIGFt
ZF9wc3RhdGVfc2V0X2R5bmFtaWNfZXBwIChjdXJyZW50X3Byb2ZpbGU9JWQpXG4iLAorCQkJcG9s
aWN5LT5jcHUsIGNwdWRhdGEtPmN1cnJlbnRfcHJvZmlsZSk7CiAJCXJldCA9IGFtZF9wc3RhdGVf
c2V0X2R5bmFtaWNfZXBwKHBvbGljeSk7Ci0JZWxzZQotCQlyZXQgPSBhbWRfcHN0YXRlX3NldF9l
cHAocG9saWN5LCBhbWRfcHN0YXRlX2dldF9iYWxhbmNlZF9lcHAocG9saWN5KSk7CisJCWlmIChy
ZXQpCisJCQlwcl9lcnIoImFtZF9wc3RhdGU6IENQVSAlZDogYW1kX3BzdGF0ZV9zZXRfZHluYW1p
Y19lcHAgRkFJTEVEOiAlZFxuIiwKKwkJCSAgICAgICBwb2xpY3ktPmNwdSwgcmV0KTsKKwl9IGVs
c2UgeworCQl1OCBlcHAgPSBhbWRfcHN0YXRlX2dldF9iYWxhbmNlZF9lcHAocG9saWN5KTsKKwkJ
cHJfaW5mbygiYW1kX3BzdGF0ZTogQ1BVICVkOiBkeW5hbWljX2VwcD1mYWxzZSwgY2FsbGluZyBh
bWRfcHN0YXRlX3NldF9lcHAgd2l0aCBFUFA9MHgleFxuIiwKKwkJCXBvbGljeS0+Y3B1LCBlcHAp
OworCQlyZXQgPSBhbWRfcHN0YXRlX3NldF9lcHAocG9saWN5LCBlcHApOworCQlpZiAocmV0KQor
CQkJcHJfZXJyKCJhbWRfcHN0YXRlOiBDUFUgJWQ6IGFtZF9wc3RhdGVfc2V0X2VwcCBGQUlMRUQ6
ICVkXG4iLAorCQkJICAgICAgIHBvbGljeS0+Y3B1LCByZXQpOworCX0KIAlpZiAocmV0KQogCQln
b3RvIGZyZWVfY3B1ZGF0YTE7CiAKLS0gCjIuNDMuMAoK

--------------65083R50yxQp9sKkmdrJ0LXK--
