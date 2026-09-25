Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAF4A262F;
	Fri, 25 Sep 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343055; cv=fail; b=oT2ogCpL2nBgck3MUCrHQ8Jnp6tf/2LZhnlQtcZCGXa+3BbZbQXJmWJMyPBZdJINU9RIlMpUkDjk22aBwA4jDGcN8YwFkh9uc9rySt3R1f6FUiINDiYjyZ7L1FjIT68cdpm6ypAAra5l0FSGmHVdDpQNx+8cAJtTtTcugf1H+ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343055; c=relaxed/simple;
	bh=l4pa2k2Xv53SOCh2sXxg+sy4okzt/pF2DJa3AB3AOyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+AFXPhFfqZvlc/9x2JUiACD0/1HR0VsHX6KatrLqzaL8gujd+YlE/IZRVJH9cMu8wI4ejt2Zp9mXqg2DNANe9fEs9k3kWESoq4+Z2x6Ck+thkmTrgoi7WRXFbCyLi7iJrDUWhd8R6IJuSmyOiqeViNTOu2I9kcmLpjWWq3bj1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q7ROoENz; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q7ROoENz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiWjt+8llc1078hr6pZlnkyrYgle3XJ1TzfbXqdFoD2FQAR2bqCykdF17obfoiWapBbbP7E6P3gVpK29l4ua8VYW+KWRqEKg76TzrSdVfwbmYvG+nHdRdwF/T7ufwB4Au5Ai447D0CW+Xnej3/GaEpqk0oHFDB6D5QCSqAvvkdsUezMnYUyeQPBBRgYe2m+C1jmO238QHQmjphwGW7bFZPIHsG4FH0LQfdVMJ0ftCdxZByIn214Fzdmv0FRB+vdB8mjOKBGEW1iXGgQqrsseSCIM0fTjfHeVBQxyihLYw0u35GPibkJjDIaVBM5v3/jV1nd+cmi+lkDRBJYTltofXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIok69anpBg4QWpUnek+BCocRcrkejdSBli9usgJKoA=;
 b=gcJox41HXxE6ZiRHRQXCX8tIKLLy2omZwUwhFXozflBrPoOI7LmYm88lITb9EqRtrIGJsdxvOKRAHWKAw3bYz1hGfOf9zAUKNaKpsyPSb1bHOKhihLqNdrMSEbnh8zaVxLoug7YbvxjuD1B5bBnd6resAfWShkNbDezHUzJYHjLeq2fgnIOO5U424xbII7M1Db82j966UCTPacUOTlZ5dJyc1EQsf+61m+CVt4OcyhWln4wxV2kMwZw8cMc1JK1yik+Nrsl3K6Jo3schltpzA8B7LW6Njyb74AiN9bcm/34Sl8otk5N5TGOvNdRNs4Xl46/HBbl14aJbbyrsk4QbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIok69anpBg4QWpUnek+BCocRcrkejdSBli9usgJKoA=;
 b=q7ROoENzJBNTPMwPHbrNt5n2a7hxcTVCXXwS/1hO+c3/XBBhrPOtMuEgF/r5nu3xbW5yxtNrWIkl9KjMdDGQHQ5v7acxtpeB6cr+u59mtvOq350TrMwhyS9qtyiRznz0i+jyEliamemUwjrFgz6JNpv/TVtLPjgnxPrYPgQ09Wo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:30:50 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:30:47 +0000
