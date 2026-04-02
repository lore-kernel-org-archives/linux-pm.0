Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0930C37E;
	Thu,  2 Apr 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120654; cv=fail; b=MhoQ/GDnXMS3Q9d2K/tEbtDGYaBxl2YW3JUrMbFkRGFJelsw0HWbgPn2HRPDhSKYHhouBXC7FDP8VY8p0nMP5cmdIeaT32UmhaKpbErmiqLNQW1QFdZurvm9B4luMYC2Q9xNM/kSjFAfxw6fv0soThb733oCXxy3IhwSY5tQzFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120654; c=relaxed/simple;
	bh=jXJPhMt5AnS1mbu+PrgliIDjehsDyuTpXZ7xnHxUO9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5cg5Hqpxm2CBXDMeaWwUQJ9AogJYg3m9tzFMYrEsM3RspcDBGkX9rK/Cqv+xF4z7S2rUu1z25DMsJQ2UMPei9ogGDQOzyZJc2CXn/zC804KAT2w6nS8r1H85ivhVJmoll65L0qFklSdTtdWy3TrcRugOZTMRVneSGrNuvxhOV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j+EAek/t; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j+EAek/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0pW9cPxhK17giMLnN1ylb9Kp09Wy7tGHF4qDtZdSnBpi5O1CBNfxGQrKUE1efbxYMpqCMcr6KYYloIFU+BWfS9Ac4cIG8DKGnm9xXdLNqaX+QCZo+TcgQcPnELFIz8Fr68pdaQEpy6tI5pll0i9RWsff+uN88ezxCe7YTHP1HfNfWkn+Kj2K3QijXMj+GVsVsViMnKE5RmOrSd55dvd4bHGWu4jye4zkW6BJwULoRI9+Kp08j2+Y6OLZN4dtklKTR4WpH8tM+OEDzOMEaWIpHjPKCum7O0tb3Y9BcjAKOD0JVl/J/1RRw6OHSBAZAqceoufhQQ7HszFmZaNGq9FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/k3SsRn8v+dOckLgVsyWqnKydKNYCsrc/bKujKv5HM=;
 b=J/T0w9U+Svo9Cmo4Dz+Il7Vp0pqxLRV/fhfpBop+lfK1COUe/VJq3LWPqSLSa7TgsxqlHQk46XbeuyH1iFfYXKMWP23h62p1hdoZPBOs0hRzQlvx3/k3uYCt3wVToShivcoa64t7P0b8dZUFz6fTMe48fVm8n4y95SMdDqgH0U0lwdnHv+TpFMnViWp8vBcVq03S6ZODZT0BcdlNRNA8URk7Fp2PSvGopzq6vFtk0lDCrCq+sQEDMstL9bWciBvChaRhIqy9a8uw6YffT+/EK4XYfQlqvVKApt9/LRXxcj1mbLqn125EoLkwTxb+dxYBg1ewojt2uN8hnyKnOlbGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/k3SsRn8v+dOckLgVsyWqnKydKNYCsrc/bKujKv5HM=;
 b=j+EAek/t00VRIGUyPUNb9g2pPSjyuTM+8B19A6bh0E4ZjfpiqlNjVBTN6B/EfCb1gQqS0cqrnnPVijMlX08/Uyu+6iGoECt+2qHajX4spP/pScej6yZCrFEzYYVNTJ1fA0ygTPmReAj8Zd2lVZ9/YG8AQIp2AaZuRall464ELhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 09:04:09 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 09:04:09 +0000
Date: Thu, 2 Apr 2026 14:34:03 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 1/5] cpufreq/amd-pstate: Add dynamic energy
 performance preference
