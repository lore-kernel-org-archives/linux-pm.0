Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E839B4BF;
	Fri, 26 Jun 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494294; cv=fail; b=rQViBYBhaU7+hbe2cx8RFbVT9KxzeoMVvPRkxiS0J7K6fs7JXS/C0DGU8riKRVnFftiVpUxQ6j18qbculQXjZMdhMycpz+UlXr5ZBEoEYisHoQIqg1qIvbvoW5QVjV/1G+FWk5IiOGO+Ys6TxXCZn6yRvPgHHAu/O5SS36i2zMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494294; c=relaxed/simple;
	bh=SaUU9AbRakzlQbIjo6LiBE+O6QpqRwz8uzWV5iV8iL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfemKyeMj/jj4IPJLSAprkvk/b8v1qJRxVcRJ+CnO1/cYgT5q1aSQpB8zdslzuauyh5CZjV/SpcMquoYd41KVVPEKqijRy2rRsOglPChdzyLNTiAzBB5tseXwEeY7Ev6LJAet7ra7QCmYK9wbCSEHT5NIqacKrwYeZ+F2t18GHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8CtFwe7; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8CtFwe7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrPN5BZXK06f8yw/i1f+kR8cg/KrpEIfy1KbCUZLKrSiTxbPxTGIE9WAhApWyeLv1VCEznWGlTNkkx6upogXnrlkZ0y04VCzWlj/n4NOy1f1s8JaIfCxQVLPtC0Rt98dbXWuBPCS37mBQ/qntvY+ujDrOGACIeVINQY/Ronu4v7ZQxVhA039B4wm71X7drSdmbAMTLZFuGZnwJtT8e5mVrH5jG3Y3zRtWaWLKcDT60yymC9/0KXZlHjObzd3e+JMko55VYykMFUvYQJxf2gGSRCcDONHxegOXMG2Hwua8UYC+4Ddu9ZueL2IOeYKYi9RxFLABFY4YXSJ8YEQc+nM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PLwse7Il3tVHm455yHF5lUc4/BJUE4Yno0bzO5AAH0=;
 b=N8eV1Gte5bGYS4cBme9mXrVdiuXGO4BmjIzzDGKNx0KDU216mmu4eSj0et4HVOhbkI0Es1mQRAxny6ya509Pv/U5zoyKx9l6cMg9CaMFBSz9SV/rY3bpMuFeawzCxGtb1LR0IxN/tpn3tfmOW0D7eVs7QutXrCQLGma7xls3aSv3jyflmv+5oy7Sb1mww3hm/NAV3vk5uxSt9FhQgaCpMNKMAf8KEB0iQHhw/NQ6hpbtDOFVDjEoJMeaK+keUzWqv7vYglMfbolMc4STo1Sd8C0Lnz/OxocuWr+MNzJ2mxcAWz2KdyWXEmWh2x6eWeO8FSbpsM4tr1AgQcqYl0XlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PLwse7Il3tVHm455yHF5lUc4/BJUE4Yno0bzO5AAH0=;
 b=o8CtFwe7/gH6i0DMxnQ2HT50Z4mQGoApBZNQ30KENTLe0ESFtt6Y1cdMl+fQfEknHfbGR43YAlkft1WAtdJr7Ae7xd01oAZGvG6GC3cVQo3bobhhtLvYFArDymhFPfuU5NQSIM70SUvoJtx1JnP7GXavdZ7ksKpdJa1qaSWCixHpszwQXmiy4tz+34Sc2cyChGf6YhJX9+OWT0OinIDZbGwYgaZhXDYNL6uFVnVQ9rnKDDsCCcA1aftrMmAuTNkD5vOrOiGDNdV7YSrahFCbc73mQlOL2PEivA9O1KDry/yoOc3o+PTXBCls+EH9UqE061vt25Tl/tSF7RW2daH+qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 17:18:09 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 17:18:09 +0000
