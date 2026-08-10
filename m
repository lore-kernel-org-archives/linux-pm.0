Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0D366045;
	Mon, 10 Aug 2026 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392433; cv=fail; b=JWEfrmx5e2haDkM4BmpPlVW577gK+QCZYsL3X5QRmzKgRsM/HEPFLoxZKrhMHEWQTj7yY/gJoZBnmwa/qYPF/v3wbFbSU7DG153w8MrAiMl7Ni4Qmez9uaFwZ8oB2UEQYQrVYUOAj95UEmUgCxxLadx6B07030XEhdv89mYDl6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392433; c=relaxed/simple;
	bh=CdU1naoIvXWZ6xxfTfQaHIyfSasS8Iw+xoXnnmdF1yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzK7ILlsJQeVLzVipUd77C5M1n4vU1MZ2QUQqxDgjn4aauekyn7HVlZ2ioP/8zc0NoMV80doY0t6a1XjyXZonVtBCJqPm5dv28qdhFbMWbdSS9D/eeEehRnEDYVplp7T2ChX+MHKyTvbhPJtCZAf9BZJQWVFpIEElEIoRbeXQDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZ8FySff; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZ8FySff"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAAuwPGdAu/ZUcCFry6iynmpm7c72bI9kkaLeXkRhD0He4ltcDgb95jPgA8uGydujCUL72zWxWStG1Wj7lZKjvLka3aKmOgX+DObhgBmGle/J/nCuDiDokDTgRh7+/p8Bxk6MhtU/0fJeIdpTab5lec4cPJWiCEc9lNRorxPNqCE9CNaR2HsS9pZibUpLXVq13GMcGJoZY9q+DPNQ9aFT/Z5uYgFAunOGUGMfbsbYw42dBf2mDcUKakMiGmU567ynSJG8VehsdIk8jASLts5W7Ad/46Um9LXisdG7kO8wRO42sPMZkSEX/qjHEW6iXOgqP/ZSQx/Jw+Ob+aRwecmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ALgK0lmPByIlQgCKE3Au8/TlOdwOCmPWBWHtM/bi4=;
 b=J4gvW/BvPE3G0saPXI5NNqHL0lgUzPe5ZcKkhW9ISWm5xWD2iVRriLAuQJHVMDAh8/dhdq06kjphg+7UqdZybpgJyDJMHycmdhlSPMyN8B/ITIPgN6T91p0OCUmi+rkN1ajaIx0s2Df6bMUf42pbpARaUJvt8bepiE/ZNR5Hm/gTz62WjAvrhEQH4kFq0VOyBIPQ1sYjNQ7WVOeubUt+1oxDhwwjGZuRxXkOkc00mwigw/Nr4IZB0gH9N6w4EL1ESMtDm9cRdS+1tVJ2QnU6HmPOphr+Eg2qVT0BuMJHE5hk1S3tHGSfIMS5bErYwQ31TIFZuTTY+HUyWRJOVt/Nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ALgK0lmPByIlQgCKE3Au8/TlOdwOCmPWBWHtM/bi4=;
 b=FZ8FySffmtWJmUqsubl1M/ykYfhZIoHJbg5vJ7Kgo0pj1SokLFkwF2+uRKkEjgL5LRA+7EFnZHFjAd6ltM0qNmLfWhQNyd2wpoEB2bSMop7BKDLnspnyYOQXSNgpsvQGeKTOEPJQTPgNdLfSHIyNB0HmbB/8u0+r0XmdSSJHwXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 20:07:08 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 20:07:08 +0000
