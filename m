Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9723A453F;
	Fri, 27 Mar 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600916; cv=fail; b=p68LEoDp3Jwbf/dDZKoql+G+W/lc3k8MnKxWAdLtOuaPOaGWpioTOGk1tA6usZ3fjwJuDbsAf2azrLTZh/sdpYOMBvnvtjKEKkNRQdidhUaa2Y8mKNmOZSvFWUaIF9SxxEk+pw3YzWuiA1VaigTuNnLM5bBP4mO+tpP/xXSKqwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600916; c=relaxed/simple;
	bh=SnjvnrruoJ3MgK+RyyhACNU1T+ZFsyaKAfCyjk4sc/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCQ49tMUXp0JIqTsU0OD0eiwlhFf12DA/X/dqIqmPKm0boo8Pak4w35OD80qQg/YkyKvyavTeTHs4EjoHocSpZaPIAcpmXwt+m6NkzntjpqTL/ixDgnER5N2DTcdgARnVKlSwQO4sP3FiB7IvurfWueLWnKgTVx+wCWDisUTkiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WcBWepSQ; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WcBWepSQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNaB6CfbHa+w66ti1F0zTt4IcgcsUbYsHlWupUOLlPy4Fi8/2emtLtvxywkhAPrS8r3Iy91L57jf7DzN2nHCoWTnM0zAuhV0CWvTcDyrTCV4NWdFJRc24KPts9hBZnyGHdYtat/lAhVzstN56S8ZCe4QXjUrls8xUx5BulvP7XShSTd/4dt17kyKApxMw9dYZndKxKEc5jbPZRwfokxuByHoivmzovrEsmsaKZwDQmS7M+gzF2i99dx6CcM+pa3E34Ztak7Is7IdpK6rbCVJkvuyLL4nHMkxz18W9UbgBcyl11To/q1A3nmaSlau1MD8sdENeRKxXclCWJz+XWTM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKQMLbH5p/gUIn6PxYj+ekl6zKvACoB1lkNM2XAtwK0=;
 b=r6mdMqaKN9ilFC8xc+VcyVOQVY4/my25pE5zCC8/Kd3wVvA9iBSn0HTsDY2CcsE3UcObIvesFt5nOfSKOnIk0bsWpNBohDW9KTI7nB+1AjvYqlgw6Y3opiN/IHRFU5GBcSvXeGgk407umcWGg5Byjmem44L64pnPYelm0bwjSk5nRZIzaEvzyi54ER7T6b94jN5iOE/2JdviY9bkv0cIo9LzsST/v0y+K9Rml977LYgu3EuIkjdeMMOZWJl3N4CTjcCUUFkYF3BrTNnDLaw96J68s2Am9MGagssHnMsfaRC1P+NQCQQ5jrhxZGGy1xPcxtnIzlgnwL4f9s5bDw3P+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKQMLbH5p/gUIn6PxYj+ekl6zKvACoB1lkNM2XAtwK0=;
 b=WcBWepSQtggjSHS4anfHY5g/4DnhP9cmVmwnp22oxD/7IruMPOuoM06slYJq+5o4f8XJOqPpcj1091M6xb13Z0Jf/TxM0Dp1Nf0pfUjRtUx1gcbS8m0gTD+oxzK5zYxxph6/XlGKVxPwjPcpQRQEoYNZPyQWEUbici4Co6ZS1rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 08:41:50 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 08:41:50 +0000
