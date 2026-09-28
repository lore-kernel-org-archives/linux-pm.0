Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908CC4D2EC6;
	Mon, 28 Sep 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603468; cv=none; b=nJSkx1sMDqTf9nWOpVVfinaDzLhj4uvB7q6KKFPqNW4XxgyF4ALUY+HCEUmu0Tsuoldkwybhw66fpWdOZPeHRI4KzVzhYSLn2x6eIYiUrwkENNPV1VTUsMGzZI2U8YDFUKkBeEO++XAPFPWnxK3bsnI8SYWP/VyVEsjmLPfCQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603468; c=relaxed/simple;
	bh=sSzs5TmeZWukHQjRBFbvOyAP6kTnX8ikVYAGdbyWEAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbrgRJiK1aTY3YSby5PgW5Zf8yDhnZQgL4TKGdFvm6hSmtN+8mxVzDvRmOad+HwhE1dP/SkYEPqXh1L4Db+BMQatBp8o5GJWDbuUdH0d+NTdkM4brWtk8otr0Kdw68uE3x1tbRctWlqa6eXHbq36sdbOv96dT1mspRtt3EUJMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D4Pd9Wf0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D4Pd9Wf0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F98E1655;
	Mon, 28 Sep 2026 06:51:02 -0700 (PDT)
Received: from [10.57.52.74] (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B785F3F763;
	Mon, 28 Sep 2026 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790603465; bh=sSzs5TmeZWukHQjRBFbvOyAP6kTnX8ikVYAGdbyWEAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D4Pd9Wf0jbZEmnV+Kz/fVFG0i6sTjPObmIYL+5FoeLG99Xo0a+vS/yUbfzIg4sS+d
	 CLsO04G36T1ruKB3aTcMgeCErznO6EsD99jqma9k5Yuc1OxuAZqWrG2+ccaru3VucO
	 pWdhAbXj2NAjwCVgRBVEwGsaGsGI4zmdE3OGLe40=
Message-ID: <2c6f79b9-2830-4a56-b4bb-8ae728eb41ee@arm.com>
Date: Mon, 28 Sep 2026 14:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] ACPI: CPPC: Resource Priority Register support and
 sysfs interface
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, saket.dumbre@intel.com, lenb@kernel.org,
 ionela.voinescu@arm.com, zhanjie9@hisilicon.com, pierre.gondois@arm.com,
 sumitg@nvidia.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, linuxarm@huawei.com,
 yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com,
 linhongye@h-partners.com
References: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 13:41, Lifeng Zheng wrote:
> This series implements support for the CPPC v4 Resource Priority Register
> mechanism defined in ACPI 6.6, Section 8.4.6.1.2.7, and exposes it to
> userspace via sysfs.
> 
> Resource Priority allows OSPM to control the relative priority among
> processors for shared resources. OSPM can utilize these sysfs interfaces
> to configure resource priorities, allowing resources to be preferentially
> allocated to more important tasks.
> 
> The controlled resource types include processor boost, throttle, L2 cache,
> L3 cache, and memory bandwidth.  Each Resource Priority group consists of:
> >   - CONTROLLED_RESOURCES: which resource types the group affects
>   - ENABLE_VALUE / ENABLE_REGISTER: enable/disable the group
>   - PRIORITY_COUNT / PRIORITY_REGISTER: read/write the priority level
> 
> The patch series is organized in three parts:
> 
>   - patches 1-4 extend the CPPC data structures and _CPC parser to handle
>     Package-type entries and parse Resource Priority sub-packages into
>     structured descriptors.
> 
>   - patches 5-7 refactor existing register I/O helpers to support direct
>     register access and add accessor functions for Resource Priority
>     attributes (enable, priority count, priority value).
> 
>   - patch 8 creates a "resource_priority" sysfs hierarchy under each
>     cpufreq policy to expose the Resource Priority attributes to userspace.
> 
> Changelog:
> v4:
>  - Patch 7: Set *num_resources to 0 when controlled resources number
>    invalid in cppc_get_resource_priority_resources(), therefore, the caller
>    will not read the unassigned `resources` pointer.
>  - Patch 8: Remove kfree() from the error path of
>    cppc_create_res_prio_sysfs() because cppc_res_prio_release() will do it.
> 
> v3:
>  - Patch 2: Add the (i - 2) == RESOURCE_PRIORITY condition back to ensure
>    the new code behaves the same as the original.
>  - Patch 4: Assign -ENODATA to ret when an unexpected ACPI_TYPE_PACKAGE
>    appears.
>  - Patch 5: Initialize the `optional` field of the remaining cpc_regs to
>    true so that they are treated as unsupported.
>  - Patch 8: Call cppc_cpufreq_cpu_fie_exit() and set perf to lowest_perf
>    when cppc_create_res_prio_sysfs() fails. Call kobject_put() and kfree()
>    when kobject_init_and_add() fails in cppc_create_res_prio_sysfs().
>  - Link: https://lore.kernel.org/all/20260812015217.74598-1-zhenglifeng1@huawei.com/
> 
> v2:
>  - Patch 1: Revert changes to the CPC_SUPPORTED() macro.
>  - Link: https://lore.kernel.org/all/20260804085042.4118193-1-zhenglifeng1@huawei.com/
> 
> v1:
>  - Link: https://lore.kernel.org/all/20260717024502.3520445-1-zhenglifeng1@huawei.com/
> 
> ---
> 
> RFC: sysfs placement
> 
> The sysfs interface is currently placed under /sys/devices/system/cpu/cpufreq/
> (i.e. the cpufreq policy directory). I am unsure whether this is the best
> location and would appreciate reviewer feedback.
> 
> The concern is that Resource Priority covers resource types beyond CPU
> frequency control:
> 
>   - PROCESSOR_BOOST, PROCESSOR_THROTTLE -- clearly CPU-frequency related
>   - L2_CACHE, L3_CACHE -- cache partitioning, not frequency
>   - MEMORY_BANDWIDTH -- memory QoS, not frequency
> 
> Placing the attributes under cpufreq makes sense for boost/throttle but
> feels semantically wrong for cache and memory bandwidth resources.
> 
> I would appreciate feedback on whether cpufreq is the right home for
> this interface, or whether a different location would be more appropriate.

Another issue is regarding adjacent interfaces (Intel-RDT, AMD-QoS, Arm-MPAM,
RISCV-CBQR for memory and cache. I'm hoping no sane platform advertises both,
but should the kernel sanitize these?

Additionally what if we ever do want to be more 'clever' in the kernel about
aggregating these hints of "boost-worthiness" of tasks/CPUs, do we just disable
the low level sysfs controls here then?

> 
> Lifeng Zheng (8):
>   ACPI: CPPC: Prepare cpc_register_resource for Package-type entries
>   ACPI: CPPC: Refactor element parsing into parse_cpc_element()
>   ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
>   ACPI: CPPC: Parse Resource Priority Register entries from _CPC package
>   ACPI: CPPC: Store optional flag in cpc_register_resource
>   ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
>   ACPI: CPPC: Add Resource Priority accessors
>   cpufreq: cppc: Expose Resource Priority attributes via sysfs
> 
>  drivers/acpi/cppc_acpi.c       | 719 +++++++++++++++++++++++++++------
>  drivers/cpufreq/cppc_cpufreq.c | 281 ++++++++++++-
>  include/acpi/cppc_acpi.h       |  60 +++
>  3 files changed, 930 insertions(+), 130 deletions(-)
> 