Message-ID: <f4ec6830-6d7e-47a0-8839-f7e50c8bcce9@amd.com>
Date: Mon, 10 Aug 2026 15:07:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Content-Language: en-US
To: Sean Rhodes <sean@starlabs.systems>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CABtds-1wb1zt4cP9jrUhivRZKEqG6Geq5XtK4j3R4hr-6nMkfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb72a9f-fa58-4695-f7d7-08def71af4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	zJlJLlIrNEA/FWGqrexyNgIlbM0hsw7wQ/inRd8xQ01hQhCYdLMSEw6hS5opb1dcsqGDXJkL/kAmhp82DCi6K5/HphePqoCAQh5xX0Wo1yzepiYyb7aANESvA1RwfqYhnkha/DJzBhJekPMtbd81h7WhDO7RaxCIrIe6xbOeK0xqWjTVCSnZRX6MtKWRwx+AxcC8pZrW7Bv+xkihqhtGqz6MTVU/fxzjT6sVzoGto581Ax+GGZKudTsYSt7eiya+mnPicLhrBafZhQnHsN5TWFrFqznXtZbivlYQpHdg3xu+gd70g4peWk+sMZiTbNcKl04cI1lKA/3+DBrvH92YwLCzP/JjOTlufqnjWBYKxvKj2G/RdOwslUry49ms9wtnkwRw9d6u/u3+zqURgn/fmHdnVEgVZoUckn7GZ7k37eIeLsa8LnhMguHvj0q03tFSKtY+TLJQlKPf8zyI86e7qKpiMBbJJ+GShLQlb76+pk/+Y8ottOaVya+csg62yy/9CqPuvJuGsq/FKuaeqN1BR3iR8NFr3BzI+04dHZUFnMMVl0ZsX/426yRXmUty1p8FZszSz1uH490F3pBG0sJuvm9GPkKjoDRsoX6ZtaV2MuoHfNLXlXjl/yyKwa1z0EAzP56grqx+LWKRBGBwVmfR7UnIGEAelDBOWYpfv4WRV+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHo5M2VUd0piTDFvS2pKbXBXMDRnTlFuVldIMFN4blNvRVNsSDVpRUREQjJU?=
 =?utf-8?B?ZFZUT0NuN3I1KzZMbllNd2dCTG5VamE5VHpNR2VCN0ZMbkdVYVIyUkIrZVJY?=
 =?utf-8?B?WlM3U1BQRnRMbjFYMXlBR3RUR3BVSkxYMWZHWXNhc0VzSWt4djI3S3VJa1VN?=
 =?utf-8?B?ak9Ha2hQUzk2Q0VybUd2WTJrcmN1RFJSdHZFUnpST2RsazhZRGxqbmNyQmM5?=
 =?utf-8?B?azAzakJIWE5Rd1B4ZGk2SFZJRGp4UnNoejh1eXRsdEtrR2d0d3lScTZXT2pF?=
 =?utf-8?B?bGY1ZnJOTFVQeWUzMmJCbUxoOTRzcmNIMElwVkMrbzNUMnFIV0p3NUlrQmpn?=
 =?utf-8?B?VE8vSGhrdk1SUWhHOGN1aTF1em4xTWRHMG9HOU1oQ1lINnhEZUNxRGFLUnpR?=
 =?utf-8?B?NndmYjY4cERZNlhoakFMbXRmT3VlelhrS2EwdnJJQ2ZPYVNGdXhTRnZlZWFn?=
 =?utf-8?B?bGJvdzB1WjJKUEZVaW5pdzNQYi9jUW9IazZXWFNiY3dBOW0xak9mblRGaVBR?=
 =?utf-8?B?R1hBVVBHWU5jb1hqWmU4dm1rQUkyMlFHanlWN2JqUFdwYVlLYVlyM1BkRWFI?=
 =?utf-8?B?bUdDSEZaTDF2Mi83bUxlcFBNdjk5UDBmbm1IQUNTaGNYbk5VU3pXcGNzWkdD?=
 =?utf-8?B?cG1IbWtQU20rZC8vdDVvdjVWZzRlRS9HVTZpRVVlUFlHZWtHU1dCWWE5VkJp?=
 =?utf-8?B?ZytwWkw1a0hZSnBSOE4vV1RtaU5MNmVJOVVYWktLdFd0ejlWU1lodXNRQmFI?=
 =?utf-8?B?c3VSQUh1VUIrSG5rYkNxUzNFVXU3TUVBQTNDREt2eGFVNVJoTHBBSXFRcFQv?=
 =?utf-8?B?VHdSZ3hNZFBGblQxdmhNNGFQUHBXaXF4Y01RcHhTTzFtUEhaQkVRTnNFeGlj?=
 =?utf-8?B?elpxN2pjdlpBd2JFTlgyVXV5Rjl0Y0c0TVdqTkNoZUMySklvNlZrOS9tb3Y5?=
 =?utf-8?B?RW5zdUNycTB1WjNLdVd4QVBKakVURFZablVBTGFXbFBUZU43NEdFTG1nTWRh?=
 =?utf-8?B?RW1WR1l1TjA5U2kyQ1MrWkpxWDZkbUlkeXV4S25UMXRiYlJaZFpJaWh6elpa?=
 =?utf-8?B?T1VwRGVibW1MeUtRR1RwbWN6TVJsSkZ4U3ZyeWh2TWpnOWo4eitMK0hJY1lS?=
 =?utf-8?B?NUFhQ08rR1RycHJuUjRLaDV4V3AvZzRrV0lFN3dvcE9LTU1VV1AvdnYwY2k5?=
 =?utf-8?B?MnpZYzEzaW5SaG5xd0gyUG1oNU9FSjhlekJudjVxZkFnTTVmaVhuNmpocjc3?=
 =?utf-8?B?RWk1bFZYdDhzY05VVXRYQjRvMFVNSTJKcjZ0WTk0b2hlaE5YTVA4WjFXRGpn?=
 =?utf-8?B?VXpCRlU4MzFOcHNNMzRJK2ludTlwclVaN01CNzdROU1MY1ZtWndUMnlEVklY?=
 =?utf-8?B?ZVNVcUlKYUc2OGQrS3VCYlRHeGd6N2QwMVlxMXVoUmtOOTZSN3E2T3NBSlNh?=
 =?utf-8?B?UGpOWnl5Z2tQSWhEMEQ2T3lSejFUYzE0ZXRRck9ERVZqbkR0WlM0SGJoSW9h?=
 =?utf-8?B?dnpyUndpZ0J4OFJSWEl1bHgwK1VORE11RHNtME5ZUEFSUkRUVGxkUVlZbG0v?=
 =?utf-8?B?bmptNGlQbUtRb1U0dVpZWWxCU0Rkek1jYVg4c1hDS1NRZDhUNndWWWp4U3V2?=
 =?utf-8?B?NHFuMmhPRTdMeFFvNkVmZ0xtQ2hVcC9nN283Qk5EYkJmNW9RYXhPQVJKNTBW?=
 =?utf-8?B?VGJCaXFsMDY5VW9ra2NOc09BaVZ0N29OS01YUGg0Q2dWNEFUMHRmWm5idlJi?=
 =?utf-8?B?cmFqN3NPdXJqQmFPTFZzeWhHQVB6VVhDNUZYeTl6N0lZRVE4cnduaUluV3ZJ?=
 =?utf-8?B?Nm9sKzcxeFdnQTdselJ1UElGY25NNnFScWtad0hacHJ4bEVDYW1BdkZ6aEZ0?=
 =?utf-8?B?MlFMbWF1QkFnSk9yYXlrWlNDTXU1MDY1Y2xKNjlaZnFXZHB0Sk9DWjdiZGFN?=
 =?utf-8?B?TlIxMnAxbEF1WlpZY1dpZmlRQnlMM1FSeldJRWg3L3RBcXBIUkRSOTVkeS9a?=
 =?utf-8?B?Uzd1bzJqVGloc2paTkxnbEQyb1E1OXRIOWs5UGVIVGNmUmJ1WHZVSk5DQVdx?=
 =?utf-8?B?UTRKTnFHem1IRUVlczFDc094MW05SmRQUG90bS93cUo5aWFQaVE2Wlh3RFRz?=
 =?utf-8?B?T25DdGYwV2N5YldNdnZVcWFnWXd3Tk94TmdIQnhnaXhpTXdkQnErSEQyS0g3?=
 =?utf-8?B?VE42d3lSZmJkR0ZKM3B2SFNpSFVNeTJwV0VSamsrT2xMdzBWa0EvVndBVHRT?=
 =?utf-8?B?T2d5TXdpbmYrQW5hWjJJOWNqM2gvK254Y1Z6bmIva3BqMGdIOUFTRkdWMGpr?=
 =?utf-8?Q?cPvBumOmHwZ6UrzmpM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb72a9f-fa58-4695-f7d7-08def71af4a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 20:07:08.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLmbYX29jzdShRMMJBlyl0UGlPzASmfV/A18SjdLwjaT44P4B+SW5ytH9S7WMR+96g0HPiMC9DQtQ1BgZGJNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529



