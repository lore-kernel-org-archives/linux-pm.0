Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343CB4A4842;
	Thu, 17 Sep 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640810; cv=none; b=cnvJq6WpYOaaIHa9TbIdbpK+fKmkxqpMIf8rctWlsoc6Mf1UbS0Hel6JQjecbDq/RpTUSioJCZEr/71JfODid+gP32AcHfwf4uqkI7IITujTWSUQn+ZB5tfGMfLBNF4e/KBEc/ZOmXs22U/x3KW2dOBaAKfDCEue4hEH+RZ1QJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640810; c=relaxed/simple;
	bh=uqYX6zvZNL5fA6XNusYbIz02xhoytzKBM/nOCfSErak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc3KVTGoxQezqnVwRwfCw563PPQPSiWt6/k1b+TCgQG9H5Sq9319xUzO1+UbvxkMQNzQX2fi/IKcX2gd1cGb11yqp3UJvPPyVZyAjh5ApSWl3jP+p3L3FLZu7Ft1hOYaaeUI9sj4RY0165ek7xG5M0IKEZ+d2gbAq+5xOY+N0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PVmp1wTl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PVmp1wTl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBAD1A9A;
	Thu, 17 Sep 2026 03:26:42 -0700 (PDT)
Received: from [10.57.50.144] (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E773F882;
	Thu, 17 Sep 2026 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789640806; bh=uqYX6zvZNL5fA6XNusYbIz02xhoytzKBM/nOCfSErak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PVmp1wTlmIrm2MUposaA1SHThULWIW5DGWcIv3a1262IAyFWEiLfEN8gGYQ9KYiRh
	 6vJdqKyYij0CNtNfePoDfFSoH74eR2qYu7QtBDLEDJz8q3PRkSewp5bdIj6AEHfMRt
	 0nE7UKSP/kgVaQ6bltGUfs7USOmc+KHWyc3roD6k=
Message-ID: <feacb7a1-1d40-4798-9b41-ae8cba62ccd3@arm.com>
Date: Thu, 17 Sep 2026 11:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/20] ACPI: CPPC: Validate _CPC entry and control
 semantics
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com,
 Sashiko <sashiko-bot@kernel.org>
References: <20260916162805.1039247-1-christian.loehle@arm.com>
 <20260916162805.1039247-3-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260916162805.1039247-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 17:27, Christian Loehle wrote:
