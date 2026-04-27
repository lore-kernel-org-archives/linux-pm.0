Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EE390230;
	Mon, 27 Apr 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273620; cv=none; b=LMiJQY/DtAJwvv+wHIXNFO1wrcNCmrAjm9zW9nUCOn4fgxLHUxmIOebiGZ3kcTYOGd3jikQ6L4b95FBGSWV6X+WPtSi3Uixu/ZPjxRuls/g36SFcK/MbbGbSQrg5wU0YuFQEHwdjP4AV1+z9M3YV6l86ZlfHJpcPVhUUzhlJx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273620; c=relaxed/simple;
	bh=jQ/Of6NuWtV95WqEXRzimFX3/RycnwrAseFb+cLqIwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QII5+In40YBmhZDXpEL5JpDJzHEdPgA69hiEqX4BxWUQXmb7abYfB2j2vfiYYbhe11Pl68YYh6reu0G/BxL/XeOwsDtg6W+oDYUn4JC5vW8eEL1PSyCnroruIwafxPkD9sYlC21oJdZXZIuCVz0u5CNH+cqplg8QJxgq1mjgE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PgNcpf7M; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PgNcpf7M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6fT5jSoSq1WmKA0qCrQezP/xOt78RngP71vOPtDOaM8=;
	b=PgNcpf7MRFgr01McwJ8qPLotT9gJJlCNtOMemyFpjMbX9giHEH4UulG1PFqPgjKl9dDKuqVp8
	/7iffgyV0reVJiUKl0InVOPbtcmE8fm0KkZTlScLgfnF0bUeb5IajpAgZl4pEpF1kqJ88ejjrX0
	Wu3q73Yw17vQQSLjhIxLbqM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g3vbH0ys5zmV8V;
	Mon, 27 Apr 2026 15:00:27 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 3934F4056E;
	Mon, 27 Apr 2026 15:06:54 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 27 Apr
 2026 15:06:53 +0800
Message-ID: <bdcc0785-9930-49e4-9918-c1255bd296a4@huawei.com>
Date: Mon, 27 Apr 2026 15:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <pierre.gondois@arm.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-2-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260427051823.280419-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100001.china.huawei.com (7.202.181.215)

It seems that mario has sent a similar patch:

https://lore.kernel.org/all/20260427035520.1427080-3-superm1@kernel.org/

On 4/27/2026 1:18 PM, Sumit Gupta wrote:
> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
> _CPC package:
> 
> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>    lets OSPM inform the platform what it considers nominal performance.
>    The platform classifies performance above this level as boost and
>    below as throttle for its power/thermal decisions.
> 
> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>    Register Descriptor sub-packages that allow OSPM to set relative
>    priority among processors for shared resources (boost, throttle,
>    L2/L3 cache, memory bandwidth). Parsing the full structure is not
>    yet supported; such entries are marked as unsupported.
> 
> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
> mark the two new registers as optional.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++++------
>  include/acpi/cppc_acpi.h |  8 ++++++--
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2e91c5a97761..a1c91ce20cc8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>   * means optional.
>   */
> -#define REG_OPTIONAL (0x1FC7D0)
> +#define REG_OPTIONAL (0x7FC7D0)
>  
>  /*
>   * Use the index of the register in per-cpu cpc_regs[] to check if
> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	/*
>  	 * Disregard _CPC if the number of entries in the return package is not
>  	 * as expected, but support future revisions being proper supersets of
> -	 * the v3 and only causing more entries to be returned by _CPC.
> +	 * the v4 and only causing more entries to be returned by _CPC.
>  	 */
>  	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>  	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
> -	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
> +	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
> +	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>  		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
>  			 num_ent, pr->id);
>  		goto out_free;
>  	}
> -	if (cpc_rev > CPPC_V3_REV) {
> -		num_ent = CPPC_V3_NUM_ENT;
> -		cpc_rev = CPPC_V3_REV;
> +	if (cpc_rev > CPPC_V4_REV) {
> +		num_ent = CPPC_V4_NUM_ENT;
> +		cpc_rev = CPPC_V4_REV;
>  	}
>  
>  	cpc_ptr->num_entries = num_ent;
> @@ -845,6 +846,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  
>  			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>  			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
> +		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
> +			/*
> +			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority
> +			 * as a Package of Resource Priority Register Descriptor
> +			 * sub-packages.  Parsing the full structure is not yet
> +			 * supported; mark the register as unsupported for now.
> +			 */
> +			pr_debug("CPU:%d entry %d: package type not supported\n",
> +				 pr->id, i);
> +			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
>  		} else {
>  			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>  				 i, pr->id);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f9..8693890a7275 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -17,16 +17,18 @@
>  #include <acpi/pcc.h>
>  #include <acpi/processor.h>
>  
> -/* CPPCv2 and CPPCv3 support */
> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>  #define CPPC_V2_REV	2
>  #define CPPC_V3_REV	3
> +#define CPPC_V4_REV	4
>  #define CPPC_V2_NUM_ENT	21
>  #define CPPC_V3_NUM_ENT	23
> +#define CPPC_V4_NUM_ENT	25
>  
>  #define PCC_CMD_COMPLETE_MASK	(1 << 0)
>  #define PCC_ERROR_MASK		(1 << 2)
>  
> -#define MAX_CPC_REG_ENT 21
> +#define MAX_CPC_REG_ENT 23
>  
>  /* CPPC specific PCC commands. */
>  #define	CMD_READ 0
> @@ -109,6 +111,8 @@ enum cppc_regs {
>  	REFERENCE_PERF,
>  	LOWEST_FREQ,
>  	NOMINAL_FREQ,
> +	OSPM_NOMINAL_PERF,
> +	RESOURCE_PRIORITY,
>  };
>  
>  /*

