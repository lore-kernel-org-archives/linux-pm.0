Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40EC3DA7EA;
	Mon, 27 Apr 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304227; cv=none; b=hEaWSxBKAKI2r1XdrP21aREGR664DUdKd3xUvPN1PVxSBfoKb9D1PdWSEppWrxjhXq6QvMYjg0MMHbvvnW6j6rw+hCMFTaw9eMwZAMUwVHCUFUQ5t/NwrilnwOnVRPbBYfkGBanLa7ez/gdHSmZNKpN4qZVAKAq5wwMDQR2kElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304227; c=relaxed/simple;
	bh=RD3ZtVzROWEejg1rtd0aMaM4DwWAMRt4/5GO3gJJYrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGvJOEwGEYU0nSjvp6fmEX/38LzVmpYQqzvBs4nh9rRqliTkdJx3/HT/upEWn1Hj26xtOuMT/ramd3N/pZGdtQSHlWKnD5Ey4//W6hX8bC6Ql9xuFRkc7YHjjn1kIUlQztp7XqZxvW23uj+fpenOlbNuMijM50JiH/eEwTIj23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIZ4nwqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIZ4nwqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD2C2BCB4;
	Mon, 27 Apr 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304226;
	bh=RD3ZtVzROWEejg1rtd0aMaM4DwWAMRt4/5GO3gJJYrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIZ4nwqQAOJG0rNrvAB++fpY9O2UrC7aNWMwXnbqL583dPWyLIHIIVaDtrcfkFQ40
	 wjtlrRSVuvmgUvmdNTUlUwGjYeNFNjhcu2X1ovWGuQbTfjwHW9/GDBP6uIWhUFXSU+
	 BwOUW4fnChrsekPrsxn9kxapA2tLuMUeteoP60gzi8+ZrniQZHUbdEtYgWLf6oTqak
	 P8LsZhB7/lzS9p8RUeCc7FHlEdQLNdfd5q1p1UR130UNXo+m9OG8WrVokZ8/bNWBA1
	 cIIplZL217t2oDugz+k5kRy0es0//YGOQcq8hLxJNxok0+HcPY9iNOLuSFDzkekH18
	 ZBjrFvRwZOYOA==
Message-ID: <703848b6-d56b-4c2e-b92c-0ba982477b33@kernel.org>
Date: Mon, 27 Apr 2026 10:37:04 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: Add support for CPPC v4
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-2-sumitg@nvidia.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260427051823.280419-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/27/26 00:18, Sumit Gupta wrote:
> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
> _CPC package:
> 
> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>     lets OSPM inform the platform what it considers nominal performance.
>     The platform classifies performance above this level as boost and
>     below as throttle for its power/thermal decisions.
> 
> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>     Register Descriptor sub-packages that allow OSPM to set relative
>     priority among processors for shared resources (boost, throttle,
>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>     yet supported; such entries are marked as unsupported.
> 
> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
> mark the two new registers as optional.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++++------
>   include/acpi/cppc_acpi.h |  8 ++++++--
>   2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2e91c5a97761..a1c91ce20cc8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>    * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>    * means optional.
>    */
> -#define REG_OPTIONAL (0x1FC7D0)
> +#define REG_OPTIONAL (0x7FC7D0)
>   
>   /*
>    * Use the index of the register in per-cpu cpc_regs[] to check if
> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   	/*
>   	 * Disregard _CPC if the number of entries in the return package is not
>   	 * as expected, but support future revisions being proper supersets of
> -	 * the v3 and only causing more entries to be returned by _CPC.
> +	 * the v4 and only causing more entries to be returned by _CPC.
>   	 */
>   	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>   	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
> -	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
> +	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
> +	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>   		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
>   			 num_ent, pr->id);
>   		goto out_free;
>   	}
> -	if (cpc_rev > CPPC_V3_REV) {
> -		num_ent = CPPC_V3_NUM_ENT;
> -		cpc_rev = CPPC_V3_REV;
> +	if (cpc_rev > CPPC_V4_REV) {
> +		num_ent = CPPC_V4_NUM_ENT;
> +		cpc_rev = CPPC_V4_REV;
>   	}
>   
>   	cpc_ptr->num_entries = num_ent;
> @@ -845,6 +846,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>   			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
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
>   		} else {
>   			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>   				 i, pr->id);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f9..8693890a7275 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -17,16 +17,18 @@
>   #include <acpi/pcc.h>
>   #include <acpi/processor.h>
>   
> -/* CPPCv2 and CPPCv3 support */
> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>   #define CPPC_V2_REV	2
>   #define CPPC_V3_REV	3
> +#define CPPC_V4_REV	4
>   #define CPPC_V2_NUM_ENT	21
>   #define CPPC_V3_NUM_ENT	23
> +#define CPPC_V4_NUM_ENT	25
>   
>   #define PCC_CMD_COMPLETE_MASK	(1 << 0)
>   #define PCC_ERROR_MASK		(1 << 2)
>   
> -#define MAX_CPC_REG_ENT 21
> +#define MAX_CPC_REG_ENT 23
>   
>   /* CPPC specific PCC commands. */
>   #define	CMD_READ 0
> @@ -109,6 +111,8 @@ enum cppc_regs {
>   	REFERENCE_PERF,
>   	LOWEST_FREQ,
>   	NOMINAL_FREQ,
> +	OSPM_NOMINAL_PERF,
> +	RESOURCE_PRIORITY,
>   };
>   
>   /*