Date: Fri, 27 Mar 2026 14:11:42 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Message-ID: <acZCxlXw0WKbMAr6@BLRRASHENOY1.amd.com>
References: <20260106051441.60093-1-superm1@kernel.org>
 <20260106051441.60093-5-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106051441.60093-5-superm1@kernel.org>
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbe20a8-cc43-4104-8243-08de8bdcb0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/vLBdYD7kCjINeGb6LzSoZgfaAT542+cRv+PQ6YJZgo68qpHwvDuo6vp7dvs/vOsdO/ZdvwEIAAHLuXe+v/0LesL9dLSSmBTdBXbzpNJVR4ShJk7WW9JECqPA7T3pgZ3tOtxLCzPdRbZ6IS1DxPLmnrfVw2cC9nh9OKCf2ANCyjA91KiXSbSRQQLAlyeiW/YtnZOXKktasdlu4Oxw2oyx+1wgBdpHVUyN7tLjPOiNoObF3oQf4o/+c3u5R04aPQnt/zbQ8EI9c0ZA5QWbeRds+syx/OJGiy3oo7ENqIDwJSExHm76G3fPoshBTtfCBNowW2DIGgxOlw+XPhVEcYnxhmffmIKn9/26lD3lDMRPAMYuo76g4o7lKrzAWP9vhOkVhmDlloPaL70NQ7IsXx2TfN7747uxhnhHFs/AbcgBlUeuY0F7qBR3oD1ngUYIUERDnVnuo+px67JYpp49/U8wzyVK5P+yoL+i8J1wisBhkteetPy/RjKGPTR+FdW7rJd+TtXHGdL2eYiEX84yNTIUKvly14fdWUKkVZlKGNaTN7R6pebi6ur46pn/AQgNegtHHl28S2dgYEnuW/yLRf19+bCf9rrLAQHERvmee+HpITaaYN77BP9mDjQTUFxUEDCedDVHUd7EFhC4BOqj17avuAVcOCiiyIXozmOOY92Pc41c62U0Pe+f5gRj9hjTFBM8904TVV0sLhu+3ltWcOU7eHEQ1NtNHtpZyulM47CNeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V5IWWQSqQ9Xx14J95l21FeN0T5NPWpiQzgAmwDfo0pIF5IXB0fJNQvDMJtQI?=
 =?us-ascii?Q?+hliwICBJkk0oiOLGATb3VrfsZ/nV7t0tmRCs6WMfLZqUNiDYu3LS3hUn5w3?=
 =?us-ascii?Q?SgO5OPkPvNr8yOrK/3qCiVIAt4Z0AOzBYbKcjxTuXVzww5XlRom1cARhBgMM?=
 =?us-ascii?Q?3cQkEhRHUvG+Gn7yeKmSKL7RvIDzJJdIYHYFXmJ//62TWW7PRBa9iCb5A/La?=
 =?us-ascii?Q?gNE4tZnnBJlS/U1aIxgNyz4tcT7objyEn4SyqrvFD0llph0G/ldN4XUn8lEp?=
 =?us-ascii?Q?CqdjssT6EDDOK9jnzlw2hTc8QvUItgwhv4iPtvNWGeiYiyMp8EOP9gV8+mQS?=
 =?us-ascii?Q?3Ffz3iiLAFgDKz26UKtRjLbfoydK/VyQrd7mqdbinA2XNvMpgfmF2DyPd6oK?=
 =?us-ascii?Q?SjhQBaaLovYAv7tfah7K8IFNhYfjxiVSyxaJwZ3SEWUwSWjx2coqLoYJiKoS?=
 =?us-ascii?Q?E5Rf4GeHM8WNMrw7fU/E1MDIPQMJ0faUeUf5u/naIIQ/mvbq7NkCfEavbzck?=
 =?us-ascii?Q?Vd+D+vMmwIOhSLA09ORYTzbSjHPAinVZRhbwYm+X8psi3XJ/dQEllJmuDeh6?=
 =?us-ascii?Q?64TxGjZVL0IUP1lYNiglD2VEe62t+mZIChAbPWnRiLQbO90aPaK3OiLcqR2q?=
 =?us-ascii?Q?pJ5eUMnvRtbNC7q0LKSMV4S4Q0+M9jkwuO6GcsJrSzEa+vK7qnpbIDRK8/Xn?=
 =?us-ascii?Q?ewrKzsWh8ZK5tg3Q+YgfqxAwBh7IjBb58oEnAE/+/DJ7qoQBX7sbIFQIlVX4?=
 =?us-ascii?Q?Hdu4PXQNDZu/6lGvGRVCLw1Skn4ulJU6bOdXVyDafwzEm4LUD1VHlqYusmdw?=
 =?us-ascii?Q?Hucei7RL5Jc4IPmZ5GHd48yJBQu8y5r3XBatZqCp9rdWe0KvIPhRf2brmFme?=
 =?us-ascii?Q?s9oWAypT+BXaM0fijCZE0OlDca4bNbncNNERsxcLlPxCwJ4OB1Gc2Ijho91p?=
 =?us-ascii?Q?CElnLZUDjy1y/bVg+zk313VHynScGQHQ+099PchX0serH6wt6+XRoFMIzZ4U?=
 =?us-ascii?Q?ACEeL6DqRSzslJW/aWALZ6+cfdq5/xwUtK0RBmRUUeiEQbNv/AO8WkTkNQSE?=
 =?us-ascii?Q?UBcKsiNdIfr11eUR+Ij5nenOh0L7N9HvK97giIMXLxnKkrV3kBQPgJjXd174?=
 =?us-ascii?Q?cwn8Bz2W07FzWfMWe1f7JbdBmp6yHN8Ou4mahkosqtITtXFKrCE1nr1blx5R?=
 =?us-ascii?Q?H2+ZwSg0aLU8oZ37rXEDsbYGZO1lxH92k2a/0kFP9VZvzzV71Hlt3lloazHq?=
 =?us-ascii?Q?LZ+hGdOTAjCy/ejKLzmQVZE3lujYOeXxG6ZxtLn43cLXbQXHWt36yZMyj9QY?=
 =?us-ascii?Q?RJoQ/OE+lM9zwUoG6P+VZw6XBp+3Yq4gONKakmFfFcT+ahs2jI8phF4EbZUF?=
 =?us-ascii?Q?vFmQ8KNovc+T3jeeHD/6jGcnjqIF/gwxMzeirW27ibEZxCEeUqJpy6IYTP/7?=
 =?us-ascii?Q?6KeoRadQLMlj78PYhMJpGzQG6kymxd9tl6ug/lP6Sf6SwUVHZWNizX05G4Gh?=
 =?us-ascii?Q?BJXZlM/HPF8x9YX+MchEkzRpBuNdHU5kOC0DHGZDum47D/cJZcKgLBk/bxYN?=
 =?us-ascii?Q?doPFby6YU0/M9TkBSmBhflUaq7IiQHNGEN80uoeL+FZdR9RPdy8Iy6xa7rLu?=
 =?us-ascii?Q?xLRHeqAIGxs+viJRJBuD7KU6t+7gnUgz/w0+T5G1+xJF2o/3qEkMcE2acezK?=
 =?us-ascii?Q?mF5TnUG/QfpfUtprqx6kINCNL7ZXcsXUsHmhKTwatbbnf/IYoQy0/OtMGHa0?=
 =?us-ascii?Q?VFtr4GDUfw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbe20a8-cc43-4104-8243-08de8bdcb0ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:41:50.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkmaVJgPy4z+LPDFSOK7HZm8Ph93+yfq+aEL7o+1hUKg8dK46ATi6nEKk/qL7610M8yoenk06tCszwJ+Iw06IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553

