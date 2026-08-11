Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09A37AA95;
	Tue, 11 Aug 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472737; cv=fail; b=ZTP8Z2sSIKj2MuGjN3nmAwPtPp0U2Fnc9F7/rnT2PWFR1Xqo8welbtJ1Ook3rGWNyqxlq+gK5Hh8KTTnF0hdr9WAiDsXKDjl6Se4iN5KODz3Koz/NqOtbjE0C8oRFrIA4S3xcTeGEkD+Az/Doh+pGAY6Ig62OWBQwogKwxkJrAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472737; c=relaxed/simple;
	bh=yMvV+YqFesnWvE1CPeF2e3yZJtKt1C21IgUEtVMLEAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdgZFtwJ0I0Dskn8AFxGk2ySwWc9pfakxJ/1BA/mbYvpX85Jep8aQxUHcDioL/v+oOnQn3KlpdM6ib4LlbIoBSgfkobZ9DKAfETcbClABPX+bsJqKgjZmovg+sykObIHJI06KTAMbbDCJR5EMH7X15L3PGjwNx6mXA/scwAP+DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HKXyaqiK; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HKXyaqiK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvXvsJdQhbzNV6DyPhBt0GiO9QsRSeEpa6LReNQLGzqcgtkOE7/ZcaGJpQuwz3SlhMUZsFEiIHn8X1z7h//5qzM6+/JE4nFQqCJfkohLbO6TuJB6ntIKGhLLcxJ9AisTQ9p+8x+DLUreFKe70spXmXTMxUijq3/7Bnu14m+v6N7ioYevFyj4vs+Y7jDyfDzZf9NhUuQ3cKnRZZQH8LjZqe4+d++bcqtGCXBreeM+bSwgVod7mMeP32wy13vocRXeqPM7cujoR1BVYPt8KaF79uWx37UxHguamDdhv1qVyIakpmqGuAPb9OZfGjcNaDnF2j/ckkt/7YE2cO8O2UrMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FTKPzFkfqofaot8MMFnPYcIczeduaacIAPswWEdMSQ=;
 b=ueCJqJVBXq93EAhdijLA08d/MOwLEvfIy4JzpC/2b8xO09DYsfgqqgvk25IHkiwgObCN/Lq6w/iUxCXztW9uIGABQNGavkiVh5RjW7TYKhE6vhktYR/jgai8shZeV9UGVicmIuKjN0hWRNUQZwShnEdu/nS6QWr1ApGtOHH0DD/dcRJn+4NcTKzzwYsCS5PnmyPXX9vZGz5hjJThPUgrx2uRyeo+KjfH7RPhaSRIBnLaxB1ypgjU5Ca/b9zBY298iol08W+oSoM4dM/MMOkIw+VG9R+E6B9nRhZN4mdVhni17DWF/7HshHSQKKjjc2BYhJf8EpAKJg/jk4A3werMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FTKPzFkfqofaot8MMFnPYcIczeduaacIAPswWEdMSQ=;
 b=HKXyaqiKRBAwQHe9JMA0z2eY0sG3W2CABLo7nBZVPMNlMCOsvyUZRy7BM7JIN+URxx0/KMoA6yzyX8vVO+XQh0GXGaNF6/u+iohxfFVhqvuUmrxRrXFmF2c+go5Le4X2VV3s84MLETCO25ejAHjz4dS3ogKvTyMpE9ysrGOkK0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:25:31 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 18:25:31 +0000
