Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45733450F2;
	Wed, 26 Aug 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752815; cv=fail; b=h+YGWAOnuwjsOtW9lJjvV0grOCVohZulijDI2ms2iDQlwENR8JE2AasMgSlYjZUNOg3SbQxtmESr3f4rdw3my9GEGKaKceOYM2ArRnX1oS+MtCQnk+zr3e7fywg9Mk3zmJOVnqRLbOX8LzDsrA+KDDxXewgTz/7hDFuPrKedwtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752815; c=relaxed/simple;
	bh=Bw1kQ9h4nKlwsckDcTnr4Q95t3WnXu0qe3iIVJUpGGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LYbsrWBj9eLxdkZb/M6WWUG7CgjRiVgemGHI7dsFC3UnPgq43BfdS3okRZL8hakeuz2WbkynPUgn0QtfJzkbWcMT3XqyqyjtIY3CT0yJDDQH6tJuOHVxETXThhDrRCaHuJ60waYu4IAzcXXq3xux6z21uQBb15eJjJLhTW6XvCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cN681krf; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cN681krf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHHuPIhgjKIHNF9VtJVhCoy6bkTsqDbIPMSiR5GsIcLtceWzj6k1vqPUbyq8y8wnxGud2Zbsg/F4DJOv/MsYZ2lEFo1QqVxpxPEiC/tmonYGz3gE40ol0d92H8i2U02qdXSq0gnn+p7DqXW1BcxsqopkjwcmeTvoEVdWV03sWOr8tYmOJ6k6boCSm3j3tCIXLJNHTutZVywXZKfFAsEH+ATmDbRcxvbT4tNBYMOFMPCabMY/BBJkh4vMs9EvOsx4iTYOeHhkipF4jPfJh5O1fGkryPYOdz49hm0mELpSetSqk7HpfU1IGtn14majNtvj/9vBAJIYel3w62z/fRp7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRqCf4yoA6DaIYWOaCQScp8eme0LZnwGjtFKwXgsRWw=;
 b=c4dHN+Vm8JpsGuh6+BYTWL3NMD5pWSu9oPyrVQKBwPiq8J1ipDqxnEqumeyperMwdTSQJEcR3/id6IUoRPUvQFRBC/xQtPElmHYYWCe7gEJd6GNLRvRux2EXbwyJC59WL6gq/Np/0jwOdDyRHr+Sp8KtGVcvBgS8p+cl5NlYKk3WXYxm32WW3NH1dGV/Q5qRWb7DmzPNVL+MXYFP18PqU6y+RoVtCKEV2pB0s2e9bQoy/4ecg6vfaeMLgoxpnncdNr2cF84Pnj+4ewfbojszfpg7K8BDBW7KeGkY3MzbZPN+OQJk6G5ku9rYcrB3ulu84CJR6RLbQ+m0gMQbHHghoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRqCf4yoA6DaIYWOaCQScp8eme0LZnwGjtFKwXgsRWw=;
 b=cN681krfN+GpbZOkMAp/EJH1jo76+cX6tcSgqKsSMMW8H7ikrb3zm6Num818sMc2JljEk4Cu8vioyxQFJUB1ds7BOkEhBeHIS7RZKfWdNf0i1qEJcPtqTlhGOJh6bGDreZo2RnF3j2GDzoaeFLH3GJYJuTiDWsxBJwix0hHJimjthlb3dawfD/T26meMvMuTl2fT4+V9+c5OwoX/Rn4goumF9Szon83HkkKyekevrpmGQrONDUvvk6xKPt22YxvMnouiiDTc3D9vSkIl7rvb6eEpvd6lS0FDzIARwHqsXG1dOdsCzy6WDwgSAveKIjuGshJ2bLVnFE++Hjp0xx5YFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:59:59 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 13:59:59 +0000
