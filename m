Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F694C9010;
	Mon, 28 Sep 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603962; cv=none; b=ERFpsQiIjnL4zwHGR8uQQq4vq4jtPvFE+uWxO+1882F7QIXv7OS2uLfo7ISIUqoQTw961/3/VgUVHb9x9Fuv39U4DF5tQMFy3EPdpqvpuwN/VHEpLO3xm4QlKU86Dh1mJ/sesKVpLJRrW35BcEnPNNFHTpvkGuNELvqfg9Cv1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603962; c=relaxed/simple;
	bh=RDb4pCXVty5O7LRf93+EO33u0Q0ffotTZxH/SbXxIHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtRpBGXEE9cQxxtckSW2oFddMug5QuXv7Iuo/hc5gAk90d918LTLuajpw7futntjhiocu/vGSnLhay2RbmCMW4fK2cUhDb1biSNMS3WuBejplHsV6yEx6v0tVcW2n/q/rpfxIN4zfMwDWx6BMlVi1hl/4jKnADtKXu1PH3LNEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fS30/dJ1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fS30/dJ1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A9661655;
	Mon, 28 Sep 2026 06:59:16 -0700 (PDT)
Received: from [10.57.52.74] (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDFF53F763;
	Mon, 28 Sep 2026 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790603960; bh=RDb4pCXVty5O7LRf93+EO33u0Q0ffotTZxH/SbXxIHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fS30/dJ1W49v/gieWe/4mLl6Rgn8p/qMO5xvrWSdaAEjI8O5K5oLb4ksibLlIMGQ2
	 FwLGMV9YDqTQBPwcx0hxD+H9BwsKVgT5/hrF0sh+9ubICmybYxiiF/cXlrL9+l1fj/
	 xSKVxRCt8eNwE9eTeC4cQUTpiiN2bmx+vqef9HEs=
Message-ID: <e0fbba53-00a9-4bdf-a415-15b9f34e0c90@arm.com>
Date: Mon, 28 Sep 2026 14:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] ACPI: CPPC: Add Resource Priority accessors
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, saket.dumbre@intel.com, lenb@kernel.org,
 ionela.voinescu@arm.com, zhanjie9@hisilicon.com, pierre.gondois@arm.com,
 sumitg@nvidia.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, linuxarm@huawei.com,
 yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
 linhongye@h-partners.com
References: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
 <20260922124121.3426219-8-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260922124121.3426219-8-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 13:41, Lifeng Zheng wrote:
> CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) defines the Resource Priority
> mechanism that lets OSPM control relative priority among processors for
> shared resources such as processor boost, throttle, L2/L3 cache, and
> memory bandwidth.
> 
> Add the following exported APIs for user-space and driver consumers:
> 
>   - cppc_get_resource_priority_count() -- number of sub-packages
>   - cppc_get_resource_priority_resources() -- resource type IDs
>   - cppc_get/set_res_priority_enable() -- enable/disable a group
>   - cppc_get_res_priority_count() -- priority levels in a group
>   - cppc_get/set_res_priority() -- read/write the priority value

Priority Register is defined as Write, not R/W.

