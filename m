Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F5386C04;
	Thu, 12 Mar 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349149; cv=fail; b=gO2H9f882xWHRcnQeuTzSBjyNvyuq57O4NX/yLMYu91Hm2rk7us1L/298cCiYkRZEuugmqQe1qWqFYScWcNpnIK2a9NT1GphBqnVOdUWFqqmxL2u8kiWTE5Hmue63eOPaFGTCLNiG9Uxuu0a73q+FDTYOzx8HwmvIAciOkw7r0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349149; c=relaxed/simple;
	bh=vGLRxvW9ed0aaW82ND0Jcx8PuOq5SxPZ/N673nrDeZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsfJLuSe8I4KOzmKmDZGeoZlSkwKU76s3XN1pxrsMOCphDxy+8YA+hb8CV5kK0At67LejmHgeDKqpZoBWiDfVdUOJSkyCSd0JokOWuYpcn81Zld2iKcyyntrRjfczaLQjILYHiY0Ajcxtu6/o0AIkOlBnOywiTNmZbDvdOYyY/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0tVtJlK2; arc=fail smtp.client-ip=52.101.57.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0tVtJlK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMYXnWjLwmGCqeuBSgDOnGMpsB8E27SL05WQoEz6SedRxnKsqDN8bcDGG+TYC4tHro+O2SALFIYHKdlsZH0xy8f6INsr1mCvcIr64UghUF+E7bnKUbKVCVOX1wUxeyFSSHNHPr1ZQmHSdg4SPRUbUCeVNdaW62rr7dBR/C3v6jCT0MVx+cy6LZWEf54mKL7wyUnvZepN761N0rs3IceyYDDoFUxiWWNNEMrHPOO+X89dS3kf22hfC0IVGWsXPgwv6VHmNtkLkrOWBLNTxmBHrdv3gk2k70cUHz4FfD+VREwsrMcbNFIu+3OOb6bz9R8cxJZ1beBy2wPpRrcgn3n6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyJYsh11EhuLe+pgoM8pbNHmLQOjcNW1VMy1MRqOMCo=;
 b=IHRoECwW4J4UiXkv1D18r+O/BZ1dvL3+kNC73QWYXoEgoVkFviFQIqzjWA5mi7KrKd3a/B4p1owKqQfDH/V9VfJpR54ekk7POTeqL/Zf64TBwpWE9GLqOuuwF/7fpelZhHjVmt3sqFmEPgnu6Jm3ShYuJItsI6Z+jsC8jFurPnGyI0fccc70QnPpPZtMvHrJ5X1+uzAg9U6vzXRYf9v9fD23GIT1mgCJ6cLW+Fm5q8YDSloyh06Z5ULZvqXlYR90qIRzG381fpt76bGq2hRhbaO7rA1bXbCl1AEn0n0Lscu/rhT4uvWUgOE+ALFhnT95PWCvVoGPyjSiRfNKeidErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyJYsh11EhuLe+pgoM8pbNHmLQOjcNW1VMy1MRqOMCo=;
 b=0tVtJlK2lQnQe2Nb7XFEZOIZL+hoE6Df890hLg7j8fI0Rc3ujtLkjdPuIO2ycfebgLQNM68DAFpbOVBynHmmei+on2pV+WCkhHtyPpq5JWBAbz9+twGb+RHdPwcXovDmEHm7P5vnRWdrT9CJghTp0+RgnxuqBoPPQP/h1uQjCJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:59:03 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 20:59:03 +0000
