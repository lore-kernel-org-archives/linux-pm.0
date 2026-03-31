Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA133F8A1;
	Tue, 31 Mar 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977446; cv=fail; b=ttgGcIwdEtv6JU8g6L1XD4fdfFcZUBQhms+gwh1LCV06FDNy2WRzil7a4tAnTjjS2GmVvwEnJUYYzIOT3CpCYzFGwAmDkaSn0Uagzm41gJ/FRRPzncdF0HG3mBNzs7LQhmWKoLVQSxbBxP8A8ow7pzRj4eQ3cMonWc+HxZj3fjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977446; c=relaxed/simple;
	bh=QSZ3BdTJblzRLlgUdq9vlZwYMZF1MSPpR0iWTklbUKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t8VqC/pvDaKYd9D5E6ncZl45IyBvtPHg90nzns4YfBPzK3WmQereAHHjv6tuCuqGIz4LJpClM2HeY/8E0eoqE2jYH2YmXthsQLC67n47a6nvFes1KBshzdoUd4/wDULDuFx66wQCvV6P1waPQIjOctoc368U5Jf+Ah5bdxwyl98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1u4J8bX; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1u4J8bX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHy1KXl/MP6U7ZWHzwY0fhxZyNCZ3K5jDx05ytYfMPUpyR8AlqYUn97xmrnJ7zgAeshCByDOYajQAf904bXMRVQtf0LJ8GbSk9lgVNoN58N0+jdmSmm3L3jIE3WW3VrxxzyNk6WIRoeOhHpQ0yR81oT+DjwfirL7sluGunZMDV2tOqWnVcfP8vtpfL2hmeCG43yQNihQFc6orgZ0zsNAvQDkKv96uTz7G1/Xb6Quq2ZHJESy4mBRzcFBsjbq9Ft+TY0xX46sFzDooAkZdbksgh1MUQO5KWRzSGvEGPmIthI62sld/+DuJv/00MRU+uwF4ibnjju/uj7KsBSzKKqbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op1EUAQO17BASMFNPZ6VLgB0CopHLeKz8XEUe8Jtx3g=;
 b=blZhSU4IfDrQ9ZFa03QOtje6MbKuRte0o1ToWgZyaM52pIo7r4jFI+zZDHUrAHFtHwIrOJEzr2yNGfSBWB+9yzo2L1INJXL2CiJnKY54NQNBxCRNqiEachyPPA46kdoThCph8xy2/GaxStGZ6qUc7njiEdKofN5O4kTXAUHPH4nL5zf4jU2HzOlc/HGFpvkIQnyGebL5xVbSn2czmSoiLjC7SE+01kgtGWefvq4xS5KHshALVtDhkhaD2F/TE6OTAGfw+XsHm47FSuw+mGi9dnSWhFGQHl6spBOkV1OtAT7aFF0F7iimUthk53p0PYeUlvpkMik6tqV2hDyD0SEC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op1EUAQO17BASMFNPZ6VLgB0CopHLeKz8XEUe8Jtx3g=;
 b=k1u4J8bX75WyvFEM8zCvmPXf9dsXKOGy21ysHa1HIsFx6rU4+ehPAmFMMdVu+FKVg1UHdNnUlwg0FbUJwTLpfK9UaVDLthjBMKg2luEHSpaQJ+P/ANxjNQfdVJcdZENPMn1+TV7ugHg9Y5BktjvW30m4rLM63xjFwnh4bHMneks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 17:17:21 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:17:15 +0000