Message-ID: <aadb5ad9-a2b8-42fb-bd3e-e0f0e641ce3e@nvidia.com>
Date: Fri, 26 Jun 2026 18:18:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: tegra124: Disable DFLL clock on removal
To: Myeonghun Pak <mhun512@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260626093014.66092-1-mhun512@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260626093014.66092-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: b51bce1b-b302-4f83-1f8e-08ded3a6e4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mW2xQkD+b4uILuQc9hdXmr8BXzSmSrfRhP2XM9R7uwX+bqMcVgQSqMgKiAsTYn0QR3d1c+fVP9d9U3EKJt8OIJzynH2/a37EQi0OmqjUaHoF3fc1+ndQLutEz5at+b2Aag/MjeudJ8TW3IkqHT+ORnXGdT6s0m51woKd2lNatAuhNBn+KRDvpYWha9rG4OUyMaMGYiIQJ/vB0x/tbzU+2kY+jPtk6c/ZmhGm7LH/Gf31WZABUrQIvrnSb4S3zVPRpJPkf7LQ/aqa24dN0p2nWKfJGyvahvNxAiVqTPxQT6SwZB5BmmvlusbbyGFlS4DOyYnE8TciOvDve+dnj7AAE2lUkrP1yzG9UeO9RbowHEz7pXz/MRl70TKSmMf++PsLIweFaM6FJhcAS993QxmV64V0QksSPpY6qOupl8OjXm4jI35XCUEpiGawZQvHKSvFgc+AvJD6reOFvOTXXpK0ABlqxIH0rjawQTKD1+DDsrr/okRAfUse2a+nFQ6B9BoziPqxg1KBm/3bnjygIvl1cETlKjDuvvgFI5eif+8gLeGDV5tTHjK8oVKsxGLWt/IKEjJfMcnqwS41MmU6v3BQVCUdosAiiK7uZGkCoVlmQDRVWOTAuzFpvMFVd5jYZ9BFJUvhyqLdIFZfUmVcnHGrSeyV7SOxVW/B1fONNtvTUYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzJ6c0JHeXdpU2tTT2VacUZUQkRzVHVzM2tMY0FzNTNoWms4VjlnanhmNTVk?=
 =?utf-8?B?UEhlUlRxbDV0S2YzUXdxbkRyU295VHN4SlNnMktWYzQ4c2VOQklHZ2RHZG5B?=
 =?utf-8?B?L2wxV2JJRXlWS0J5OVNUeEVJUXk4YXZjYW9mekFYK25BYW1oSWxRb01iZjdE?=
 =?utf-8?B?WWRMK3lMYkZXNktrUGNsbEFLVGtYTm50RVhheEhRR0FzUkhOUDJqcmdtTVRF?=
 =?utf-8?B?UDMyVVp5NXVBZkxNOEh3WVZEcUc1V0dsTDdQbDFMcjY3QXI3NjJLYTBsWjhH?=
 =?utf-8?B?d1hPcmxxM1NLRW0wT1ZMMkZyVDRZS0ZibEFTODFFd2R0LzZ1MFJBNFlCYnpk?=
 =?utf-8?B?OFVHcHNwTGpLUTNITjU1MTQrbm1udUtGZmZZaG5qcnZYb3F2S2FBb2tISURt?=
 =?utf-8?B?bDBxZ1FzRmpWNmptb2FWWldsUFRHWkg5a1BVOWNmZlVoaTJZQUxVaEFabEYz?=
 =?utf-8?B?dDljMDlvNHdyV21uYzNyTnk3MHRyQVJGeFV3akE4bVFsWDkrYmt6NnFFNG4z?=
 =?utf-8?B?eG03K0ZrZXVQbnM5Q1VsWC9tNm9Sc3ZmZzFmZGsxUlpKdTREUDEwVGtaMm0r?=
 =?utf-8?B?UmVXNDYrcFJnZU9hbWZTSk1qcnJKaXNEcGFwRk5hR054Vm9hVVAxOWcxT09L?=
 =?utf-8?B?bzVUNkdtd0NtMm9QZ21GQ253bFpESE54UEFGN2w4QjljM2N3a1A4Y2dTR0li?=
 =?utf-8?B?ZTc2YXJwS2FmbWl2RmoybjdqZkVlOTBzZUNUcUQ5THF5Snd3SDV2QWdHNkhj?=
 =?utf-8?B?U2VjNUtxc0lhbjhTd3VhRHU0aFQ2b3BmcU0rL1g0VmtXNWc1QVFva25JUndw?=
 =?utf-8?B?VTJXTEFscE9CU3ZmQzR0R1ZHVzI1RVQ0bzQwUzNtRUYzcTgzV2pGekNmRlFm?=
 =?utf-8?B?K2M0a1h2OW1CYzNCY0E0RnlXVEpvMkJFeEcrd3pxVHVQMmtuaHFVeUcrRFhv?=
 =?utf-8?B?TVFQS1dkK0I3R2NZZnlrQVp3TFVod25qVU1YTnQvZkpNQWVvMWpnZmdRUTUy?=
 =?utf-8?B?RmlpSUJhZEN5SUVqb0xEVWg0L05wTmtHWWpDbHIvMzdpYStLZzBCZUhDenky?=
 =?utf-8?B?UWRmbUJuV0V0SkJLZEY4bDYya2Y1T0ErSGNVWHk4QnV4ZVFXMG5WeWhaRlVM?=
 =?utf-8?B?dTNSNVQvYkpJeWNvSHpDSWtxeUp0UFQ3akFtSG1TWC8vSkczL3hMVmZCYzMz?=
 =?utf-8?B?SUdxQXB2MERFTTBkdUN0L0RhT1IzOGxpRXpjTjJLa3NiVjlwQ2VBV1pMbmx6?=
 =?utf-8?B?aHJuSkw0S0VmM3JBdkE4ZDcwTTJHMCs2cGhLR01ERjhta2h3MTQxdWpuREVn?=
 =?utf-8?B?ekxtalFDL2c5c1lEZ2FQZVhwc0wyQXpBeFZFL2s5RlVCSmVOSDhGQUorUkZo?=
 =?utf-8?B?NSt5N1VENms2NVJBbWZwVVBJUFNVUUVvVVBrMzNPMDJvYjAyb2IxZWlubzY2?=
 =?utf-8?B?am9sWkUxM09FYmFuV3VDZnBxOVBpc3RTV0c2cnNpU21xczBteld0c1pDdWV0?=
 =?utf-8?B?TEo2MGZYZ0s3dDFBODZENnN3cFd3Q2E3cnpCaUpDQUVyZjNLWVhlQ3RoVEtq?=
 =?utf-8?B?VWt6TVAxQWMzWXhFSkh4cW43NHRXdmREOFk0dEU3aHI5QlpWdmtaWEhUQ2VP?=
 =?utf-8?B?UnRPemNNV2sxa1ZnQTk5Z3Z0S1lMcGJJcURQWDYyT2pkMUh2cXlrMnZVQkw5?=
 =?utf-8?B?blRtWEczY2gwcHA0dVlTdTVGanZxRitONFU1WWp4VVhMZTQrNnljYitINkxm?=
 =?utf-8?B?c01nY1l0TFUzekFSU2dUR05udHRCNUgvU29sREllU09obGgrdzhUYkxQOVN0?=
 =?utf-8?B?dHprVFNUYWhWMU1nTXZDbUttajUvOEtyZ0ltTUl3bzFYd1kzODdIbUt2TjFE?=
 =?utf-8?B?ajUvYVZCUGVJNzJoN252QzF6NFBNWnNXMVd0UmNiVis4Z2ZEb0xXUXFvSFVm?=
 =?utf-8?B?VzNxNll2OEY4QzBOaEF4dSttcnNkRTRQODhFTTk0Zk1ua3J6VlM1WXlyZGpv?=
 =?utf-8?B?a0VQZWpyWXNXb1psWHdiMjJld2pjSjlKVkJkaUt6aHkvSEpRYzArcmxSRzNI?=
 =?utf-8?B?SVo3eEQ1NTRmMlZmUURGcEhlejdJWjg3bjJIVHhTQlRoS0xrT2NMYmk2bHUx?=
 =?utf-8?B?azdHTTZneWtnYWUybHlFakd6NXN6aENsZXc1U0FCOE96R2ZpN3FWY3pWYzIr?=
 =?utf-8?B?aWNsc2VlNUNjQlFuMGZJT3NKbVFFdTRtanRkZDg5REFXMUZ1VGdlRU5DenpD?=
 =?utf-8?B?S1BsN0FSL1lSREE4bFVKVFJXK0orRGpMOEJNeWhYVmpyY0hyMDhsTWEzL01o?=
 =?utf-8?B?U3B5eit3YTVBMHl2M2t2OTRqMUtVenRNVUFkcmVLTHZUL3FIbzU5MDV5aUV4?=
 =?utf-8?Q?HdGqxoyjm4PQeLQVZ2V1jbV9z5MOF6oqzXHxfaJKIWFMw?=
X-MS-Exchange-AntiSpam-MessageData-1: ST30fWhAqCiVmw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51bce1b-b302-4f83-1f8e-08ded3a6e4e8
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:18:09.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KBLCG4uHrg1X+5lfzBEAaX4CajQhQMdhBvjapoTFowE76q+xWKjt+EwI38aEJACijUfD0cI8TYXiDeizwkeuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278



On 26/06/2026 10:30, Myeonghun Pak wrote:
> tegra124_cpu_switch_to_dfll() enables the DFLL clock before switching
> the CPU clock parent to it. If cpufreq_dt_pdev_register() fails after
> that point, or when the driver is removed, the driver only drops clock
> references and never disables the enabled DFLL clock.

So after this change, if we successful switch to the DFLL, but we fail 
to register the device, we disable the DFLL. That does not sound good 
because the CPU will be using that clock at the time. I am not sure what 
the value in this change really is.

Jon

-- 
nvpublic