Message-ID: <9bb8de30-47de-4a7a-a2a0-379dd8302aa6@amd.com>
Date: Thu, 12 Mar 2026 15:58:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] Documentation/amd-pstate: List prefcore related
 sysfs files
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-9-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260311140116.19604-9-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:52::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: a86dd034-f45b-46ef-ef5b-08de807a312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	htamybiNDIdDu9qkfksp2qDhtqRnqO4PncnSyLwbj53Qy70tnlFj8Y4p/3VgeFi/H1rShcd353LWkiaD8YG3D05ka6QMTemxQx0RBJxxP/WKs3Hhcd4vY7KGcIWcCohNHpsxHAkh0L2uai91fHZLzQKpyPwclclLA2mdVg043Imx/kAHd0A53bmdOhXTVlDHSv/QVVqRX/RCQAgKvqANZ/95sz+l+dmuEnbIOW8fUpZ/SYX11pFryXCGNRAld44MwokFRvCuI6CQn3X60w4kpfJ8zLV/qL2HvH85BXRTXsH3FbzzTuiCxZZzCszu5GxCucx7ZduWqoZP+dtJtSzaxQUslAIX1qBzUOWEE+aWEh0zg1iJgfMl2+SLmH8Vp7HEtNu2eF4H8j8fVN50CNs6sGIVrSqwJpqRMAlhHnkwdDN92qPvO5GLHml1ihhV25U5Qt1Xqj1jZjI/BaovzWLNai7kMtk6iPPOXVgM8h8tM/d63A4q6Upa0jfDVf/KpQ+BgUxv++2l0CUakPAzGP07AkqyNPUPBseN2DzW3Bcc7cvV/W2qBpi2D4WhIbPsb+rXN4pYlWZwnIR/y2JkVpbE3htGQy54ZylQLEiCFfgIqx2RYCla1HWkOHRpCLrVy2wLE7oO+iIh744hnlK+Co80r0mJEppWUOhobJoeozL2WNzLIuemY86+zNZMkrYQnDsXDtp3IIjLxcinSBV2+cOYODBzHMw/fECHFQOiITr6wnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWk4akpPYTMwc0thSG45L2UvcldHemVldWN1WGxOR1p0eVZoOWpOVGtXd0dK?=
 =?utf-8?B?T1ZmbzhzMCtZL0dpNC85dTFXWUFhdUp4c1M5MlB2WFBOTzFFbktjVHRHSi9p?=
 =?utf-8?B?amdxeU4xTFl1RWxheXJPOXpYMHdJa3VqTnI5cVFxSUhwcm9McVFRQW5KbEpH?=
 =?utf-8?B?OGpSendselNCaDVvVkhkWlJ5aUdpTStRRVFsV09WSUtTc1l4Z3prUWk0ZDI0?=
 =?utf-8?B?SERNU0t2Um5qeWt5NERZd0V0Uko3TE1zOEtTQXhvKy9oMmx1QUFKUHlZZnpD?=
 =?utf-8?B?ZVFFNW94NmFDYm5uelNPSHdNSWhmWWNRelcwaURMZzhPMWQ3RmhOTElIYS84?=
 =?utf-8?B?MEhzRUJLOXA1U0ZSRzczazJjYmZiWWN3Ukx6djBTbE8zdDd5eTlzNGFsd3ZM?=
 =?utf-8?B?V0RDR3l4V2ZRMGV4Y2RaR1UweDZOM0crRGVUQWtVOHo3bmswUFZKYkFGL1dm?=
 =?utf-8?B?cE5aL0tld2J5Q0J5dEpnemZKTVJlQVFJa2JBS29TMTJpMk9uV2xLSWpXM3dL?=
 =?utf-8?B?bWF2empkRDAvZzJabHliN09XT2JwT0ZVOXNCOHNiNDlPelNCVm9BU1NRNkx3?=
 =?utf-8?B?TzcvMFNpRk5lZFUxRHhGemgyMTVaUTh5NVhUNWRwK3RLYkpwRkpOam13K1VW?=
 =?utf-8?B?UXFOdmpiRmlvUUtmSDIvVXgzYmFmekdIY0hHTkxrYjliT2NJZVVOK0c4Sm5v?=
 =?utf-8?B?SmVRVHRzanBLcGZLYVJ5cllFQUhuL1NVdFd2dGVIQ3dnS3VDUVNNSm1tUk53?=
 =?utf-8?B?WVlLejZoWGRNMkJFdUVBSnR0RUo2TmFZMHpBOGlxa2lJSTVRaUdabUFIcnlP?=
 =?utf-8?B?UTVneHVOYy9VTXF2RTUzU0RONjcwaWhJVi9KWVd2cXZBMjNNcG0zZGhockd1?=
 =?utf-8?B?NEd0RWN1SHhKd29SUGNVSXczb0Y5RmN1QlpuTyt5YmtlTFpxVndRNnQzbjcw?=
 =?utf-8?B?aGIvZUlRbHhVblM2MENqekFSZTZDbmp6dmRseStMa0gxLzZJdm1ScmdZR3Mz?=
 =?utf-8?B?Y1JTQ3dYTXJBTklBNUJMT21YZGxvQW9oMjM2UkY1cE1xa3F5a2VzTEdMZEUz?=
 =?utf-8?B?bzNMWUVha3AyV01JbnFRdGc4VGhZaERpL0dZTnZ6TjNaRjI2UkJiVE55ZXN2?=
 =?utf-8?B?N21iYnFnVEZwY2xJSmlVWTJZdWp0SE1yQVVBcmdYVGNOeWZ3a3BhK2dyRXJR?=
 =?utf-8?B?K0loNGdTV1ExbmtTZ1R2eGY5QXcwRnRVYmQ4OG1rejVaZHVacWNuM3RsRlRL?=
 =?utf-8?B?VHhPTW9OU0hHV3VtZWFtT2N1c3JWVy9Nb25aaUNEQU45dVZaNkpRbTQ2Ymxz?=
 =?utf-8?B?TkUxeUxQbWpqM29TdnQ2Sk9LMWh0ZDIxaFB3clZsZWV4KzY0VGdDTGNsY1c5?=
 =?utf-8?B?V3pIU3owSTB6YXdOdjZmMWlFWk1zbDhVSnVTUUwxa2dFZTNzLzNrWnpUSGY4?=
 =?utf-8?B?OHFkd1RDNGRYZGJ6VjU3SlBlc1pPVkpaZzZuNjh2VXZteG5yTWhFT1FrRWYz?=
 =?utf-8?B?UmQ0ZXlEczRsSU9SUlgxeTR2L1Mwa3ZSNWlVQ1pmVWFmRGJQdlpxaFMrL0dL?=
 =?utf-8?B?NmZJS2hSa1paczdMekFkWHBZWGhDd3k2REZGZllYTnVqbTRMOVBJTmZWaXhI?=
 =?utf-8?B?L1Q0TVIyR3Q0bEg2cGJqclgrQVhsV1hNSEJ3S1l1ZjREQlpaaW5IUVRpTHha?=
 =?utf-8?B?dEVkUnQ1YTRpSjdtQkExTnYzd2RVM3JxRWQ1U09HZ0VVeW9iTThvQVdnWFlR?=
 =?utf-8?B?dHVtcjhPd3phT1hJbnF1UHdsYjhkdC9xODZrOGRUam1ySXR6MmlRVnVtak5x?=
 =?utf-8?B?eWVsRHZSZ2xBcmdJcU9tRmRxQjFQaG5YSUZiczZkZ1FJQ3hSRWg2ZUt6ai9M?=
 =?utf-8?B?ZGFrclJ1SEdpc1hXOHg2RlVkbFZTY0FiOU5XZEpSVTlhSUdDK1l1Vkwxcjlv?=
 =?utf-8?B?SlowNFpySEVDTkNtcFhQTXEyaEJJUUNFdmRhREpuZERnUWFXZStSKzdGMVRt?=
 =?utf-8?B?Y0JLU3FhWVkvTUhCUmJOM25Ic3dnTzM5WFFjS1FidS8ySDFYU2JVcGFVY2JJ?=
 =?utf-8?B?K0wvdU05NTlxRWpFT2YrRWFsTityMCtjOW95QjFSSkxLMzdxckpROTJJWnYv?=
 =?utf-8?B?d0EyWnhlamdvU0pXbTQzUHdqMEpjQ2FTNzA5NWRHd0diclhjeDdRbXh3cUVV?=
 =?utf-8?B?emRLSWZSc0tkaFRENUVWbGFnc0p4RDdLR0YvdWw4TjVISEEyeStFdTB6c0s3?=
 =?utf-8?B?VERuVHVUN3R1Sk04aHhBblpyNVBpeFBwOUVNWTRaOGRqQWVvbUZacFhJczN1?=
 =?utf-8?B?UEx4VFlteFlaMENDbHZsUmNmb2tZZHNoWXd5RGYvbi81MzNLZGd5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86dd034-f45b-46ef-ef5b-08de807a312e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:59:03.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkZzoOfiyJ49Pf3ccqKJjmCCJkQrXV3hWGR6FBA+rye71q44xn05lvaI5WchKhWQhq3pHSPCrRsIGjj8Pb+rig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205