Message-ID: <b2e13400-d1b7-4a9f-b7bc-a2d1dc7a4912@amd.com>
Date: Fri, 25 Sep 2026 08:30:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
 <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
 <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
 <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
 <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me>
 <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
 <3a080b50-6396-bf8f-2e70-011b85c15fe2@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3a080b50-6396-bf8f-2e70-011b85c15fe2@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:610:5b::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e97b33c-26ee-4013-713a-08df1b09356a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|10067099003|56012099006|6133799003|11063799006|18002099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	HpSqO6sYfQRQo+lzKtFSimKPa8dpj08HlKpYhx02f/HOErHb7WT9iJo5Amn9/R2nmr47fHspP5Zc9Xs23xpRUv4zVU2NcCfvbm2N4/WtbyiVzyhUs09oofzlqhjJrBEKU+BrnfVm8vulkQSM21OZequKrDxKZD45PiVr9dqTVnUfKRerhYsQfyt+WfQUOuGHuKSiZd7pGyxcEqFBwbta5lYIShuGGldNw9NOa8L10PM2agnY8kQ+XmbQfiO5/5sVOA3eVkpQswrBT4WZp+3Z2NDUdzVueAdNBdUoiswWmr62nyjngiYBtC9clvY2ylRDnZz9Tr2iUMJBvM61iIwN8mpORCXHAx3z7+H/FmfIWuW/J4ai5TFAfI+Q8ht/h0ucVupeo+CasRls7rBCR23US0ZDSUW5Ad9r1dNaH+sLa//3Ly9Fvock/xYhxdrlv2D9chqCVUANr6YIpwDh8aw8F/Z2YZjcAqpU19J0vmv76bWB1R7H/+OWl/EYvF69aEFjPw9rnaRMRJe3DdcDOoL7aqiEQyj+R1bCrM9lMlTNIrl27UReuxejsgqMnKmxhDYkkze3kuj1PQNmBgB0XXiOPbWfWA6WWRwjQU0FWXBOlJHlThHiAD3KjqolpXF4wofBUKZ/lfzuB5Hjxw1Xy/86vyKXfJkFw5GTRMUR3QMjskU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJ4RnpPbmxRZlNnS2s4bXFkTWJUZms1enQ5dGFwa3FvOGxHZlhxWk9yMUdH?=
 =?utf-8?B?Y1psb0ZjbVp6Y3BpK09ZbndaL0Z6YkhncjgvNzk3Ylhiei9ySzMyS2lFQStM?=
 =?utf-8?B?NFFCWWhvR1R6Z3ZaWGtwNWNWUDJaNGtxWU8wNlhXeTQ4cGk3Q2ZvMHYwY3dF?=
 =?utf-8?B?c3FhdVFoZURQQ3lLRnBUSkxOV01JblZGV0lTVGptRFNza0pqczR6WlBKenZs?=
 =?utf-8?B?MEZzNEtKRmlJR1lodkIvTXJqaDFqOTlEZHVSTk1LdzRDa01nUU9BMzJMWS9I?=
 =?utf-8?B?YTF5N0tqbTJGMzRjRzdxbGVVb1pFeGZWSzZDSGQxdFd5bG41RFdpTzJ5K2Nu?=
 =?utf-8?B?bjUrdEpwNVVpS0FGbFVaSzJMaWx3aDlObUVJY2YyaVpNazJBbjJnZXJXcDE4?=
 =?utf-8?B?Qkw2bGNZNTcvV21VYTJ3emRhZnlJTndMRHRESGxrT2VLbXBzZGVKQmdKbXgw?=
 =?utf-8?B?NHlncmFzeTVqUWJFTXZrdTI3NHR1bkV4QkFCRHA0eWNWVlRBSDllOXBMZ2pX?=
 =?utf-8?B?R2Z4bFYwdFZNT3NNSStoYnNGeWdEUTRidHFoQXNvT0p2U1A2dkx4aW1ZbENv?=
 =?utf-8?B?SitBNWlXUDJxNVg5U0RXWEVrd29wV01HcnBwL04xbERIazBjcFV5WGNEMzJX?=
 =?utf-8?B?ZWtHVXVVK1NOQ1c0LzBRdCtaVUJxcllvTG1sR3Z0R0lmWFBKbVhKUHZja2Js?=
 =?utf-8?B?WEtubEhWQlVrbHA0a0V6QXV3RUptb3BBKzR1eGV3ZGR5RjAxckdaRUJFSG5T?=
 =?utf-8?B?QjlLb3Jhd1JnNkFJWlJadGFNa0VFemdGbzZnR0t4UkVwOVdFWGsxbkpPN244?=
 =?utf-8?B?RHN1bVA2T1FCVkh6Qm1oNGxLR3JKQVd5THROUjF2OGVCcC82M1hkUVBPZWlt?=
 =?utf-8?B?K1lhZGVSU2pUT1ZYL09oSExSekJ6OVROSGx2ZjRDMnZpTjd2QVJZQVYrYjdK?=
 =?utf-8?B?aGNiZ29DVXlneXF6SUJPaWt3eEtVVVFuejdMelJlLytKZGdWaFdjYzAwUkMx?=
 =?utf-8?B?U01RVVlQUW1xTmV0TitCcWxwQmdnNzhETFZvR0orT3dGN3RGWCtBUm9sNU5j?=
 =?utf-8?B?RXpEcDZqQm9mVzdrY003QlRFeXkySUxUYUhpZjFFZ0RySmllU3RGRFRyR2NB?=
 =?utf-8?B?ZlR0dnF4dXBScDNWamFYbnBJYVlyYmRMN0tKYmh6TkxPOGo1Q3BDOHNlVDZW?=
 =?utf-8?B?OTc0SGZON0w1dElaekd2WFJrVDVwbVN6RWQzczYyMHh2TzFZMSs3N2JNQTdM?=
 =?utf-8?B?MXVyMjVCNVdhcUNqMFFjdzE3VjZNNXBWcWhZWmVOcDdQMzJ1elQ1Y2gvdkY2?=
 =?utf-8?B?b1dDSkpJVHcrSGJ3MSttWlNzcWV3RDB0RnN2WVdjZ0lSWk45TVFzSDJYSnVZ?=
 =?utf-8?B?cWdyc2E5MjJDcjZob0duTzQ1L29nWnRIYkF1dlVuM1VlRlYzTWtqRVl5M2gr?=
 =?utf-8?B?SG1NQkFndmFEUEtrb1NhMEJod1U1UTRqYnAvVWs5Y0VZNUd5Y0FMajFZM0FP?=
 =?utf-8?B?am1sSE91SHJJZUVUZ1dGMndIamlnZ0VHNDVSVm5GbCtxQW1nd0VLa1czQ3pZ?=
 =?utf-8?B?Wm5wbU1rNkF4Z0paVXd4OGNGcVY4b0RqaFFrV2JEN2N3elVKSkFOTmdqbEJx?=
 =?utf-8?B?OVNyczh4YmZSSTVpUWtHNzB0NkQyaWhobVE0R2NaZDBMOUNLVGgwMjQrR1cz?=
 =?utf-8?B?WW9OWWlBQkZPbksrdEVrZnVRblBqYXFOYjR2U3BLMGI4T1ZVU2E3QU9WQjc1?=
 =?utf-8?B?NFc4OExSMkU3MGpWMnpsNk9iTzY0RlFhL3ZPaHppQndXUTVnNlJWUjZmVGx1?=
 =?utf-8?B?Yk1LOE5HOVJXNmMrMUljTS93ZUI5TEJKVGxRa1NJdTJCTmJueWliNGpmc3Zl?=
 =?utf-8?B?TmFtdEtsZXo1ZnhweVNkcERPN2ZDUHZWSVdQVytRVlA0N2dNMSt6eS9lMENX?=
 =?utf-8?B?VkZzczJoVGxCQ0ZRano5T2ZMeHhZdXE1OVphUXRyN0g5WGd2T0hiN20xNDNq?=
 =?utf-8?B?VnlEaENUdmlYTjJHL1RNaDNBaDMxcjl6MlhWTzk0LzcvR2w2YW1wUkxsVU92?=
 =?utf-8?B?UHBIUWxmZGsvdzI3SS8xeDdtRzhXNTFLVUw3WlRqWmI2cHdvVmhweVdZMG1V?=
 =?utf-8?B?YWJCWVBDMHBvUGp6SS8xSU9mSjdDY2FBODU4RkFVK2FLWklpcitId2p6RlFn?=
 =?utf-8?B?eThtd3Q5Z2xqbWZ3Z0liMVdna2xPSncxMzFPQWJZN1ErS29wNERWaVJDenFY?=
 =?utf-8?B?L3J6ZVFvNHRVVHZsUHhzYUVuMkk4dkJuNTRDSjhiSlVMM0ozbVA5YzhNNk5W?=
 =?utf-8?B?U0drUUU1RUZMdG9idGhBYzBiYXVXbWZQK21DOTE5WEZmb2NWb2tsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e97b33c-26ee-4013-713a-08df1b09356a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:30:47.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edXxHv4IY+AJUdHkPG9ncCovC6C13+0WHskUzokM1IKJXRbcPUoj+WMP+ImdMiQiejXGCrCqdLBwytyihjb6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425



