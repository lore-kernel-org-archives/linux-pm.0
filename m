Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626F4FC8D1;
	Wed, 23 Sep 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174197; cv=fail; b=fzhIZWzUicaRtyBi0NbQB7/yGIf0EnONmxxMalID0lOa8PBxw0aMaBjS4Mk9lZg10P3LH8GjGhqrFa7BA6jZ7H0ev+TnQRheeQnFniQQ8qAaOMqgCZ0qoe/WjHr095KKelMuc462mE71g9k3SMY4N6FZRUm0KJLrGB8tH6Cq/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174197; c=relaxed/simple;
	bh=8WphXGxZhRgPOhDiu3H9ot5TLXQEe42usDP8dzbTm9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXVYdB9JxLJfX0g2O4czFORdhbxe1HCTjbUTb5MjpwjRPchkgx0GxFTlUStLWukCPtr5hLvWfvXWPU2gZY2Z0Rpb4LRbZ/iNRdN1rmapLSKreFoqWUc5n32e8Ep7ZR0iVMkDDs3mtl/27LGoJVS0gxHRDcGKQGg5r6KJHt0pk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Whufqq9v; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Whufqq9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGakvalSmFojE0EXpylmj3/9lHk76Bw1aqbfaD9oA7B0OLJ6Qkd92SLC5HJkvJzSyotzEMT+5VyxxUkkrExjv2CPqNz3MuKWmVfBQT2mI82upF1msh8JnepZtOOy+ueOopOJqs4hwdixyhMFDSGhPQVH9hUHpGGqTrX4qUeVokzANlOT/O3qwBKRMVMoirJFWTbtegm5xkj+jMxE6L+4O5yGZ8RxuQZZ1+2MypJWyKBbQy401vftiD1HOWqOVlunAvUdvcpNDFIUfbdqLy6yPAAxS6kc+kK8V72WMiIurvHLV1+eBG/GbN/cpu398HBxI+15uFbS2VIqT1Z5yh18ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo0VqXMxNtF0jTg8TBE0l+zyw+xWvTuR7wofqH78UG8=;
 b=oZYVtaFghrB6gDqEWDGJtsYK6X8YLPsCWa2CQelBdGpc5YUdYMdzcQD63xeP0Mqg+IJNrOAXmCHg08usFlp8/FP+ft4ebEFQDmUcPOXKU+EGuqf+xoRz6rV4j+5iasu7pRZUKVQANMxeuI2vaD4p4SuFqEvh7bzzH+CH1Ghjc4N0zfCQoNPl48wvj7eEajRbw13WXfXmejPy/SS8wPiXe5SXIAy1x+UDaJzzVKjZmdLZws1QocZeKnD9trwEN2oL/Cvx9yaZV3aeAve1viEp/ZBfb568REToWjTfWFvEGsPVWcsjHrVHGaK6nQVQXdhgxYkVKEnrWwTo+5bE35Hitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo0VqXMxNtF0jTg8TBE0l+zyw+xWvTuR7wofqH78UG8=;
 b=Whufqq9vigodFyerht+p9wynSZ7NK+UmDzdUVZSCYU9/s0H91J93JHPfUbJwVE3oqWDXW1lOHOGgJJSs3cRyinG19AvGqTGMqoLKZwZCPEwU0a2owarinLasS9aNUmEEaRyHxQXXWWnt0RJsUYq+XAsvJ9UsT2DrhiYS1TvERpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:36:25 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:36:25 +0000
