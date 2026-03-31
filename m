Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457B3009C7;
	Tue, 31 Mar 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976582; cv=fail; b=BH1/wIHh4l9OKNMe/eafgbItvAfYAH+G2ewg7F9LjRe709MIHawKL8+rRLH34E6xbyfM1/twWABMjhIkgbO5BpsTTDzai2xoqkBukt4Si0l48FM90hrcoE++90Mhgkd/QqkT+Zl/BKVjcmGD1HZDakAWhgjWIeUzzSttpGHHUlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976582; c=relaxed/simple;
	bh=6aoLqFTx0V2f1sgYHrJn89W2naoYXPHTOsq33n/PLEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZD+QvrvwNP2Ew/blm4+BoFKjTb3cHF5WVS7nQ6OgwTX9o0kXSzLvzz9urmsom/SHnYLkXR3wRCvFovW9Hn2wrtQ1ERYjhCyNHMgX9dDeU4naTrid22BnI0/n12dv9x52kYNUj8jEPYr5Ye5je+LEXStuwYsoZBeCR8EJ95Pr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lr8YuqFa; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lr8YuqFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLrFlWPLtCSfc3N1gVClE3ugMoV72VkhWlN22n78d6qp83BZFu552zbr3PuazridCcZ1dASXWeCo8qVNKVvC6sNEcl9m1E+RzEuqSaH7U6UfS04K9s4DgGqFNYwJvIxp8Aqmm991J7IKvp2st3uK+Hmu7UDcWrfmgAAXhk/1COGOwjqLSYg1+u359qPb0r+Z6wIz/KT0DLEbbctV0199Pxf34MK77a4HuuUaZVcLXkwBRQHWNKAetXj0Z6T1sUwGmEA81Vnb2qXOFUQVdRUy3cJ7f0HcwcCZsaOutnBegRCBFvUJoeo/XM3B4Kixwyeuiz1PKOMS6LxB26mkovTgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WUk+ri8xTJO/iYUkpZ8CVu0I3tXrGb5or1Vv9+nzHo=;
 b=jrHye7qPnZCSzybENiJzuQpG9vhBCJQ9XQ8Px4uM5pzaoXPSMyDjXmXHIEugPZnWZYkWojPjzfcOItpBnaZxzaKS7X5DFrG+FAnrGHmXvevgf5MnJfraphNK8Jy5qv3KYnSyZXzzA2I+WzbT+At00nZiWLFM7UXJQecdm87WMCsoC+GOJSHQ9nqmLlNiOKXkYZdjijgECmht8i69JdKOn0AiliBAL+QUiMpVYHUTsZCzq+rL0boSxQkZ1cW6OVzxALVStVIo/3SkcoBJOqKiIO7ltNU3ggMZ8cloNizx0x1tjnxiCmeD0b5UiGCSxNQgzcm6H/A+refUyxRdGLCiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WUk+ri8xTJO/iYUkpZ8CVu0I3tXrGb5or1Vv9+nzHo=;
 b=Lr8YuqFavXSCbzLb5cBZum42F6FPMfvTibDuy9UUnr9rR6kd174AorQ8fGcEw7miYs9e5U1RCSHYVKDf6J4GdD8v7m/tO3KlXXwbqPPLCFHQ32PpKEjtGb+1kx3OwvLlG5uoBW6XoBV4bVQKl2aBVVsPl2CTruWqVcjA+engf4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 17:02:56 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:02:56 +0000