Date: Tue, 31 Mar 2026 22:47:08 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Message-ID: <acwBlJ07Y+9Qx86V@BLRRASHENOY1.amd.com>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-6-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329203811.2590633-6-superm1@kernel.org>
X-ClientProxiedBy: MA5PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b64c186-e555-4737-6550-08de8f495a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aclazcSQcxNRn0KFBaG7qUfOZMDc1j76sjU+KT3M2pAooD1aXV9NFFb2A3F5DTJIx2/Y4XncpDBsFN8Ij35OZVARBXLPuGFuHQMxfMRRRsPn+sGf86pi8fhXpxuJbmOvvMd/DVKzj6Mba0ZiU30R8LPUJAu++zXO8iVNLbf518jjvyoo61auEiKmmWibzpVsC2T6hIkU2L7TkK0wf3YHoksLJShaY2pBVxQrLmebGFRYTX6z2zckIKpaPEDfruVbDLvtF+Qc0c5fIE6ZHH2U6zwKkfXdXAZXbV4Igf0Ld3kLqEMfzWMI8uyAfi/SOnKY8KNn+Zu7CQ5aeUwCZzz7TWG+2yyotLzEnzmVCIO8AH5m9opIQ016mK5SDAiaPPp0f7CtA0GGw/do1ofmtGe5j+6QzMnHicA9Ng9gu0LaE6t12+CkSWjuNcAwmto3BCWNQEafGVmai/7Yygmjxv8RU/COVdcuRKb7h3x2cqszPQJgJ3YlZRAC6ecvQDmWbWTrOgsWZsNUmOUXh5h02dTrwMEvlPWg+KmQNFoi2W5WMdjPFwVbcf3C6wJGwMMGop4pldpWggKH+lz475Pu2tgIYfncR/Xwyig+2wkd6pMlP00HApKm7MAv2hCC1hH0UTkEN0/V1S8s2pBFV/fvYCsZ5Ocl58+aMId1FXiXM0qekQZR+nYihgoLyQ68AygXdVFDhjH2wS6t//RssFK1a7hoQuvUNfZ5If2Y8OyPQ/v/dK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90/WcE5yrHzLItaZPREIH8Md/vyK6NZUmsHv8uR9yFHoviZn+WVwT5pJl0yu?=
 =?us-ascii?Q?kvqJdwSIiPZFjB+1NqciNBI3yFnQMvdyj6Tjk2/Rc+JnmcjJXlsfd+d4Z4zB?=
 =?us-ascii?Q?E1xs9namC5RG5uMd62vc0E/kjVHelin2cci9YbYmtXoFUrFjE9S3T5LeoZPa?=
 =?us-ascii?Q?1Mx7MX8svUDH9s/Cv3209R+nEtSwLDkQJDQGZn/r3yrE+Uchqjsz0EjHPNi+?=
 =?us-ascii?Q?V6ypOnw4wXAyMrSrCe+1Zp2N6PpSfwTtw9ndoYG9qOT92+d6MTWDftKW3TN2?=
 =?us-ascii?Q?mn3jdflbolCsMTAaHffHGCSMWf1f3C9updSGbYCMRoruEZDVi8ZG1FG+B0lQ?=
 =?us-ascii?Q?bck95sssz+1Cp/yfuINSLHkAvcQxn1T69bobt3nFF649PpQTR+7FH/yOQy73?=
 =?us-ascii?Q?/UaWsnyBaZew4ShtRftyqV29qI6hkAya8G3KuG0JX+L0pHPk37/TCcS9q3Qc?=
 =?us-ascii?Q?DTzFnGZaa68INBKVxzWvp70D+cJSMQVNODmjIrDDErYOnN5+oh1lxvFyUtKv?=
 =?us-ascii?Q?LuTHc4VvSntQo5D3vD4ej9qQDlUfvaWLRqXTx2tHKLPKCqxnPplI48XVjMtG?=
 =?us-ascii?Q?2pyBvqPxjuVUS01frAz4gBYB2GB3zVPunKZP8fBIxLplgVhVmYELH1OOpeCV?=
 =?us-ascii?Q?tz/D9+rpKd39Td4U9RnipohyinBltOBSsB3JDk5bND+sPIbprGIKMYl2mqjC?=
 =?us-ascii?Q?u8AIk2TS+KD5PcLMVHoLg3rvJmGgavS0rFLmUyFsJ3svP6fhDUenXcmousm4?=
 =?us-ascii?Q?OTKR1nlBhHmk2bYk/qcmYHZQFEGHtDNiaq19QcxFW9O9cCV7ZeKX7b39awQu?=
 =?us-ascii?Q?TVDmqil2RM688dqV06se9Az9fSancAMse8GgnLPthbbCwpQ+iA49XEu/bniV?=
 =?us-ascii?Q?kmKdoupHnQ1deopTwzDFHqN1Vg9R/aFE3as69kIs7ZqWbhTMLkNlkTVuipim?=
 =?us-ascii?Q?5tiqGVaT5/CF7Hl+wz1PPTmJBeA33AMa8h/nXiLB8VlabBDPbSrZnOdxdAh9?=
 =?us-ascii?Q?vMCwkZqwreSsUn2B4LsReZMNgr3uGHP3yAAHEMre1LSufShPZ4dnwouOsg87?=
 =?us-ascii?Q?TISSKQKTQb8Y9e1F5zeYgpa27PWv/EbC1h44zlG3IX4NN8Xy73jtr8dNFUJ/?=
 =?us-ascii?Q?YgeDhhTnny8JV6K1UfPYro5zw3e0uWzw5RSssky0YHeJjU0VQ2kcJWTl+0R7?=
 =?us-ascii?Q?DwNyvKYUI6zEKt/kRRrlnfrdMQz1gzHCWEzbyjCWIjYUqZTZdJSfnHDCYGPm?=
 =?us-ascii?Q?hS/IfVGUDium/GdiX6H7C/nSZi/YaNeFkLGA7LnwUcHlEiaKkYky7oNxDbtb?=
 =?us-ascii?Q?GI5pk+aNhiXucbTk7KWJjwQrhoCiitE3PHhltDmQy3BZIIlFBCbZ9N5L9au1?=
 =?us-ascii?Q?0Ny83Cvr2upndZz2b7MCEgYvs4wMBrcVMtDiofFaNn54qOAAHCdwQCH7T2NT?=
 =?us-ascii?Q?fsxRLksuyqp35BL6TX9n8mV2I39/KTJqvfRppNpfEAB4l7U1DUnpD4oqFpM+?=
 =?us-ascii?Q?J+BeugjpZsvkOAuRClCI3/XsxdxfnYNkTR1BWW31J7bc8e2LoTg7v8/g+Luz?=
 =?us-ascii?Q?bEY/GrwNgzOcU7Va98M02WIoHPuJqryI2nyGVrPs+ADH0jjvQuURQWwelepF?=
 =?us-ascii?Q?ehwhlg/YdVQe2ifr52HvyJtINynMipAGcwaPW5JmMUiD7pqHhvTd8Dg4uY06?=
 =?us-ascii?Q?Si6CWObfripO90Wde0fxPWFKRwabsvK0w/56qYyZiUeqO2Bilqez/IdXcM+D?=
 =?us-ascii?Q?sOi6nuRz+g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b64c186-e555-4737-6550-08de8f495a90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:17:14.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s14bZ+sYNu6wwHSzT9Z6gXR61FE1w22mte+TcjGJ6aNNW0f7qpJx9esEppW3liumth6GnrftJ5MhrLQ4zvygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404

