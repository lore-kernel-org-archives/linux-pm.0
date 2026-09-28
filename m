Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148C4D09FE;
	Mon, 28 Sep 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604403; cv=none; b=l7UntQ7wULJObmiLdflH3sxdOsXGEa4eby18D79XkmXPbdXB913pRkEnCq7Bir7VLdR/kSFVs85Uk0jDcou5RSDDhoNzUXeU4wksPzK1GvaZcfvR/+ALrj0FFALYGdLgrOD99MHB8xPdue473N+WIOgPj070YVmdr0oN+8S7HsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604403; c=relaxed/simple;
	bh=8G8SqLk/hmvlFAAW+G/IG3SMCE9/a5m6EYqzTMIf1Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPzcTVtHvN7mPrrdDswQA4SoYsFYlKfjILCc/hdmsmoejzDHasEkVplNiPY2gJIt/r6XIIWssDjjEIfiP4q1/KZxUKXB9971AIEfRaoVIPJ7Y7MLcNZ5NSOj8EjpcEzhdXhCD0MNtl3aEbyZzAWk7YTDlUtXvuJ3+JN3y68AxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z2PYMTQp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z2PYMTQp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1947F1655;
	Mon, 28 Sep 2026 07:06:37 -0700 (PDT)
Received: from [10.57.52.74] (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC53F3F86F;
	Mon, 28 Sep 2026 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790604400; bh=8G8SqLk/hmvlFAAW+G/IG3SMCE9/a5m6EYqzTMIf1Qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z2PYMTQpAeLKjYpF8IpYgvK+C1q7AR5ds0mMaR88Eo90V00uuUcSYtqe9DPISn1Us
	 GzZHPP4hUZYP9syCq1a6IGwq+4tD7Ot5eZC1bMDpQeE/Ix8n1F+PfMjpVMxFw9RwtY
	 ySnWqFpIilugQUdy/3jSishKAPWr4S2NBuZzC1D0=
Message-ID: <75f2372a-9eb4-4ea8-a45e-24153484a5e6@arm.com>
Date: Mon, 28 Sep 2026 15:06:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: Parse Resource Priority Register
 entries from _CPC package
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, saket.dumbre@intel.com, lenb@kernel.org,
 ionela.voinescu@arm.com, zhanjie9@hisilicon.com, pierre.gondois@arm.com,
 sumitg@nvidia.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, linuxarm@huawei.com,
 yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
 linhongye@h-partners.com
References: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
 <20260922124121.3426219-5-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260922124121.3426219-5-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 13:41, Lifeng Zheng wrote:
> CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) defines the Resource Priority
> entry as a Package of sub-packages, each containing:
> 
>   - CONTROLLED_RESOURCES: a Package of integer resource IDs
>   - ENABLE_VALUE / ENABLE_REGISTER: enable/disable control
>   - PRIORITY_COUNT / PRIORITY_REGISTER: priority level setting
> 
> These allow OSPM to set relative priority among processors for shared
> resources such as boost, throttle, L2/L3 cache, and memory bandwidth.
> 
> Implement parse_priority_regs() which:
> 
>   1. Validates each sub-package has the expected element count
>      (RESOURCE_PRIORITY_NUM).
>   2. Allocates cpc_register_resource arrays for the sub-package
>      elements and the nested CONTROLLED_RESOURCES list.
>   3. Parses CONTROLLED_RESOURCES as integers and the remaining
>      entries (ENABLE_REGISTER, PRIORITY_REGISTER, etc.) via
>      parse_cpc_element() so that register descriptors, PCC subspace
>      tracking, and ioremap are handled consistently.
>   4. Wires the parser into the main _CPC probe loop, replacing the
>      previous "package type not supported" stub with full parsing for
>      RESOURCE_PRIORITY while rejecting unexpected Package entries.
> 
> The probe and _exit() error/cleanup paths already use
> free_reg_resource(), which recursively frees Package-type entries,
> so no additional cleanup changes are needed.
> 
> Add the resource_priority_regs enumeration that defines the indices
> into each Resource Priority sub-package (CONTROLLED_RESOURCES,
> ENABLE_VALUE, ENABLE_REGISTER, PRIORITY_COUNT, PRIORITY_REGISTER)
> and RESOURCE_PRIORITY_NUM as the element count sentinel.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 137 ++++++++++++++++++++++++++++++++++++---
>  include/acpi/cppc_acpi.h |  13 ++++
>  2 files changed, 142 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index dce15d875c62..b5563d75d6c5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -777,6 +777,91 @@ static void free_reg_resource(struct cpc_register_resource *cpc_reg)
>  	}
>  }
>  
> +/**
> + * parse_priority_regs - Parse the RESOURCE_PRIORITY nested package structure.
> + * @cpc_obj:         ACPI Package object for the RESOURCE_PRIORITY entry.
> + * @regs:            Output array of cpc_register_resource to fill.
> + * @pcc_subspace_id: In/out pointer to PCC subspace ID.
> + * @cpu:             CPU number, used for debug messages.
> + *
> + * The RESOURCE_PRIORITY entry (CPPC v4) is a Package of sub-packages.
> + * Each sub-package has RESOURCE_PRIORITY_NUM elements:
> + *   [0] = Package of integers (CONTROLLED_RESOURCES list)
> + *   [1] = ENABLE_VALUE, [2] = ENABLE_REGISTER,
> + *   [3] = PRIORITY_COUNT, [4] = PRIORITY_REGISTER
> + *
> + * Return: 0 on success, -ENODATA on malformed data, -ENOMEM on allocation failure.
> + */
> +static int parse_priority_regs(union acpi_object *cpc_obj,
> +			       struct cpc_register_resource *regs,
> +			       int *pcc_subspace_id, u32 cpu)
> +{
> +	struct cpc_register_resource *reg_elements;
> +	union acpi_object reg_desc_obj;
> +	unsigned int i, j, resources_count;
> +	int ret;
> +
> +	for (i = 0; i < cpc_obj->package.count; i++) {
> +		reg_desc_obj = cpc_obj->package.elements[i];
> +		if (reg_desc_obj.type != ACPI_TYPE_PACKAGE ||
> +		    reg_desc_obj.package.count != RESOURCE_PRIORITY_NUM) {
> +			pr_debug("Malformed priority regs sub-pkg: type %d count %d, expected %d for CPU:%d\n",
> +				 reg_desc_obj.type, reg_desc_obj.package.count,
> +				 RESOURCE_PRIORITY_NUM, cpu);
> +			return -ENODATA;
> +		}
> +
> +		reg_elements = kzalloc_objs(struct cpc_register_resource, RESOURCE_PRIORITY_NUM);
> +		if (!reg_elements) {
> +			pr_debug("Failed to allocate reg_elements for CPU:%d\n", cpu);
> +			return -ENOMEM;
> +		}
> +
> +		/*
> +		 * Assign values immediately after successful allocation to ensure that resources
> +		 * can be properly released.
> +		 */
> +		regs[i].type = ACPI_TYPE_PACKAGE;
> +		regs[i].cpc_entry.package.count = RESOURCE_PRIORITY_NUM;
> +		regs[i].cpc_entry.package.elements = reg_elements;
> +
> +		resources_count = reg_desc_obj.package.elements[0].package.count;
> +
> +		if (reg_desc_obj.package.elements[0].type != ACPI_TYPE_PACKAGE ||
> +		    !resources_count) {
> +			pr_debug("Invalid priority sub-elements: type %d count %d for CPU:%d\n",
> +				 reg_desc_obj.package.elements[0].type, resources_count, cpu);
> +			return -ENODATA;
> +		}
> +
> +		reg_elements[0].cpc_entry.package.elements =
> +			kzalloc_objs(struct cpc_register_resource, resources_count);
> +		if (!reg_elements[0].cpc_entry.package.elements) {
> +			pr_debug("Failed to allocate %d priority sub-elements for CPU:%d\n",
> +				 resources_count, cpu);
> +			return -ENOMEM;
> +		}
> +
> +		reg_elements[0].type = ACPI_TYPE_PACKAGE;
> +		reg_elements[0].cpc_entry.package.count = resources_count;
> +
> +		for (j = 0; j < reg_elements[0].cpc_entry.package.count; j++) {
> +			reg_elements[0].cpc_entry.package.elements[j].type = ACPI_TYPE_INTEGER;

ACPI_TYPE_INTEGER could be checked instead of just assumed (and the value copied) to be sure.

> +			reg_elements[0].cpc_entry.package.elements[j].cpc_entry.int_value =
> +				reg_desc_obj.package.elements[0].package.elements[j].integer.value;
> +		}
> +
> +		for (j = 1; j < RESOURCE_PRIORITY_NUM; j++) {
> +			ret = parse_cpc_element(&reg_desc_obj.package.elements[j], &reg_elements[j],
> +						pcc_subspace_id, cpu, RESOURCE_PRIORITY);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * An example CPC table looks like the following.
>   *
> @@ -815,6 +900,7 @@ static void free_reg_resource(struct cpc_register_resource *cpc_reg)
>  int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  {
>  	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct cpc_register_resource *pkg_elements;
>  	union acpi_object *out_obj, *cpc_obj;
>  	struct cpc_desc *cpc_ptr;
>  	struct device *cpu_dev;
> @@ -823,6 +909,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	int pcc_subspace_id = -1;
>  	acpi_status status;
>  	int ret = -ENODATA;
> +	u32 pkg_count;
>  
>  	if (!osc_sb_cppc2_support_acked) {
>  		pr_debug("CPPC v2 _OSC not acked\n");
> @@ -904,16 +991,50 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	for (i = 2; i < num_ent; i++) {
>  		cpc_obj = &out_obj->package.elements[i];
>  
> -		if (cpc_obj->type == ACPI_TYPE_PACKAGE && (i - 2) == RESOURCE_PRIORITY) {
> +		/*
> +		 * Package-type entries are used for nested structures such as
> +		 * RESOURCE_PRIORITY (CPPC v4). Only RESOURCE_PRIORITY is
> +		 * currently supported; any other Package entry is rejected.
> +		 */
> +		if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
> +			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = 0;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = NULL;
> +
> +			pkg_count = cpc_obj->package.count;
> +			if (!pkg_count) {
> +				pr_debug("Empty package entry at index %d for CPU:%d\n",
> +					 i, pr->id);
> +				continue;
> +			}
> +
> +			pkg_elements = kzalloc_objs(struct cpc_register_resource, pkg_count);
> +			if (!pkg_elements) {
> +				ret = -ENOMEM;
> +				goto out_free;
> +			}
> +
>  			/*
> -			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
> -			 * Package of Resource Priority Register Descriptor sub-packages.
> -			 * Parsing the full structure is not yet supported.
> -			 * Mark the register as unsupported for now.
> +			 * Assign values immediately after successful allocation to ensure that
> +			 * resources can be properly released.
>  			 */
> -			pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
> -			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
> -			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = pkg_count;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = pkg_elements;
> +
> +			if (i - 2 == RESOURCE_PRIORITY) {
> +				ret = parse_priority_regs(cpc_obj, pkg_elements,
> +							  &pcc_subspace_id, pr->id);
> +				if (ret)
> +					goto out_free;
> +
> +				pr_debug("Parsed RESOURCE_PRIORITY (%d sub-pkgs) for CPU:%d\n",
> +					 pkg_count, pr->id);
> +			} else {
> +				pr_debug("Unexpected ACPI_TYPE_PACKAGE at index %d for CPU:%d\n",
> +					 i, pr->id);
> +				ret = -ENODATA;
> +				goto out_free;
> +			}
>  		} else {
>  			ret = parse_cpc_element(cpc_obj, &cpc_ptr->cpc_regs[i-2],
>  						&pcc_subspace_id, pr->id, i);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 1839582b80be..19f8a722654b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -123,6 +123,19 @@ enum cppc_regs {
>  	RESOURCE_PRIORITY,
>  };
>  
> +/*
> + * Indices into each sub-package of the RESOURCE_PRIORITY entry.
> + * RESOURCE_PRIORITY_NUM serves as the element count / loop bound.
> + */
> +enum resource_priority_regs {
> +	CONTROLLED_RESOURCES,	/* Package of integer resource IDs */
> +	ENABLE_VALUE,		/* Enable/disable value */
> +	ENABLE_REGISTER,	/* Register for enable/disable control */
> +	PRIORITY_COUNT,		/* Number of priority levels */
> +	PRIORITY_REGISTER,	/* Register for priority setting */
> +	RESOURCE_PRIORITY_NUM,	/* Number of elements (sentinel) */
> +};
> +
>  /*
>   * Categorization of registers as described
>   * in the ACPI v.5.1 spec.

