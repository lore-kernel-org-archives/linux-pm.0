Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECF3BFE2A;
	Fri, 27 Mar 2026 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601958; cv=fail; b=l5+rmql2Nyqnzz7RHA0Ank5DEJpfl4r08NbvCZjdcQvB/bmHinbpCa+kbEtPXVFRP3dmI4gQN1i/eeq4Muf7xQdZX4o8fAS7FXKHBVzfRn7lBGS7dPzZpH0cgzkFKk7YxxvA1QBslwAiIEWFQo9cCPu2EaQINFJ4KKX0szO228E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601958; c=relaxed/simple;
	bh=0yutfLeUP6UoHb1xlTeu+ytGeJE87HHWS+1w7UqBIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g8O95N8KnhNPcO+vX3u4rH6Xl3EAn3B0MiEDGq87VoriHyA4Wczmm6lo/zBVeA7d1CFqRyWqupbThhjNLMpIVydYiMtcbaKMXjUZCmeojVPgs7HOUkfyLnsGL+uZDW7Bf6LO9fgCVvI38FRWo2fe8F3QJ8jkJlHZ15Yk+rIqY+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiUoMgXt; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiUoMgXt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaYoBV4aSTe1xQeHkG62Y+0ACHN0lygR2lTIWQ19V2eQKuzF1M9Mvq/2cX6gx6JNAD9hLT+cXOj0fxm25HWy+fbUFu5wMI2RHHQ2gD6FtZCQ/YIVM7DkwiQSy5htwNPGqWUevVF+3xHKbCWtu0vOV5WvRA1Op2K+6TwPrdq8uunbIbKvDlA56NgtrYFwkZDjPyfPAxLTN/WZMhL/T7g60PhVyMq85vHu3IH8S/R8Z62ZkJj+z/xv5akpfhsrzbFMOpxyB0A1hy5yAteL3/8kjQw3VDpIcoTXkTOxiyBpgtlHQR7qzUltczURVkoHd+Y1tOy2rrn4jbQtf8BJdtgfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2cNujVBziOWUSyOcwegsBguy8Z1jFHxN2bZuSwy0ok=;
 b=E77/Kq3oA2uhdDaEjWLfStFv5DAa2GBjSfBXvXFdSYhypjUHbK2vsb+F3ByClQexyPbzD3kgBiaUMDN4wsmramUuaiYwTW6Cp/5Ut6T1bJAvNLFqwQ85hZSzEgREnyVLpo5jVSYABeNLiHSw+0COGfejYJ3gbiU4IB1Xd4uMs7oeFeO4UKXCcMtAwpdNFZhkluxLfz2dZQ7eqRYJsXpWaF6QqRBmlRazaIC4U3Ri7zU/f1VPMacHWF+2/Jp7l6JR7gOC44petSDog0gkdNWRotjBMBgGD02qs6llac5piqRQqqZ1jyNCP3YXktwnWDFUy7CCmzdMAQYNKEoi1LwRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2cNujVBziOWUSyOcwegsBguy8Z1jFHxN2bZuSwy0ok=;
 b=JiUoMgXt5wuZrL0vSdSJPwT3OSzUrLtdQiDBE/W4qpRMqwajBq22UtFRod3lXRNVLXFI3KoSfsgv1OdoRf9uyf7Nwy+pOKn96APQJr+bkbBSA2f2qJz2C7Q590iv7nMbtTBnC031n4vBGXYHHMGiltn68/TbvfRXkqVNy1Gwl2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 08:59:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 08:59:13 +0000
Date: Fri, 27 Mar 2026 14:29:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 5/5] cpufreq/amd-pstate-ut: Add a unit test for raw EPP
Message-ID: <acZG2JUadI4zqgGp@BLRRASHENOY1.amd.com>
References: <20260106051441.60093-1-superm1@kernel.org>
 <20260106051441.60093-6-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106051441.60093-6-superm1@kernel.org>
