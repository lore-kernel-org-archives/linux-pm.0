Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6340EB82;
	Mon, 27 Jul 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158122; cv=none; b=f2g8MDxqa7uigvOjSkG3Mr0fqy1G4i4WfJ+L+jhMdzNE/tO31WPr1BOGYALru9OdkTIjz5uv0nzDRYzXE+CqWOLqZ+ueY3SkOr6yoN945LzSQS9m0bD3TVOov/ZJec7AoKC3tBrUKIdSbRcbdeYbbfONFkByeijEcSJCeV2S+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158122; c=relaxed/simple;
	bh=rJWbiUDF0aztC9MsTrWCyMFzdxKTMeetPyv9Jiug1vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se6gWmp2yM1ATQl4IfCljDHOHXVD8exfjyCsKvFQA6X2kY1VwYV2qJ35lIANkPGxSLpJ1nyq1S/ZSzhTUe69dDjlH2toSa7rr2r3OWWudF8vJB5QdhOpGsZs5f1FFgOZ+JSipfXPCL7lzVoaZs9RCI5kV9wGQaAonRAgQBPIjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sNJCLHZl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sNJCLHZl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7E8143D;
	Mon, 27 Jul 2026 06:15:15 -0700 (PDT)
Received: from [192.168.0.248] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1083F66F;
	Mon, 27 Jul 2026 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785158119; bh=rJWbiUDF0aztC9MsTrWCyMFzdxKTMeetPyv9Jiug1vE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sNJCLHZl3ezzii8fE0VbcnIc3jKhAEHaCReMaVpdIO8HWwFU2T2bytKObfYZV+K4A
	 wK6tnmdpIcgrmDYSRfEY7hNK8A8QvRVhmeO7MXlY6lhZDHKX6Msnwp9or3WFDwNTyq
	 aP1KqOd95oYPUAUfEnij5FStgfOVYVMCF/vO4UjA=
Message-ID: <c8f62b1d-4ab5-4d85-ae15-b5fc9ec2e3bc@arm.com>
Date: Mon, 27 Jul 2026 14:15:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-4-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260724215937.3368276-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 22:59, Sumit Gupta wrote:
> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
> boot parameter) can be lost in two ways:
> 
>   - Across CPU hotplug: the platform may reset a CPU's registers while it
>     is offline.
>   - On driver unload: the value the driver wrote is left in the register
>     instead of returning to its pre-driver state.
> 
> Add a small table-driven mechanism that handles both:
> 
>   - On init(), capture each register's firmware value before the
>     driver programs anything.
>   - On offline(), read back each register's current value (whatever was
>     last set via sysfs or the boot parameter) so it can be reapplied, then
>     restore the firmware value.
>   - On online(), reapply the value captured at offline() after the
>     performance request is re-established.
> 
> Keep Autonomous Selection (auto_sel) last in the table so that, on
> online(), its saved value is reapplied after the other registers that
> shape its behaviour.
> 
> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
> (EPP) and Autonomous Activity Window (auto_act_window) registers.
> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 34cdba00e61a..8a13ec49eb9d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,150 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
> + * the autonomous boot parameter is reapplied from online() across CPU
> + * hotplug, and the firmware value is restored from offline().
> + *
> + * Autonomous Selection (auto_sel) is kept last so its saved value is
> + * reapplied after the other registers that shape its behaviour.

While that would make sense, unfortunately:
"8.4.6.1.6 Autonomous Activity Window Register
Writes to this register only have meaning when Autonomous Selection is enabled."
I think restoring an inappropriate EPP/AUTO_ACT_WINDOW temporarily is okay though.
AFAICS it has to be:
1. enable CPPC
2. restore a valid DESIRED/MIN/MAX
3. restore AUTO_SEL_ENABLE
4. if autonomous mode is enabled, restore EPP and AUTO_ACT_WINDOW

> + */
> +enum cppc_saved_reg_id {
> +	CPPC_SAVED_EPP,
> +	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_SAVED_AUTO_SEL,
> +	CPPC_NR_SAVED_REGS,
> +};
> [snip]