> 
> These wrappers navigate the nested Package structure parsed earlier by
> parse_priority_regs() and delegate register I/O to cpc_read_reg() /
> cpc_write_reg().
> 
> Provide stubs returning -EOPNOTSUPP for the !CONFIG_ACPI_CPPC_LIB case.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 264 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  37 ++++++
>  2 files changed, 301 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2c2b25ec3e27..f90d727798e8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -2284,6 +2284,270 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
>  
> +/**
> + * get_res_prio_subpkg - Get pointer to the elements array of a RESOURCE_PRIORITY sub-package.
> + * @cpu: CPU number.
> + * @index: Sub-package index (0 to count-1).
> + *
> + * Return: Pointer to the sub-package's elements array, or NULL on error.
> + *
> + * The layout within each sub-package element is:
> + *   elements[CONTROLLED_RESOURCES] = [0]
> + *   elements[ENABLE_VALUE]         = [1]
> + *   elements[ENABLE_REGISTER]      = [2]
> + *   elements[PRIORITY_COUNT]       = [3]
> + *   elements[PRIORITY_REGISTER]    = [4]
> + */
> +static struct cpc_register_resource *get_res_prio_subpkg(int cpu, int index)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *rp_pkg;
> +
> +	if (!cpc_desc)
> +		return NULL;
> +
> +	rp_pkg = &cpc_desc->cpc_regs[RESOURCE_PRIORITY];
> +	if (rp_pkg->type != ACPI_TYPE_PACKAGE)
> +		return NULL;
> +
> +	if (index < 0 || index >= rp_pkg->cpc_entry.package.count)
> +		return NULL;
> +
> +	return rp_pkg->cpc_entry.package.elements[index].cpc_entry.package.elements;
> +}
> +
> +/**
> + * cppc_get_resource_priority_count - Get number of Resource Priority sub-packages.
> + * @cpu: CPU number.
> + * @count: Output number of resource priority groups.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if RESOURCE_PRIORITY not provided by firmware.
> + */
> +int cppc_get_resource_priority_count(int cpu, int *count)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *rp_pkg;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	if (!cpc_desc)
> +		return -ENODEV;
> +
> +	rp_pkg = &cpc_desc->cpc_regs[RESOURCE_PRIORITY];
> +	if (rp_pkg->type != ACPI_TYPE_PACKAGE)
> +		return -EOPNOTSUPP;
> +
> +	*count = rp_pkg->cpc_entry.package.count;
> +	if (*count <= 0)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_resource_priority_count);
> +
> +/**
> + * cppc_get_resource_priority_resources - Read Controlled Resources list for a sub-package.
> + * @cpu: CPU number.
> + * @index: Sub-package index (0 to count-1).
> + * @resources: Output array of resource type IDs (caller-allocated).
> + * @num_resources: Input = array capacity, output = actual count.
> + *
> + * Return: 0 on success, -EOPNOTSUPP, -EINVAL, etc.
> + */
> +int cppc_get_resource_priority_resources(int cpu, int index,
> +					 u32 *resources, int *num_resources)
> +{
> +	struct cpc_register_resource *elems;
> +	struct cpc_register_resource *cr_pkg;
> +	int i, cr_count;
> +
> +	if (!resources || !num_resources || *num_resources <= 0)
> +		return -EINVAL;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	cr_pkg = &elems[CONTROLLED_RESOURCES];
> +	if (cr_pkg->type != ACPI_TYPE_PACKAGE)
> +		return -EOPNOTSUPP;
> +
> +	cr_count = cr_pkg->cpc_entry.package.count;
> +	if (cr_count <= 0) {
> +		*num_resources = 0;
> +		return 0;
> +	}
> +
> +	*num_resources = min(cr_count, *num_resources);
> +
> +	for (i = 0; i < *num_resources; i++)
> +		resources[i] = cr_pkg->cpc_entry.package.elements[i].cpc_entry.int_value;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_resource_priority_resources);
> +
> +/**
> + * cppc_get_res_priority_enable - Read enable state of a Resource Priority register.
> + * @cpu: CPU number.
> + * @index: Sub-package index.
> + * @enable: Output true if enabled, false if disabled.
> + *
> + * Compares the current ENABLE_REGISTER value against ENABLE_VALUE.
> + * If ENABLE_REGISTER is null/unsupported, returns -EOPNOTSUPP.
> + *
> + * Return: 0 on success, negative error otherwise.
> + */
> +int cppc_get_res_priority_enable(int cpu, int index, bool *enable)
> +{
> +	struct cpc_register_resource *elems;
> +	struct cpc_register_resource *enable_reg;
> +	u64 reg_val, enable_val;
> +	int ret;
> +
> +	if (!enable)
> +		return -EINVAL;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	enable_reg = &elems[ENABLE_REGISTER];
> +	if (enable_reg->type != ACPI_TYPE_BUFFER ||
> +	    IS_NULL_REG(&enable_reg->cpc_entry.reg))
> +		return -EOPNOTSUPP;
> +
> +	ret = cpc_read_reg(cpu, enable_reg, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cpc_read_reg(cpu, &elems[ENABLE_VALUE], &enable_val);
> +	if (ret)
> +		return ret;
> +
> +	*enable = (reg_val == enable_val);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_res_priority_enable);
> +
> +/**
> + * cppc_set_res_priority_enable - Set enable state of a Resource Priority register.
> + * @cpu: CPU number.
> + * @index: Sub-package index.
> + * @enable: true to enable (write ENABLE_VALUE), false to disable (write 0).
> + *
> + * Return: 0 on success, negative error otherwise.
> + */
> +int cppc_set_res_priority_enable(int cpu, int index, bool enable)
> +{
> +	struct cpc_register_resource *elems;
> +	struct cpc_register_resource *enable_reg;
> +	u64 val;
> +	int ret;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	enable_reg = &elems[ENABLE_REGISTER];
> +
> +	if (enable) {
> +		ret = cpc_read_reg(cpu, &elems[ENABLE_VALUE], &val);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val = 0;
> +	}
> +
> +	return cpc_write_reg(cpu, enable_reg, val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_res_priority_enable);
> +
> +/**
> + * cppc_get_res_priority_count - Read priority count for a Resource Priority register.
> + * @cpu: CPU number.
> + * @index: Sub-package index.
> + * @count: Output priority count (>= 2 per spec).
> + *
> + * Return: 0 on success, negative error otherwise.
> + */
> +int cppc_get_res_priority_count(int cpu, int index, u64 *count)
> +{
> +	struct cpc_register_resource *elems;
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	return cpc_read_reg(cpu, &elems[PRIORITY_COUNT], count);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_res_priority_count);
> +
> +/**
> + * cppc_get_res_priority - Read priority value for a Resource Priority register.
> + * @cpu: CPU number.
> + * @index: Sub-package index.
> + * @priority: Output priority value.
> + *
> + * Return: 0 on success, negative error otherwise.
> + */
> +int cppc_get_res_priority(int cpu, int index, u64 *priority)
> +{
> +	struct cpc_register_resource *elems;
> +	struct cpc_register_resource *prio_reg;
> +
> +	if (!priority)
> +		return -EINVAL;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	prio_reg = &elems[PRIORITY_REGISTER];
> +	if (prio_reg->type != ACPI_TYPE_BUFFER ||
> +	    IS_NULL_REG(&prio_reg->cpc_entry.reg))
> +		return -EOPNOTSUPP;
> +
> +	return cpc_read_reg(cpu, prio_reg, priority);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_res_priority);
> +
> +/**
> + * cppc_set_res_priority - Write priority value for a Resource Priority register.
> + * @cpu: CPU number.
> + * @index: Sub-package index.
> + * @priority: Priority value to write (valid range: [0, PriorityCount - 1]).
> + *
> + * Return: 0 on success, negative error otherwise.
> + */
> +int cppc_set_res_priority(int cpu, int index, u64 priority)
> +{
> +	struct cpc_register_resource *elems;
> +	struct cpc_register_resource *prio_reg;
> +	u64 prio_count;
> +	int ret;
> +
> +	elems = get_res_prio_subpkg(cpu, index);
> +	if (!elems)
> +		return -EOPNOTSUPP;
> +
> +	ret = cpc_read_reg(cpu, &elems[PRIORITY_COUNT], &prio_count);
> +	if (ret)
> +		return ret;
> +
> +	if (priority >= prio_count)
> +		return -EINVAL;
> +
> +	prio_reg = &elems[PRIORITY_REGISTER];
> +
> +	return cpc_write_reg(cpu, prio_reg, priority);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_res_priority);
> +
>  /**
>   * cppc_get_transition_latency - returns frequency transition latency in ns
>   * @cpu_num: CPU number for per_cpu().
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c0b8d52016cd..86a4764c504d 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -208,6 +208,14 @@ extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
>  extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>  extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
> +extern int cppc_get_resource_priority_count(int cpu, int *count);
> +extern int cppc_get_resource_priority_resources(int cpu, int index,
> +						u32 *resources, int *num_resources);
> +extern int cppc_get_res_priority_enable(int cpu, int index, bool *enable);
> +extern int cppc_set_res_priority_enable(int cpu, int index, bool enable);
> +extern int cppc_get_res_priority_count(int cpu, int index, u64 *count);
> +extern int cppc_get_res_priority(int cpu, int index, u64 *priority);
> +extern int cppc_set_res_priority(int cpu, int index, u64 priority);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>  extern int amd_detect_prefcore(bool *detected);
> @@ -312,6 +320,35 @@ static inline int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_resource_priority_count(int cpu, int *count)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_resource_priority_resources(int cpu, int index,
> +						       u32 *resources, int *num_resources)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_res_priority_enable(int cpu, int index, bool *enable)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_res_priority_enable(int cpu, int index, bool enable)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_res_priority_count(int cpu, int index, u64 *count)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_res_priority(int cpu, int index, u64 *priority)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_res_priority(int cpu, int index, u64 priority)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  {
>  	return -ENODEV;

