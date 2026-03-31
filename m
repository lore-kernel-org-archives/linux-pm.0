Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863B3A1E8C;
	Tue, 31 Mar 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976407; cv=fail; b=NYd3m7XxSNiupgxgRFkaYIUmhB4NAVKXmcLnflXeT9U6XfGFuM7KcnNOqt6dlH3dGi74p5919/AvCpl6sFviUzwLSfdIjClS8b12LG1aZcTcGf+zXU2HqwA1jEGsyEysZFOquPRbRNWRMCUc/wbIGYUb58XbC0FEz9zNfkN3kTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976407; c=relaxed/simple;
	bh=EjlKqBDo4VheNSo4pI0UbQykExfXurErWgfOekyQvJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iAyAr/DkDnXxoVJHAL2zQ4cyhR/XUQMoqCl40/a0KLmRmcdGxDsCobpAfM0zjPsAuI+y20tAQ0tQp3TaVzlpy/c5csyJxlljTmBFgtY+p8ER2C7NcOswTcKVirgby14H2DxAOif25y4NADUJ2lxLT5n6h8dIn7DU7TN/ATrHW9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zrdFc1NO; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zrdFc1NO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEvPLyCTjzY5nqnwo/qBii1I1qAfE1+AaJaaJ1BQgO5LBHQ6LCnv77RYm6a0AlvDvvP/p3/buOwCdzFGHyURXGrw3l8iR7j1mpmNq8N4JNr/INmMMpdUhV0XAPPPzggZKnPvGr5XwLAC48/y2hYT0gl1QqgE2fL6JfGFts36WZWs6c9FRUza3yz9pnohduj5/6ov8K4TKqfE2YWWX9GMXvLlzInvAhwfCgYhKy73tPxkkgA14/51Vzi1afuo3dIxlfHwZQoSQxEirr4WcRYdFDEjeCs+Y/1KNNhQgrEpIeh1IZdxrBgxJwxiyk2wJRpgoK+6NpP7YqQV6qxSnVzNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8PKzA0VZJB0p64PuP2CmphBIdRFKrorYM2EjH8TK88=;
 b=pDHSGbisvapjYk4WA8ryeQZ6J/Emez0VArvphVWRVhqTr6/3HfiIKXPe+FHLHe1hRNU5Aajrg07P7zAaQgNi15VVQgF+uY7OPCx6nNCmcFGxLc5agtjkFkj/QgzYHPves/bp6KtvsQM2Yvi51xwcwX1iHxzgO5qTtTib9hFqFhZiUXV9joaQoC+5dw1XxXjOblpvJDimTOnowWs4dLJ5kvXKHD6whed4kKYH/lwKynnIuYUVdq4bSWt7Fcf5HsWXRx0UGwzfg6+H9UdHH0yJrGFFxsDKvRG3U13uLoAqv3SvGFiYN73KXEaRN+Xs64LlLj+JKSHPqhuciZ6GIpycug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8PKzA0VZJB0p64PuP2CmphBIdRFKrorYM2EjH8TK88=;
 b=zrdFc1NOn6M0Md/xiLr3tv903bc/5qHXJfwDHcoKfz8PJBCSAV56ewx8z0vdtCojhC5SdTW+FszWJfcXti1yGIOQSFM8pC5Ze3MAxqnWQS1OxDh8tJ/s+8Oiq+Pcn7XxDwrh3/MOQAZZDJWumQvkxdxxxuvNANuCY2x6da4g2/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 31 Mar
 2026 17:00:02 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:00:02 +0000
Date: Tue, 31 Mar 2026 22:29:55 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] cpufreq/amd-pstate: Add dynamic energy
 performance preference