X-ClientProxiedBy: PN4P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 71803e41-b828-4db5-2dd1-08de8bdf1e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jgddNWUTEJU9FZta1UMzmihmFvdXwnMq66IyDAA7XkliiAK4UYWGZ2SHvAr2wFlAqeNLO9GX0rn16SqHlLtKPqAf7rNXagtyjUjlUnh6xGyPg29KdKW5wiLOgiKaLuuYr87A3ZRFRV4NKBNEQtcx5xUFj2mC1mYQU5u+DP99FYTOSU912fuaZ9ZyBhydHKXxv/xrbN49x06xaJEqFdZ6poiFz+uPP2aQFfn0/AmAvpra4NVhVdWhZFCgqmiNRuiU4DmZLf/UyNeCABO/l2Pwzg+ZozAwI1d5HKGQhNv/iUrpNDm0gEjMqY7x44ZMn3pqLO75D1xRjbjXTZpMkEZKhRzZgf0ZRnNdwEmFXEfZbapV25Bme7/FwrzTYmv3D4Fo+WGi0vYwNPa2jvREeSvpVSi5nsVPLykCnlN/Q+Jb69g2hg5JMMW4zgk/VX/bPTNm8oVW5g3tPWlDpKbOTfKQSHaPu+fGSY3xNrqaWeW1zylNC2J3Lttis/289zFm2SsRwfaJYlAmvTkDam/acKRN4Bjm2A2quDy8bE0JFqu5agqGbiMl0UvcxWBC872BHOjstucLU4bEioACtRhJE5Rodh/Vvk6/B6OU8GoG9/TXLXCaDcvgUtGL0iAYq/2C1ejdI4DLpjP6DooUIgH7Fl3u716SIUZWY2x/MpVR9pg0jZSiP+T6b4O1cpxiopSmpqMhiXi+c9o8md5PBWC8436rCUYnoy8Wwe2/J3cZc7R8uJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Gz8WojrsiXWlQXITdp1UIaVzSVncY3Gying+AOoCrNZQGpzpoBLH8r2otcW?=
 =?us-ascii?Q?BxNCKEzV9FaTMztITSRi16E7NpLRMkvln0JPDACcP4oMS3mYrF20/7jQaX2z?=
 =?us-ascii?Q?dHBW7JrzQxxSp4GyVlqsFOUjSC1Nfy9+sA/gjcZ1uEzTMiMwE8EIUB3elJac?=
 =?us-ascii?Q?u+o0u6wPktPrV2SE155uFoRnSIe/j6OmGB7/ByfjSMCVR3065Vw9Np6EUFdx?=
 =?us-ascii?Q?fv3iHTJFKIfA68obrwm/wMWIArSn5bgA+zXKXJmGQONqhjAHNe41Jk/ImSPC?=
 =?us-ascii?Q?97qvFbSyWSshRR0UzHnblxRmDlzD9TcRiS9w91KaIlBCHsAyZ//0nG5kjIec?=
 =?us-ascii?Q?158yiC4UTjzqIosJC4HQ55hcljTxMohH33xuRoetnT1HVZuMl9y8ZpL/3crb?=
 =?us-ascii?Q?UbXW65BnxxVIRDKIoNVLs+RnKfehG4qsEuyXic94lQi1Km9j4Ay3ihRYX625?=
 =?us-ascii?Q?JrvsDxqbYW58Oykm9efrOvLjNkjpju7wVffdXJClFO0V9VwaL0G3ugtETcsm?=
 =?us-ascii?Q?aLph5a/vCVONIChoNKS8UOmEfMar9R1TfiRqBSPtDW/BoIslCpltfdu+GqRf?=
 =?us-ascii?Q?cvf34kKFRDGGFkE14nxqP5v3+sNUvkM1LyoJzdKpSncqEogT1RJmG7fPyhGz?=
 =?us-ascii?Q?/g7mQ8pELu/WA0zjmTSZghGxXTFv6VDsPubY1uDBDiXuFB0ayMkebf3ytl6K?=
 =?us-ascii?Q?R3PYC48MT/Qd4PGX97XqE7Tu6iovOiRJBVUspcTUwCL7mbGySzckHDw1xHe8?=
 =?us-ascii?Q?0dEXVJklh873jKZZFsE7zMSIOI3e4BpuE5DvimFqXwErEL+InwxH/dRRvB+m?=
 =?us-ascii?Q?rRyLKOZPUsGVb2R1iWoHgmSwb2fqkjG7S2LVFHovVrLkaicQilZDnnVCpiKg?=
 =?us-ascii?Q?p5OLUOgHTV53plXCsMoo7+qV2jQMxa/XRqA7G/cykIxH+LH7eZR5wjtXJLvS?=
 =?us-ascii?Q?d1SLwQv5mfFWoxmq11hsfT7e4aLFIyvElZP5EvY7p3ZMc/adnBFVu39LTh0G?=
 =?us-ascii?Q?Tk6Us+D9YAQp9GjrJ0K6bBSXx8vm7oqc+/NBNyA7GZa5PsRM3aGGVws1KxKQ?=
 =?us-ascii?Q?B8vVEflNLmX8rnqYOti6OxbnaJvX9w3zzQkVRKzR+05uvOazMkrml21qBlKS?=
 =?us-ascii?Q?2Sf2dXkbHkHoc5MCmFCtb1B8FWjOaHddmeDLA6WoLvvRmIi1ug7w3X7Q1KOb?=
 =?us-ascii?Q?BINqf5Z0sP+ra9zFiSHKvnEfJyPYFKS0J19Z4b82C0zsEWkGT4L6udzyZ7sd?=
 =?us-ascii?Q?8+XbERIWWn7UkRdYnzvIG4EH5/wwkOeuvZNF9/gAt67ODob2jtNj1wYgW63+?=
 =?us-ascii?Q?sQcPkvAC9TDD+ytzHu4n0VoL/Sny7YyrPX6ElsMkapF2UOXEr0OCv06iXpF9?=
 =?us-ascii?Q?ylRgPw+pKF8YURZAYCJrff8WOPgz9PjHtsKzIYE7BiLtG4hoSCvMiANaMrxb?=
 =?us-ascii?Q?2gbiRELfhiXaywvtElCVJ4J1UTu0UDbJWxOQjazvHP4Xg+VSsJusDAyHzX/7?=
 =?us-ascii?Q?7Klcfw6oXMMHRngeWrCv6JW5jGwh9IejuZhjwAdf5+nKYYN7rl7XqgIK0Sjx?=
 =?us-ascii?Q?C6HJ1dMaz0ZbPrKHUJbUOBggsG5/HFojEepNbRvr+cat15uH54dAjhRh6EVi?=
 =?us-ascii?Q?PTGu5BUDyzCgZ5UPPCOwxjtA15fZC/+xlZ2egMnNCxvN1cJYI8rw/ajF4KQT?=
 =?us-ascii?Q?YWjmeQgKbalqv1oc284uqnCUzVlg3ugxHx3zdtFS7HI6ShpX+xT+tx+lfwl6?=
 =?us-ascii?Q?z6cKDG7zZQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71803e41-b828-4db5-2dd1-08de8bdf1e15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:59:13.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBOtTVS89wCNZgH82VpsXKTxAZBa592WpLNgLYKjdDLwnFVPbzfaE8PqMNi7/xXdPAuvX5Pxp8M+wFgLuFOMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