On 8/10/26 14:42, Sean Rhodes wrote:
> On Mon, 10 Aug 2026 at 19:31, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 8/5/26 20:29, Borislav Petkov wrote:
>>> On Tue, Aug 04, 2026 at 08:22:36PM +0100, Sean Rhodes wrote:
>>>> If you're saying that because there might be a firmware solution, I am
>>>> all ears, but this issue is present with AMI CRB and coreboot+FSP -
>>>> hit a wall trying to fix it there.
>>>
>>
>> Does this only happen in coreboot + FSP?  Or it also happens in latest UEFI?
> 
> Also UEFI

Can you confirm the version you tested?  Is it the latest one?

> 
>>
>> Does it only happen in S3 or also S0i3?
>> How about S4?
> 
> Only S3

OK if it's only S3 it's unlikely that this problem exists on the newer 
systems.  They have switched to only supporting S0i3.

I think you should narrow down your proposed quirk to the single 
affected processor.

> 
>>
>>> I'm making sure you're using the latest one which might potentially have
>>> a fix...
>>>
>>>> Why not?
>>>
>>> Because we're not fixing three things with one patch and without a proper
>>> justification for the other two.
>>>
>>
>> I would expect the restore of this register to be the platform
>> firmware's responsibility.
>>
>> I don't know right now if this a BIOS bug, an suspend/resume bug, or how
>> wide of an impact it is.
>>
>> Your fix might make sense for "this single platform", but we don't have
>> any evidence it's needed for any other one just yet.
>>
>> We shouldn't make changes because there "might" be a problem.  We need
>> affirmation from testing or an assertion from the BIOS team.
> 
> Ack