Message-ID: <acv9i/LeVfpImFsm@BLRRASHENOY1.amd.com>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329203811.2590633-2-superm1@kernel.org>
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: a95275ab-eb1d-4396-ecf0-08de8f46f300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HALoRePAbxDas5Dj/UhhISHq3auq2uvDemAU34OBqZOzXnsBxpgNFEFSVaUs17JeV6skUuPdlap8c8b1A4hZJnc60TjuRfPiS3Ws8FyPYzPVZHrs2ooXmY/QLHYoUSfKH4A5YqGkQyQ6Gm20c0knWWqGDY8psbnXQCFUnHTb5PbIJZYSqcPW2TWGTSQlolIGLJVdnXwNwJdYH/bwDUvGsdj6yIfR+LuIckMID9x6FhyPbLQeayotxAlvdKlp+VZ1tCeoOcu8OTK70OnAeRi4hbVC4F1EeKV64+CipfL9N7B6ZaL8o/xHjpzorPMXVlLAIBycx4q3yt+ME9BO6sACcrAf55IFk8qO9tD0yvxc9l9hpfYkaTRaMDfIZqcNsqm+yr68qP2ELE+uqwksCYailz21a9FiZ51nM7BAZOyc4Uba/sMNGvnOcZLl6l1N23yF4Ie+dZKgu9GVpeDUaeXhcHJEzYwiRcXjx2Yx/otjQ/TbCIl/J0nfBdM9aBBOSa6RtZFL+S9p6MZhsm0gM6rXNOQQ3F3Fq4nbXHtDiqSlw7bWbj8p0OskmoB29ASRt3IGBdxkYWZdxIodf5ejaY1qfJ+mDfQEbUgBpBUrONw+OO68Aeq8HW8R0zPpm7MIprasb9n8gOQgIFQQYuFbWg6TU71nnjlkiWCqtr77IlstPzohXp0bAJJbA1yWGXAsicjVK3YrYnqyowkn7QzZVKgK203AUz94/21ClpxSpPozhSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfS1rF5Fp0Yw+dy/vX1nJPnA8YjM+Sz6kvE1sAcF65enb168YS7dpi7bhCHR?=
 =?us-ascii?Q?DrPnENIU5Ek4KVzsyFdO4j4jdeEvJQsAXi7U7uU6SD7P0pE8JACnE+IR1yL8?=
 =?us-ascii?Q?Su5kmh63e3O6tU2QwL/ck4PLvhhwoMWy/ji+IJV1PsOtBQRKd4WogQhPrMNN?=
 =?us-ascii?Q?OFeL4VxU4Nw05jzb2cbAOJ6oezNopgaECUKf4dbhMimHsD7/UxmO0aYaTxrX?=
 =?us-ascii?Q?kGy+4BYDl6Yu5wPpUBzyeu5Y2C3jynIOewYFJ+nOUeBotExtGWd4Y9DTxs63?=
 =?us-ascii?Q?S3DvYJA5n+S8lsJHYf7dsAm96BbXvLtTJz/uWmOLIML9gJo1lvsviLocF4zB?=
 =?us-ascii?Q?AXaZPSfssV+G/K2S0WdJ3s1XEclXnbvzohM4KkB7f/rWCVzCSbB3HTQIy3dA?=
 =?us-ascii?Q?mqTRQvBqwOlXF7IUdOhNF7BBD6p1GxvypEZ5pskk34Ap9GFZjfgKRg40Idr6?=
 =?us-ascii?Q?alHgEW3gfQUIJdGdFz62r1mSAlE/e9W0Nh6544ogHsYFqFFItULcPUYz7EyX?=
 =?us-ascii?Q?R564LxNf99RloeVvrBb/guO8a00+O7XDnDJYpCeTZ5kzxq4JmNP71UYQgXs6?=
 =?us-ascii?Q?UTQGtMDr7PA++wVAvyVjcAhXJ+w8xpJo0epZuGV7xP3mNcK0bS1dAizDjtwv?=
 =?us-ascii?Q?dCf8couPrlmoXzkf5ZwWO1rARHA/NeKWSnCGFmdEjN2g0d/ik43AfNG3MoYh?=
 =?us-ascii?Q?q5PP7spPQhYYHxVn5FQeOKjqZ0VSjKl5YK48et25WMsP4fRGCAbW7gHLuJvv?=
 =?us-ascii?Q?y0KKt8f+aHdtFWAXbDVbB61aV0SnZFSPNKHggtxmBi6D9QUVVbnoqWDF8dey?=
 =?us-ascii?Q?c9eZ1gyTmjGw5ciOVJa8bkLaXTZnINKpBz0cTEWVC6Y4UhAWlohnrtjtjeXY?=
 =?us-ascii?Q?Y+elswO3eQ8lbxxVf3n2Z3txRK0vfIfNahDkPu0dBvT7tpA85pwmTONsO0x+?=
 =?us-ascii?Q?zJuCe/EEo0brfg22TZiKN85NO7iww5r6XIqjUr1dufoGpJJEPCaRl3wURQpq?=
 =?us-ascii?Q?Alj+Gm4tuNqM4drfQETGh0QGyLpaEpAPkFQhMGat1/iZXjMOyzN8trkpFH3r?=
 =?us-ascii?Q?fwV11KQz1p9kfhTXg41+ID6k1xB3JGTkfxTlwbkqqalKb6F8glvM3Q241U/g?=
 =?us-ascii?Q?88jjebl68DlboAEm2DNf7/ApL4Refnvqwx3ow7xbkRlsVYiJD01PHFIc9+W1?=
 =?us-ascii?Q?dlbxcykiKLnLXajTSYXTG3wPuR+yri/rpAwHiycAkUV3Bg08n7twx3jSlW01?=
 =?us-ascii?Q?AEBHVQLH3LbDj8UxEiTy8elFRm5zDLrhOYe0CdsFJjXuI9/OGDT6wuO8QpQV?=
 =?us-ascii?Q?zk9cZOhagncIjKLxnEHyuPziTG5NVF4pZ164T3AQsdhAMAGS/Bbckz3B8I2U?=
 =?us-ascii?Q?eI7Ng6f5IULO1MsTLY6HVTknYC/yB+LtqVvmJn11iVGjCBT9VXHc8skTQzij?=
 =?us-ascii?Q?qUhVuTJfj8KNpKpMOlNdeRh4JqTvmK8MLEZLiAubZvKXaBTgAPMvqQ/3udFY?=
 =?us-ascii?Q?VplwePcYYxXSAwezb9oVpNxdYtpmgtqjY+KvemOoS0yJDfCx03EpmrrCrVTd?=
 =?us-ascii?Q?N03DxrnOy7walDW8rWT6v9cikuBQIJGestpG6t9aGXHA2RIiE7Nlv6YjaCnY?=
 =?us-ascii?Q?Ku2fRkFpmWN0vsTVVNcX9mG/uM3sx4oLQdkKQlDX5iOHRYaazLxnrQ18CCcT?=
 =?us-ascii?Q?/drrHXcKxw/ACPvffatSXlLmdPn85oV/k73aES1o9AkvoTq885xyq4QaidNC?=
 =?us-ascii?Q?zNmOsFYfIQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95275ab-eb1d-4396-ecf0-08de8f46f300
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:00:02.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhyzMVIB1jJxEH5duTzAmyDvI1PUg0Ll0mm2lxR1/CGSpHak93QhWC9LbgHyF+JfhmpnOy/tFmoz2l5/qJQvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On Sun, Mar 29, 2026 at 03:38:07PM -0500, Mario Limonciello (AMD) wrote:
> Dynamic energy performance preference changes the EPP profile based on
> whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust EPP
> values on plug in or plug out events.
> 
> When enabled, the driver exposes a sysfs toggle for dynamic EPP, blocks
> manual writes to energy_performance_preference, and keeps the policy in
> performance mode while it "owns" the EPP updates.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> For server systems dynamic EPP is mostly a no-op.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v5->v6:
>  * Set the power supply notifier callback before registration
>  * Expand the changelog to cover the sysfs toggle and manual EPP blocking
>  * Add missing kdoc
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 137 ++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |  10 +-
>  4 files changed, 163 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index d6c2f233ab239..0e4355fe13558 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -325,7 +325,7 @@ and user can change current preference according to energy or performance needs
>  Please get all support profiles list from
>  ``energy_performance_available_preferences`` attribute, all the profiles are
>  integer values defined between 0 to 255 when EPP feature is enabled by platform
> -firmware, if EPP feature is disabled, driver will ignore the written value
> +firmware, but if the dynamic EPP feature is enabled, driver will block writes.
>  This attribute is read-write.
>  
>  ``boost``
> @@ -347,6 +347,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> +Dynamic energy performance profile
> +==================================
> +The amd-pstate driver supports dynamically selecting the energy performance
> +profile based on whether the machine is running on AC or DC power.
> +
> +Whether this behavior is enabled by default with the kernel config option
> +`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`.