Date: Tue, 31 Mar 2026 22:32:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
Message-ID: <acv+OupkgZQlMmHO@BLRRASHENOY1.amd.com>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329203811.2590633-4-superm1@kernel.org>
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: ec949c7b-8334-4a8b-54a9-08de8f475abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GUpSKQwz4kYJ1k6cfvUaxVdIR74SALZrZi9l/ZD4/sxp2xMy9NTTIFJqv0C2JetCn3Gtm6YfNzsC9nuhbMvtR7t9Rp0SdQti5mI5XgIepoU7xYfzw8lewR5f09jfu9jHPCAkJrlNuRdDarWlchiYYV/vPwOUj/b4p9xZXKjC+jh0bYvP2HHSfV66+gN2rsC8qvfICFAwFdR8pG2UI31It4gpZ/w6ECh1eeRwc7Z+0yP56bKm5QwlVdYJccfVyOptInpjlI3SzoXfdNtVeDA4gKSDBr1usgU4mssXmSc15F7Ferv8jRKbRXwHGCPWt2JW+nvot/BNnA7QrOsceCJsrvpJq8aoTb6w5PhTIffs3pK/ChU0ueujnP5cP9xonBrlwZH/Cs2gllLEJeZMkdI55pbw9cMDILAaBsANgoewpHpV48bDcBhR+7BrbK/JfOboVmFWoA3SlcQuP5FGWn1fqFSqEzccYDuN5O/6r92/ODDbxRKZhir1tmXqTlRd2r5FLJErKrZsoWJvwVmFjLAQSx28wsi+r3qjAG43MXHLJttXzavvXcEHcgqjpZUsbcm/PTLdettgfPDuqHFRnOKppimisHXgQAIImSrNuB0bbjL0WUWKylioaW1a/K0bGbhK3kD/PCogUcY98yvjj3ZA5/cMbrq+yEABSw+xylBZVvnYHZt1PNU1huaKO8bONtJnBOdhrbSiz6hhY6eQqERYGfHzI4z+VzQBIT04Jv6RqJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4iw9pLj8OOeLHxJPJeWi+lqKimotnGnipdiFEOTzKYVPDj13yAEPLK+fogX2?=
 =?us-ascii?Q?yB5F3ASElpeuoLHmNI9W+HufUMaVVLZ94RsIkPxQesw6bRvXIEYNzCP9B90l?=
 =?us-ascii?Q?kMO6V0gNW/gLEKxhXoAvpBLyoyEVj7h7EbXpfvS3Ui1Tt55f8rgUYSIF3ckg?=
 =?us-ascii?Q?5Wt0nugmJ99Fql2ioN0gIcwApJE/ndHKInu1nza5UV5e7uJzkSx+42cwCMho?=
 =?us-ascii?Q?02o7SAANEgg6H5kksqdfLfvbKAYDF9n45s5qk95Cdnfg/+N2sMYP6jI9TTWP?=
 =?us-ascii?Q?n7E6m+t9O1CkK2kGPrUUts8AjgwuflXa4wlXyAxd8JCSDhinBub6sEXL1ncs?=
 =?us-ascii?Q?az55pXe1LPeWTAgnkawV540Qq9Cmn2CiBdpEsm/xoBOA8XV+UJXmZY+QEqtj?=
 =?us-ascii?Q?e3mmTX5av3qvUzwVNXZ6lCQIgsm5IjKRE5HNd1UfbhB8t2e3M9SrezS0ZVAg?=
 =?us-ascii?Q?z8EkU1DA2xPy3sDPQ0chTKF7LI4N8jac42TelshSm3jySE6XJ9gpv4HnaXxz?=
 =?us-ascii?Q?lhzr1mYQdDdToekryKp/TZrc8H+h8J0NULqAfk9bV2c8oF8M5Rp5nmw2XUkn?=
 =?us-ascii?Q?hPS/eMJQnMGteJl8CxeOocdruh+8MJ/kiMvWCffOR0HLyO+fZo+7T7sQGfAZ?=
 =?us-ascii?Q?rw7qmm+KgVDwSYxD+fXbdeDeMO6hQd07WtOZeNh7iCwol8e1D0IxLBdkdHHM?=
 =?us-ascii?Q?vYC+xmxUb9PEMmXxNKwV816qFXxzamzgT+sfA6gSM/6Vi9VB7yUpXsE6H1Gp?=
 =?us-ascii?Q?/Gdn9hhBDbPycfQb9FVNs2ddW8uWfE38yAGcAjwezysbZUK/bPn1CpFTt1ln?=
 =?us-ascii?Q?sKEcm+8OHbM5/JPLeWQip5gh0Dx/YKSrZ6sb6Zue4TBYk67m5J2F3HDXrLJ7?=
 =?us-ascii?Q?wImnbVNPatTD6w/9/48IL+kwG5+etkRclCh3BqDpnEfXnUGBlV3fW76eV6a6?=
 =?us-ascii?Q?HGdCSiq3yRlnlOR4QoKv3X3YxAoTrvDGwKGGmwMpiYnCPFeqNlHUT/xCNki8?=
 =?us-ascii?Q?P4DD3iwEzTbj+CGyAGzcfxvweGNB7GnufY3QcC59ny/M3bp5kEom3vig7jf5?=
 =?us-ascii?Q?N020SMtXcwg+2KqHrZiDb7UwPnfemCoGn9ijfEFH4eJoMZeXaXKB6LVpCG1h?=
 =?us-ascii?Q?Rznui9IIblbdiyKv0Jd+6lVaypntTgYVDD5Zs8x03/1GhQ4JbCfK2dgCqSmD?=
 =?us-ascii?Q?p7SeuPqYY89+swiNufv+Law49VDHs7d6hCLcpV0ha+L38/QgbfJ7JnJLGZxp?=
 =?us-ascii?Q?E4DzXU8TG0ia+iMOyiJ5E1xEpqNTBBzz+S5H+YS750viDWUvE1vYsYRQbiGT?=
 =?us-ascii?Q?j/QwOMunzchsTa+FztsP3vviPW6ZPfWomhhG0WUum3gjJ/P4bcSVbi0d0rQ8?=
 =?us-ascii?Q?EofkYzIF0Nk+MfAbUvRq9U2wrZ/bHHPBjRzSslI3kVVBiBvI+pFQq4hGf0TX?=
 =?us-ascii?Q?SScvIf/1FvEAfToWLd6d/e76n+9ITVsb/RquEma5KVXgjA7TZlz8oI+KQ7GT?=
 =?us-ascii?Q?Kdit+5/XqtNLWyge7URjcmL+ygUecQXwGHa+phRS/ggoDaLQWOZz4hFfpq/E?=
 =?us-ascii?Q?0fzOVm30YgFICWcW5Xbgo1TSk+dhhjKH7BJc9uRWNiBnsLD/TlW/Z7QCrw1l?=
 =?us-ascii?Q?F9EXwRetCXokHsVdbx2t9T2JaviHO8PBHL9mS3vSv/FNiHhcLA58SNejOQMG?=
 =?us-ascii?Q?p/kct66uyft+ds7PZNgUvGRJzqCH3+QibZGq/Xptq7O2nZbhH9RrQNbAzsT6?=
 =?us-ascii?Q?GO4HsblzUA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec949c7b-8334-4a8b-54a9-08de8f475abe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:02:56.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slSzoRvnO8cuBpWSQlRNm2J1UycuCs+dCSNDxIwI/KzJa81MkUj+wym6RQNurFRp84ndrsCKAzkm1LpqYVH06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

