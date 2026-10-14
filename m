Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A421B87C0;
	Wed, 14 Oct 2026 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979097; cv=fail; b=UsOKROiyp+oMt8ivQfnTWPMm93CxaYyBt3DUWNsYjy12cVtVXoqvA5xM1VZTllw1fMWqnJCxsH5RarYgF6kmNLNOYHAWvtuLW3jzvUO0jvGt7jKHXQ5pl6FPKrQcC6r+Trv9Q2Kr2ryVfS3LRu9i2VEIJYEe6BLvnl6ySNbJl/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979097; c=relaxed/simple;
	bh=/TvARWW6MmhMB/DWEQv1FAW60Qr5Mewya6JGvlPPd1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HrT2edz5UIWhw467G/CEX1yF+Bwqat6ZA5zLlUnnbP3Udm6EQWcsM4jaHCNHPG8Jy0mQKjleasSsxqU5GfizOtC269VEaZmHdoZHZSmhcrNRS9nAHY/rMD0qnxN4rRkGTXHiqJFXiac+A3o0hCVSMgVgCbjXz4DmEHsyNdKmNF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cn8dX02/; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cn8dX02/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5tbqPh2zRyztSUFr3KhcwU8+hqCI2QDp+amTgijksX0jf8u1H1ZAgKNgfgSgF6kA3+dRwPUNsYb8obe7BJkqubfcVycT9QD1WhPqWev9MU0quTXgk9JpSbkArh3IlOgCTFJEiyVswC9PnOgaDjZ8mr0km9pmbQJCIGiQUFSB/9PybCnT7ChfoBaehqVVV9uJsYNwssJR5kqFHgAZAR5/Va0LvuvF4n28z0f+0YIjSoojaEz6R2RBXt7w5MO62ZxzEu5WNBREaHGkRR3cFxpjJxkrsz3aDkfuE6yZFdC/YqMcB72AioISYqx4lfislQNUEzOT0/S2tSuFwDeMMqgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHdPqSUcqgLSNS3LqmkavxtvXJJDfxz/6ciwVSqehNY=;
 b=b14hisTyIOmnvMve4vkGtcuObO4/PFAYNkdprHmFtbkKmalPe0DWxVJ07u5S2aK30pQj7kQ2ykTjojKIaittLtVOhTwVAWmH3nCmVJXFctMtLsyPdzi0TbgitheIEUn1WkDdNQx3EY2sF364vF5txSgj8hquhKKx6aYAVamygCWl87gWgjeud5PtZl21nl7qG3YZb+Thtkqby9vt4NOwpJ7u83yrbTNnno5lr89sSBB3fQLxhShZNa5ED2sxAdisU+J2G45pX3kGV9MedAGrNoXpDQCuWZzh70G+FbQCEdwi2nsHa84B2BSHk4UVIg/7x2R0eEWsiP3hG4dqCQh1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHdPqSUcqgLSNS3LqmkavxtvXJJDfxz/6ciwVSqehNY=;
 b=cn8dX02/xeVXoeb7MuVUisNkjomfHRs60dfTsfCkuCx3jpl7ITV8hBQ4PyqvY1wzeqEmdNWP7JKUoOADCPujQA52u+7pjtrEk4NsfJMIc8m5dUXX3GLF+BKq5ldB6hVOKyABClYnM4R+/PNSt82ZcBp47qMkvhWat7t3eTHS8pY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV1PR12MB999327.namprd12.prod.outlook.com (2603:10b6:408:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 11:58:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:58:05 +0000
Message-ID: <5c2d1d75-b416-484d-9895-78b863c1c599@amd.com>
Date: Wed, 14 Oct 2026 13:57:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
To: Palmer Dabbelt <palmer@dabbelt.com>, sudeep.holla@kernel.org
Cc: cristian.marussi@arm.com, linux-kernel@vger.kernel.org, monstr@monstr.eu,
 git@amd.com, vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
 alexs@kernel.org, andy@kernel.org, brgl@kernel.org, bmasney@redhat.com,
 dlechner@baylibre.com, dzm91@hust.edu.cn, festevam@gmail.com,
 Frank.Li@nxp.com, linux@roeck-us.net, jic23@kernel.org, corbet@lwn.net,
 lenb@kernel.org, lgirdwood@gmail.com, linusw@kernel.org,
 lukasz.luba@arm.com, broonie@kernel.org, mturquette@baylibre.com,
 nuno.sa@analog.com, pavel@kernel.org, peng.fan@nxp.com,
 kernel@pengutronix.de, p.zabel@pengutronix.de, rafael@kernel.org,
 s.hauer@pengutronix.de, skhan@linuxfoundation.org, sboyd@kernel.org,
 ulfh@kernel.org, viresh.kumar@linaro.org, si.yanteng@linux.dev,
 arm-scmi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <mhng-8AE63289-05A8-49D5-B38A-F5AA1D56C2E8@Palmers-Mini.rwc.dabbelt.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <mhng-8AE63289-05A8-49D5-B38A-F5AA1D56C2E8@Palmers-Mini.rwc.dabbelt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0044.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::15) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV1PR12MB999327:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b01f14-a808-4bcb-7e97-08df29ea678a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YHAqEhdXNFmeospNOUrGoz4ieKFmQ2q8AuPHUMertfAKYbs2OddBlq8ouu9iUucPkEKeHU458zQUNEf/eUTNTtOMoKkQdoDFDsbuh32JrkLKN4GZ3wzXXiIpjZSUWa46kmRDlJZGtZfEBpmBEd3ZUcZWpIo/UXGXkbF5PfmDL2iLije/7cL39vRLPT4IZ+HImHI8RtuSDuVZHbf3GkOxGyGL+j/IfwHJsauSQSseHE/VA4V1oJ28Wkx95XT06PbO231e8aQR3PlxO8w7t16nmn/Cn3SJXdOpWJV1JApr0vp6ii5nPrh6zkHJx/bnTUlmtK2yoKWXc8vYl3XyyzOBYXtD9EQmRdpXnXtC60/vqdNlQuuM41c44WMR713pbyWsFGpSCEO8JzkdQC5UrMA4U/RdFZg8pbx3WrjOde0MU2gEBifOlElR2+kwlzx2Gw2YcEytrNU0IkADvnKwRYdh2HOddSQi7ZBQAx3QwNc4ewcx9t83adh7ZwlhylQWt2rv7gQGSS+Ce0d5S/Bd1qvduc4uX0DKa3L95iQEG9SVmmvKJpjT+O1DbA4qxn+aG22/fUQ49ZsCZh3gbGPM8U+SsgMP3EKNJOwuqOZejq4xXB74cb1FcStyz+EFTeP/ykBp4ShxsC5OXAaRY7mLNOxGQZKppjDfSnBnnZTukbkWTwg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFXNWp4SDBWMU5Fd3FISk1hV2ZJbGVWaDBXVGQ4b2RNcU5oWDFIbFpIcVk2?=
 =?utf-8?B?ZE81blZlUmpRd1BJNXhPTExIY1NXNXI4WXhLbHZ6OFhYSVJFZTlnUjkrbzJB?=
 =?utf-8?B?UUlOWlBYcnMweWRrditQYzVYSWJxcG1oaElSNUt6SEhFaU9Rd3BvMWpWbFl1?=
 =?utf-8?B?K3NqakZ4cWFxYjQvc2U4MlpBcHB3QXFDZzZFdk40dlZROVJ1cGZBdGFqZmRa?=
 =?utf-8?B?THFqbFJ2NlRoU3pmKzFVQk56YnRQMElkc1h3eVVKdkl0WTNnSzVzVVkwMmZ3?=
 =?utf-8?B?SCsrVG40N1JKQkhLV21rdDNDU0hIL3RLZEVlRTdmMjJRZzdNN1Jla25OZ29U?=
 =?utf-8?B?WEZlNC85Z3lWcVI4TkUvUUdiWGFHRDIyNmJZWitsZUY0dmt2djc4NjhXVWJV?=
 =?utf-8?B?RzhLY1lhSDhCNkJSRXp0eTZQc3NXVVUwUFZBTUxzbVIxZlBWQURFU2VsWDl3?=
 =?utf-8?B?L1ZEbVVCSklXeGYyamhpUmszR2MwSFQ5SjBDcndCVEl3bW15eXA0TGQzV2VK?=
 =?utf-8?B?SkFzeDNEMnh5czZtWHpNRzBDdnFuZURwSDlUNUFTZWdwNkZ5NllYWVI1dEhj?=
 =?utf-8?B?azU4MWhwM1UvS0JaV1FMUEZGVTZCbjRBbmQ4TTRhT0IwODBNNjJjVE4vdGVy?=
 =?utf-8?B?NXlvb2kzL3k0Mmg1YlI0VWdkTk1pWHpZR1FVTWlib3JGNm44cFI2czY1VVl2?=
 =?utf-8?B?VjZxR2U5WGdpZ21OelJUNlFSQlR3LzZNUTR4S0QzRU5td0wxWVZiTmlaT3dX?=
 =?utf-8?B?U0Z6dGtRb0o0TGxQNVpoT3lkWXdOTWtMYlBkZ3JjNmZKL09sd2ZkWEZVb2FO?=
 =?utf-8?B?UDVpbFVUTnM2T2JodkxQc3AyQ3J5bGIzMkFScWRGcTB4aUJpdU5kYStvVy9s?=
 =?utf-8?B?WjJFSVN3ME5wL0IrR0lRMkRCVVpxQ0ZOOW10UjNKTlZldEg2dGs2eUcvMUs0?=
 =?utf-8?B?dFF3c0kzUS96bWhWazBTL0JZNDlPeEFabVlOckVBb1doNFJvbW5jNU9Bd0VF?=
 =?utf-8?B?SjBkaFZVenArdEJDUGFpeThpd29lNXlDQWkvS2cwZ1F2VG5FUE9MT3d5OExB?=
 =?utf-8?B?cmVpMlZMZTg0UEZVSEo4TllTT2VGTGtHcEt2YmV5MDBpVHhrVFgwS0t6Qk0w?=
 =?utf-8?B?NGFTMllkQ0ZBTjZ1RmpiZHRidHVKNUJpbktnUTN2dVhVdXlxRFpnMjhvUHk1?=
 =?utf-8?B?M0FrMi9XTnRwNDU2UGVtRmdSRjhpOHVwbkJsQjdUbTlKazBvYjVSZEFNSHlY?=
 =?utf-8?B?cTk3L2xxSEdDTU90ZVRqL0hvNjVsVnF3M0Ryckh6NitIbzZrTzNwNUlUTlU3?=
 =?utf-8?B?bkl2dlJlVkZUMzcxK3VFamZ2c0svS0pIZGNtWXVGQmRrRnVjM1hQUnp1YVRX?=
 =?utf-8?B?Z2s5dWtRT2t3Mmx5YjdYY1NmTTBlZlZyN0p0TmtaOUpjcmNLWGh6bzUvVEpw?=
 =?utf-8?B?K1ZXOGZWTUIyUEJIclJndEgxL25UaktMRU1BSmplbTNLa1NkUkdqZWkyZ3c3?=
 =?utf-8?B?Ni9VS3BRZ01DM1NtcVNVT1Vsd2RQK2p4UWxlQURYYjF0RHFWNW1XdnFWT2tV?=
 =?utf-8?B?b0dUY3VPSzhhTUNVSldDem9PTCtUY1pWODFndWgrbk9UYUVwWVozY0lsa2RF?=
 =?utf-8?B?bjdjbmt6aWRQZGJMWFZwSUdja2ExMkNyNURpRS9sOTBJcXBqT2VnRUNOU0Fz?=
 =?utf-8?B?Y0NJbHNWMXlVRmc5ZE5vQyszWk1BYVdyb1AxdE5FZnR5MDFXQitXOTFTcWxV?=
 =?utf-8?B?R1h1a1J2d3lqdDk1UDIrb2ppejV1bVVoa2RFY3I2RmZVRTRqOTBYbDVYYTRr?=
 =?utf-8?B?di8ySHVyU3RadTFHVW5rbWF2ZXlhY3dRZWg2bTR0LzVzUHFyV0tGU0t0Y3Zr?=
 =?utf-8?B?ZTlVUTFQU3NEOVhTTzdVTElSZENxdVQ3M3U0aDhIQVBBR1ovNVM1SlZrVzZT?=
 =?utf-8?B?S3JadGdtNXh3TEV6ellkajd6R1Q5L2hzdmRnL3UrWjA3aWF1VS91MnQvOVk4?=
 =?utf-8?B?TnhmR2lSVmRqK21rVTMxTkN5Z0NTdTdPakVHOUptR2FJcUNhdmFDTDdpZHVs?=
 =?utf-8?B?UFVvb2p4c21YaDZZYmh1bjFScnJaTTdMZk9kMmpQV3poUFlXUTIyZG12c2la?=
 =?utf-8?B?VStZOW9UbGxUQ1F0NjZneUMrd0VUR0JGdmtTaWIwM1gwajdJY2QrV1ovWjh5?=
 =?utf-8?B?QkZhZmNhL0ViSXc4ZmpieHRaQzZPZzFuaFp0VUZDanpuenBNbWxLTjk1alYr?=
 =?utf-8?B?bzJFa0pNNUFUWlpzOVFFVG16dEVtWCtFaldGd2trd2lOa3g2Mm50U3g3Tzd6?=
 =?utf-8?Q?SiSAsoKfwOj35xLzI5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b01f14-a808-4bcb-7e97-08df29ea678a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:58:04.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UXrRhcy/rcFhMldGyRKQRu7YLK8NjXQC2cO6uwUKjT/JdZhG6MuJKanzsYZJLDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999327



