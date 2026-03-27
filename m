Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AC3C1989;
	Fri, 27 Mar 2026 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594756; cv=fail; b=cba6/z0aU4wEEOxAm3m+7Ikc6Nk+7q7YoKM1m60P+RkmJmVOL+4f/M9zImlU2IX3n2w0H4hCyM06l4VtCHRpVN/LjoJbkDMPkkLkc00F6shXpDpT+lkmrN+3mOUi9dHdBF03K0T1D05Pz9rMBkrLYHoVJECA4+ApNq0K+8lNDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594756; c=relaxed/simple;
	bh=jTb6O2kWVtGReVdZaeoQLhkGN4xgSGOGiTC/EGT/OcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohtBs5eq+y8Ok6xNpEyElUJ8+oM6SWMeZEiHpo+iYL1q90VZd2Z6uT1Ae+xN7Jtt542pjz18LpMEob/1DjGA8Z1S+jJJkFuB7/1MqrC5e1AgTMszgO9zgrjHK9Rpq7w3FECyg7juM8s9jhRkQ/Eh0giZhIO31ZslfKenvkMAOdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5MpdXXZ; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5MpdXXZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKd76eHmal359etH2B5M0B1YQYPW1xn4TaYAzvRs6OKpKuxlf/eQ+TtLnjCI5UlSjzhznGBdBKStlGONYP+HfkEIRX7YpKX/Tpk9m7I0IhZeBcIvCEyGSNTjIyrel3zJesWuRMaxFYFIoWSNRK9ZApHTuf9p8Iz+m7HKpeW/vi/oKLV6oph0Oi/TErLKZJKv3t59h82FJldedYzFLwMsD5iNkxcEXiPJeq2cRV7a0ppcPa59HLD/dcBWc2EUQBN6bYyBTbMV67OkEW79gTXjDxh3GJUUKb/SSiVPX6q2Rcb7c10rARZQ6Gzo2zD6lNIyW3VXemSrNvMvLU2anq2oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdykEU07pcaMq+7aEWFH3ZhjVijXdqdBfWQscnF4NEI=;
 b=McPfeoDNMSwrdknXWB9Bv9f4ZiZxpUGsRL+6/6SWhfMmJjEinvzqapajg9hvarksquLmlz7MnLMJL2gEjoNub6bFQxgdfm2g6h4Lob1vxlgfhPyrsz3ylPVr70rpJ6fyGq5zs5ODPAoDQHF6syrnlOx6MvVqdXbdqzBPFhIBaCSb8toDexp4poKVA2lOnA3Y0Hb3jgiQLNoxL7y2OS5ayW/plu4tSvZfjv/PBC7bTyz4W/WsUng452CrMugPBM3goXGtS4IPS4ad1xApnXDABM0gwmsV2pIvMOmLC0i5uJFIXo3wb+uFeAwDpOb5nL+jrrEzW929g68dQejh1p5fzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdykEU07pcaMq+7aEWFH3ZhjVijXdqdBfWQscnF4NEI=;
 b=k5MpdXXZ+UH6azGxZqsR2I3q1EfSXP+CFBINXp3nfNLaCADmnfj17ecnvsImMztXq9EQOB5KdWHOp+2U7cOtduZINwS38M1XL5Hi0+emnOrN4kzwEjKOgdvxjSGxQSRETQeJYy/PA6onUp3Rz080j1Pm6nO2S5kgzw/hAFlrrNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Fri, 27 Mar 2026 06:59:01 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 06:59:01 +0000
