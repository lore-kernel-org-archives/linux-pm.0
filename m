Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8B40F72F;
	Mon,  3 Aug 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762487; cv=fail; b=USGARRHhSTGvcD587NQfPXrRfMdQgtzcG5Ja3nulFzmB7q/G3QzA+/Kk1LBaDzafKGCYy60fLQWvHD1Xa1aCT1lGJ7n5Zb1mxXLcybQ+Il4TJATvAYPt9WK95UQe7XMBQna+NuJksutMyiG7stcJTagHQTSp9WMrgWPaUxGeX38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762487; c=relaxed/simple;
	bh=5DVI8P7Xa8JqtpiP90Slzl+Tpvyi1MMFe7xZQc9znf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ls/d+BDXfkFUF1uV8gkPyyvXfaoiajsdNuOyY+OVHZbRit81bYhISmEntDazm1v/JoMh+OxRZ98L6Rhn7EAIhmy5u/xTnpau9jP3YjpJGnWpbJKnfv9Wrdvp3t82iUVkYHc6PM81rPJXb1yIT0mMvDnqco5dxvrS3fzT++kCk4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C92vm85O; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C92vm85O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqD+J41JCVPCkcKsmxUCfXj8YZS7JBmic3R+M9pT5MYUju6JLbBXIdpGCGJ72C0U3kpE0zVVsVwbTt+7Hdd9fZpFUhrcpsE463bxhysFyPsfVjjxKb1GV72na0Uh4kiU6I9FwD6OiTTgHRKJW5z7BC4ilyOqmClzUt1msNvu/ufQUmgZIAdDCmoGqac3MSnPGxcFaSMVvTRx597RmYf5T/7CfNYTA8fQE4UmnoaNxp/2CQPzVHOaZoclwyrFs1bGb9ZFD0zwb98iDvXI2kzkemObSFIMPcfBfsHJUWQN7M2uBU+DETr5cGBMNZU+8ecvpRRyFQdy0pLDE+2/M7urEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn3rDZ89fjzMYTzy5fEiEhIbvUjWefjtsXos2WYY7+I=;
 b=NHtnXc9WASnryDrFNzNvLJcSAVBT4llRBfZqeVM+AHdOTWZ/qnmx/ADWC8hOrk4L/bNhiLpQ2eaBRdGrPTp+sAdGpig4WGTknu7Xk7K5tS7g3mHaLNcOqBReH5mjjkCgWYPNomJgHmdWW6ECn8H2csD63xH+XrVs5OFltIV0iW5Nx81zjVN3iXvOpFmWyzSlcbsnAdWtm3FVHtZxco7VYkDYAqdV92hQirpKHoyCL1kxfvYQjS+CiPigzM0+1pGwflmPc/PcFJFSbBD8JM9pRLIHBxjJuQ9x5jISycrPZfkRbWASh7lWXeRnekVJWI4MwjEGJu66RmeuTUq3670GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn3rDZ89fjzMYTzy5fEiEhIbvUjWefjtsXos2WYY7+I=;
 b=C92vm85OIPUnnCy3wpHSU3qPIrVpccBl/kJ9AkGo5mIDo6M9AZeTY9j+ZI+RKdFIBbiyI0kG+Cf2iOjqrV89Xeu/bvgwMsDObB6/0XVputUsB1tlzdpLd8YbF9Kxa3zPj9zIPnwpKivN7Ycj0e8cVm+wdbDuFnFAivFSumi6W4SSFgfdcm907bZZptYk9v7aTgWMIcagalLy7zKQ8/bt7UY+oE3X59SEfTa6pnGxnES17oM/tpvkuc5qmcBS12Sra5QDP47U1/HOoHYzgmcZrAYWNUiFyerLTMNtXFVeZXMpps28Iv+hfHXORnm5oXGbjQXFHUSx67xoaHzp7hKVeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 13:07:58 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:07:58 +0000