This sentence doesn't read right. Should it be

"Whether this behavior is enabled by default depends on the kernel
config option CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" ?


> This behavior can also be overridden
> +at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
> +
> +When set to enabled, the driver will select a different energy performance
> +profile when the machine is running on battery or AC power.
> +When set to disabled, the driver will not change the energy performance profile
> +based on the power source and will not react to user desired power state.
> +
> +Attempting to manually write to the ``energy_performance_preference`` sysfs
> +file will fail when ``dynamic_epp`` is enabled.
>  


[..snip..]

> @@ -1715,22 +1824,20 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (amd_pstate_acpi_pm_profile_server() ||
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -		cpudata->epp_default = amd_pstate_get_epp(cpudata);
> +		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
>  	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
> -		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
> +		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
> +		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>  	}
>  
> -	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
> +	if (dynamic_epp)
> +		ret = amd_pstate_set_dynamic_epp(policy);
> +	else
> +		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	ret = amd_pstate_init_floor_perf(policy);
> -	if (ret) {
> -		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
> -		goto free_cpudata1;
> -	}


Was the removal of amd_pstate_init_floor_perf() intentional? It looks
accidental since the call still exists in amd_pstate_cpu_init().

Before this patch, amd_pstate_epp_cpu_init() called
amd_pstate_init_floor_perf() which reads MSR_AMD_CPPC_REQ2 and
initializes bios_floor_perf, floor_freq, and cppc_req2_cached.
With this call removed these fields stay zero (from kzalloc) on
systems that support X86_FEATURE_CPPC_PERF_PRIO.

The bios_floor_perf is relied upon by amd_pstate_epp_cpu_exit(),
amd_pstate_suspend(), amd_pstate_epp_resume() functions.

Barring these two issues, I am ok with this patch.

-- 
Thanks and Regards
gautham.