Date: Fri, 27 Mar 2026 12:28:53 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
Message-ID: <acYqrfB6Lh3LG8UY@BLRRASHENOY1.amd.com>
References: <20260106051441.60093-1-superm1@kernel.org>
 <20260106051441.60093-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106051441.60093-4-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 02020ad4-ef41-4d21-a755-08de8bce5363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	33EYY3IZRa36YnTo3zcQviYu7ze/je1Zs4VnU4rOvPXR3NIsVWrMJRCtTXwFeP5Sb6ojry0iNZuKEJxG26VGOsp16aXO8Q+kyy0dBT8zxO4iugxxmcGyvh56OJ87S3BfKxlT/7rC8lqRvZLqGXFZ3AIZUIQz6UnzGd+iuJK3Chgey2TLqz/ubTLneczJrSHhEZRcK4G/tCHSUlZG2LDqSIEuPYDS0D1HNDMytTBXEeyDfP30+vTyXdNigZ/Xm7wHgwCl/cfHQl8vnsjR34SxGo2tbsnIqUtMiwJMuzbFcYn7tD0dVub47u6EhhuKig7sou7qnnuQdvniS+JvoWv1PhuPC4c/5hHNO7vHovL65KVAyBWDkWX0OtFD5e9d6KjSb+zUoB4CRy18/3bkdIbtl52eoZFqsXeM0v0Yb6iCIWbXI3BRPK0dzZP1TdujAzxlWKKT7eUC3wPleQYQYtxN29d79qLz87sRMSTZb9K9/HsjcJri0fqGXDVOiUUAcb2tumxDO0K9pzxuJN1gL/MuBN0glUL/dRPFHot+HDAHPxmaEEf0QT5aDlDDEilC6ms9iiM0QBxhWIzG6F1Rb/o49ylUz/L9lAP1YYlOaqy8jb4gEGlei1dgw2pL4cAdgo16KWpbKdQoVklQMBsycRy3uTRXhu+x3rJqTla5A0aMQkjyjGytyf5GnBzRgN7qHGlbMKObB3YaXZUQqiu1VUutMXm553pW0A/xo+67Ra6ME9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LYLyTK71wUqk82JEXxQ6NVQGhZaKH4pP7VwbU9B68GdYAOpvPZ83FK4PR9xr?=
 =?us-ascii?Q?nBeDPpqoBOZdpaNlBvV2QP1689xuufnwviZ3gEGxVJnRDL28DT6yFFQk5uEW?=
 =?us-ascii?Q?8PI/A2U0wB6q+a2hAfU2RMLXxvt+QG2sv7+Y9rpgd4FdOFFHQ8kFWf09RsSN?=
 =?us-ascii?Q?bG+KF5ilo14nPxADo55BRUb+TsEkkIhbDriVWJCBu+Y63aRfxqAFNOOJZ/LE?=
 =?us-ascii?Q?CDZWgwHhOm1JSXd6Fo0nSI5y4PaWWrRALvP57Dw9xJsoXgn/EHVDJIWbmnWY?=
 =?us-ascii?Q?zCcf/yKdURYj3UARLEWjx4lej5ou2x6G1X58m2OJ++0P7gb20dZFRxdPMzEa?=
 =?us-ascii?Q?MdKzSBptAbz5pzPde5PiUakN1WRUGdpf8ZnSdloJJ+xijJFYmH4TqsjqjFhg?=
 =?us-ascii?Q?SyOwZ8bGDyj+kNN/wnMPsFEEMP8mBc+8bwfRgs14H42k1gYZnv0cbv1bq5M+?=
 =?us-ascii?Q?1yRbu1w554uCd/VZ/BlpWaTrJ5J+sXIle9+KIoNMoS4+Fb/k3cWOR152I7Pg?=
 =?us-ascii?Q?/MikByLU0UtKeNNoW+bzfzsYtbSDp/XQG+cSGCvgAY3FeZmq00DY4QQVPHMx?=
 =?us-ascii?Q?/nFvNZkNHT7VdLD3M9LzI0hjfkglAypwwlf7RUm+E2SlbDnDOg9coyPUo1HN?=
 =?us-ascii?Q?UbeGdGdHwb1UpPS7Z3Tmt1THwB66vXCvp4vQRbVCQLUoZOt2wHMqM6xYK+Wh?=
 =?us-ascii?Q?j7Q6cZV3B2xbKUnD4jx4cGtHK1TWY9lwqGRk0xyWkWeOiqtxl5Xo4Fh09eWJ?=
 =?us-ascii?Q?PKSffQgNlimvCf+8wHYNR47pSrzhrnHLZFy9/DwB8gtG+Y4hW/JKx1ADq4++?=
 =?us-ascii?Q?lqODxSjduC4sfT/4IdVAWs81yE5sCvK3DlW/DU5gGOs3MP9cKJyk5+2t+Xde?=
 =?us-ascii?Q?3oZVxLQoTh+xTt/VKmocJTJTT4P7+A/cW2ff/IWa1t5mMo2a4+0AIaluyOc0?=
 =?us-ascii?Q?eikYriSMLKTrzkhnIQLrG744SSlsV7gS5qoVu/UfrOH49T5fBlPPgsGVBOtA?=
 =?us-ascii?Q?yOMLLfS/Sr/3eHwoGZ1qiOQll2G3sY1xXIAldlwlLKzvUFPkyOIZkuiQF6JQ?=
 =?us-ascii?Q?882J9Ep3zgrQpCVeDxC9HfWiIaNnSkOqebma1hqdBfPARy4v5qS6s3yvnpLe?=
 =?us-ascii?Q?Kcmsxf7v4gqlSDkfJ3Jbfw0WLPlzSt6iXFW7toE56UxBIZuD6qzBvX7aHADP?=
 =?us-ascii?Q?NoJOr9We9JNcEtoNn60Oo8UoPW5FUPLhz84Wh9HAucpkXxb9YWbgvNKjgILJ?=
 =?us-ascii?Q?0NFyvyjBYU7evp9ZTL9IZCnMZhm7Bsl3z3k8icnDRE8eLzTCg8CFGXXua12b?=
 =?us-ascii?Q?9zPmIjDOba3pfUq+x6qHfm5QFZSZuGOrzcg1V01ndAURudJ0Du0JZbFDF7l0?=
 =?us-ascii?Q?67luoG6K/7uV9ujCnaZKmYTxqIDvpkW7Mv76DI9KzPWccHjCZZEGxmhWUhfe?=
 =?us-ascii?Q?zfdcwI/HI630cwrz+IHZFxK1aOaKX1/iMieC18JUVJI6BPJlBKVHUVijmxC5?=
 =?us-ascii?Q?klPVhNR4O6wL/denpeGFmzV75criRse9uxmlSRTi+SZnVxz3Tob5j7JjAsiJ?=
 =?us-ascii?Q?T/auNM+Kh05Ihtnb70qsXtyISqTjnVX8H5elV2N2kwHQaGx4+owChPgsItqK?=
 =?us-ascii?Q?GQ2PlSTLI1O3Ey8Gm8rg91xAsbBqDd+v+EbY4LsftMjOZpjWK+lZWPTCId1W?=
 =?us-ascii?Q?K/PSvScjV6+Zun5Ec1a+n/Yk3LqSXYyHgxTZ99L9WJM8UlxkoGR7jYQO1dnL?=
 =?us-ascii?Q?aM1XHjtJWg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02020ad4-ef41-4d21-a755-08de8bce5363
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:59:01.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eo/U+AT5/keICGLmT4yE74z2oyi+nfXxEj7iK3VdridH9biGuLjGi8CjlJ+idoRp4eDQofd8juZJ84TyWDavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

