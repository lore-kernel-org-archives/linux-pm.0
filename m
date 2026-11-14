Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794673551;
	b=RsFeCZ62VqkqXillhagcc7oSMOxaF5gn5SCmEioDrB4N8oxSfCtQBMNSWioxLhCUNLCR
	 EtPRC4OWw0ZpK3kiJc6ae8PqGb9QBYYWr/HO/F/uwRDgP3Rvla9OzREerbYxk/Z1h4xdl
	 6A0WxguDrzXxy4WufTfClQRvL4RgOscWloVhKSYXfGyFmwCPEOl7+aMLP2burtUW6DDSn
	 GK55H4+75ggK/nHFMsAK058VS1VtLWW+fG4U3jDM850GpF4mGa1xSg/4xuVmgrqjxEQ1Y
	 /vfS98a8zAZLbM0FbRUaojpVR3/9sDGaOjnUGblxRGAVUM5hTTtVl1REn0ggiWGzTPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673551;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CQ9lrcipopW63Uvd5gN1dSnhK9M/x53k14HCWWubL48=;
	b=rIeEQIZl4rbZIz5uV9ESeCod35JBl1jI/CHwSnmEVZm0RG8Vg5HvxodG8By1jAp6hgu5
	 TDD2DUEW1XjKiHGbP5kWSSZKEM+Kq5TTd65RDWWoO1nWe9cma+RsfIIRG4HtfKffJdtix
	 16GD0HcLizmOuiJt+lm568OY4DnvWsQpc/uQNn21dPboiNZBzNlKdNdpLN8tAAAUTGQk1
	 wGYp/mCv9ZUNx+yHWskdCQsHnJN+3BnfsEshRTmgnZdhg8lIkTyOLfLVz9ZbV+JB1ZV0t
	 YEydBkse9tOrkjWZ70E1+Q3gtY2/4lKnjxFc6B3fTT7E0ieT9YiFDvRSeAPXiB4s2YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Cm9XWit;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCE606A329;
	Sat, 14 Nov 2026 16:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05FCE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Cm9XWit
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4AHlNCc9dKot7D10oFR2Uvg2TwJyXhMBCoDPWnwKq3fHgxo2Vd+i68I111BGJNm+RcGj9uWeU1d/l+A4xwrg7A0u6hcDs39L3Lu1ksfKZy09UiYtpZNkKynwb05WQ7bs7OIjL8X2OojtvBK6cng9YdAV9xa+Z+kAMHD9bPyYjnbAB56UoF/WUJdra67c6zHy0WVI5FAOwf65pDeh9082WtCWjKdHZ/KnFbu9oAGQTMAsSz/Y7bx5b9etFT8sSqRXP387CUL9y/kSmoeDcwDg9/SWlQzS/lRIGRZcBppiZ628yLEiz67fQwDU8OuGRCFBhV8IvGe3Axw/RLZVNbM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ9lrcipopW63Uvd5gN1dSnhK9M/x53k14HCWWubL48=;
 b=kkyqzrt4Oom4c8wmwcVwrKY3JPIr8/k+MWXwEMiuPPp+wSMfyiz5LbCz4rnzvv9yLGoIROtn6j1OFraP3Uo3IIzTaR3M+tcDY7qT8Fh1jT6qUMzma9ZH6+bNpMIEon4ZK2shuwEzebmtS7svN4TK3mRcVJrtha8ArRFILMrVVVAWSFv7dH2FKfDFfMWXj0huaO1va1GCsVVg2G1/bMmViq0dnf8sL6Kw7JqXgN4yD7/CNL7QhRivPhZaYGOdvp1USVpjBV0DYaJNK/kf6tDFPYithjlFmbAzoierXvzRPuipBl0zzrW2hlBRLp3Ew1rK3j/50+gktD0eeQBlYSN+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ9lrcipopW63Uvd5gN1dSnhK9M/x53k14HCWWubL48=;
 b=0Cm9XWitsAukviAvEa1M5VGkaimymlNHGnfkGsIwgGsT1dFX+iw52H0v0+kmXWy3czY6gAWNawMokoIIGWroXtZUrVrLqUp29k5KMV5Udc3WCz0d/dLlDzigW5YJ8eqIAShsLDkG/1weXp+10+it4jqaXgHL4AtuE/9MUQMbGWw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by LVUPR12MB999135.namprd12.prod.outlook.com
 (2603:10b6:408:3a1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 16:25:47 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0615.012; Sat, 14 Nov 2026
 16:25:47 +0000
Message-ID: <8b335026-c116-498c-83e6-4d9dccd49d1c@amd.com>
Date: Sat, 14 Nov 2026 21:55:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: amd-pstate: Enable hybrid CPU capacity
 scaling on heterogeneous Zen CPUs
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Aiden Hecker <heckeraiden@gmail.com>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113022934.13397-1-heckeraiden@gmail.com>
 <20261113022934.13397-2-heckeraiden@gmail.com>
 <bd326953-f693-4994-91e4-f8301430557a@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <bd326953-f693-4994-91e4-f8301430557a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 94002016-6016-407d-ab21-08df426bf047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	f619zpzf2feFmq/kRxklkT9O8P6OAIpL3Re14UJ3Vy+CP8JSFn9meVRkWPe/Uoi6GFd/+1YPy23Sid7pthRClR+u5n9cvL9Artlf5O8bNTKzMaZykix+D+ucxtrlaGS8JJPEzhsuJC6KV0xEbj/13dswsDQs82F4Sr2TMI6d4dKeM5xu4ygoSSj08+2cJAINN1nOdTyjLhhc+6GXD2ahl/0+PYTdylo6WukBjlmmtij5KTM2eZq5AAfiapA/nbbYjyDFOCatqB89W2REBopRL1nsU2Ui3x+7O4GvXCUG6fOxlddLuEZBIA+RKcV+rXq62Irj4Waf1F0BU8xn526VGX4+c0LFwubyHwAjDeW1tP7da+HS2jggz+n+wgYJaTg+0ZbeOprfI148kbwokYbg6Vac9Vxg7frGgaWZEbz81M7h1gh4fkbPKYNw/BLonv3YOPgl2VCLBZjUU+xd1jlRu9ir1ZU4mCAi/rtxF1ZILmu25knQI4R9xSVEVpW5WU49dU0lgX5RKTDRZiYphAHZu6ABzaLrmg9wT7jqfsOyrDwcSQtn12GLQ3DsYYy7GUZUILV0BdohQpMed9lTuekd1DTaOzo60Q+yXPGGHEXWyxRcENTjlTDfWHP3Iy5IfoK6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TldHVFZrVlhUOVE0Nmc3WjY1NEZXUG5LUitzNnRKL3AvNlFzZHpydTVEQWVB?=
 =?utf-8?B?SVBGYys5NEtCaHdsekZWQm5DSzhubHZieU9kQmZUc2ppckpOTGNGdFlxbXN2?=
 =?utf-8?B?YVZndmhmVnllb1VRNW16SXRLb1BNd1VDWWkwSnJWTURiZjgzWlp4M3JDWGxz?=
 =?utf-8?B?VXdFYmhQSjIyQXNDaWdZVVM4akdqZVVEWnJSdm5kOU1HNzRUdjBKY0NWSlU1?=
 =?utf-8?B?aEtDRHhiVk1FOThvdW8rbWc5d1hvWUdNS1RzazR6NmhZeHVVK0xlbkZWU2VE?=
 =?utf-8?B?cGw1ZHpjdUZBWTdVY0t0L3FxbFVSbFJML0N0ZWJQUFJjWmVxVEc5NCs0R2FQ?=
 =?utf-8?B?MVlOMkM2OVYxenhvWG5naHY5bEd2WXYrSkVJb2hsK0FIOGU2enU0b1krTjZT?=
 =?utf-8?B?aFhjUmMra09NUjY4UFdlMHZZTG5CN25zS1pCY0p2L2laVjNTWWo1SzNUYTVz?=
 =?utf-8?B?UVNHSmRyOGo2ek5NK0ZPaW5JNi80bVFGVGJQL09XQXVYdmZldTF2Z2pJNmtv?=
 =?utf-8?B?Z2tGRzhBWnFscXcxTEd5VWIzUDRZSlRPc0hWbGRXSGhRdWRnWGxGYW94ZC9Q?=
 =?utf-8?B?RmlkRWxvQjVVRkxROElFTnM1aExOUjc2NVdRQ2JEWVFFTG1MazJLUUMyK3hJ?=
 =?utf-8?B?T3djby9ndVZHZVVQQlI0NGlDMDF5MlZzQkYxVXFjWGVHeDFUTGdWLzRpNFVF?=
 =?utf-8?B?NGlQRTEzTXJrTlQxQVVaTDVJanFwMmtQUGF6d1ZvUWR1SythMm9YZk96NFhs?=
 =?utf-8?B?WUhCQ0dpUHVOaXV3eWprQ0hPZVovM1JELytyN0Zsd1RseUZnL1lCdDBmdUw4?=
 =?utf-8?B?bmQyNFUrSWszdHZVZ2hnVndmWWJFRFJJNzk2clE0NzNVN0F4NEpOZm9Ncmhs?=
 =?utf-8?B?OW9kKzA5ZlQ5NDJySUhCZ0MwL3U0K3kwV1RMNTduR1F0OVROODVLbE8xMlI1?=
 =?utf-8?B?VTc0VFQwZXhkMUtiY1p3VFY4N2l6VzNTTCsxSjdVOUN1Y3pUeGZSSk1EbWNB?=
 =?utf-8?B?dW55TGhTSTc1Uld0bDB1MnRVV1RvZnRPZkRkVTNkQ0l0aldwMnJFTDM1dzh2?=
 =?utf-8?B?bkJWSVlVU0RWeXg2aFJSYXV6anVvcXIxM0pnbUgzK3luSTJWMDZ4SDBjWjV6?=
 =?utf-8?B?dm02ZTNXa0ZMTDRRYzQwZXdYYlJBY01jSDJMOUpUb1pWNHJJdXpGY2lIM2tm?=
 =?utf-8?B?VHdPNi9rNVgyb0ptVWpCT1piNFFiYzZ2ZUcwQkVuOW9adS9sZTZZeE1HRHJq?=
 =?utf-8?B?SStMNzRGcEZQZExwa2JiaiszS2ExNGlSNDAySFdDczRCMnB4RThFalQxMENB?=
 =?utf-8?B?ejRnbFNibVBOZDM1RUpzRVNmbnF0WEt5endBN08yeWtGSGV0UDU1QkF5QlFh?=
 =?utf-8?B?ako0UmxUckZzc3hzQWVOZk5kN1lLWHdNdDNQOVhPbzFGb1Qwc0NOWThkYW1t?=
 =?utf-8?B?MUxicXZ2NXk1NGVoN1lvbW5zUlpPNDUvYmw1VzlMNkJWdjZpRUtNejZPV2Vu?=
 =?utf-8?B?Z3ozZSt3TVQ0QlVQaTJaakludWJmM094SWJaY2ZsOW84aGw3YzFwNkJPTjVC?=
 =?utf-8?B?N2lGY3UwUEdtSnczbCtBZVZXNW84aVRBOFdNTTkraWFTbGE5VlRRbWl3NVZv?=
 =?utf-8?B?MGtCaGtqSTJFbDFleGxDZmlPREc2U1BZOU9NbWxHVzhIQmROcU94VXl5NEM2?=
 =?utf-8?B?Q1NyYlQxYTN3UVBJZS9Fazh0cHA0RHdUWHRLdk1RNEg1dVpZTHQrZmx1dUVT?=
 =?utf-8?B?SzM5ZlYxL3plaElxZ0hoR2ZtTVkyMnQycTVIQ01oQUVIbm5iUjNHRlp3d3Fs?=
 =?utf-8?B?YWxRVVU1VFkyL0FsYWs1MVFoY3VUc0tCVVN3Um9HSmtNcE1FQlNJWXRtQlEw?=
 =?utf-8?B?YjZkTUV1T014cUxRYm93ZmJxSkIxV0hwdHNjUTcvUXErcWRUWlo1WnNEbVhy?=
 =?utf-8?B?VDQxeXdvR2d6QWJyWkVOZTVyNkx3SEovdlZrUTlTdkt0dXZySGlNZnBmaDRw?=
 =?utf-8?B?VEYxL3I3RFRxRC85dk1yZ1owaGRuTVd4OXlSTzVBS20zc21LSEJSNkhaNENO?=
 =?utf-8?B?RW81aithTnBmQTExajk0dHpnYjNDSVFiMjZZMUJJZXNINnNMK3NQRDQ0UjJk?=
 =?utf-8?B?SkhPaGZLUE9WZjNWdmMxaThOUzJzM2JNQlBuU1RiRG1DM0RRS0hORkxpNW10?=
 =?utf-8?B?QmRMc09nRTlvbWVoR1hIdk93YmJIS0h0OWpxZDdBQ0Q5NmVsdWRXbENGQ0x3?=
 =?utf-8?B?WGtuT1c4TmRlcnE5UHBQZWNqUCtOK3dJWUhYb0JjQU54dllOWk15RmZPQ0lw?=
 =?utf-8?Q?3BklzC1nuP5a6VU7oc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94002016-6016-407d-ab21-08df426bf047
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 16:25:47.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsi2cecLvGAnSs8oTngf9bapBSj4H56QtSClKU5rHxmjpxhtDXclXkZRd0gHCmUwfJOBiv+giJOcSzb+KgjOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135



On 11/13/2026 12:45 PM, K Prateek Nayak wrote:
> (+ Vishal who too was working on this)
> 
Hi Aiden,

Thank you, Prateek, for including me in this discussion.

We are also actively working on enabling capacity scaling, and our patch 
series has already gone through internal reviews as well as extensive 
validation across multiple platforms. We also submitted our patches 
today after becoming aware of your work in this area, as our series was 
already reviewed internally and thoroughly validated across multiple 
platforms.

For reference, our patch series can be found here:

https://lore.kernel.org/all/20261114150310.1377654-1-Vishal.Badole@amd.com/

Given the level of review and testing already completed on our side, we 
would like to continue moving forward with our Capacity-Aware Scheduling 
(CAS) patches. The implementation and associated changes have been 
developed based on the hardware behavior we observed during testing and 
evaluation across the supported platforms.

Thank you for working on this area and for sharing your approach. We 
appreciate the effort you have put into this work. We would greatly 
appreciate it if you could take a look at our patch series and provide 
your feedback and review.

Thanks & Regards,
Vishal Badole

> On 11/13/2026 7:59 AM, Aiden Hecker wrote:
>> +struct amd_hybrid_cpu_cap {
>> +	u32 highest_perf;
>> +	u32 nominal_perf;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct amd_hybrid_cpu_cap, amd_hybrid_caps);
>> +static DEFINE_MUTEX(amd_hybrid_cap_lock);
>> +static u32 amd_hybrid_max_perf;
>> +static bool amd_hybrid_cap_enabled;
>> +
>> +static void amd_hybrid_cap_workfn(struct work_struct *work)
>> +{
>> +	rebuild_sched_domains();
>> +}
>> +
>> +static DECLARE_WORK(amd_hybrid_cap_work, amd_hybrid_cap_workfn);
> 
> This is probably not necessary - more on that later ...
> 
>> +
>>   /*
>>    * The numeric EPP value programmed for each named preference. First dimension
>>    * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
>> @@ -969,6 +990,99 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>   	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>>   }
>>   
>> +static void amd_pstate_record_hybrid_cap(struct amd_cpudata *cpudata)
>> +{
>> +	struct amd_hybrid_cpu_cap *cap;
>> +	union perf_cached perf;
>> +	u32 highest_perf;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
>> +		return;
>> +
>> +	perf = READ_ONCE(cpudata->perf);
>> +	highest_perf = READ_ONCE(cpudata->prefcore_ranking);
>> +	if (!highest_perf)
>> +		highest_perf = perf.highest_perf;
> 
> I think it is a terrible idea to mix the preferred core rankings
> with asym capacities. You should just stick to using the
> highest freq as a reference fot capacity.
> 
>> +
>> +	guard(mutex)(&amd_hybrid_cap_lock);
>> +	cap = per_cpu_ptr(&amd_hybrid_caps, cpudata->cpu);
>> +	cap->highest_perf = highest_perf;
>> +	cap->nominal_perf = perf.nominal_perf;
>> +}
>> +
>> +static void amd_pstate_sync_hybrid_capacity(void)
>> +{
>> +	u32 max_perf = 0, min_perf = U32_MAX;
>> +	bool updated = false;
>> +	int cpu;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
>> +		return;
>> +
>> +	guard(mutex)(&amd_hybrid_cap_lock);
>> +
>> +	for_each_online_cpu(cpu) {
>> +		const struct cpumask *sib_mask = topology_sibling_cpumask(cpu);
>> +		u32 sib_max = 0;
>> +		int sib;
>> +
>> +		/*
>> +		 * SMT siblings share SD_SHARE_CPUCAPACITY and must expose identical
>> +		 * arch_scale_cpu_capacity() values to avoid scheduler warnings.
>> +		 */
>> +		for_each_cpu(sib, sib_mask) {
>> +			u32 p = per_cpu(amd_hybrid_caps, sib).highest_perf;
>> +
>> +			if (p > sib_max)
>> +				sib_max = p;
> 
> This should never happen - even with preferred "core", both
> siblings will have same ranking (but you should use the
> amd_get_effective_highest_perf() - more on that below).
> 
>> +		}
>> +		if (!sib_max)
>> +			continue;
>> +
>> +		for_each_cpu(sib, sib_mask)
>> +			per_cpu(amd_hybrid_caps, sib).highest_perf = sib_max;
>> +
>> +		if (sib_max > max_perf)
>> +			max_perf = sib_max;
>> +		if (sib_max < min_perf)
>> +			min_perf = sib_max;
>> +	}
>> +
>> +	if (!max_perf || min_perf >= max_perf)
>> +		return;
>> +
>> +	if (!amd_hybrid_cap_enabled) {
>> +		if (!arch_enable_hybrid_capacity_scale())
>> +			return;
> 
> Capacity of a core derived from the fact whether it is classic or
> dense, should not change at runtime and you can do this full setup at
> amd_pstate_init() when the driver loads at boot.
> 
> That way you don't need to rebuild sched domains for mode switch
> since it is done before the sched domains are built.
> 
>> +		amd_hybrid_cap_enabled = true;
>> +		updated = true;
>> +	}
>> +
>> +	if (max_perf != amd_hybrid_max_perf) {
>> +		amd_hybrid_max_perf = max_perf;
>> +		updated = true;
>> +	}
>> +
>> +	for_each_online_cpu(cpu) {
>> +		struct amd_hybrid_cpu_cap info = per_cpu(amd_hybrid_caps, cpu);
>> +		unsigned long prev_cap;
>> +
>> +		if (!info.highest_perf || !info.nominal_perf)
>> +			continue;
>> +
>> +		prev_cap = arch_scale_cpu_capacity(cpu);
>> +		arch_set_cpu_capacity(cpu, info.highest_perf, max_perf,
>> +				      info.highest_perf, info.nominal_perf);
> 
> Nope! Please don't use preferred core rankings for capacity.
> Use amd_get_effective_highest_perf() to get the largest perf
> value use that as a reference.
> 
>> +		topology_set_cpu_scale(cpu, arch_scale_cpu_capacity(cpu));
>> +
>> +		if (arch_scale_cpu_capacity(cpu) != prev_cap)
>> +			updated = true;
>> +	}
>> +
>> +	if (updated)
>> +		schedule_work(&amd_hybrid_cap_work);
>> +}
>> +
>>   static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata;
>> @@ -1130,6 +1244,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> +	amd_pstate_record_hybrid_cap(cpudata);
>>   	amd_pstate_init_prefcore(cpudata);
>>   
>>   	ret = amd_pstate_init_freq(cpudata);
>> @@ -1769,11 +1884,14 @@ static int amd_pstate_register_driver(int mode)
>>   	if (amd_pstate_prefcore)
>>   		sched_set_itmt_support();
>>   
>> +	amd_pstate_sync_hybrid_capacity();
>> +
>>   	return 0;
>>   }
>>   
>>   static int amd_pstate_unregister_driver(int dummy)
>>   {
>> +	cancel_work_sync(&amd_hybrid_cap_work);
>>   	cpufreq_unregister_driver(current_pstate_driver);
>>   	amd_pstate_driver_cleanup();
>>   	return 0;
>> @@ -1985,6 +2103,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>   	if (ret)
>>   		goto free_cpudata1;
>>   
>> +	amd_pstate_record_hybrid_cap(cpudata);
>>   	amd_pstate_init_prefcore(cpudata);
>>   
>>   	ret = amd_pstate_init_freq(cpudata);
>> @@ -2149,6 +2268,8 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>>   		return ret;
>>   
>>   	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
>> +	amd_pstate_record_hybrid_cap(cpudata);
>> +	amd_pstate_sync_hybrid_capacity();
> 
> Apparently boot CPU can now be a dense core which means if someone
> boots with "maxcpus=1" and then decides to online rest of the CPUs
> this bit must go and adjust capaity for rest of the system since
> reference capacity has changed.
> 
> On MSR systems, you cannot find the core characteristics / highest
> perf since it requires reading CPUID / CPPC_CAP MSR of an offline
> core which isn't possible so you must account for it here.
> 
> Sched domain rebuild comes later so just adjusting capacities
> should be enough.
> 
> Also, it all the classic cores go offline, in a system with
> Dense and Low-power core, you'll have to start using the capacity
> of the dense core as reference and adjust accordingly.
> 
>>   	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
>>   }
>>   
> 