On 9/25/26 02:05, Fourhundred Thecat wrote:
> resolved by resetting BIOS to factory defaults
> 
> after that, I tried painstakingly to enable/disable one by one
> 
> The cause is two BIOS settings, and the reason it took so long to find 
> is that they are independently sufficient:
> 
>    AmdVt (AMD virtualization)        Disable  -> breaks s2idle wake
>    PlutonSecurityProcessor           Disable  -> breaks s2idle wake
> 
> Either one alone is enough. Both must be enabled for the machine to 
> resume. The full matrix, all with the IOMMU enabled and 24 CPUs online:
> 
>    AmdVt      Pluton     result
>    Enable     Disable    no wake
>    Disable    Enable     no wake
>    Disable    Disable    no wake
>    Enable     Enable     wakes normally
> 
> I had both disabled.
> It also explains the confusing bisect: when I tested AmdVt=Enable with 
> everything else at my settings it still hung, and when I tested 
> Pluton=Enable with everything else at my settings it still hung, so I 
> eliminated both. Each test only showed the setting was not necessary; 
> neither showed it was not sufficient. With two independent triggers 
> those observations are both true at once and single-setting elimination 
> gives nothing.
> 
> So amd_iommu=off and nr_cpus=16 were both masking this rather than 
> telling us anything about the kernel.

Well this is a great outcome.  Would you mind opening a pull request to 
amd-debug-tools and adding a case to this to test for this issue?  That 
would help anyone else that encounters this in the future and save us 
effort drilling down again.

You should be able to add a new check that verified the value of these 
BIOS settings using the think-lmi driver sysfs interface.
My thought on the logic would be something like this:

1) Check whether think-lmi directory exists, skip the check if it doesn't.
2) Check whether both of those attributes exist.  If they don't, skip 
the check.
3) Check the values of both of those attributes.  If there is a failure 
report it.  If it's a pass report it.

It can generally apply to all Lenovo systems that offer these settings 
then (It's more likely a "generic" BIOS bug).

> 
> this is clearly a Lenovo BIOS bug. should this be reported to them ?

Before you report this to them, can you diff some acpidumps from the two 
changes that break things?

I would have "expected" that turning off this AmdVt BIOS option stopped 
the IVRS table from being created, but that seems not to be the case.

I just wonder if we should be keying off anything else in Linux for this 
case to avoid the issue.