Message-ID: <55854916-292a-40ae-8421-1a784785d899@amd.com>
Date: Wed, 23 Sep 2026 09:36:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: ad81a958-cbe2-4932-8b06-08df19800b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	1ADQeGjn3P2GeAxSgNXMhrAFOz8PiNOXw7efxUDG4ZQRgXimXj7S57h+tNjGtpHBaZBYZlvp3Sm5Lj4CaXZysuWwa3haokCx3xSXNj0BgnNEkrYS09Ja1xeWanXB0+/xJUG/tjR5vmaz0VyznSJW6vVp81DFYTB6lMh52bjx8gTpJFhiTkJbRspe9Eg69zNViDgYGFbYyNDFw38Bbd59u+qFnTBi+mjOimB/dCfAfeCT1Aao7eb1shizluKOW46AYRgUFkHtCoMJUsI7Gc5nlMRVGmMmDsIIOkSc37WwOg7DbXZbgXoIrEU+BBABc9fTEVP3r1pgOiZkglAj633qjxYu6Hp8jKa/0Hk86eS9w+SMN8vEuPIkUJVTE4DTTq60jQoIjANgAayVpq80HvhLdsfrUsWsciirJjmuH+vt03TwOSU+KZ8ZuNzl8QdH+bsWAdRcVwFRTuHcZJk/FyDpdVtP/v5jJiQ+rRfSHMAxiwrVJLFDtLGjm9euNNuUzPntOXe4BjvG2tf4n+KSdnmOxLNONugTftqin4RdOOBu6bLb4BBl3+jaBefLxAW0uVk6QVx3eom/0MOqY0NdfMY6HV2XNAVaX25qA6OU7iBtJaDDQmD9xHAsDZhL2k7jQP4vmRRNY2InaMsNvm7NMCF2xLacj7yqEGTo160JKVCVNkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjBpUnpzZWpUMENxNmFnQlNObUpiSE1nMWp2SllCUEJydFQxTGV1Q1FrZ2ZD?=
 =?utf-8?B?NTZ3SzUySDNTMGtzc1gxc25pWmQrZllIckIvLzZoeTNtYU54RUQyNml3Sk42?=
 =?utf-8?B?WHZRMnZsYU13SE0zd1ZpcG1lYlhJRExGdVlTQThjVWFkbEZLR2N4cTBQazRJ?=
 =?utf-8?B?QVY1U0JmcFFaa0c1U3ozMUZtbFZwZitueDI1ZkNMMXpROGlHSGlWRXBEcUpD?=
 =?utf-8?B?RW1RS2ovdTVqckxXR3B5WnFMbEFmRGZobzVDMTExcloyVTFkNjU5UkdHM1Ey?=
 =?utf-8?B?cGJBSkQ0MnVTMDJNWkVoaHNhc2FCV21BZkcwZ0hkbENBM0tOOWhpQ0RJdFRv?=
 =?utf-8?B?dEEzcTFrWm9nanhmODBWQWdVUElnV3BLK3JnVzFEZmMyanNYTXJVT0U4TkZ6?=
 =?utf-8?B?Q3ludlVub0FMZUJXTnRJY0NRZE11aklPdFhmZkpRcS9PYTF5aHc2NUhGeVdC?=
 =?utf-8?B?S2Y4TnZXeENkSW1Sa3JLQ3JsNXBpWFprT0gzZjhETTQ2UWhPWjRBZGtXSnND?=
 =?utf-8?B?L2FXY2VpaU1oSEhkVVhEODVCNGpueWxHRVpERlllbHRZc2U0QVovZC9SM3Nz?=
 =?utf-8?B?c285ZTBkc2JZYnNOSDRmaVhRK1B2bFk1UzlXZldKc21RMUVZNDlRSkFnS2dV?=
 =?utf-8?B?WXk2OXp5eFJ5YnpaRTFPOGxzYzB4YUYwREtVMGJJckNkdjlxd0EvdkJXV0Z3?=
 =?utf-8?B?L1R3RmpuV0RYN0tHallQVmdFbzZKY2ZMTkRzWHdFejhia0hUaDl5dlFtTGRT?=
 =?utf-8?B?UWtoZkJHS2QrZjM4alNkNHBqd0tIQ2srNFAzSmluOHhTYWtaMG9xbTc2Zmx4?=
 =?utf-8?B?Y0M1b3YxNGtQN1JmVENJV0pxSVpvbHUzSnYwc25rSW5XMXFwa245QXRGYnNC?=
 =?utf-8?B?SEtOR1gxdE9WdE9QU3F0TzczeWJOcEVKR0l3bURnc1hud1pFQ1R1WGIxZSt6?=
 =?utf-8?B?T2k4enBkekdVWks4Z0JWWVNYZ0t2c1Bvb1hDdVBqU3IvcHJHRFoxckJJSmNs?=
 =?utf-8?B?UmV5T0hodUJ0Ui9nRHNhRzQyUXJkNkt5bXpmemNaWUttTVVvYkhjc0hhWmNi?=
 =?utf-8?B?bkhZZlBuUVpzNEh0OGtGY01FekhvNmdHYVBUR2czS2p4VmFJTGdVelVRUS9W?=
 =?utf-8?B?NVJLUzF6WVdCdit2cmZxN1F5Z1ZTYTM5eW9CR2RHbEFOeDhqQkx6ejRVb0VU?=
 =?utf-8?B?Z3p1SEM0NkVLWjlTMk8rQStXaWdua3hjdUhYekdZcVMwd1hNL21Ib2VLUEt0?=
 =?utf-8?B?MytNbHJRRXlpWjE5NzJBZ0hNaXVwN1ZLUGNWUE8vNVZFTXNzSFJneFhzbXN4?=
 =?utf-8?B?QUJ3Qmp3NlgzSmNydWFyWndTYW96MUxnMWZURkVybWgxNHRNL2tCSzQyUDRa?=
 =?utf-8?B?YlRsZ2VKcUMyMDVxR1UzSVdBMndpcmV5dFJENDdnQVU0bDZPekYxTmxqSU1K?=
 =?utf-8?B?bFM0MDZwQW5TOVBuSVFIRXRQMXZ1RER1a2I5SVJSMWdCNHBwSGdRYS9NTUV5?=
 =?utf-8?B?dTQwUEozekFLYm04TTV4QWJCQmd2WWcyK2ZzY2NvNk1TUm4yb2c2K0d3UWZH?=
 =?utf-8?B?T0l5Z09hbUVCZmJJY0pFSHovZTJJcVVFekF4MVdFWkM1TjdKU1NIbXdvdlVv?=
 =?utf-8?B?UU91end1Snl1dlFCRDdvcDlPOSt1MjA5dzhNa1gvTnpzTEJ5ZXlYb2tzRWd1?=
 =?utf-8?B?YnNiblNBVml5emRWbnhpejdYbFU5MkYzRTNQT2VlaFpucUkvYTVYbHFBckFl?=
 =?utf-8?B?WDBDcWgwNzA1SjZ2citQMm53ck9jR1N3SnhDTEs5VGhOZzl0QmhaSEpjb29l?=
 =?utf-8?B?cTRHbzg5QUdmbXRSNllyRHFhRFpBeEcyaWMyVEh6S0Q4ZUdMR0YweG0rMHZI?=
 =?utf-8?B?dFQxQnV3V3VHcGVJVzQvUWdXVDZCN0o5Q1VzQit1bmxLTU9CR1JjaXZEc1Fz?=
 =?utf-8?B?Q21ucmp3Unc4R29HaGdUazhnOVR4MDNIL0RINDBRb1hlMkJyQzdDdE1xbzMx?=
 =?utf-8?B?czhnbVpTa0FrdGJBUUdZZ3piRDJoRFNNb1h5WFN5bkx3N0xuUi9qZXdHWUJ2?=
 =?utf-8?B?emNOaC9tY3ZGZEt5REg0UE1kclJ3cUthVTZLZlpaZ0phSVlsWmVyWWhCbzZB?=
 =?utf-8?B?K2ZrVzlJSVBDeFBqRzJoMEFXYk9peWptY01tbG01ZEdiL2hEbTlPTFVjZ09r?=
 =?utf-8?B?VTIrWGNmRTk3RWNyZ3Z3MEw5NEtoWXFQaHErTEprQUVEUXAzZEZ2ZTZJcHZu?=
 =?utf-8?B?WGdkWVJ1bnpaL0NKMHJqajd3eXExK01qT3kzTmNWKzhLWXd3WWt5UjhzU0dY?=
 =?utf-8?B?Q2U5SDk4NWJXTWMzUkJUK2dqNnNFYlNqVmpPN0FTTmxqVitYd0h0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad81a958-cbe2-4932-8b06-08df19800b73
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:36:25.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mIEtVt3jUY0z6rXAhIG3Xo0DBF0hCXTN83Dgn3EZrO+FdJ4d3oS/4agjHto9waQyCRGxwdFhyj+c/8zvOgCTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223


