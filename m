Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EE38F624;
	Fri, 24 Jul 2026 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920064; cv=fail; b=Dvf1sMSLiHzleBEHpodwveF8N9FB6HUoKZhX03U3zRQHVRz2tURapqBykiu+ukv87LeI80Kztyt4DefQSS9FUZAkmlMbY19VbNCZTw7HxiiclHquWpPRBXpy8YSJgWsEwPcNhERmRRY5Nw+wjbSGeBNT17WjpKS3SIPbCbKE390=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920064; c=relaxed/simple;
	bh=pIb8Ffak78fnvQEipda7E0LT1kkSsjRRCozjm4G3ffI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5/36DjnlVcml9dyoR5l5MD/2739XwUqNXVxw4NGVuCFuYGbjF08HB3xLPYhHXicCAdC0U3bAq6YY8ocUUYhWHsCHMKRKuijgmnS3eSvRqO4UkTV/oeS6P+Hn/oJ/m+/MZXOxzsZiBCOAJ6Z5lWQZsfPA5WM1eyMiOVfvM06z1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DfUoILZW; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DfUoILZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDhm1c7NYcVO2kFszvqrzvezZQCyhyVXUwo5YDKxOO+NBSQ5i6j7m1mjNTZvzgRpLa0OQxLqE2aVflqYVJN+Uck8BfZUlhzypxWx36f03uvizoLTpxCcVHBMlCs39dWu6SQ1W11/0wNmVoyIfaffWnAXB1Ja+C18IhcW4vwPsKjfWrTEAEAGOiG/yfT5AFf7x7rDNuYt0laZwY7AR+mu358v2IwwOdJ80RdV9Gylhj5FIWvyW2Q59Z+ERmPBtQ0tgtsmG0Mhgf1mYDCGXug+bu7TJHu55sw1Xar9pmL9Bb06HhyyT8Y5zusMUe5/VMXNWUyPO/YLhZb0v7iuQUjtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3Cp7z6LU1vLerRWwtLZ6wsQDVVHfWB33l90G2Qsy+k=;
 b=dqDOtO7DIZxqC4K3CXN4D3Ss/ktQ0sIyVye2ckAHR2pGZnm2jojNS5rbPVIj/V4FIHGLPTAUhZAUW7XCmBrh66wAVlIb/G+ZZK3y5WUiGDmSiItA/0fOsRBYiX9SZ2UpgYIRa0u0rC//QqpNpaE+dvvYIMFo6Rtcr7mRe7bmctyufL8ucZECkWwIaPybEcXl1ie3uQPBhN9qmYUrRFWQKEIqqrY5yu12uCsrzFK1+sDrACwmpaky+nbOPopHG/eYwZTuSahwNKUl/y50ILVlpLCr03Ux5vEsW4SkYlBwkFG0MPzo+gzrXGrKz2/Rkz3eAjGT3IEme3TPHTKIKYMtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3Cp7z6LU1vLerRWwtLZ6wsQDVVHfWB33l90G2Qsy+k=;
 b=DfUoILZWdOhcM31HY7VQ1MmsrdFjRGYpXd59U3pVlc/PtcCXUoetpyVoLj60mY+wiosJmuusrbXxzoiVMni/uE74IVt1qyQxMr33Z56hL4id7ryGNxNAcYczzot9lgAXEIgjfQEMT8HPGkILbLkhBygGYQ9X3nzEXKdxhGA0ArY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:07:38 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 19:07:38 +0000