Message-ID: <ac4xAyTls5lcvOto@BLRRASHENOY1.amd.com>
References: <20260402050214.1238624-1-superm1@kernel.org>
 <20260402050214.1238624-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402050214.1238624-2-superm1@kernel.org>
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d04a91-c822-4a3c-456e-08de9096ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W9nBGFGy+u8a9qBPJ5gJYQR8Bz6fkan2u3ry8+xJMyGLHOQsa6d/nIA5o7LNAGm/T9hlriLNqeiRaZZIXpXDz1zFkTGswX7J8XWbz+ulYIvDwvEMt7n3EguWP/9qHCDaDGrx3Pr8M+j/xXFJTa4AbU41sDrG1RERchQra+p8QKsZvmHzeNxonjC3sGkvq7yg3srhRsAyH3YilPmckxyvI/Shtp2cGPb7BFfksC9+deojcs4MIzsee392cKsc5KgqAvvR+spgv2yPnr4VWnh0p69Ye07AsBfHdjRol9m0scQ7o/OvnYJUUogsX2NPoBI1qyndcHRItNbhUXybVn1T6cxsnOGZlj2hMY4D0nvDYPVLL2iIaHhWIg9eWibKmOdJYKKEYEaCYWBuXIrBWD6sMEUa/bRfH7+75DG7pleQibrd8C0aljHqLrSkOH4moH0SBjcvLAM6adS7iYeDhHCD6WVU4WjZZG0Ud2BsdMfkANNBPvFeLqSAKGeZJQOfBZSFgLiawyUYCp81FSqUKc/YO3xsSpJPwDEUiE6715gGSK6chK3zokfFPkH6EPrNskQY5Yaib21DCwj+9r43MjqwHxDiZPzRcCT5Rihxt7ffkTihlEbm3Nqd19974hLNXtB246HqCNsBmvRCU+WpKPAF/T1Cr0lxZVWeOkaZxORupsqlAmASqdhHaG4IZeSlNANAh0nZ0YoDJqd2qk421sOp1rZP554y8Jf3RO6z1oqLr5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zuoc4KvdJ61MLsCk2PwJm4/nipy135uEDwNFCdHxJ7gOWDN0j0rXrHxzKiue?=
 =?us-ascii?Q?UUnqO0qKzoZQHr/5pbOzM57h5RMYUh+wDaHw6Djiek8/SbbVMAGMdqZZvd9H?=
 =?us-ascii?Q?0cydCU0KUadW67kHTfXWZLHn2aRhzbEXoTcMQQK3u/YPHXQLgTo5NFdWmM7g?=
 =?us-ascii?Q?ZyUbziDVhkMfLdM+1KWi6+1XodbnSTlDC1VqPUqKmUYoEbDFQtqrkiFKgwzV?=
 =?us-ascii?Q?5E3Jw8rNXfcylI4zvGJT91502TbDUwACFqi6FCcV69e92RUqoDpvZBIiKcSr?=
 =?us-ascii?Q?KQ47gbv4JHblkBFHpEbxAG4ZBiE1R/ecnKzy6JKuH3gk3Azh4Ztcot0vDimy?=
 =?us-ascii?Q?SUKabFKka0qxbJzpsDcycM7ygb8iQZmHzaIaCl/wcKfAN34Kl4dyQj4laAnQ?=
 =?us-ascii?Q?0U3YI4UU+V7jGeluMPxUtKzf92AeIxV08cePRMOcSUTAVGXtufGQMMFUpOxv?=
 =?us-ascii?Q?8zSQa/pe/Z3D2cBRVv+NQtt1YVFDVuDdtEE6xjS7JcnRdR7ZQTub1Zg+yp7A?=
 =?us-ascii?Q?xmYBIKzieJXhKw4w/urxZvCDZAGS9ymZFfuAj9sR0VongJBMdTrbuSFgpMw5?=
 =?us-ascii?Q?8w7BKNFGHHhzLdMcLY7RUPUMQGdm0YL88Jtp2iIzbTbXWR5pKXIlHJgglJXX?=
 =?us-ascii?Q?2AjvcI1L3TSVvlI5LV52MrD72s2TZWDMa0cW/exDj1jTCEvaEYwjEZ9xRNb2?=
 =?us-ascii?Q?0HwH1d0YmbFt045U8jJ7iAMsnbso9M7ieFv4KSHVvKE+TeF4/ZMUw7vLVbyK?=
 =?us-ascii?Q?cVWgyaG9ze/KN8bU97JIfKfWJK0rDe8t8/T9zsc+7iJZfXop7oHpE5QsIqAs?=
 =?us-ascii?Q?ehOi4gy8xAtMQN+L/ATg5xMsZodn5z58rpTiJl+YVj/hFADX3eYhW1qBL6a9?=
 =?us-ascii?Q?RScRCXrZcLeLLanqh0JVodcimGntcYPldCKR0x1MMwkbxHeFoJuEPkrR3qvM?=
 =?us-ascii?Q?8MLRJKX47ghDiYBnw9Q2aoVFclc723STJtHi91uYqZG3OcHehXquIWAucbUH?=
 =?us-ascii?Q?9VXEb8QqeVr0btEMuC3iY1uHxvuGykTi1YAbReE7r38axFw9DrykJlxTOG8M?=
 =?us-ascii?Q?oScRr53bL7QKRaMss15kKzerYImlvjqYcAg8+8Bybs9evt7s4jVQzQ+DGhFc?=
 =?us-ascii?Q?Y0kJtjBtHXaPxZ5u3Ch1EIaR03QgzD1wG0zdZ+Le9RwhiKc8tBW6QKH0m1d1?=
 =?us-ascii?Q?jNSEJXFD4QCv63BUYNwEbO6JNrx6uExOyh2oc9MVdU+4NbkguDUBAix+HVXp?=
 =?us-ascii?Q?KDz2WItyrVs6K0vQ1L6GfRZPIMsEII6fcl+xXXQnVXdq1j2NX9Krhit2mrHs?=
 =?us-ascii?Q?wTYH/NkGX8s2jbBnELlZHS5jz4C6MZtqnY/H3E+GjpbplHnUyMZV3d2xHch2?=
 =?us-ascii?Q?q1xfuidD9SNPhEvHlJIy+BwrXRfMSq1zLIK9msOXQkhFEvJ9W0Kg0JwjX5rW?=
 =?us-ascii?Q?cKEznbffIA7ORe6NrfxrNIQhMkHuq5DY7iW/pb/fTCTt4vZ+PUCw4LxSp/DK?=
 =?us-ascii?Q?kRRie2AevUfldf494EVh2PPid0tSvhLCtRRaNCG14EAJ4dCMATaPa6M3AZ6A?=
 =?us-ascii?Q?8pr8AUU9BkIOY/4dVnSHKNeFNkkmvbP1bqxSb0UOa+wPsrOKC+XRI8ptfbG4?=
 =?us-ascii?Q?27t9bbykeVoYJ9m7kNArtFeRCDtUkz3s993ranY4ytTbHEtijzKgrwg4zfJX?=
 =?us-ascii?Q?WV3UeYr6maurgCfZ2NAto75sEj9leMabMVblL/1xb4pz5rZlsK+psKs+oFV4?=
 =?us-ascii?Q?OOBabjT9QQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d04a91-c822-4a3c-456e-08de9096ccc2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:04:09.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iR/FKA84121JGr8kqS53EJi7TZEyzEszEOh0A2Jb8jWPJEQHSVjTwJzEh6SsMHquLH1GeVlEEhaLGf8Cuv8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Hello Mario,