On 3/11/2026 9:01 AM, Gautham R. Shenoy wrote:
> Add the missing amd_pstate_hw_prefcore and amd_pstate_prefcore_ranking
> filenames in the sysfs listing example leading to the descriptions of
> these parameters.
> 
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Can you please split this into two patches?
In the first track down and add a Fixes tag for your next spin for the 
missing files.

In the second make the change about the visibility.

You can add to both:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e1771f2225d5f..f566fea6613e6 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -239,8 +239,10 @@ control its functionality at the system level. They are located in the
>   
>    root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
> + /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
>    /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
> + /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
>   
>   
>   ``amd_pstate_highest_perf / amd_pstate_max_freq``
> @@ -264,14 +266,17 @@ This attribute is read-only.
>   
>   ``amd_pstate_hw_prefcore``
>   
> -Whether the platform supports the preferred core feature and it has been
> -enabled. This attribute is read-only.
> +Whether the platform supports the preferred core feature and it has
> +been enabled. This attribute is read-only. This file is only visible
> +on platforms which support the preferred core feature.
>   
>   ``amd_pstate_prefcore_ranking``
>   
> -The performance ranking of the core. This number doesn't have any unit, but
> -larger numbers are preferred at the time of reading. This can change at
> -runtime based on platform conditions. This attribute is read-only.
> +The performance ranking of the core. This number doesn't have any
> +unit, but larger numbers are preferred at the time of reading. This
> +can change at runtime based on platform conditions. This attribute is
> +read-only.  This file is only visible on platforms which support the
> +preferred core feature.
>   
>   ``energy_performance_available_preferences``
>   