Message-ID: <a841ceef-8d94-4134-9c04-a96cc4f4cdd2@amd.com>
Date: Fri, 24 Jul 2026 14:07:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] cpufreq/amd-pstate: BIOS min perf fixes and
 Dynamic EPP rework
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Kalpana Shetty <kalpana.shetty@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 70010918-c705-4a3c-cda8-08dee9b6d401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0xkxPKBiJEDhoSLPHUjL+SKDSJ3b5FrCLgnszNsVYmS8BBPelWTYcinrbcIk+ISj0pTUORtfNTeQRz0LLPOux/Rr8x9nU0Z8orlJFqPMK5SgRiSv6xRON9IkznK/MEHJlKn8UYdqiHwTYp8nYF0fv4XG+MZRVSatJKDKSI3D2y4bPu1puTxVyg8RKu0aRLwen1JL4pY2REXNEwRr9RSJjTRdVpldTAOtIX9/lsqwwUVDcAerYh0XY9RRJENj6tj7dlZdSjPPMakiNeREHLwAlfFrL840Ke4Td2FtmwXUgv04vp7f343ItoaH0EfHBp7k22iONQmtdiqgTBoruw0X8D34/H0QzvaPaeUDX2el96cQnkFO9irgeeFcRKzO5S6U/+6V4FkB6sPVpSq4turHaBAMyMcwooktu59z65hWP+/ELAIFGisdHpzgLFJy0fZOwqtPF6v1MTuh3+bBQCyo52FGWSKDbqIWoarLHQAtLe6SN7+/DsfQ5oIc0HWPn5/KkdV3yK6XysDDpeBlJV9rvdm6W5KwyzFQxjXg/axTV/aKQWInoEiLKovayxpsxZsJ/NJ7hWwEDAZdmUtyPenN9f26GN7Qf+qUUPBzCiG1qnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRJMUFHVUNtNDZieURZNWFQUnpiT1BIN3N5K3duTVVseGRabWFiejhEcDds?=
 =?utf-8?B?MFJ2MWpYWHFvU3FXRmZVelVYcHM2enQ1OGFVZ3g4V0tUV3FwMWNSNHZLeHQ3?=
 =?utf-8?B?TFAvei8vSUZwb2x5KzJiUTMrNWJFM3V2V2xaZTA0b3VTU3hoZy9FTWpkeXBw?=
 =?utf-8?B?WTU3Y3I0dnZueStGNkllcUxiUWF1aTl5RkdDd29tK25aN0R0dFVvb3g1RXlL?=
 =?utf-8?B?K2xRaHdxVFJOajRzQlMzK3RGOThSQncxZmMzTmkzTlN6U2lxZlRqeXVWbmU4?=
 =?utf-8?B?MHREaS9iWHAvQWFya3psN0V6QkpVMGhRa1VpQ281ZWROVW9JS3ROSVg4bXZv?=
 =?utf-8?B?SUVKNHN6QXZvQ3puN1JCSHRQcFBlR0J6RWR5cTQxTmVNU2p2SmNnTGFDRzhp?=
 =?utf-8?B?bEZySmhvdlpNN012QjJ2V1hIV2duWDg4cE03a2lRUENObm1OQ25lQWxJT0JT?=
 =?utf-8?B?VTRuU0dJVDgrZlVCai9Sa1FQMHZQQnNLdVJJNlpLd2FiTitVemY3OWtuT25Y?=
 =?utf-8?B?dzdEL2ZQc2IvaUNneHJqODVEYzIwMEZqbTRHcWwrTDZWQ2F1c05nSHBsdjh5?=
 =?utf-8?B?VVU4ekZzUnJ4bjN4cytzWVFveFEyWUVmUUMyL1RNdmhGN25ha2xHejNvZVlj?=
 =?utf-8?B?ZWhSVnhmdVBWQXREMjlPM3JTVVljRkJZeHl3NTBXcWVoVHRpZ3NmcEtaZHZY?=
 =?utf-8?B?WXZod1RDM3NGblUrZExtRW1ZZ3FZOWhsWllUcUtPQzE4UTZEUGQwd1ZKcjUv?=
 =?utf-8?B?MXNNV0c3eEtwdldLTDg4N1hzVkZmZEJxWDltUExPNDB1LzJHdjZmdmdYRFBU?=
 =?utf-8?B?YzFMVHpzd0ZzOXR3TExtUHErSHJZdFpLSGtXVDhEOUJhR0lRM3FWQ0xCZWRS?=
 =?utf-8?B?NFg2SGF2SVhnSTZxSWwrdE5zZ2RqWHkyY2djSGY0dlQ4VHlmaGJSWTNiUFlB?=
 =?utf-8?B?WnRBSVk4ZVlLVlNMS1BZaFpsakpiWWp2ZWlLNEY0dEh6Wkp2NmxtZ3NQVHVH?=
 =?utf-8?B?SEdCN0lZZmQ0SzRyK3JwWjJzb3R4amJrWUZSUUFYcFYxb0pQbytWbjRoTHNM?=
 =?utf-8?B?MkV0MkRHNERNbEZtMk1zeE9ndkl3dFRjeUZTMXhDZEMyM1FpQmZFMDVnWUph?=
 =?utf-8?B?TDJHRTFubXpRTTZKWklQdjJjZGFEc3NPS3J5NGI1Ym9HSWNXU0lQMU5VNGNY?=
 =?utf-8?B?YzFIeFBFZXN1c0FOLzR3bWJ3Vk41Z1NhSmI2a1FMWXk5dDNuTFIwaW1UUWRr?=
 =?utf-8?B?djhWNnRMc04yWVE3MDRQeVg2RHpwYVFJMFQvSEl2YlRlUi9rS3VqeVdFdVVx?=
 =?utf-8?B?TDBJM3dCSUpFVXJSUWt5L0s2SEhnS0w3TjZGSzE4NEdUbmNHSHRaMXVsc20y?=
 =?utf-8?B?eEd5KytvUWZpRlovZTljOU9xTW5rdnhpaHJNSGR5UXBHczRJUXZOK2ltZDJm?=
 =?utf-8?B?UW1mZWp5UFd2YWs4bW56ZG4xOGhZQktJWkxwK2Y4WWROVlhsM1pRblhTTW1h?=
 =?utf-8?B?RXQwZWZ4YzZyOUszd00ySE82SWpSRGEwY2FDMTBrRTM3NU1ISldqMEZQeGhU?=
 =?utf-8?B?ajVvL1BKYlJLUVU2enExcnJ6M2FZdHJRUjFJMy9RT25MMGM2ZHdvcDZKZS9u?=
 =?utf-8?B?ZGZJS3lQVUV3b2FiMjNCUWViN1poYS9KSSt6VjBpcVVUOWI0OFZSVTdqZ2t2?=
 =?utf-8?B?b2RlS0YyQlNRNzljeXBuc2M5T2QrQi9EN0Z1UiswbllwWXVqdzJCQk56dmZk?=
 =?utf-8?B?RXQ0azJyNGVXWmJ2T2x4NTd2bG5XZWlnZTluaEdoOE1DbjUzK1BjcmhuQ0xT?=
 =?utf-8?B?S2tDejhLcUsxL2hnblFOallPVU9TR01lWUZBa0szV0s0Q0RLNnBBZWhnYzRK?=
 =?utf-8?B?aGJabjd5MjBkN1orVlB5b091VTR5a2NKaU5ORWJ5akM2MmhxckhsM3RocE5x?=
 =?utf-8?B?eXZON2hyS3RvSFJSYy9FNUNpZVNwL2phNTRsTkZRQ0orTjk3NXA4dTBNUmhy?=
 =?utf-8?B?WGY1Zk56QU1ncUNSQ1lyaGZkd28wUFlaa05PVmt3VHVGNVFhVFlkbUdyUis0?=
 =?utf-8?B?TlJEMmRYWFZpcVpUblBDeEJqZXVRNHlSVmhhdEg4VHBhS1YzUTdjc25kbTQz?=
 =?utf-8?B?cGQrMGVhVnk3ZFdGcHJxdis0UCtUN1ZNa21tSVEyY2Z1NG1LQi9ZMmVqN016?=
 =?utf-8?B?ZjlHS080d1JvR1NDRkV3eGdoUGtBbncwdGpIdnNOUWpkTzlkN2I3eUhVcmYw?=
 =?utf-8?B?Zm44VlFYbFdQM0FyVk1kYnY1OXdpZHRLN29UMjRuZ1k0L3VJUTdERzM3NTJt?=
 =?utf-8?Q?upMfhsRYALEX3g9oNv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70010918-c705-4a3c-cda8-08dee9b6d401
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:07:38.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR9B9RLAt02TP02ind1F28Uva2GuQ2j11exwZMhnMNnslzEpHBX25llHNiK8mtVRT3FiDCue96X+JISqWcUnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532