Message-ID: <fd10b117-56c4-4a4d-be36-d083ad0fceae@nvidia.com>
Date: Wed, 26 Aug 2026 19:29:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260826063019.670240-1-christian.loehle@arm.com>
 <20260826063019.670240-16-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260826063019.670240-16-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe0335b-003d-4d9e-319b-08df037a5113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RsTtlm9Ry0bW+oC+LnuRE9gP9Xo4yNYZEtqb+C1V1yB7RdenvGxm3gycrlhD3fNGfCy8q0agn+VxCb52VyE/hPf2ccZhqtTyjFrgRzvETH9eD3FZ6GJBqYwbbQEfKdFsojhzz7N7xq4ooB/WdaTs+gs3bgqbIYjVUtuSGLufjpDxOSB60AjWuH09gz6nxzPW3LHlo/k3WCUhRaIsJTPMxSI4CH1bcrEJGUKfBJL4L7qpBe84HAIFU9qDa3I+62mAC9uAweKKZlbilXTF+uRvhwGfg0bQSZymf80QfcdGYPke8KosGpndYtxzpAhAxyEZ+wLl6N2y0i40+gnzS7blEgS6mhNfA4PTxjNdT1bHBwoDBi6XQZN36HlCFnJ/PS4So25yRuyCirx8O/lyCZsPGzfBE72V2avO8Ou4KQUZ/qR7hLFeY/sbaACVUW702TQuve2mlHRCTI2sNp3zl3IfysXMAk9tiItipiFnksJ1R+nmyCtYRDLuET9MlP3psRl0Xk/uZuTszJF6rDAztmueaU0FU2iJ9TLI8nUSgpBfn6ZTWXNTlJaowVr2+wXUSoBk0Ryd08WOOw5HPcYANUUvfJbV1fZm1jGz7i7wSCrficTevq9+YTRV3xus9FMxJ3JVyXB5yLI8FExUK1tz2U/3MtvtG8rWK/HQgsYoxqXl4EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWlhZDJUNFR1RHl6ZjBPV3RjS0RnVk82b0tQLzhjQVZqU3AyYUxjc3JsN1gv?=
 =?utf-8?B?MmFlRXh3Q1ozU25nSDVMS1c2QVNYcm9lc3VZRXl6WU42Qmp5YVBwRmNGQ3Zn?=
 =?utf-8?B?ZWVLb2ZjajZETC95T3puTDlxQjlZT0JRaHdYbGlxck9PR1BFYnViSUgxZmVZ?=
 =?utf-8?B?ZGFwdW1qaXlTVGVZUmQrdXgrSFlZVVBSeDVEbmoyNUNHOEJjZkFRbW84bnpt?=
 =?utf-8?B?QjZxUnRmSjR0MEFRMENRRXY1UklPbmdvWWRLakJ0L1o1QWhIR29UK2dOR0tD?=
 =?utf-8?B?R3MrNFJ6a2wxUEN3Z1BnMk5ZNXpBWW50Ylh5OXJUaWV3RjFldXEya3B6ZXVJ?=
 =?utf-8?B?MGt4TWYwN1BCeEZhK0tnY21QSlIyQUNJZEl6bmUxZGsyWTdUMmI5UVVOTTRV?=
 =?utf-8?B?U29DTmJiS01OMmEwMmI1Y3dvajFqTENlVDZtWFl6ZXNzVnNZUThlMWJkL2Er?=
 =?utf-8?B?QU00dVYxdGhpeTBsMWNDZDlSN29tNm5pcXZGRlBmSW9saCtvWi9haXRJMEc0?=
 =?utf-8?B?YVYrSldERnRRY3Z1VFozMHFTNTExakR2SHVoeWN1Vm92UzVVejFyYm1TbmZh?=
 =?utf-8?B?STkvMHhjN2haOTZoQys0UkRUZEZBeDNHb3AzcFlHZmJ1Tm5MOWxiN2IrcGxu?=
 =?utf-8?B?SE9OekJlOHJTbW5aMndwQXlOTGFIYnR5dS9lbHREWE9WaXFWREhKRTkxM0ZK?=
 =?utf-8?B?WEFpK1BNVXFiVEkreXlXVWZJTDM3dW13Qk14dlB6UFhweThDSHNjbVo5R1JF?=
 =?utf-8?B?bXBPdFlXQVk5L1Q1aHpVQmplQnNTMUpIcG1hcVBrWHpLMVgvUE9PTkxPbTc2?=
 =?utf-8?B?MkFlZGNVMEdUNGp0UnBrQmNlRVlXaTAvNlFFb2p6UFVlSEZpUzgxZ1ViTjNI?=
 =?utf-8?B?Vjg0cmgvTkUza0lScFFZZ0JqVmhScGhJVFJUcVdFWFY3am93NWpDS2ZaVVJt?=
 =?utf-8?B?SXJPMDFwbFlhYS9qNTdTelN6RWQ5L05iNE5KMnRjMEJYMEs3MU9pWkdNYlhX?=
 =?utf-8?B?ZllBYnV6bDZsNUV5UWk2dVJlMW5ndjdmMC9VNjZuRVQ1RHVCMVVlQ2hKcVRa?=
 =?utf-8?B?azkzUXNvRm51Z096NzZqQ2Y0ODBDdEZuSXdrcXM2V05mRVZOaUs5ZWpHU2gr?=
 =?utf-8?B?eHh1NmxPZVZvaWt4QWJzS2lkeHBsSnRCcGlOeVo3SnU2TzNMRDJ3WjJZQVJL?=
 =?utf-8?B?aXRiTWdIWnAvMjF2WDJQcWd4TWFJTWFLK1RUVFpYdkc5cGhCcTR1R3VNWTFi?=
 =?utf-8?B?Mmh4YytFY2doZWNQNFdMUFhEdkozdHJzZUg0WFNVM1BPSUczR3RvRVNrQ0dH?=
 =?utf-8?B?dHZiWVZhdjVMem84SCtGYzhiemVqN2xNT0s2ck0vT1B5SGxEVW1Fc216Y3Br?=
 =?utf-8?B?N2JqVXRXVUxrTEdjb2lDN2FyVk9qa0pwUXlVKzFYRW5zanZkbnF1K3lFdzls?=
 =?utf-8?B?SG5hMHovR2k4cEZ4ci82eDU2K1FXVW9NSUFlR3ZYTm1qQXJxRmtqSjR5M0po?=
 =?utf-8?B?Q0VacVVJWnJGZzB0eHgrcUNPN3pnR2oyY3h5VERLTCs2TUFmTGE0Y1VnWHpx?=
 =?utf-8?B?NnN5YWIvK0dLYm9qVUt3a1ZmdUFEKzJiT2xSVjhGV3QyY3dOZ1NHUVZ6YnBj?=
 =?utf-8?B?UEZvZkpJeVk5Z2p3VjVWenJaWGN5cHNnQjJUWm00enhxVC8wQklZL2JIbmZs?=
 =?utf-8?B?Ui81VzJYRnltZy9zMytZSEdaYnNHRXIxcFBITTJKLzJWTFlPUnJHcURPOFJt?=
 =?utf-8?B?cm9panRjTndMbXkwbktpVmVOc3hvMTBhLzlTV25uUnZpYWNjSXh3RWlBMkxR?=
 =?utf-8?B?UzRRT2RjMHdoUUI3VUQvLzJFRjlCeVRFdFplTmNNYXkyL0RnRGU5dHVFTEc3?=
 =?utf-8?B?TWRuKy9UQ09nZVNPSEtOYWFzSDVTTnZodGhLTW1wc2lIOFVVTk9vQU1rdUpj?=
 =?utf-8?B?TUw2Rmw3S0Y2THNtR2dNSUVHdTloN1N4TmRjcFljaDhrVHh6YlFXVGZOZG4x?=
 =?utf-8?B?alJEcmt2QWpuZ20yMlp4RmxsL1V2TjJhUzBGZ0RpaEZNRDV5cGE4MVpxUWla?=
 =?utf-8?B?aDhaenI0VE13bFRDbEJoSlEyUWw2d0E5dVYvL1VVOWZqcS80R1psSHlxT292?=
 =?utf-8?B?dUxPNkJ1OWg4cThtZFFCalVwank1STZBN2RzL3BsWVI2NXo2VThLQ0ROWWE0?=
 =?utf-8?B?SHRjTEJ1S2ZkN1VqTGJvMkkrQ1gvWVRmZGZ4SlVIOVJtSGJ2RlZrV0I3akpU?=
 =?utf-8?B?RUpCcGZQMktOaWxFUnUweTNZWksrRllUVFIxaGRrSVY2SVl6RE5oQzh3TmdK?=
 =?utf-8?Q?u2+tkmhBZOo5LOPPgF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe0335b-003d-4d9e-319b-08df037a5113
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:59:59.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk7Azb+YQrewOkBIQi/gmr9vkDEsfGD6B7HW4zNwYQcWnoSC4cGRCiqZ9z39glAFk1ZzLmQb/SeVSkG+OIVvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014