On Sun, Mar 29, 2026 at 03:38:11PM -0500, Mario Limonciello (AMD) wrote:
> Ensure that all supported raw EPP values work properly.
> 
> Export the driver helpers used by the test module so the test can drive
> raw EPP writes and temporarily disable dynamic EPP while it runs.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> ---
> v5->v6:
>  * Also verify that string EPP writes read back as strings
>  * Save and restore the original driver mode and dynamic EPP state
>  * Export the helper interfaces used by the unit test module
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 109 ++++++++++++++++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c    |  11 ++--
>  drivers/cpufreq/amd-pstate.h    |   4 ++
>  3 files changed, 120 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 1f62ab6438b4e..aa8a464fab47a 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -28,6 +28,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mm.h>
>  #include <linux/fs.h>
>  #include <linux/cleanup.h>
>  
> @@ -41,6 +42,7 @@ static char *test_list;
>  module_param(test_list, charp, 0444);
>  MODULE_PARM_DESC(test_list,
>  	"Comma-delimited list of tests to run (empty means run all tests)");
> +DEFINE_FREE(cleanup_page, void *, if (_T) free_page((unsigned long)_T))
>  
>  struct amd_pstate_ut_struct {
>  	const char *name;
> @@ -54,6 +56,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
>  static int amd_pstate_ut_check_enabled(u32 index);
>  static int amd_pstate_ut_check_perf(u32 index);
>  static int amd_pstate_ut_check_freq(u32 index);
> +static int amd_pstate_ut_epp(u32 index);
>  static int amd_pstate_ut_check_driver(u32 index);
>  static int amd_pstate_ut_check_freq_attrs(u32 index);
>  
> @@ -62,6 +65,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>  	{"amd_pstate_ut_check_enabled",     amd_pstate_ut_check_enabled    },
>  	{"amd_pstate_ut_check_perf",        amd_pstate_ut_check_perf       },
>  	{"amd_pstate_ut_check_freq",        amd_pstate_ut_check_freq       },
> +	{"amd_pstate_ut_epp",               amd_pstate_ut_epp              },
>  	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
>  	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
>  };
> @@ -268,6 +272,111 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>  	return amd_pstate_update_status(mode_str, strlen(mode_str));
>  }
>  
> +static int amd_pstate_ut_epp(u32 index)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +	char *buf __free(cleanup_page) = NULL;
> +	static const char * const epp_strings[] = {
> +		"performance",
> +		"balance_performance",
> +		"balance_power",
> +		"power",
> +	};
> +	struct amd_cpudata *cpudata;
> +	enum amd_pstate_mode orig_mode;
> +	bool orig_dynamic_epp;
> +	int ret, cpu = 0;
> +	int i;
> +	u16 epp;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
> +	cpudata = policy->driver_data;
> +	orig_mode = amd_pstate_get_status();
> +	orig_dynamic_epp = cpudata->dynamic_epp;
> +
> +	/* disable dynamic EPP before running test */
> +	if (cpudata->dynamic_epp) {
> +		pr_debug("Dynamic EPP is enabled, disabling it\n");
> +		amd_pstate_clear_dynamic_epp(policy);
> +	}
> +
> +	buf = (char *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);
> +	if (ret)
> +		goto out;
> +
> +	for (epp = 0; epp <= U8_MAX; epp++) {
> +		u8 val;
> +
> +		/* write all EPP values */
> +		memset(buf, 0, PAGE_SIZE);
> +		snprintf(buf, PAGE_SIZE, "%d", epp);
> +		ret = store_energy_performance_preference(policy, buf, strlen(buf));
> +		if (ret < 0)
> +			goto out;
> +
> +		/* check if the EPP value reads back correctly for raw numbers */
> +		memset(buf, 0, PAGE_SIZE);
> +		ret = show_energy_performance_preference(policy, buf);
> +		if (ret < 0)
> +			goto out;
> +		strreplace(buf, '\n', '\0');
> +		ret = kstrtou8(buf, 0, &val);
> +		if (!ret && epp != val) {
> +			pr_err("Raw EPP value mismatch: %d != %d\n", epp, val);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
> +		memset(buf, 0, PAGE_SIZE);
> +		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
> +		ret = store_energy_performance_preference(policy, buf, strlen(buf));
> +		if (ret < 0)
> +			goto out;
> +
> +		memset(buf, 0, PAGE_SIZE);
> +		ret = show_energy_performance_preference(policy, buf);
> +		if (ret < 0)
> +			goto out;
> +		strreplace(buf, '\n', '\0');
> +
> +		if (strcmp(buf, epp_strings[i])) {
> +			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	ret = 0;
> +
> +out:
> +	if (orig_dynamic_epp) {
> +		int ret2;
> +
> +		ret2 = amd_pstate_set_mode(AMD_PSTATE_DISABLE);
> +		if (!ret && ret2)
> +			ret = ret2;
> +	}
> +
> +	if (orig_mode != amd_pstate_get_status()) {
> +		int ret2;
> +
> +		ret2 = amd_pstate_set_mode(orig_mode);
> +		if (!ret && ret2)
> +			ret = ret2;
> +	}
> +
> +	return ret;
> +}
> +
>  static int amd_pstate_ut_check_driver(u32 index)
>  {
>  	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 11fc992ea2da1..e246a1477cf78 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1261,7 +1261,7 @@ static const struct platform_profile_ops amd_pstate_profile_ops = {
>  	.profile_get = amd_pstate_profile_get,
>  };
>  
> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> @@ -1274,6 +1274,7 @@ static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>  	kfree(cpudata->profile_name);
>  	cpudata->dynamic_epp = false;
>  }
> +EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
>  
>  static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  {
> @@ -1411,8 +1412,8 @@ static ssize_t show_energy_performance_available_preferences(
>  	return offset;
>  }
>  
> -static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> -					   const char *buf, size_t count)
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +				    const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	ssize_t ret;
> @@ -1453,8 +1454,9 @@ static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy
>  
>  	return count;
>  }
> +EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> -static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 preference, epp;
> @@ -1483,6 +1485,7 @@ static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy,
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
> +EXPORT_SYMBOL_GPL(show_energy_performance_preference);
>  
>  static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
>  					   const char *buf, size_t count)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index f7461d1b6bf3c..e4722e54387b0 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -150,6 +150,10 @@ enum amd_pstate_mode {
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>  int amd_pstate_get_status(void);
>  int amd_pstate_update_status(const char *buf, size_t size);
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +				    const char *buf, size_t count);
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
>  
>  struct freq_attr;
>  
> -- 
> 2.43.0
> 