On 10/14/26 13:52, Palmer Dabbelt wrote:
> On Fri, 10 Jul 2026 01:59:04 PDT (-0700), sudeep.holla@kernel.org wrote:
>> On Fri, Jul 10, 2026 at 10:46:15AM +0200, Michal Simek wrote:
>>>
>>>
>>> On 7/10/26 10:38, Sudeep Holla wrote:
>>>> On Fri, Jul 10, 2026 at 09:42:09AM +0200, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 7/10/26 09:35, Sudeep Holla wrote:
>>>>>> On Fri, Jul 10, 2026 at 09:03:32AM +0200, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/9/26 17:56, Cristian Marussi wrote:
>>>>>>>> On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
>>>>>>>>> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
>>>>>>>>> SCMI server from different architectures than ARM that's why remove
>>>>>>>>> ARM/ARM64 Kconfig dependency with also remove ARM from description and
>>>>>>>>> rename folder to reflect it.
>>>>>>>>
>>>>>>>> While I understand dropping the dependency on ARM (I always wanted to do
>>>>>>>> that and test if it worked at all on some otehr archs with QEMU), I am
>>>>>>>> not sure about the whole renaming party ? why is needed just for
>>>>>>>> cosmetic reasons ? it is at the end an arm originated protocol so I dont
>>>>>>>> see it as a being wrong to be named as such even though used by other
>>>>>>>> archs...I have not really strong opinion on this...
>>>>>>>
>>>>>>> I have been in CC on U-Boot RPMI patches which got to my attention because
>>>>>>> I don't want to have another interface for MB-V(riscv-) running in
>>>>>>> programmable logic and have another server in the system doing the same
>>>>>>> thing.
>>>>>>>
>>>>>>
>>>>>> Ah that's interesting. I wasn't aware of that. I still agree with the move
>>>>>> in principle, but how does that align with these:
>>>>>>
>>>>>> drivers/clk/clk-rpmi.c
>>>>>> drivers/irqchip/irq-riscv-rpmi-sysmsi.c
>>>>>> include/linux/mailbox/riscv-rpmi-message.h
>>>>>> drivers/mailbox/riscv-sbi-mpxy-mbox.c(Should be fine as it is just transport)
>>>>>
>>>>> I am having separate discussion on u-boot mailing list about RPMI and it's
>>>>> usage on non riscv architectures because one raised argument was that it is
>>>>> community driver spec compare to SCMI which is owned by ARM. But IMHO only
>>>>> for riscv.
>>>>>
>>>>
>>>> IIRC in LPC 2024, we did discuss opening up SCMI so that RISCV could use it as
>>>> is instead of copying quite a lot from SCMI for RPMI in some closed groups.
>>>>
>>>> Here is the summary we got from couple of RISC-V vendors at the time:
>>>> "
>>>> RPMI is comparable to Arm SCMI, but it includes RISC-V-specific services such
>>>> as HART State Management, CPPC, Management Mode, and RAS Agent. The SBI MPXY
>>>> extension enables secure and non-secure system partitions to exchange RPMI
>>>> messages, allows an M-mode RPMI transport to be shared with S-mode, and lets
>>>> hypervisors virtualize RPMI for guests or VMs.
>>>>
>>>> RPMI development is already well advanced, with much of the client-driver work
>>>> implemented in OpenSBI. Supervisor software can access selected RPMI services
>>>> through SBI MPXY. A permissively licensed reference implementation, librpmi,
>>>> is also available for platform vendors.
>>>>
>>>> RPMI was created after evaluating Arm SCMI, mainly to support RISC-V-specific
>>>> requirements.
>>>> "
>>>>
>>>> I didn't pursue it any further following some of these followup discussions
>>>> post LPC 2024.
>>>
>>> interesting. It looks like that they even didn't try to ARM about it.
>>>
>>>>
>>>>>>
>>>>>> Now I feel we need some alignment before making $subject move.
>>>>>>
>>>>>>> Based on that we had discussed about it with Vincent and Souvik (we missed
>>>>>>> you there) about using SCMI on non ARM platform and both of them didn't see
>>>>>>> the concern to be marked as ARM only protocol.
>>>>>>> Truth is that some of protocols have ARM in description, file names, etc but
>>>>>>> some of them not. That's why I think it is good time to sync it up and
>>>>>>> enable
>>>>>>> running this protocol on other SOCs.
>>>>>>>
>>>>>>>> ... my concern really is ... wont this full scale rename simply generate
>>>>>>>> a lot of un-needed churn for future fixes and/or backporting ?
>>>>>>> I don't think it is going to be a big problem because it is just git mv
>>>>>>> which git is able to gracefully handle.
>>>>>>>
>>>>>>
>>>>>> Otherwise it may end up being unnecessary churn though I completely agree
>>>>>> with the git/backporting aspects. Just don't want to churn things up until
>>>>>> we have some plan and further changes/users of this move.
>>>>>
>>>>> As I wrote above AMD/Xilinx platform with SCMI server where ARM RPU/APUs
>>>>> (with multiple VMs) and Microblaze-V in programmable logic acting as
>>>>> separate agents is going to be the first user. And for being able to run
>>>>> SCMI on Linux running on Microblaze-V I need enable SCMI on non ARM
>>>>> architecture.
>>>>>
>>>>
>>>> Ah OK, if the plan is to just use SCMI as is and having "ARM/arm" name is
>>>> a blocker, then sure we can get that done. Hope you are aware of and already
>>>> considered some of the RISC-V specifics listed above and ruled out any of
>>>> those as concerns to use SCMI on RISC-V platforms.
>>>
>>> I know that we can't maintain SCMI and RPMI servers running on the same chip
>>> doing the same things. We don't have space for it and make no sense to
>>> duplicate testing on it too.
>>>
>>
>> That is very valid and compelling reason to re-use and agree with your
>> assessment. If you can make it work, go for it 😉.
> 
> Ya, it'd be great if we could stop duplicating specs in RISC-V land,
> it's just a big time sink.  So
> 
> Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
> 
> if that helps any.

After rc1 I will send new patch series with more patches to clean this.
Will keep you in CC.

Thanks,
Michal