On 26/08/26 12:00, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> The Performance Limited status bits are sticky and write-zero-to-clear.
> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
> accesses.
>
> cppc_set_perf_limited() currently reads the register, computes a new value,
> and writes it in a separate transaction. If the platform reports another
> excursion between those transactions, the stale write can clear that new
> event.
>
> Write zero to the requested bits and one to the other defined status bits
> directly. Keep reserved bits zero as required for hardware status registers
> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
>
> A partial SystemMemory field would still make the generic writer perform a
> read-modify-write to preserve the containing access unit. The
> per-descriptor spinlock cannot interlock that RMW with platform updates, so
> reject clears of such a field. Keep the descriptor mapped and readable,
> because reading the containing access unit once and extracting the field
> does not require RMW.
>
> Also reject another writable SystemMemory field sharing Performance
> Limited's access unit. Its RMW could similarly replay stale status bits,
> and an OSPM lock cannot serialize against the platform.
>
> Also reject 64-bit SystemMemory descriptions on 32-bit kernels, where
> generic readq()/writeq() may be split into two 32-bit operations and cannot
> provide the required portable interlocked access. A naturally aligned
> full-width QWord remains supported on 64-bit kernels, where the
> architecture provides a native 64-bit MMIO accessor.
>
> Performance Limited status is not required for CPPC control. If firmware
> describes it using an access which Linux cannot read safely, disable that
> status register instead of rejecting the processor's otherwise usable _CPC
> package. Report reads as unsupported rather than returning a synthetic
> zero, and emit a single warning for each nonfatal fallback.
>
> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---

Performance Limited is readable but not clear-able on my test platform,
with a warning on every CPU:

   ACPI CPPC: CPU0: Performance Limited register cannot be cleared 
safely; keeping it readable

This occurs with both _CPC revision 3 and revision 4.

Could clearing remain supported?
cppc_set_perf_limited() now builds the W0C value without reading the
register first. Here the field is 2 bits at Bit Offset 0 in a 32-bit
access unit. If Section 4.6.1 allows bits 31:2 to be treated as
reserved status bits, the value could be issued as a single 32-bit write
with those bits zero. That avoids RMW.

A full-width description already writes zero to the reserved bits.
Is the same treatment valid for bits outside the GAS Bit Width when
Bit Offset is zero?

Apart from this, cppc_cpufreq probes and basic frequency scaling work
on this platform.

Thanks,
Sumit
....

