Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8F411661;
	Tue,  1 Sep 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276392; cv=fail; b=b8jWuxSkMinU6ljDy7MOMtXfXwOtxbo4rjItszi+BFLctbIyZr747fczrIfoI6s6D+za9FAzH9JjtgDCNNQeu7na2sFKWd7uGp+gS2akDC2kRdZnPjrXARxRcvyUDYkDMtzW/Ae5NwKasJq8620aIe2niW7DQw+9ymjGZpFIa60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276392; c=relaxed/simple;
	bh=Qh0HeyVDcBc7PfLlyZ/MJ4yMWlZk/1i/4swB4MUubFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qO7C9KOUe84vpeApQdY0+qksuDj5/GSWmBtwQ466McPkuPHVHl0ZUiX3VMFXMMYZh85uuac3t1cEREv5fI4OvZKjr/G/KAoxOYAnLeuo9L3rh9dn9tGrh3SsNh8PU4XpY97Ia/mSEPdDtcJkISi7u87dssHOZxyWAcpCgnYjVss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nUtM+PPr; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nUtM+PPr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uysFuYMkfwdgbmd9owmnNeY4jFzzhy149lthZLo0bMQGbTxiLS3f6eWJewoouRO5nzFVi+xyXN+lecW3GIX8vomdncP6DRM3D3WfsF0+c3LYbsKRnKMGFVLEcTITkCqt7POE7jbAWaZw77Qx2H61cKZXmHVe95Lx30iqRuYz/+UkgUh6qNzZLTuvjWv++K1gfjQjeKz2tCH6+eIZjqJtAYQ0nq9FD/dx6lYsQ2Fo7dDLDmuZ+2imJb1UU4QP7vo/ELRizb4nNQ+HtPxSrUqm/1XJHNVDfVjk2uG3K4URtHrpqfuvv+p8XCXNFkRv1E3mWKH1gAPbZHrfYZkkXdXUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15WgpkSe5Nlqpy226/oUnrlobYI93vksnADWr8Tq96Q=;
 b=i0T8lzSsQBbiZ6bSrgFt6KYCVmfbfR3/MHaifwN58fWJPSrUssECX5BI8sA9GW8yL4b3BhJX2xaXzGnxHRZTsZwkLZWAlQnf1LCWWcWkHqYt2wVr6WVIyrtq2O3ZGqF+r68QIcxg18jQlgafdatz7C3DGRjiSRw130g7zVUMP6kI9yXZ4XJ0pBTzLxIVx+vWV23KVZvXE0FPSRraYOMZoURre5lSSmxgaP7ByOjw0yZ+1k7JIl6J7MvO16DetzDhtxQYCskncTm376YTPgF6m0h2cyX7XNkxTHEoy501Kid2n+ncj5CBBZXLrZ2ICs3cmBKDvnswuetKzBMwGi8muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15WgpkSe5Nlqpy226/oUnrlobYI93vksnADWr8Tq96Q=;
 b=nUtM+PPrutNoxN3sCzclm6zm41i1c9r7KHxtk4+jCIyW7SDzdyACWpEPOHFiRrmocs3dq9C+ysaa3v4YaIBtuT0FtyhPZgcDkOSY9Bq1I5btYaQh2vSg8yoBMVjOMe/IhEwf7brOfI7I0qj4gIAR3bmVZR7IFHpMwsz5LyL1xUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV2PR12MB541025.namprd12.prod.outlook.com (2603:10b6:408:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:26:26 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:26:26 +0000
Message-ID: <f7a94d16-348d-46dd-a8b8-e36fa95267d2@amd.com>
Date: Tue, 1 Sep 2026 10:26:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, x86@kernel.org,
 Vishal Badole <Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com>
 <1aab438e-9841-4def-8982-1433f38c0e96@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1aab438e-9841-4def-8982-1433f38c0e96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV2PR12MB541025:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb4252c-2992-4e49-a53b-08df083d6386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j4gyOIqJr0vUB2+nGcVOurhc6BrrUoeKyFvKCTxIXFQG1bOAyDCPT7NQBc7n/iO0nbP9sAXYfKmv1yMs1Wx9v5WipMjRSKdctNvqwhTGQXE4Q/eGyUHe9/VgVgzuVDTx8smgFWucjM1L5ul9tcIR8O9qekiRHahpgsPfvwDX7qEK9fbkYIForDMC3pkdntzMJtyUycCz+wU9Swompmv1qrpOLacbmZPjnJYadqkCYItSqraG7c48AV/a/x2LIN0U+RAEowrDGFcj6yO5WE6hnpkYoDGsXmfgTyxoaJqa5vK+yDufsBks/LbujbT1Ne5rt7i4VySPwXLsddQ89vPQBL4yMHff3r4cV02R9WVSG1tBwTNslcq1OF2C0Gl6zCJbmwfj9xUiFpRcwbZUm3lauKrY25s6OQndPMYkALrvitQdtZhNjrhcocXExAChN9ubRUUbJq8snI0Y7ulg4zCBC2YsA2iogV/uK3UZnomMfrj9XDgxisxeKE7z9FTyfl2QdDun4dQtAQxk/eIuvDxy1OI10WJwEPuqmggZHLbRR9b+/x/P/O+9oDVJ04xssxx8tLya7ndObaFTllhF3uMl5iY1xL3zfpLwjt0adlrJLARGIGq0MfynU/tndIyHcuGjcYIJ2gvknQPO+QDErx9d73q7zelYwjSAaa0DdrXyE40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0p6ZDFqMm1rTHJiczFTSEpjSzJCM08vK2RMYk5qN2xJaEl4N2tWNUZtSEp4?=
 =?utf-8?B?SWd5cGo4bXV1SHNnUU1KeGRGRzlLK1o5NXFFVE9PRkpNb3kxVXUwdDk0RG11?=
 =?utf-8?B?L0hMcFhGSWFzcE5vcnRjaEhVT2xJb0t2MGJkc1Z1QWZaM0tZYWFmVzZ2dWps?=
 =?utf-8?B?WmwwdWNXN3kvcGRMNy9qcGI3WXRjRXZrdklvTlp3UFAwZkJicVZGVGN1ZVY1?=
 =?utf-8?B?aHRBS1BIcVhGMTFEWllFYlkzeEh0bkt4VFc3U2puUVdYSjJuVTYrdys4SmRo?=
 =?utf-8?B?Y2trcTB6Q3F4ZzhjcEFrcDRiQjFhenZ1MEhWOXAwbEF1UUsyZTVjWlByVXM5?=
 =?utf-8?B?SXY1QTAzT2ZxdjVNd1lIays4M2tVSVVPSVRzNFZhd2ZIWWhoaFdMRllJTUNB?=
 =?utf-8?B?N3J0MHlqUTNwTTRUUlJrS0lvbjM5VjJzaUJtSnVqMkF1RHhITDdNMVVSVEZh?=
 =?utf-8?B?aUlkZ3RRbWlqcisvdFZTTUVrTWo4d0hEV3p0SE92UHpNdTArYWw5VlhrdTJ4?=
 =?utf-8?B?dzlUU1BXcHdyL21CaGJoMjNFRGFKK1hwaFBkZElYN0txdTloVlhxemdCaG5z?=
 =?utf-8?B?UWloYVQzUjgzbUhyVkdmWi9JQmRZd3JwT011M3RVbWhUQVJ4cVBFTGxXcjVk?=
 =?utf-8?B?SjJEK0ZDTGEwSE1IbW1WRDFTYkU0eUNKbW8xemIrdGZhQUFoSGdzdVJzL2lU?=
 =?utf-8?B?M0t3QlgzT2JNclhEV1BTdDhXTGYrRFNyeEZsNFJLcEVsb3AxcEJrTzJ5a2o3?=
 =?utf-8?B?MFl6TWt1Wnk5VVU1QkRsdVdWWk1WdmlQdmtCZW9QYko4TWtwOWQ1dml5US95?=
 =?utf-8?B?aDNLajhxRTllaVEyZ0gzYnozUUxKbE9IRGpCbk53V2c5MUhZTFJtWEc4K3RT?=
 =?utf-8?B?cWJDbWxTZU9ERVp6NWx2eURuYk82OFA2bVpWOFByRXc3ME83WmNNVlBnOVlC?=
 =?utf-8?B?K0JvSTQvY2VkUysrWi9tQmNoNnh1V2RHeGJZNzlWNVVHK3FjL3U4Y3o0WjBT?=
 =?utf-8?B?UjQybmMybEhWb0pralRNZVBDSUd5Y2t6aHB6ZnQ1TWpRYWQvazh2cDZSRTNz?=
 =?utf-8?B?S24zM2JFckl0blA3am9aRjJmaitVT1RZTTNhWEowMUw4UFZaUWhBUXZlUVFD?=
 =?utf-8?B?anRvQlRwb0U4OTRRVWlQcDY2LzhmaXNjSVRjb2ZlNHpLUEVmWU5iQ1ZnMzBL?=
 =?utf-8?B?QkJFTEIvTHdPU3VxbHNOalZoRndRbDA4aUNBUmJaN0RYSFpYYnEvNGFjRktz?=
 =?utf-8?B?eDZFaHRzV2FnbXQxN3poaFlzSXNNUnUvU2FyWGRiZXBKcHdvN0VjY2NwRjY2?=
 =?utf-8?B?VXJrdVNEV0IrU2xqd1k2L3phQXNYSkExdElTR3BYL0J5eHhGem1MRE5JVUdh?=
 =?utf-8?B?ZFZJL2ZZSlVHTDBMUXJUSGFSUWNNZDMyOU1jN1J5bi9PU3VwMjlEOURHdnpP?=
 =?utf-8?B?NUZMaytnenppSGowQ1hQR3hWb2c3VmxJSUlQU1pOdzlGaXV5WG50NTQ0ck5v?=
 =?utf-8?B?R1gwQVBTUkNmKy82NHZlS3RGdm1ycGJPdGVRWks3ZkVTQ0xyMUdZTEZIWndK?=
 =?utf-8?B?M3ZMcWtwYm5Ld0FYeDR6ODVTNlRoeHVHMnJVamdIZXR6WmNTVFFqWDJLYXFD?=
 =?utf-8?B?bXRzTzlwR3U2K0VnTVdxL1lFQ2ZFY3FVM240WC9qVHdNRnl6MnhWS0ZOUVJU?=
 =?utf-8?B?Tlc5VHNrWVpTOXpmTVlvTEYwSUJGV3BWWm9saTNKQTI1UzUrVWMwVEh3RnBJ?=
 =?utf-8?B?M1dNUXNtRDBRODFQdXhvaXEwYTBlTmpFYWl2aDlWR3NZcTQ1MGQ5a2RDdXdK?=
 =?utf-8?B?VTBWd0FWWXkwSmJsSU9vMGMxc0VhV0FjbFEyYlR3a0NDb1FHNDlHYTVheFNB?=
 =?utf-8?B?cWR3Skw5TWc4T2IxeWxoNWxBSzMzNlEyM3dCWGVVYU93ZmdBVzJlTUlmS0Yx?=
 =?utf-8?B?SVhSWjZWK2M4N1RJTngzeDM3Mm1nbUV2N3VzcStFayt4NE5zRkNmWG9oanhM?=
 =?utf-8?B?bFpnbFh1eEFKcEhPRHp6RzNDdm54VG1xYzdLa1I3WmIwR0ZkcVJSaWVtY3lF?=
 =?utf-8?B?Yjk2eSt5dmNPK0N1T3FJVnlRVEE5QjFINGFCQlh4TmsyZW9QSVN5cUFNb0tG?=
 =?utf-8?B?QllRSnhYYUVFdjd4Q0dobWJFejZkVnQ3RFNsTE01MSsvSll2dFEwcUgzY0J5?=
 =?utf-8?B?T0ZVdG1IalJiQnBoMDR4Q0dxUlRwR1ZpcHJScTYwRkJITTc1cUh2Mk13aGpO?=
 =?utf-8?B?UUNXVHBEQmJnZUxhM2pPN0dLbjVsdENaYkoraCtudk9ra3lJM0pVb29TOUxK?=
 =?utf-8?B?M20zWEdUM0pYY1hMYmk1KytvK0tYK2pFSEEweGFOSi84OFJMMWpPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb4252c-2992-4e49-a53b-08df083d6386
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:26:26.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlmgaDZfzt2CYpE7qviaEHsndJxjR93jbHMNLpOz63NXucwmXP3Z8wh+pRyhiktH2lcQBl+fVyremNi3x0vgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB541025



On 8/31/26 23:41, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 9/1/2026 1:14 AM, Mario Limonciello wrote:
>> +static const struct amd_max_freq max_freq_zen6_client __initconst = {
>> +	.performance = 5025,
>> +	.efficiency = 3524,
>> +	.low_power = 2399,
>> +};
>> +
>> +static const struct x86_cpu_id amd_zen6_client_ids[] __initconst = {
>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x80, &max_freq_zen6_client),
>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x81, &max_freq_zen6_client),
>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x84, &max_freq_zen6_client),
>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x85, &max_freq_zen6_client),
>> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0xe0, &max_freq_zen6_client),
>> +	{}
>> +};
> 
> So I see:
> 
>    WARNING: modpost: vmlinux: section mismatch in reference: amd_get_max_frequency+0x27 (section: .text) -> amd_zen6_client_ids (section: .init.rodata)
> 
> Since amd_get_boost_ratio() can be called post init too, I think
> dropping the __initconst annotation makes sense for these constants
> otherwise we may have issues after initmem is freed.
> 

Thanks, will get this fixed.  I didn't catch it because I usually step 
out during my kernel builds and it didn't make enough noise to stop the 
build :P.