Hello Mario,

On Mon, Jan 05, 2026 at 11:14:41PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Ensure that all supported raw EPP values work properly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 58 +++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 447b9aa5ce40b..d51233b753db6 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mm.h>
>  #include <linux/fs.h>
>  #include <linux/cleanup.h>
>  
> @@ -35,6 +36,7 @@
>  
>  #include "amd-pstate.h"
>  
> +DEFINE_FREE(cleanup_page, void *, if (_T) free_page((unsigned long)_T))
>  
>  struct amd_pstate_ut_struct {
>  	const char *name;
> @@ -48,6 +50,7 @@ static int amd_pstate_ut_acpi_cpc_valid(u32 index);
>  static int amd_pstate_ut_check_enabled(u32 index);
>  static int amd_pstate_ut_check_perf(u32 index);
>  static int amd_pstate_ut_check_freq(u32 index);
> +static int amd_pstate_ut_epp(u32 index);
>  static int amd_pstate_ut_check_driver(u32 index);
>  
>  static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
> @@ -55,6 +58,7 @@ static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>  	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
>  	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
>  	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
> +	{"amd_pstate_ut_epp",              amd_pstate_ut_epp              },
>  	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
>  };
>  
> @@ -241,6 +245,60 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>  	return amd_pstate_update_status(mode_str, strlen(mode_str));
>  }
>  
> +static int amd_pstate_ut_epp(u32 index)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +	void *buf __free(cleanup_page) = NULL;
> +	struct amd_cpudata *cpudata;
> +	int ret, cpu = 0;
> +	u16 epp;
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return -ENODEV;
> +
> +	cpudata = policy->driver_data;
> +
> +	/* disable dynamic EPP before running test */
> +	if (cpudata->dynamic_epp) {
> +		pr_debug("Dynamic EPP is enabled, disabling it\n");
> +		amd_pstate_clear_dynamic_epp(policy);
> +	}
> +
> +	buf = (void *)__get_free_page(GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = amd_pstate_set_mode(AMD_PSTATE_ACTIVE);
> +	if (ret)
> +		return ret;
> +
> +	for (epp = 0; epp <= U8_MAX; epp++) {
> +		u8 val;
> +
> +		/* write all EPP values */
> +		memset(buf, 0, sizeof(*buf));
> +		snprintf(buf, PAGE_SIZE, "%d", epp);
> +		ret = store_energy_performance_preference(policy, buf, sizeof(*buf));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check if the EPP value reads back correctly for raw numbers */
> +		memset(buf, 0, sizeof(*buf));
> +		ret = show_energy_performance_preference(policy, buf);
> +		if (ret < 0)
> +			return ret;
> +		strreplace(buf, '\n', '\0');
> +		ret = kstrtou8(buf, 0, &val);
> +		if (!ret && epp != val) {
> +			pr_err("Raw EPP value mismatch: %d != %d\n", epp, val);
> +			return -EINVAL;
> +		}

The loop validates that writing a raw integer reads back as an
integer, but the commit message for Patch 4 ("Add support for raw
EPP writes") promises:

    "If the last value written was an integer then an integer will
     be returned.  If the last value written was a string then a
     string will be returned."

The string-to-string direction is not tested.  After the raw integer
loop, raw_epp is left as true.  Writing "performance" should flip
raw_epp to false and reading back should return the string
"performance", not the integer "0".  The same applies to
"balance_performance", "balance_power", and "power".

This would also exercise the transition from raw_epp=true to
raw_epp=false, which is where a regression would most likely appear.

> +	}

Also, the test forces AMD_PSTATE_ACTIVE mode here but never saves or
restores the original mode.  It also disables dynamic EPP above
without re-enabling it.

Shouldn't amd_pstate_ut_epp() save the mode and dynamic_epp state at
the start and restore both before returning like the other tests, for
e.g., amd_pstate_ut_check_driver() do?

> +
> +	return 0;
> +}
> +
>  static int amd_pstate_ut_check_driver(u32 index)
>  {
>  	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
> 
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.