> Writable _CPC controls are Register descriptors encoded as Buffer objects.
> Integer entries represent fixed values or legacy placeholders for
> unsupported optional registers; Autonomous Selection Integer 1 is the
> special immutable form which enables operation without Desired Performance.
> 
> The parser accepts arbitrary object types and cpc_write() assumes that its
> argument contains a GAS. Malformed firmware can therefore make it interpret
> an Integer union member as a register.
> 
> Validate the portion of each encoding consumed by the driver: bound Integer
> capabilities stored in u32 fields to U32_MAX, and require Buffer entries to
> start with a complete Generic Register descriptor with the expected header.
> Do not restrict an Integer Counter Wraparound Time. Both AML Integers and
> the kernel interface are 64-bit, despite the DWORD annotation in the ACPI
> table. Continue tolerating Integer 0 placeholders for absent optional
> Buffer registers to avoid breaking legacy platforms. Report their invalid
> encoding as a firmware bug. Retain type checks in cpc_write() as defense in
> depth. Reject an attempt to disable immutable Autonomous Selection instead
> of silently applying only the EPP part of the request.
> 
> Capability registers are read into u64 temporaries but exposed through u32
> fields. Reject values above U32_MAX instead of allowing them to be
> truncated. In particular, a truncated Highest Performance value can become
> a zero divisor in the performance-to-frequency conversion. Enforce the
> required ordering from Highest through Nominal, Lowest Nonlinear, and
> Lowest Performance, and constrain a present Guaranteed Performance to the
> inclusive Lowest-to-Nominal range. Also reject reversed frequency anchors
> and unequal frequency anchors with identical performance anchors. Those
> invalid tuples otherwise make affine-conversion differences wrap or divide
> by zero.
> 
> Check mandatory object presence separately from the Integer-zero convention
> for absent optional fields.
> 
> Reject Minimum and Maximum Performance readbacks above U32_MAX before
> narrowing them. A truncated minimum could otherwise become an explicit
> zero update when cppc-cpufreq writes the initial controls back to the
> platform.
> 
> Minimum Performance also defines zero as a real no-limit value, but the
> exported cppc_set_perf() interface historically used zero to omit a bound.
> Add a minimum-valid flag so callers can request zero without changing that
> legacy convention. Set it when reading a supported Minimum Performance
> register, preserving zero across cppc-cpufreq initialization and exit.
> Keep zero-as-omit for Maximum Performance, whose no-limit encoding is all
> ones, not zero. Initialize amd-pstate's control structure with the new flag
> clear: its shared-memory backend does not record bios_min_perf, so its
> zero-valued restore requests must remain omitted.
> 
> Performance Limited is listed as a required Buffer, but the interface does
> not depend on it to control performance and the specification permits a
> platform with no limiting indication to always report zero. Preserve
> compatibility with firmware that represents that case using a NULL register
> descriptor instead of disabling CPPC entirely.
> 
> Emit an error when a present _CPC package fails parsing or initialization
> so such firmware and resource failures no longer silently suppress cpufreq.
> Initialize malformed-package failures to -EINVAL and preserve specific
> allocation, mapping, and unsupported-access errors in that diagnostic.
> 
> Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c     | 183 +++++++++++++++++++++++++++++++----
>  drivers/cpufreq/amd-pstate.c |  10 +-
>  include/acpi/cppc_acpi.h     |   2 +
>  3 files changed, 169 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3b8cdf88e31d..965ac29ab8b1 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>  				!!(cpc)->cpc_entry.int_value :		\
>  				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
>  
> +static bool cpc_is_writable(const struct cpc_register_resource *cpc)
> +{
> +	return cpc->type == ACPI_TYPE_BUFFER &&
> +	       !IS_NULL_REG(&cpc->cpc_entry.reg);
> +}
> +
> +static bool cpc_entry_present(const struct cpc_register_resource *cpc)
> +{
> +	if (cpc->type == ACPI_TYPE_INTEGER)
> +		return true;
> +
> +	return cpc->type == ACPI_TYPE_BUFFER &&
> +	       !IS_NULL_REG(&cpc->cpc_entry.reg);
> +}
> +
>  /*
>   * Each bit indicates the optionality of the register in per-cpu
>   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
> @@ -142,6 +157,36 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   */
>  #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
>  
> +static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value,
> +				    bool *legacy_null)
> +{
> +	*legacy_null = false;
> +
> +	switch (reg_idx) {
> +	case HIGHEST_PERF:
> +	case NOMINAL_PERF:
> +	case LOW_NON_LINEAR_PERF:
> +	case LOWEST_PERF:
> +	case REFERENCE_PERF:
> +	case LOWEST_FREQ:
> +	case NOMINAL_FREQ:
> +		return value <= U32_MAX;

Sashiko:
"Does this code accidentally omit GUARANTEED_PERF from the whitelist?
According to the ACPI specification (Section 8.4.6.1.1), the firmware can
provide Guaranteed Performance as a non-zero Integer. Because it is missing
from this switch statement, valid non-zero integer values for this register
will be rejected here, causing CPPC initialization to fail on compliant
platforms."
So first of all 8.4.6.1.1 doesn't describe the type at all.

We have
8.4.6.1 _CPC (Continuous Performance Control)
describing
GuaranteedPerformanceRegister, // Buffer (Resource Descriptor)
(i.e. no Integer)
and
Table 8.23: Continuous Performance Control Package Values
Guaranteed Performance Register Buffer
(i.e. Integer)

The 'finding' is deliberate behavior and correct.


> +	case CTR_WRAP_TIME:
> +		/* AML Integers and the kernel interface are both 64-bit. */
> +		return true;
> +	case AUTO_SEL_ENABLE:
> +		return value <= 1;
> +	case DESIRED_PERF:
> +		/* Validated against Autonomous Selection after parsing. */
> +		*legacy_null = value == 0;
> +		return *legacy_null;
> +	default:
> +		/* Tolerate legacy Integer 0 placeholders for absent options. */
> +		*legacy_null = value == 0 && IS_OPTIONAL_CPC_REG(reg_idx);
> +		return *legacy_null;
> +	}
> +}
> +
>  /*
>   * Arbitrary Retries in case the remote processor is slow to respond
>   * to PCC commands. Keeping it high enough to cover emulators where
> @@ -150,6 +195,8 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>  #define NUM_RETRIES 500ULL
>  
>  #define OVER_16BTS_MASK ~0xFFFFULL
> +#define CPC_GENERIC_REGISTER_DESCRIPTOR 0x82
> +#define CPC_GENERIC_REGISTER_LENGTH (sizeof(struct cpc_reg) - 3)
>  
>  #define define_one_cppc_ro(_name)		\
>  static struct kobj_attribute _name =		\
> @@ -773,8 +820,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	acpi_handle handle = pr->handle;
>  	unsigned int num_ent, i, cpc_rev;
>  	int pcc_subspace_id = -1;
> +	bool cpc_present = false;
>  	acpi_status status;
>  	int ret = -ENODATA;
> +	int err;
>  
>  	if (!osc_sb_cppc2_support_acked) {
>  		pr_debug("CPPC v2 _OSC not acked\n");
> @@ -791,6 +840,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  		ret = -ENODEV;
>  		goto out_buf_free;
>  	}
> +	cpc_present = true;
> +	ret = -EINVAL;
>  
>  	out_obj = (union acpi_object *) output.pointer;
>  	if (out_obj->package.count < 2) {
> @@ -871,11 +922,38 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  		cpc_obj = &out_obj->package.elements[i];
>  
>  		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
> -			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
> -			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = cpc_obj->integer.value;
> +			bool legacy_null;
> +
> +			if (!cpc_integer_entry_valid(i - 2,
> +						     cpc_obj->integer.value,
> +						     &legacy_null)) {
> +				pr_debug("Invalid Integer _CPC register %u for CPU:%d\n",
> +					 i - 2, pr->id);
> +				ret = -EINVAL;
> +				goto out_free;
> +			}
> +			if (legacy_null)
> +				pr_warn_once(FW_BUG "_CPC register %u uses Integer 0 for an absent Buffer\n",
> +					     i - 2);

Sashiko:
"Is this FW_BUG warning spurious?
The ACPI specification explicitly states that if a platform does not support
an optional register, the field must be an Integer with a value of 0 or a
Buffer containing a null register descriptor. Printing a FW_BUG warning here
incorrectly flags spec-compliant Integer 0 absent fields as firmware bugs."

This is wrong, the ACPI spec doesn't state that. No FW_BUG is printed if the platform
uses the null register descriptor (like the ACPI spec specifies in 8.4.6.1).
We tolerate Integer 0 for compatibility reasons and log it as an appropriate FW_BUG.
Also see v6 review:
https://lore.kernel.org/lkml/CAJZ5v0jp9q-ZzOKXsOVpvF0ABytHXU9qeSdGyHdhLUL-cLX4sA@mail.gmail.com/

> +			cpc_ptr->cpc_regs[i - 2].type = ACPI_TYPE_INTEGER;
> +			cpc_ptr->cpc_regs[i - 2].cpc_entry.int_value = cpc_obj->integer.value;
>  		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
> +			if (cpc_obj->buffer.length < sizeof(*gas_t)) {
> +				pr_debug("Invalid register descriptor for CPU:%d\n",
> +					 pr->id);
> +				ret = -EINVAL;
> +				goto out_free;
> +			}
> +
>  			gas_t = (struct cpc_reg *)
>  				cpc_obj->buffer.pointer;
> +			if (gas_t->descriptor != CPC_GENERIC_REGISTER_DESCRIPTOR ||
> +			    gas_t->length != CPC_GENERIC_REGISTER_LENGTH) {
> +				pr_debug("Invalid register resource for CPU:%d\n",
> +					 pr->id);
> +				ret = -EINVAL;
> +				goto out_free;
> +			}
>  
>  			/*
>  			 * The PCC Subspace index is encoded inside
> @@ -886,8 +964,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
>  				if (pcc_subspace_id < 0) {
>  					pcc_subspace_id = gas_t->access_width;
> -					if (pcc_data_alloc(pcc_subspace_id))
> +					err = pcc_data_alloc(pcc_subspace_id);
> +					if (err) {
> +						ret = err;
>  						goto out_free;
> +					}
>  				} else if (pcc_subspace_id != gas_t->access_width) {
>  					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
>  						 pr->id);
> @@ -900,14 +981,18 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  
>  					if (!osc_cpc_flexible_adr_space_confirmed) {
>  						pr_debug("Flexible address space capability not supported\n");
> +						ret = -EOPNOTSUPP;
>  						if (!cpc_supported_by_cpu())
>  							goto out_free;
> +						ret = -EINVAL;
>  					}
>  
>  					access_width = GET_BIT_WIDTH(gas_t) / 8;
>  					addr = ioremap(gas_t->address, access_width);
> -					if (!addr)
> +					if (!addr) {
> +						ret = -ENOMEM;
>  						goto out_free;
> +					}
>  					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
>  				}
>  			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> @@ -929,14 +1014,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  				}
>  				if (!osc_cpc_flexible_adr_space_confirmed) {
>  					pr_debug("Flexible address space capability not supported\n");
> +					ret = -EOPNOTSUPP;
>  					if (!cpc_supported_by_cpu())
>  						goto out_free;
> +					ret = -EINVAL;
>  				}
>  			} else {
>  				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
>  					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
>  					pr_debug("Unsupported register type (%d) in _CPC\n",
>  						 gas_t->space_id);
> +					ret = -EOPNOTSUPP;
>  					goto out_free;
>  				}
>  			}
> @@ -961,15 +1049,35 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	}
>  	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
>  
> +	/*
> +	 * Performance Limited is required by the specification, but tolerate a
> +	 * NULL descriptor used by firmware which cannot report limiting events.
> +	 * CPPC control does not depend on this status.
> +	 */
> +	for (i = 0; i < num_ent - 2; i++) {
> +		if (i != DESIRED_PERF && i != PERF_LIMITED &&
> +		    !IS_OPTIONAL_CPC_REG(i) &&
> +		    !cpc_entry_present(&cpc_ptr->cpc_regs[i])) {
> +			pr_debug("CPU:%d lacks mandatory _CPC register %u\n",
> +				 pr->id, i);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +	}
> +
>  	/*
>  	 * In CPPC v1, DESIRED_PERF is mandatory. In CPPC v2, it is optional
>  	 * only when AUTO_SEL_ENABLE is supported.
>  	 */
> -	if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
> +	if (!cpc_is_writable(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
>  	    (!osc_sb_cppc2_support_acked ||
> -	     !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
> -		pr_warn("Desired perf. register is mandatory if CPPC v2 is not supported "
> -			"or autonomous selection is disabled\n");
> +	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].type != ACPI_TYPE_INTEGER ||
> +	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].cpc_entry.int_value != 1)) {
> +		pr_debug("CPU:%d lacks a writable Desired Performance register\n",
> +			 pr->id);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
>  
>  	/*
>  	 * Initialize the remaining cpc_regs as unsupported.
> @@ -1037,6 +1145,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	kfree(cpc_ptr);
>  
>  out_buf_free:
> +	if (cpc_present)
> +		pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, ret);
>  	kfree(output.pointer);
>  	return ret;
>  }
> @@ -1217,11 +1327,18 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  	u64 prev_val;
>  	void __iomem *vaddr = NULL;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> -	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
> +	struct cpc_reg *reg;
>  	struct cpc_desc *cpc_desc;
>  	unsigned long flags;
>  	bool locked = false;
>  
> +	if (reg_res->type != ACPI_TYPE_BUFFER)
> +		return -EOPNOTSUPP;
> +
> +	reg = &reg_res->cpc_entry.reg;
> +	if (IS_NULL_REG(reg))
> +		return -EOPNOTSUPP;
> +
>  	size = GET_BIT_WIDTH(reg);
>  
>  	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
> @@ -1364,7 +1481,9 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
>  
>  	reg = &cpc_desc->cpc_regs[reg_idx];
>  
> -	if ((reg->type == ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(reg_idx) &&
> +	/* Desired may be absent for immutable autonomous selection. */
> +	if ((reg->type == ACPI_TYPE_INTEGER &&
> +	     (IS_OPTIONAL_CPC_REG(reg_idx) || reg_idx == DESIRED_PERF) &&
>  	     !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
>  	     IS_NULL_REG(&reg->cpc_entry.reg))) {
>  		pr_debug("CPC register is not supported\n");
> @@ -1415,7 +1534,7 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>  	reg = &cpc_desc->cpc_regs[reg_idx];
>  
>  	/* if a register is writeable, it must be a buffer and not null */
> -	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
> +	if (!cpc_is_writable(reg)) {
>  		pr_debug("CPC register is not supported\n");
>  		return -EOPNOTSUPP;
>  	}
> @@ -1505,7 +1624,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	struct cpc_register_resource *highest_reg, *lowest_reg,
>  		*lowest_non_linear_reg, *nominal_reg, *reference_reg,
>  		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL;
> -	u64 high, low, guaranteed, nom, ref, min_nonlinear,
> +	u64 high, low, guaranteed = 0, nom, ref, min_nonlinear,
>  	    low_f = 0, nom_f = 0;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
> @@ -1588,7 +1707,12 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  		goto out_err;
>  	perf_caps->lowest_nonlinear_perf = min_nonlinear;
>  
> -	if (!high || !low || !nom || !ref || !min_nonlinear) {
> +	if (!high || !low || !nom || !ref || !min_nonlinear ||
> +	    high > U32_MAX || low > U32_MAX || guaranteed > U32_MAX ||
> +	    nom > U32_MAX || ref > U32_MAX || min_nonlinear > U32_MAX ||
> +	    high < nom || nom < min_nonlinear || min_nonlinear < low ||
> +	    (CPC_SUPPORTED(guaranteed_reg) &&
> +	     (guaranteed < low || guaranteed > nom))) {
>  		ret = -EFAULT;
>  		goto out_err;
>  	}

Sashiko:
"Can this check fail on platforms where Guaranteed Performance is provided as
an integer?
If probe succeeds, legacy code in cppc_get_perf_caps() forces the local
guaranteed value to 0 when the type is ACPI_TYPE_INTEGER. However,
CPC_SUPPORTED(guaranteed_reg) still evaluates to true, so the new bounds
check (guaranteed < low) will evaluate as (0 < low), returning -EFAULT."

(also see above)
We only accept 0 (as an absent buffer) and then CPC_SUPPORTED(guaranteed_reg)
evaluates to false.


> [snip]