Message-ID: <f93e0c1b-e343-4767-a340-1774c1e8bdee@nvidia.com>
Date: Mon, 3 Aug 2026 18:37:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] ACPI: CPPC: Avoid Desired Performance reads on
 ACPI 6.6+
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <cover.1785749175.git.christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <cover.1785749175.git.christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 076f005b-3d10-4927-9613-08def1603d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/qIFsnMdvdBxDX4YlXmnm5fKX51u/Gjd4df3TjkLfRnpz14NhIYKClPNhjBtAm17NLDU0HayOXT/L3/wtny8nu4u2yig4l9Y0soxSBL9JbSfft7VQ9/PZ9HnhogwhRnYCeaQawrTqFc6bYNqAOou9AjjNHHHvjqPn41tf5+/QI6RHqw1PHq3YPStJIF0QfkRtyiW4aExNTR6J15ny8LGKKWtc+nEYaTmz45l9jsldKxPm4aLxTpOx9D2VQnqHkm4wncoVxS8u1KoWKgbZuEG4/5Qa4pG+m//BSpa1ZMjiV7znRDbUvAqti0jcjWbR9zTT8xUtOFnPvolmuMICb1NU7pRyaTk/iWjRI6+yEYittKrEf0HMUuxSVnEcVY1AZ/9sZYEEbbisz62fTPBBz/3nejcSjxLAR5l6R24OfiZLMEqzV7JcPE/3dBQVe86Q+2q6RTCqdkNZhk4RmkCy1//QHGlSNrMtFOgKKfXQt4P2hbJU53+2Jfhg4NH6qYTpj/yprzvVhiGjuvf/BmDNBoF1ic6Rm9GON6SXE/nak/o1agAtYoIIGwyLFExncLQTeXab4IBb2tgD/pwm/RHJp44ckxLoDtvLTYsY5M1JFJhx7PwFyZ2O/MMDp7r2jq0D1dbvyvLUwCJR6iw0ePLRvvAjle1x9Hsevx4MuO5v42Xrg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHEvbVA3RmIzZjAyRzlSVDNJek9hNVZSM1l6YlRkek1rdksxVG8wSVRHaWEx?=
 =?utf-8?B?MUVTYjZKLzJqbStVVjRlMWJSeEcyVzlHMmhrWGh6aUd6N1dIWWVDNEVaWU1O?=
 =?utf-8?B?WCs1U2lnUUpCeFRzb210N2J4SnlaWW9tTkZoQWR4UmcyeDBxN080OUp4dEJH?=
 =?utf-8?B?RmtOdVNCamV2dG1EVTBrekxtazA1OFZhbXJnMFNBQXZLV0Y1THZxem9jby93?=
 =?utf-8?B?NFZEUHdMcXJVVjBhV2RCckMyWXljejlNb2hpYVlrTHBJUmF5WGk0bkk1REl2?=
 =?utf-8?B?TUpKd3JSOGhTYWpDUExJM3p3ckZtQUFOekRpTUVmcG1LQ3BrQmhyNDlldHNY?=
 =?utf-8?B?bkgzVG9GRkpwaUtobHExc1R6M2FOM1FNekxrSWVGODZuNS9ZZWVrSGdxbkl5?=
 =?utf-8?B?RzByMjNPdUdBcko2eE5iM3JGWWNhdko0cUZldmhwcW1lVERQRnREVDFmK1Ey?=
 =?utf-8?B?ekptLzVWNzM3N3Fsb25zK1RtdjNDZXdYVktxZk9WY3JXbU40NnVXcXBuNUcv?=
 =?utf-8?B?ZHZXR1hlZVk2RW8vaHppSVZlMkIyb25MMmtmczYrdS9vUlF5ci9qcjJkdkNX?=
 =?utf-8?B?Z3RqY2Y2Tk56M2dLZ0ZpVHNHbW03U05UYVp4UkQxTkkzQ0xpbXdyaHZFY0Ry?=
 =?utf-8?B?OG1Cdlg3bUlzQ2pBWCtWUTdRYUxBWlRQZHZ0My9Qam5QZStoOWNpS0NENmZE?=
 =?utf-8?B?MFpEWUhjYzdJbzFtZnQ5WTFZdW5UWHBkV2M5azYxU3cvdGJVVmY4NWVCUmc0?=
 =?utf-8?B?dmpIUThkVlVMaFhJUjZmUGk3dlQ2cEFVSGs2c0RBaGJPcWx6UzdjRUNUb2ZC?=
 =?utf-8?B?R2t3dFNMNDJ4RTRTY2hTZjhVeVlQY2dwMmlkV1NOd1JiMmtidHJWMWZUdWxa?=
 =?utf-8?B?U0FMblpTT2QvRUdOeEJuSjF0cmZqNk1QeStuMjhuRFRocnJNeEVMU2NTb2d0?=
 =?utf-8?B?UStHYkliTkw1T2VhVHFnVkhIL1AzMWQyVithYkRLb2wwMzlIa2YzbG5VVktl?=
 =?utf-8?B?UXNhR0RCS2RIcUozaE0zV3ZyV1puYUc2Kzk5ZklHQ1VZTzVNQzZaU005Vkw2?=
 =?utf-8?B?Vlc2cDdQSm02ckdzYng3dEQyc1IwM0dBcVRCWFJaeUw1SW5jSUMyOHFpc2Nq?=
 =?utf-8?B?U1BMMi9NejlDUXBndDNNZWlBNFFkY0pWbnlOcG1lNzRnNktZWWp5MWYyVisw?=
 =?utf-8?B?TnhoSUU2Uk0rNVRZNFRFWW9wbnY5LzVIR0ZralBOY29JaE9mYWZFUlpwZnEr?=
 =?utf-8?B?Q1JKd2xzQmtDNDVYT0FUaSs1Q0JDcWM3elp1SDR1RU1CbzN1WU9hckF1cExO?=
 =?utf-8?B?RW90NVRHOEJpY0JpL3owUFBGVWRFeWFSQ0xoMGhENUQvSFlzNytPb2dzbzI5?=
 =?utf-8?B?ZWdmVUIyY3JBbHVjUzBheVdYMTJEU3AvejZmQnJiVzNtL3NxR1hxTFBHVUZw?=
 =?utf-8?B?SzFjMW9Zb09XTG5tNmRoQTV4R2VsQjNjQ2lDUmNuUngzT25ra2ZmdEJiaFhk?=
 =?utf-8?B?dHpHL1d5Q21SeWFGeGNVUWpWK09FN1B6eEluNEQyNStjeXY4WThINFhFOEZt?=
 =?utf-8?B?NzZqV2IrUDZVV3N5MTcrbjJyb0NzazF4OFBqZDFXTktqd1RJY0sxcWRnb1pM?=
 =?utf-8?B?M2g1VlVoSzFPNGY0OEJVajJpaUFxNmsyUm5YbTF1bmF6Tmw1Y253TWg1Y1hR?=
 =?utf-8?B?Njc2NXpDbW1YeExKbFY4TFk1bkZ2TkpBclB0QmZtNUVYTFJRdWtmcFBnREdR?=
 =?utf-8?B?ZVUyTWU1Uks5TVNheWs4SlZlUmVlRlI3aVVkMTc0eERYdDl2TnNtTXAzQUZG?=
 =?utf-8?B?YnZ4VWdpVlc0ZzcwQ3lYTTZyVUN4TTVVaEVaRGJjWS9xYjl0V3B2eHgrbVIy?=
 =?utf-8?B?ZkZ2cndNeTdFSTVQWTZYdStWMmtSUGRLU0N2U3MxaXEwZHpjYWs3bENuN2VX?=
 =?utf-8?B?dHBkUE1iUFZxVXRyN2RKdUN4WHJzdDFtMjl3bEhMdGNKMTJFN3I4dStQdGdu?=
 =?utf-8?B?UkFBNEgvQURHY0I0aDZPMVN0RjNDSDYvTnJldGdramhiNWF0YURxbmZrZG1n?=
 =?utf-8?B?OXN2VVZ1eHBURU5YSHRFUm83RktFKzlzL3dKeGVDSXN6elUyMDlUbkxLRHF3?=
 =?utf-8?B?ZDgxQlQwWWxrWkllem1kNHlKcTNvNlEvMW0xTm8zYUtzMVlGY3gzTEw1TStE?=
 =?utf-8?B?K1Nxclh0YUg5NFRsYmRhWERlOTVwczlSNVVUNmdQVWFkTk43RThNN0hDWDZi?=
 =?utf-8?B?b1dxWmsvSUhEcEJNQ2ZDWXpmT1RXbVluQ0NuSjdlaFFSQit1cG4rWHFUSFFh?=
 =?utf-8?B?OWxrZVlBRTNtRVdqUG9oSFJmQ1k1NXhhRjZZb3hWRDNGb0dFMFZpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076f005b-3d10-4927-9613-08def1603d69
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 13:07:58.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipxdT4fH6Sac3C96OGpXhxXG5IXmgeCxrFvSHCF0RLgk1dsXHozI7XfLpOKaezYvv57hts63++KRu3/JmWGHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979


