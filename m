Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994219;
	b=Ctb4eZDFZPAAxZUdflmHBYtQ/cT7rxxjkqSNREPqigxuAdjKuCmvmHtvCjcQEY2wDmpa
	 Ek4bk4mqKI4oRU2iexICYXFm67KFV4lXX8ZSUYtTin6mLNNDKjdnlfUh8GNpcNmQ/ghVn
	 3VQ3f9qvHtEUltswwDfDzapH2PzR2Nmh8BhhphbuziOMqMtcHCFrvH8CW+/Zo1I18fK8q
	 D1N7NocEuHIlb2piQH7KhHvqSD0EaBi3b1vIyzH9wa7TmwgQe+f7xWAhg5GCBRFkQ4jPP
	 FZx+OIEAYayEC8Kdj9VtrcHUzk2Go6xjjN18SnbqijsQoMouX960n2leoDYcpsVY3gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994219;
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
	bh=IE1z3MlEjwI1Mm2+MpVbAGhCteCybEr2CWnMgQ0pGWY=;
	b=BpzqCzf/Q1BeT3nFES8+kvgGS7i5EPO10NP99DRjCrsVCnFfQSm4yMKJhR/PDQ2bS0fh
	 nETgvSl2anaXL+UDMapXvZy7CNPTTCG7a3SL5daYL+RRpKY8QgBkR6kefR+HNKE+26ved
	 jqX5TFLybKsHvfwkYglPtafwPPCg8TBWYId8F4NID/xEXObMxLIJGnVWmjbPMdlXJYihC
	 FdPaWMVFPKo/pEW+dqGBYlb/MXVbOcNBp3kg1gkSJgCPSaWax4A3DMPLOyObip7WY7+7A
	 iQsNiEeYNEongukFl0UKTHz5fY7mq5beDwwRVnFIWv+vSlB387LddZF33KsRbaOcs5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e0QuTIts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AB606A326;
	Fri,  6 Nov 2026 19:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e0QuTIts
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFmdLiGWLxf2/aTq7aRZ5AKu/az04vmE4M/vlx3dJr4+yLd7Vqxd1ap/hD25fC1Gw0QiFMrO+haWVOiRgd2Xo4mHhExGQcCCdR7suhCx1iuFWHh5hkda0wGckV7ThLcVCJNffu8mOxrAJ92sh7SHlUa6szUqXhXBAkwXs5ucEcnNugnmd4J5ULoSSPAOPamfcAMc+sSEzBAp1U0VngBzfd4pF3xPFkltw/aHALORG71HVQR1jmYpgHs9VZ0lBU2soJ3Uy/gop6zcIoBvK8/fnD/cw0g+hyvRnW5QK5QbSQ0KRvmL/klW5/nkmZM+a3wdYNt1ouFdsVRzFutrY9X3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE1z3MlEjwI1Mm2+MpVbAGhCteCybEr2CWnMgQ0pGWY=;
 b=JGeMB1GdY0M+cb2oadTXyBdgoh6ZvZIS4R/Zelr29qdDoYDGaYtEMqyT1y+LLd0y47PgKndctNFGRtb+xV6G2UoGkoWKetHmqunpScRUMael9fxs9NpD0beY7hit9ZkA+Y+oB++O/KFINRQ/36XA2Fuv2CdhOGHm6j5Vx0k0gALAbf+f79jptBljm+PzZY4Kt29rv+JgFYt01EB2uaP7X2kYAglM7AKTM9O+49GH7WBv46+1bxFstPRCUIx4oTViS/aoMmCwbmKRarZ8Y676VpQLRK0Y/eakiOEDYMbMQfujGBJXDctsA0VO0qzH8V1aLSwcXqsbmeq9oqo0x2oXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE1z3MlEjwI1Mm2+MpVbAGhCteCybEr2CWnMgQ0pGWY=;
 b=e0QuTItsnJuumfeO0ERhSVRjM5hjATRkUjouUFAShMQwv1IZdBm9MTAgrUc/afbJZhDoqGbTsURJoAGtLCLK/cmN/nqZNJpXwdhBH9ypL+dzUmh/+my1mvCO9GFCwJ4U3fTozfYYCo+Zv8CETK3l6ZFLU2bW0CnKO4bdl8yGPZSYOenrBwN3mKsAXG1CvkogzlO+ogRDcQk0LU3Ek8cpjBK4lq6XRKvAy1vSuIlvgoz7amWHUrm++ylFWO72zSuQu7FiTGCiAuXPmSRcM6QBH4JYIDVi9DXg1kpyVjqRHIa3zN+1hL7wmxjbHLVvbUHqOm0RyWMjwcrOtZCuuFEuOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by PH8PR12MB8430.namprd12.prod.outlook.com
 (2603:10b6:510:259::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:43:35 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 19:43:34 +0000
Message-ID: <d7b6126d-9c82-451c-a139-59e2a0a064d8@nvidia.com>
Date: Sat, 7 Nov 2026 01:13:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf
 support
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <CAJZ5v0hDm=FMftFfxnzthRQXWzUqcm8SkAaxzVWZcsyQtNLj6g@mail.gmail.com>
 <5089e131-c904-471e-a078-5df7cc664372@arm.com>
 <CAJZ5v0jP-z=zu=S_aBc3JpocRWJXcjzB8WnXu2UHd3WBf9cE3g@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jP-z=zu=S_aBc3JpocRWJXcjzB8WnXu2UHd3WBf9cE3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2c) To CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10)
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ea5292-8a10-4e41-1021-08df3c3e3e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|261022075727099003|261021121427099003|261026140227099003|4143699003|261009223027099003|56012099006|261021123027099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	79kKsjscYwaz5lqELpfj3wdOKEaMHLtHJ5jgDAiyunOtE/6qKCOXAu6QE4yf4Ak6kzcVCh9yjN8k14QQk3+gj3BFaQqFLqjBI/adPqCbb3Eewb7BfT5SSxNqfQeJPJdvCczXlPCuYZdE8/KvnY7oX/IA4JR5nWWbvIkBSiAfyZ6M8OmNYCUYJgyVEmiSGjpylOAsCD0/t6MkpfCJOTidrynJOkuxU/utLIaqj64Belz5WZHtfG4pYvAUu1N+1dxNve+oK3R9zY19nLImJ/2U819sjk4m+3p44y7usVCqza78u48vkEZYgHhb0ZGd9iN2+cgIbzqoexjYk6j/hX7X095z9ZyLdYFhu59eUrmJ6AIugGKHSV3E4J/1IEP/q3qOyulOw9TpdtV7KCjeyZn02mIujoIMy3VUNgHJoWrO/gYPQMLqQeqcOJYNjhbaPmyLZKSL1n7ZcHGwvolKsUwv1FMH9WLjwl1d6grCJPjQKz9gbpCsfzvPSfL4Yl+D7cZqS4UUO+hLtOh/0O7WlEpbxXS4EwsEfzSpAI3QyitmwKJe8TGJXSc1Su5OZ2NzsKXSnOrLWTEy4qlQNV8KPRE3yafDilPr70UXzYFzyjl6SsyD23058vmI6uuZjmYoN4kExzSg2P8CNRaJ11PoW3OsYWnpba2Cuwen7Sved5zTVWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(261022075727099003)(261021121427099003)(261026140227099003)(4143699003)(261009223027099003)(56012099006)(261021123027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elp2cWYvbkJBNmJQWW5ZeDBCRW92Vmx1a1hpS0dUQlJRMTZ6TjB5Qm56ZGtl?=
 =?utf-8?B?ZXRvbWRIb01nQ0hrdFIydXVsQnpnMnYyZG1NeU8rdmY0aSsyR212WXlua1My?=
 =?utf-8?B?M3g3WFpCcGdnUHVuUmdHUXEzZUhIZGlZdmVrejkvQ0tnTlN2YnVuekpwYi9w?=
 =?utf-8?B?NXAxRVhMTXoxYUQxeURoNlJ0ZnJjSXZucHZ2d2VkZ01wRkFsOWVYR3FFTVR5?=
 =?utf-8?B?MWRHVUFUbHJZRVgzYWFvcStWSXVtVGg4U0ZLL2tZZ2owUHBsZVphSDZTUmI2?=
 =?utf-8?B?cWNVT09LaHZwRE9tZ0lnTUZFNjE5b1RUdnZ2Yy9adHRtQlZ5K0tEbzdrV3Zk?=
 =?utf-8?B?empKek5RVW5XOFNPUHREcDlNakZBVzhaa0ZxRzNnMzZQODNEcXNGTmZkZ1JB?=
 =?utf-8?B?U2hKK1Q5andtZ3JQcTMyQkZHSGtWeHV1ZTE5ZVBNTGRYUUorVmJCdnJDcmpa?=
 =?utf-8?B?R3RkWVFJNDczK0VQOStnZGREeXU4ZnpDWlpKejY1bnE2ZlhabWF4Z2NraVAr?=
 =?utf-8?B?YU5YTHRyak1qeDBvN2xpOWM2djgrd05HV2YydXZERjQrZkNDSUhFbjl5UHZh?=
 =?utf-8?B?V2FhL0dHd3U1UHZ6UVJ3eDNDdEg5R1djWVRndVJ4QVU1TlNBdGNuOG1qYjRr?=
 =?utf-8?B?UlV6RlZ6REpMMHFZdlpWTXQ2VmZra25lNWJTRlpTOXN1MTU2QlF0Y1h5bWRZ?=
 =?utf-8?B?SGl3bjk3eXp2ejR0SGthY3BHTmVINmk2eXVOYnIyMHVpRm1ZRWZ6MmUrTE1a?=
 =?utf-8?B?N3F2Q2RITTVROGpCZlZYS0tRaDFyNkgwUFFQSlVBQThGVXhmY0IxODA0T2h2?=
 =?utf-8?B?NHFxTHZlVlpsRGJyQ053TS9oSXJaWnNLZ2lmeFhwOUNIc3RORGcrZmx3dVM0?=
 =?utf-8?B?em1QdTNHY3pWQUExTDJuaGk2ZFE3V0hvN1MvaEhoUE41RVlreTRvVi95RUxk?=
 =?utf-8?B?QUlTRUx0RExDb3d2ZWZzci9IWnBsS2xhcTVyRThyRHRYVUdIUG93SldaR29G?=
 =?utf-8?B?WnJWamZDbFRGVE95bTU3TDlDOHkrenZPMWdpQzdqQUN5dXRIb1ErYVFNQ3Ay?=
 =?utf-8?B?QkNBZXRoQStUOGRKaGo3eDdYdlVKQlJvbGNHdjFPLzZkQmZSVVBoWk0yc0Z2?=
 =?utf-8?B?Y2hEZDQ4TUdpbnhua3B2ZlhyanBuNHRocmkwQXZqd3FhWmhrMU9SZWhCTWJP?=
 =?utf-8?B?MDNrVmFLdFBFNWRTTW15WWdDZDhkU3NzckcrSWp4cGlYNnRWV3RTeDQ0TzJD?=
 =?utf-8?B?NHRHVktaa05rR1dRYVhPaUcrMFVUS3VjRUI0QXdha2RkL1YweHlqaFprenFS?=
 =?utf-8?B?WnFNVjcrOWlQSStZb0NaWnhibXR4OHdYS20vUTFPc1duUWdtbG9UV3JhR2g0?=
 =?utf-8?B?aE4yWkFXRElYbjFuazhKeGJsT0hjNWN5RDJpMm9sZDVMWlZmOCtFcWVDbVIv?=
 =?utf-8?B?VW5SVmt6SVdMejJ5Vkphb0l0cm1pZ3dRL1hLR1NYWXBqKzA1Z1czbDNZVitG?=
 =?utf-8?B?alVLWnQ5bTZzRVZxaUc5blRvc3BWSlplbXpSenMvTHJrcUY4RHRkOGJmV0R0?=
 =?utf-8?B?UG9JNUZPb2FYeXFIb1lIT2xGaVlHLzdIeGNRQ0l3eTk2Z1Z2N21SSCtrWEU0?=
 =?utf-8?B?ZVYzejYwYkZlRDFVNU05a0FDWlZ2MHRDUUZWeTl4MmtCUU1LaTlxanlZOGFR?=
 =?utf-8?B?Q092Q2FoV09DajJvQlpQU0pKTGlqbElydERHQzlRSmxzUHdmTEtRejhPemRp?=
 =?utf-8?B?dUNQVkhtRWRoeUZBTmN6bFpqa3hFY2VPQXJDVUpBdFJBcmMzTUhSQTlSbW1j?=
 =?utf-8?B?Ym1rTzc2ZGIzcGsxVGFJMkl6Q0hmVUJBUkFaZFJKWFNIQW9mVW9XOTNnRHNC?=
 =?utf-8?B?aXZjN3VjUG9BNlpLM2dTNlZRV051QVQ5dTJ4amI3WEh4NjhBb3BNbElxRndh?=
 =?utf-8?B?bDMvUjFKaWV5R2tLejBRRnlrdnpPVVBraUl2WmtoWG1qTUw4R2NGY09kekFp?=
 =?utf-8?B?Qko3QjRkOUE1cG0vK1A3SCtDbDd5MDRYa3dlUE5ZaldBUEVaU0R0alBSZmJh?=
 =?utf-8?B?cWNob3lvSS9NNzZZa1QvWGVWNlIybk93UmN6aGVicDI5ZkRVRmxVZHoyN2Z3?=
 =?utf-8?B?L0d2cnFiNEI0YU5nZ0JWVWFaRDhvWTNGdDFuV0I3RE9SbC93MnBLb1VLd2Vl?=
 =?utf-8?B?dUZUZzZTWXVvQ0ZHVEZSWGNmZlVIV0FXY2E5eUYreFFGMzhtN0pDa0ZTdVdm?=
 =?utf-8?B?QkY1MG5tU3VtSGx4Ti9LNmJXMElROWZsVUFDM3RRNUlVcHM4UUpIVk1abk5D?=
 =?utf-8?Q?DKuTeI65jxLtqFMShS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ea5292-8a10-4e41-1021-08df3c3e3e4e
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:43:34.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+J8Ctt0SJ6mvFI9werDjLr0OjGxXmGtmVMK2y+frRtUqMOc4ocuKDBHnHpTW0WEDqKP65ygxi3yau2J5eW3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

Hi Rafael,


On 06/11/26 22:31, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Nov 6, 2026 at 5:59 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/6/26 16:08, Rafael J. Wysocki (Intel) wrote:
>>> Hi Sumit,
>>>
>>> On Fri, Oct 30, 2026 at 6:28 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>>>
>>>> This series adds support for the OSPM Nominal Performance register
>>>> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>>>>
>>>> Unlike the read-only Nominal Performance register, OSPM Nominal
>>>> Performance is writable and lets OSPM request a nominal level below
>>>> the platform-reported nominal. The platform treats performance above
>>>> this level as boost and below as throttle.
>>>>
>>>>   - Patch 1: adds ACPI helpers to write the register and to check that
>>>>     the platform supports it.
>>>>
>>>>   - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz. The
>>>>     value is kept across CPU hotplug and suspend/resume. The register
>>>>     cannot be read back, so a read returns the last value written.
>>>>
>>>>   - Patch 3: uses the OSPM nominal as the maximum frequency while boost
>>>>     is off. Lowering the nominal creates a boost range on a platform
>>>>     that has none, and boost can then be enabled.
>>>>
>>>> This series applies on top of v7 of:
>>>>    cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>>>>    https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com/
>>>>
>>>> v7 -> v8:
>>>>   - Rebase on Christian's CPPC fixes series.
>>>>   - Patch 1:
>>>>     - use cpc_is_writable() from that series and drop cpc_reg_writable().
>>>>     - add the register to the list of controls the driver writes.
>>>>     - take cpc_desc_lock in cppc_ospm_nominal_perf_supported(), so the
>>>>       descriptor cannot be removed during the check.
>>>>   - Patch 2:
>>>>     - make ospm_nominal_freq read-write. A read returns the last value
>>>>       written, or "<unset>" before the first write. (Christian, Mario)
>>>>     - keep saving the values in the store handler, not at init(), so
>>>>       the driver writes the register only after the OS sets it. (Pierre)
>>>>   - Patch 3:
>>>>     - document in the ABI file how the OSPM nominal sets cpuinfo_max_freq
>>>>       and caps scaling_max_freq.
>>>>
>>>> Sumit Gupta (3):
>>>>    ACPI: CPPC: Add ospm_nominal_perf support
>>>>    cpufreq: CPPC: Add ospm_nominal_freq attribute
>>>>    cpufreq: CPPC: Reflect the OSPM nominal in boost and limits
>>>>
>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  31 ++++
>>>>   drivers/acpi/cppc_acpi.c                      |  44 +++++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 173 +++++++++++++++++-
>>>>   include/acpi/cppc_acpi.h                      |  10 +
>>>>   4 files changed, 248 insertions(+), 10 deletions(-)
>>>>
>>>> v7: https://lore.kernel.org/lkml/20260807214837.863209-1-sumitg@nvidia.com/
>>>> v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.com/
>>>> v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>>>> v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
>>>> v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
>>>> v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
>>>> v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
>>>>
>>>> --
>>>
>>> This would be good to go except that it doesn't apply for me on top of 7.4-rc1.
>>>
>>> Can you please rebase it and resend, with Christian's tags included?
>>>
>>> Thanks!
>>
>> It's based on the hotplug/resume series, I guess Sumit could post them as a combined patchset
> 
> That would help.

Sure, posted a combined series on top of 7.4-rc1, with Christian's
tags [1].

[1] https://lore.kernel.org/lkml/20261106193304.3347374-1-sumitg@nvidia.com/

Thanks,
Sumit