On Mon, Jan 05, 2026 at 11:14:40PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The energy performance preference field of the CPPC request MSR
> supports values from 0 to 255, but the strings only offer 4 values.
> 
> The other values are useful for tuning the performance of some
> workloads.
> 
> Add support for writing the raw energy performance preference value
> to the sysfs file.  If the last value written was an integer then
> an integer will be returned.  If the last value written was a string
> then a string will be returned.


Support for raw EPP values was present in the previous patch
itself. It appears that some hunks from the previous patch belong
here.


> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 16 +++++++++++-----
>  drivers/cpufreq/amd-pstate.c                | 11 +++++++++--
>  drivers/cpufreq/amd-pstate.h                |  1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index a6745f2358e61..674e76ff9293e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -280,16 +280,22 @@ A list of all the supported EPP preferences that could be used for
>  These profiles represent different hints that are provided
>  to the low-level firmware about the user's desired energy vs efficiency
>  tradeoff.  ``default`` represents the epp value is set by platform
> -firmware. This attribute is read-only.
> +firmware. ``custom`` designates that integer values 0-255 may be written
> +as well.  This attribute is read-only.
>  
>  ``energy_performance_preference``
>  
>  The current energy performance preference can be read from this attribute.
>  and user can change current preference according to energy or performance needs
> -Please get all support profiles list from
> -``energy_performance_available_preferences`` attribute, all the profiles are
> -integer values defined between 0 to 255 when EPP feature is enabled by platform
> -firmware, but if the dynamic EPP feature is enabled, driver will block writes.
> +Coarse named profiles are available in the attribute
> +``energy_performance_available_preferences``.
> +Users can also write individual integer values between 0 to 255.
> +When EPP feature is enabled by platform firmware but if the dynamic EPP feature is
> +enabled, driver will ignore the written value. Lower epp values shift the bias
> +towards improved performance while a higher epp value shifts the bias towards
> +power-savings. The exact impact can change from one platform to the other.
> +If a valid integer was last written, then a number will be returned on future reads.
> +If a valid string was last written then a string will be returned on future reads.
>  This attribute is read-write.
>  
>  ``boost``
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e1ccbbdd56d42..14347baf3cefb 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1333,6 +1333,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	ssize_t ret;
> +	bool raw_epp = FALSE;

s/FALSE/false ?

false is already defined in <linux/types.h> and rest of the file uses
it.



>  	u8 epp;
>  
>  	if (cpudata->dynamic_epp) {
> @@ -1345,6 +1346,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  	 * matches an index in the energy_perf_strings array
>  	 */
>  	ret = kstrtou8(buf, 0, &epp);
> +	raw_epp = !ret;
>  	if (ret) {
>  		ret = sysfs_match_string(energy_perf_strings, buf);
>  		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
> @@ -1364,7 +1366,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  	if (ret)
>  		return ret;
>  
> -	return ret ? ret : count;
> +	cpudata->raw_epp = raw_epp;
> +
> +	return count;
>  }
>  EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> @@ -1375,6 +1379,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>  
>  	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
> +	if (cpudata->raw_epp)
> +		return sysfs_emit(buf, "%u\n", epp);
> +
>  	switch (epp) {
>  	case AMD_CPPC_EPP_PERFORMANCE:
>  		preference = EPP_INDEX_PERFORMANCE;
> @@ -1389,7 +1396,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>  		preference = EPP_INDEX_POWERSAVE;
>  		break;
>  	default:
> -		return sysfs_emit(buf, "%u\n", epp);
> +		return -EINVAL;
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 9839c7c6558f4..38b575b8ad959 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -110,6 +110,7 @@ struct amd_cpudata {
>  	u8	epp_default_ac;
>  	u8	epp_default_dc;
>  	bool	dynamic_epp;
> +	bool	raw_epp;
>  	struct notifier_block power_nb;

Looks good otherwise.

-- 
Thanks and Regards
gautham.