> Booting with all 24 CPUs and then offlining cpu16-23 via
> /sys/devices/system/cpu/cpuN/online before suspending does NOT help: the
> machine still never wakes. Only booting with nr_cpus=16 works. The CPUs 
> have to never
> be brought up at all.
> 
> cpu16-23 here are the second SMT thread of the eight Zen5c cores
> (APIC ids 17,19..31). With nr_cpus=16 the kernel brings up every core's
> primary thread plus only the four Zen5 siblings.
> 
> On the amd-s2idle report: I cannot produce one for the failing
> configuration. The machine never resumes, so the script never gets to
> write its output, and there is no pstore to recover it from.
> 
> Or did you mean to generate the report in the working nr_cpus=16 boot ?

If it doesn't work during resume, that's fine to run it with nr_cpus=16; 
I want to see the prerequisites it reports.

> 
> also, I should explain that I am on a sysvinit system with no systemd, 
> so the script's journal-based log collection will not work. Is there a 
> dmesg or logfile fallback, or should I capture the kernel log separately 
> and attach it?

You can capture kernel log separately if the tool can't fetch it.  It 
will try to capture and use 'dmesg' as a fallback but that doesn't work 
on all distros.

Some other thoughts that might be the root cause based on other 
historical issues.

1) Have you changed TPM policy or Pluton policy in BIOS setup?  What did 
you change it from and to.
2) Have you enabled a storage security password?  If you disable it does 
it help this issue?
3) Do you have WWAN in your device?  If you disable it does it help?
4) Does booting with `amd_iommu=off` help?