On Sun, Mar 29, 2026 at 03:38:09PM -0500, Mario Limonciello (AMD) wrote:
> The platform profile core allows multiple drivers and devices to
> register platform profile support.
> 
> When the legacy platform profile interface is used all drivers will
> adjust the platform profile as well.
> 
> Add support for registering every CPU with the platform profile handler
> when dynamic EPP is enabled.
> 
> The end result will be that changing the platform profile will modify
> EPP accordingly.

This looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v5->v6:
>  * Keep the platform profile patch focused on platform profile support
>  * Move the raw EPP plumbing into the follow-up raw EPP patch
>  * Move the test helper exports into the unit-test patch
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>  drivers/cpufreq/Kconfig.x86                 |   1 +
>  drivers/cpufreq/amd-pstate.c                | 110 ++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |   6 ++
>  4 files changed, 114 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 210207d301aa5..2d92c8072b83c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -357,7 +357,9 @@ Whether this behavior is enabled by default with the kernel config option
>  at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
>  
>  When set to enabled, the driver will select a different energy performance
> -profile when the machine is running on battery or AC power.
> +profile when the machine is running on battery or AC power. The driver will
> +also register with the platform profile handler to receive notifications of
> +user desired power state and react to those.
>  When set to disabled, the driver will not change the energy performance profile
>  based on the power source and will not react to user desired power state.
>  
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index cdaa8d858045a..a0dbb9808ae99 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -40,6 +40,7 @@ config X86_AMD_PSTATE
>  	select ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB if X86_64
>  	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	  This driver adds a CPUFreq driver which utilizes a fine grain
>  	  processor performance frequency control range instead of legacy
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e96f1da5c7b38..93cda05ffa855 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1182,6 +1182,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  	if (event != PSY_EVENT_PROP_CHANGED)
>  		return NOTIFY_OK;
>  
> +	/* dynamic actions are only applied while platform profile is in balanced */
> +	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
> +		return 0;
> +
>  	epp = amd_pstate_get_balanced_epp(policy);
>  
>  	ret = amd_pstate_set_epp(policy, epp);
> @@ -1190,12 +1194,81 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> +
> +static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_get(struct device *dev,
> +				  enum platform_profile_option *profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +
> +	*profile = cpudata->current_profile;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_set(struct device *dev,
> +				  enum platform_profile_option profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> +		ret = amd_pstate_set_epp(policy,
> +					 amd_pstate_get_balanced_epp(policy));
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		pr_err("Unknown Platform Profile %d\n", profile);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	cpudata->current_profile = profile;
> +
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops amd_pstate_profile_ops = {
> +	.probe = amd_pstate_profile_probe,
> +	.profile_set = amd_pstate_profile_set,
> +	.profile_get = amd_pstate_profile_get,
> +};
> +
>  static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->power_nb.notifier_call)
>  		power_supply_unreg_notifier(&cpudata->power_nb);
> +	if (cpudata->ppdev) {
> +		platform_profile_remove(cpudata->ppdev);
> +		cpudata->ppdev = NULL;
> +	}
> +	kfree(cpudata->profile_name);
>  	cpudata->dynamic_epp = false;
>  }
>  
> @@ -1206,11 +1279,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  	u8 epp;
>  
>  	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -	epp = amd_pstate_get_balanced_epp(policy);
> +	switch (cpudata->current_profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		epp = AMD_CPPC_EPP_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		epp = AMD_CPPC_EPP_POWERSAVE;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		epp = amd_pstate_get_balanced_epp(policy);
> +		break;
> +	default:
> +		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
> +		return -EOPNOTSUPP;
> +	}
>  	ret = amd_pstate_set_epp(policy, epp);
>  	if (ret)
>  		return ret;
>  
> +	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
> +
> +	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
> +						   cpudata->profile_name,
> +						   policy->driver_data,
> +						   &amd_pstate_profile_ops);
> +	if (IS_ERR(cpudata->ppdev)) {
> +		ret = PTR_ERR(cpudata->ppdev);
> +		goto cleanup;
> +	}
> +
>  	/* only enable notifier if things will actually change */
>  	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
>  		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
> @@ -1311,8 +1408,8 @@ static ssize_t show_energy_performance_available_preferences(
>  	return offset;
>  }
>  
> -static ssize_t store_energy_performance_preference(
> -		struct cpufreq_policy *policy, const char *buf, size_t count)
> +static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					   const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	ssize_t ret;
> @@ -1332,7 +1429,7 @@ static ssize_t store_energy_performance_preference(
>  	else
>  		epp = amd_pstate_get_balanced_epp(policy);
>  
> -	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
>  		return -EBUSY;
>  	}
> @@ -1344,8 +1441,7 @@ static ssize_t store_energy_performance_preference(
>  	return ret ? ret : count;
>  }
>  
> -static ssize_t show_energy_performance_preference(
> -				struct cpufreq_policy *policy, char *buf)
> +static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 preference, epp;
> @@ -1825,10 +1921,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>  		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
> +		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>  	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
>  		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
> +		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>  	}
>  
>  	if (dynamic_epp)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index d929ae3163b3d..a7e52f79a8029 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_AMD_PSTATE_H
>  
>  #include <linux/pm_qos.h>
> +#include <linux/platform_profile.h>
>  
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
> @@ -127,6 +128,11 @@ struct amd_cpudata {
>  	u8	epp_default_dc;
>  	bool	dynamic_epp;
>  	struct notifier_block power_nb;
> +
> +	/* platform profile */
> +	enum platform_profile_option current_profile;
> +	struct device *ppdev;
> +	char *profile_name;
>  };
>  
>  /*
> -- 
> 2.43.0
> 