On 03/08/26 15:32, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> ACPI 6.6 changed the Optional Attribute of Desired Performance from
> Read/Write to Write.
>
> cppc-cpufreq reads Desired Performance when feedback counters cannot
> provide a usable sample because some older platforms repurpose the
> register to report actual delivered performance. Preserve that workaround
> on systems reporting an older ACPI revision, but do not attempt the read
> on ACPI 6.6 or later, where firmware no longer promises a readable value
> and cppc-cpufreq can fall back to its cached OSPM request instead.
>
> cppc_get_perf() also reads Desired Performance while populating the
> control values used during cppc-cpufreq initialization. Its only in-tree
> caller overwrites that value with highest_perf before the controls are
> first written, so the value is never consumed.
>
> Patches 1 and 2 provide minimal, backportable fixes for the two read
> paths. Patch 3 simplifies the mainline API by no longer reading
> Desired Performance through cppc_get_perf() on any ACPI revision.
>
> Changes since v2:
> - Fall back to the cached OSPM request when reading Desired Performance
>    returns zero as suggested by Sumit Gupta.
> - Pick up Reviewed-by tags from Zhongqiu Han for patches 2 and 3.
> - Rebase onto v7.2-rc6
>
> Christian Loehle (3):
>    ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
>    ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
>    ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()

For the entire series:
   Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Thanks,
Sumit