On Mon, Jan 05, 2026 at 11:14:39PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
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

The commit message only describes the platform profile integration.

However, the patch also does the following other things

 * introduces raw integer EPP parsing via in store_energy_performance_preference()
 
 * adds EPP_INDEX_CUSTOM
 
 * exports store_energy_performance_preference(),
   show_energy_performance_preference(), and
   amd_pstate_clear_dynamic_epp()

 * changes the performance policy check from policy->policy to
   cpudata->policy.


These are separate functional changes that aren't mentioned in the
changelog.

Or perhaps split the suport for raw epp as a separate patch, and the
policy check from policy->policy to use cpudata->policy as a separate
check.

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>  drivers/cpufreq/Kconfig.x86                 |   1 +
>  drivers/cpufreq/amd-pstate.c                | 144 +++++++++++++++++---
>  drivers/cpufreq/amd-pstate.h                |  10 ++
>  4 files changed, 141 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index df4607b6a5f62..a6745f2358e61 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -321,7 +321,9 @@ Whether this behavior is enabled by default with the kernel config option
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
> index 7dd50b5825d78..e1ccbbdd56d42 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -109,6 +109,7 @@ static struct quirk_entry *quirks;
>   *	2		balance_performance
>   *	3		balance_power
>   *	4		power
> + *	5		custom (for raw EPP values)
>   */
>  enum energy_perf_value_index {
>  	EPP_INDEX_DEFAULT = 0,
> @@ -116,6 +117,7 @@ enum energy_perf_value_index {
>  	EPP_INDEX_BALANCE_PERFORMANCE,
>  	EPP_INDEX_BALANCE_POWERSAVE,
>  	EPP_INDEX_POWERSAVE,
> +	EPP_INDEX_CUSTOM,
>  	EPP_INDEX_MAX,
>  };
>  
> @@ -125,6 +127,7 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>  	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>  	[EPP_INDEX_POWERSAVE] = "power",
> +	[EPP_INDEX_CUSTOM] = "custom",
>  };
>  static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
>  
> @@ -135,7 +138,7 @@ static unsigned int epp_values[] = {
>  	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
>  	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>  };
> -static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX);
> +static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
>  
>  typedef int (*cppc_mode_transition_fn)(int);
>  
> @@ -1094,6 +1097,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
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
> @@ -1102,14 +1109,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
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
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
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
> +EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
>  
>  static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  {
> @@ -1117,11 +1194,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  	int ret;
>  	u8 epp;
>  
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
>  		ret = power_supply_reg_notifier(&cpudata->power_nb);
> @@ -1227,8 +1328,8 @@ static ssize_t show_energy_performance_available_preferences(
>  	return offset;
>  }
>  
> -static ssize_t store_energy_performance_preference(
> -		struct cpufreq_policy *policy, const char *buf, size_t count)
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					    const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	ssize_t ret;
> @@ -1239,16 +1340,22 @@ static ssize_t store_energy_performance_preference(
>  		return -EBUSY;
>  	}
>  
> -	ret = sysfs_match_string(energy_perf_strings, buf);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (ret)
> -		epp = epp_values[ret];
> -	else
> -		epp = amd_pstate_get_balanced_epp(policy);
> +	/*
> +	 * if the value matches a number, use that, otherwise see if
> +	 * matches an index in the energy_perf_strings array
> +	 */
> +	ret = kstrtou8(buf, 0, &epp);
> +	if (ret) {
> +		ret = sysfs_match_string(energy_perf_strings, buf);
> +		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
> +			return -EINVAL;
> +		if (ret)
> +			epp = epp_values[ret];
> +		else
> +			epp = amd_pstate_get_balanced_epp(policy);
> +	}
>  
> -	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
>  		return -EBUSY;
>  	}
> @@ -1259,9 +1366,9 @@ static ssize_t store_energy_performance_preference(
>  
>  	return ret ? ret : count;
>  }
> +EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> -static ssize_t show_energy_performance_preference(
> -				struct cpufreq_policy *policy, char *buf)
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 preference, epp;
> @@ -1282,11 +1389,12 @@ static ssize_t show_energy_performance_preference(
>  		preference = EPP_INDEX_POWERSAVE;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return sysfs_emit(buf, "%u\n", epp);
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
> +EXPORT_SYMBOL_GPL(show_energy_performance_preference);
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> @@ -1621,10 +1729,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
>  	if (dynamic_epp) {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 7bfe5f8115623..9839c7c6558f4 100644
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
> @@ -110,6 +111,11 @@ struct amd_cpudata {
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
> @@ -126,5 +132,9 @@ enum amd_pstate_mode {
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>  int amd_pstate_get_status(void);
>  int amd_pstate_update_status(const char *buf, size_t size);
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					    const char *buf, size_t count);
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
>  
>  #endif /* _LINUX_AMD_PSTATE_H */
> 
> -- 
> 2.43.0
> 