On 7/23/26 15:12, K Prateek Nayak wrote:
> This is essentially a combined v2 of the following series:
> 
>    https://lore.kernel.org/lkml/20260715074822.16324-1-kprateek.nayak@amd.com/
>    https://lore.kernel.org/lkml/20260630185904.5602-1-kprateek.nayak@amd.com/
> 
> The first two patches fix BIOS min perf setting and its persistence
> across kexec. The next set of patches rework the Dynamic EPP feature
> into an energy_performance_preference mode.
> 
> Unit tests are extended to cover the new dynamic_epp mode and also the
> floor perf (CPPC Performance Priority) feature for completeness.
> 
> Patches are based on:
> 
>    git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
> 
> at commit 39c0cf62fc78 ("cpufreq/amd-pstate: handle missing policy in
> dynamic EPP callbacks")
> 
> Everyone has been Cc'd on the cover letter. Respective maintainers have
> been Cc'd on the relevant patches to reduce noise. Lists get the full
> series.
> 
> ---
> Changelog rfc v1..v2:
> 
> o Simplified bios_min_perf handover during kexec by removing the
>    defensive check (Mario).
> 
> o Removed the amd_dynamic_epp kernel cmdline and the dynamic_epp sysfs
>    file as they are now redundant.
> 
> o Updated the documentation.
> 
> o Updated unit test to account for dynamic_epp removal.
> 
> o Added unit test for floor frequency. (Kalpana)
> 
> Individual patches have breief changelogs attached. Reviews and testing
> is highly appreciated.

Can you take a look at the Sashiko feedback?  Especially on patch 1, I 
think another safe guard makes sense.

https://sashiko.dev/#/patchset/20260723201228.22584-1-kprateek.nayak%40amd.com