Message-ID: <95a0c1fc-4556-4f82-b488-90c5377737c0@amd.com>
Date: Tue, 11 Aug 2026 13:25:27 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260810213309.GDanpDlS1IcRhHKyWK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db11a16-5c66-42be-3244-08def7d5ece1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LT+L4l225KQtmFbEIdG/Al/quAR4SPkx/2s9R9OWVR9BStghx2I133VtoWiJ3nKSSjYIKqB3N5iZjMklxIJdmaxZCDEc+EGIeI45mSdl10LpihAEjC33CXaY9GZd5U1jVyRCHKUePXUzJX9Su2f/Ir3p2r0anPdTzNxaxPH+78l6Zug2JyakhL9B+OhgGkFvDprBoiCvpxLqfNig7+ebQabwZLbLJw8aAcIdvaRPyAgDKIcmkQHi45zPjBux6rVjT/5r+BLQfm5W44NDWh1WoOER524uIVNKKITLFDM+T9mEjS74PPPOluEDcaKTm8vAla0kskUcz3cJNp+ROo0/QTKSl/C0eD/AycLouuZtl9KfGjyTNX3ko4DBwYMaFozIrGXSbveBvlttRlN03OOZNGF9yoEwruFj/n7glD5eeAq7fZqUjHSjVrQTO+s0fXmdZof97znknHOMtHeixVURl6B5AO5ZA55njFXFc+c2YMNMst64GozM1QoqE+9Qi+h6qumh/8eIdTT6MTQAxbJPP9TDILiDLkA0D4w1e06nVR0mr1/1xjxFE+Ik5Dwj4+dRV1gKNZ15eB1fBF3eSHR33j6B+Wbmw1O23IRcrcCa0btfioj1C1qrnMT5QQh1ThsGUjvcUJGxfL2h1YGmGfCORxoutrC9rgpMO5CY4RI+N6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjBOdjV6UVRiL09BZUpVVHA2Tm9TKzN1cmprQmI2N1ZWWjdnbmdNQkNFVWdB?=
 =?utf-8?B?OFpRemp6SU5zbDMvcVFDNnltMXFJQlVRZ2crVFNXN0tlRWJGUlZNcjBDWDRE?=
 =?utf-8?B?MUpaZnZKaHl4ZG1xTkZvZDFidXdSTkwvYytOTVlGTVJIUnRleXhWbk1yNVBk?=
 =?utf-8?B?QjI0NFVvNW9rUHozS1lhbTlicUhMT01oeWM0ZUNTcjdyQXJHRVpnWk9Fekp3?=
 =?utf-8?B?UmNRS1AvbkUzQ0VhbXFrdHBNSWFlVkNiVlMxKy9ESnA0c3orbjlVRkVTZ3lB?=
 =?utf-8?B?dmF2QnZqR05DOVNyOWY1SFJzMGFtZE5wcVNMbVZZZ0hSbEgyZjZhMUUrS1Y0?=
 =?utf-8?B?RjRRTC9vWE1DYTZNUGY5T1FvaUJDbDFTM3ZwYVg4TW9mYlpVQk5pa1FxYm51?=
 =?utf-8?B?MDdrZWJlSFYwSkg2VEtGOTJJSXE0WmJRcnJ6bU0ydlBDeDR6eVo3bmVhN3Nk?=
 =?utf-8?B?MGVGVnpRb0xlbGovZDdXOThOYXdneXZnTTlrTUlLa2F0VExzaUpVQ1F2S1Vk?=
 =?utf-8?B?LzNHS3RFVDFCVU40NTM0N2NjMHBBVFJ4SmZOYjkwaU5iNzdHMTNVTG1vUDFY?=
 =?utf-8?B?eGQ4NGsxUHNCcU4xZGlOOG5WQllvNHZNWHdDVjJieWszRUQvL0FWM3IwTlli?=
 =?utf-8?B?d2R2dFRxZzBWdlZ5b2E5ZEVRTDFPQzh4ZGhKTlkwRUJKS3JvY2l3R1ZHcGdv?=
 =?utf-8?B?YTMzelJHRDVUUTZyejZWTmxpN1M3WWk0SEtHVENLM2xUYk5YZGczQ2Vnd082?=
 =?utf-8?B?M0t4TkFSaVlmSys3M2ltZDZGWGtqRktFZ0xsdkd4UEI4ZmRNZjhMbUtNVkFF?=
 =?utf-8?B?OHVHSG1aam1TeVhCQzJZZzh1Mk5sVGFYWmlwRHFObnpsUXhpV1RNQjVPSEJi?=
 =?utf-8?B?QTkwUnBqRm1DY3JmSHpEYmxnUnRVU21HUituTlVPU2ZySG45NkhoMEJLcU4y?=
 =?utf-8?B?L1kxb3FBeG9GK1FyOERxZzRlVjN6WlFUcDBwRGsrNWlGcnU0NkN6ZVdHWUpN?=
 =?utf-8?B?TmVCajBLN2xnNWRScWJidEFiaDE3TFlici9relRDMEs2VEloUWpKbXBnNjlR?=
 =?utf-8?B?VzZOR3RWQXlUdHE1NndmSXZBZm5OZ1VsWXRMWFBPRHBZYUVVbWZWQTY1OEFp?=
 =?utf-8?B?by9GK1Uyb0tsMTBTQzhNWDVtcW1BbTAyelZ4d1lEUVVEYkJxSTFrZzlSdGRn?=
 =?utf-8?B?eTdSVjNERGhIaE1GVU1oRWRlL0ROYmcwazlLOWE5K25rSzRJbjB0YThNN1h0?=
 =?utf-8?B?UFIyaDBza2xOWkJZUjRwaGt5UWIwV2s0azJEVTFBRHhsVzU0SWdTSS9HTWxz?=
 =?utf-8?B?NWV1NmNGN20xWGxCWk9JK3J2NlRZQ0JVRkVtN2tTSTA2Wld1bVFGQmEzTm9F?=
 =?utf-8?B?TXJ0S0IwelhxYmMydWxEZktmQXRnc3REaWUrZWFlVjFYVGE2SUV3WnpJMzBG?=
 =?utf-8?B?SUJiYWRVNlRIZHp2UGtMN1lmNDVTOFNwOEVMNytBRWpSS2RtZGF6S3p3alVq?=
 =?utf-8?B?Ynl4K2JrTTVST0JjZ2k1eFRTSFh6b01XRkFCK3I1R0dqMzZocHVWamdqdnFr?=
 =?utf-8?B?ZmhlOEJjTzhRbFJVdFA3dTBqTktkK3MxaWQrN1h3aXJTYnZlS1VSNzR2UmRE?=
 =?utf-8?B?cHlXRGwyamVNM0tmQ0FMeXhnaFIwSmx5Y2o1ZjVwWlVYUzZVNnYvbFJQNk5x?=
 =?utf-8?B?RWUrTDRzazJaRlRpRFpmM3M0Y3F1cnN6K3FkbzUyU0QwWVdlSUhNUzQrWGNV?=
 =?utf-8?B?UDJXK0hoaTBHUnkxYkdGUFU0RjJyTE1scm1YNkV4L0tCM0xuYWU0bmdNekRC?=
 =?utf-8?B?YXZWSThNSWtScEk0dDY4UGp4aXF0ZWRFemhWdnJmVWRtUmlCT1BrWDFtZmE1?=
 =?utf-8?B?RGVRZ0I0MW05NmlOQ0xQZmszZmh3NWxpSjJsNFlERHdrR3FwbzBxbWgvUFdq?=
 =?utf-8?B?bmh0VmExZGk5YW1qSjFmS3FicmhpSXpLL2Y5MWVzVjZENnlTWjRYQnJxVVBt?=
 =?utf-8?B?dW9XZEJ6WTZ6bEZLZ0NpR3pEYklvdUNzaGtQWlFUQm5LWDhRWWRkZGJyTjlz?=
 =?utf-8?B?cmhyZE51dGtXRW1kN0FmY3BVWFE1M0xVOFdFZCtoRG1EWTQ5ZXE2cWhldUo2?=
 =?utf-8?B?TE5NWG1Tb3I4VjJoOWNNQ3o1K3VmZ3lwVTVBM1YvMWFTM1RYY1Fvb3B0Z0hj?=
 =?utf-8?B?T01oWHFCdmZ6bEVIRTVNWnZwZE8zT1VpTjBuMzIrRXZnWGUzY09jTEs1ZjhT?=
 =?utf-8?B?cyt6Y3YvZGQyaThHd0ZjQ3ZpOVB2dHRjSnUvME9DOHRzNnord04xdDNqV0R5?=
 =?utf-8?Q?NIvf/Gy/buTfPWkJNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db11a16-5c66-42be-3244-08def7d5ece1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:25:30.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChlY7gNWFcmmKCHfxI/tKgj7IY6pteNUOKdLsTSZKxfOsNco8dOdD8m4RWmFFdhND5RN3ARJl9AqPG328y6YsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125



On 8/10/26 16:33, Borislav Petkov wrote:
> On Mon, Aug 10, 2026 at 03:07:05PM -0500, Mario Limonciello wrote:
>> I think you should narrow down your proposed quirk to the single affected
>> processor.
> 
> You mean "platform"?
> 

Well the fact that they could also reproduce it on the CRB with UEFI and 
the latest firmware tells me it's most likely any system with this SoC 
and using S3 for suspend is affected.

> Looking at
> https://us.starlabs.systems/pages/starbook?shpxid=c61652d7-d0de-458c-a7ee-ce809ee0ad2b
> it sounds to me like we might fix the fw even...
> 

I guess the same thing might be doable in coreboot ASL handlers for S3, 
but I don't know how well that would go over with coreboot folks.

They might say "It should be fixed in FSP" or "It's the kernel's problem".