On Thu, Apr 02, 2026 at 12:02:10AM -0500, Mario Limonciello (AMD) wrote:
> Dynamic energy performance preference changes the EPP profile based on
> whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust EPP
> values on plug in or plug out events.
> 
> When enabled, the driver exposes a sysfs toggle for dynamic EPP, blocks
> manual writes to energy_performance_preference, and keeps the policy in
> performance mode while it "owns" the EPP updates.

The commit message still says "..keeps the policy in performance mode
while it owns the EPP updates".

That is no longer true in this version, so this needs to be removed.

Other than that, the patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> For server systems dynamic EPP is mostly a no-op.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v7->v8:
>  * Handle failures to enable dynamic epp
>  * Don't set policy to CPUFREQ_POLICY_PERFORMANCE in dymamic epp
>  * Allow policy governor changes
> v6->v7:
>  * Fix accidental casualty of floor perf from rebase (Gautham)
>  * Adjust documentation (Gautham)
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 128 +++++++++++++++++++-
>  drivers/cpufreq/amd-pstate.h                |  10 +-
>  4 files changed, 160 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index b43675b7f739b..bb1341763882b 100644
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
> +Whether this behavior is enabled by default depends on the kernel
> +config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
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
>  ``amd-pstate`` vs ``acpi-cpufreq``
>  ======================================
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 2c5c228408bf2..cdaa8d858045a 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -68,6 +68,18 @@ config X86_AMD_PSTATE_DEFAULT_MODE
>  	  For details, take a look at:
>  	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
>  
> +config X86_AMD_PSTATE_DYNAMIC_EPP
> +	bool "AMD Processor P-State dynamic EPP support"
> +	depends on X86_AMD_PSTATE
> +	default n
> +	help
> +	  Allow the kernel to dynamically change the energy performance
> +	  value from events like ACPI platform profile and AC adapter plug
> +	  events.
> +
> +	  This feature can also be changed at runtime, this configuration
> +	  option only sets the kernel default value behavior.
> +
>  config X86_AMD_PSTATE_UT
>  	tristate "selftest for AMD Processor P-State driver"
>  	depends on X86 && ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f207252eb5f5f..379e7dd442522 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -36,6 +36,7 @@
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
> +#include <linux/power_supply.h>
>  #include <linux/static_call.h>
>  #include <linux/topology.h>
>  
> @@ -86,6 +87,11 @@ static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool amd_pstate_prefcore = true;
> +#ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP
> +static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
> +#else
> +static bool dynamic_epp;
> +#endif
>  static struct quirk_entry *quirks;
>  
>  /*
> @@ -1155,6 +1161,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> +static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (power_supply_is_system_supplied())
> +		return cpudata->epp_default_ac;
> +	else
> +		return cpudata->epp_default_dc;
> +}
> +
> +static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
> +					    unsigned long event, void *data)
> +{
> +	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	u8 epp;
> +	int ret;
> +
> +	if (event != PSY_EVENT_PROP_CHANGED)
> +		return NOTIFY_OK;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
> +
> +	return NOTIFY_OK;
> +}
> +static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->power_nb.notifier_call)
> +		power_supply_unreg_notifier(&cpudata->power_nb);
> +	cpudata->dynamic_epp = false;
> +}
> +
> +static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +	u8 epp;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		return ret;
> +
> +	/* only enable notifier if things will actually change */
> +	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
> +		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
> +		ret = power_supply_reg_notifier(&cpudata->power_nb);
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +	cpudata->dynamic_epp = true;
> +
> +	return 0;
> +
> +cleanup:
> +	amd_pstate_clear_dynamic_epp(policy);
> +
> +	return ret;
> +}
> +
>  /* Sysfs attributes */
>  
>  /*
> @@ -1244,14 +1317,19 @@ static ssize_t store_energy_performance_preference(
>  	ssize_t ret;
>  	u8 epp;
>  
> +	if (cpudata->dynamic_epp) {
> +		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
> +		return -EBUSY;
> +	}
> +
>  	ret = sysfs_match_string(energy_perf_strings, buf);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	if (!ret)
> -		epp = cpudata->epp_default;
> -	else
> +	if (ret)
>  		epp = epp_values[ret];
> +	else
> +		epp = amd_pstate_get_balanced_epp(policy);
>  
>  	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
> @@ -1259,6 +1337,8 @@ static ssize_t store_energy_performance_preference(
>  	}
>  
>  	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		return ret;
>  
>  	return ret ? ret : count;
>  }
> @@ -1620,12 +1700,42 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>  }
>  
> +static ssize_t dynamic_epp_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
> +}
> +
> +static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
> +				 const char *buf, size_t count)
> +{
> +	bool enabled;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enabled);
> +	if (ret)
> +		return ret;
> +
> +	if (dynamic_epp == enabled)
> +		return -EINVAL;
> +
> +	/* reinitialize with desired dynamic EPP value */
> +	dynamic_epp = enabled;
> +	ret = amd_pstate_change_driver_mode(cppc_state);
> +	if (ret)
> +		dynamic_epp = false;
> +
> +	return ret ? ret : count;
> +}
> +
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(dynamic_epp);
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_dynamic_epp.attr,
>  	NULL
>  };
>  
> @@ -1715,13 +1825,17 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
> @@ -1753,6 +1867,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>  		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>  
> +		if (cpudata->dynamic_epp)
> +			amd_pstate_clear_dynamic_epp(policy);
>  		kfree(cpudata);
>  		policy->driver_data = NULL;
>  	}
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 32b8b26ce388f..d929ae3163b3d 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -85,6 +85,11 @@ struct amd_aperf_mperf {
>   * 		  AMD P-State driver supports preferred core featue.
>   * @epp_cached: Cached CPPC energy-performance preference value
>   * @policy: Cpufreq policy value
> + * @suspended: If CPU core if offlined
> + * @epp_default_ac: Default EPP value for AC power source
> + * @epp_default_dc: Default EPP value for DC power source
> + * @dynamic_epp: Whether dynamic EPP is enabled
> + * @power_nb: Notifier block for power events
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -118,7 +123,10 @@ struct amd_cpudata {
>  	/* EPP feature related attributes*/
>  	u32	policy;
>  	bool	suspended;
> -	u8	epp_default;
> +	u8	epp_default_ac;
> +	u8	epp_default_dc;
> +	bool	dynamic_epp;
> +	struct notifier_block power_nb;
>  };
>  
>  /*
> -- 
> 2.43.0
> 
