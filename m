Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81329BD91;
	Sun,  9 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786258879; cv=none; b=TZLKOKNEkHkJFAus6o8rBxi0uN334smJwM/jtGLMCB5rh0m7jLOQwTZzsPc5AEf1xabLKDODr/UcGZmmdWpbVI16vBNtACdoKwWIDFh7wk42D2St2EXoKySn2N+BI+Z1nOIeln0hEaVD95hgbudFUtPbeepC55CinFZnb+1OnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786258879; c=relaxed/simple;
	bh=liX76EDjpuPfqNjDBiQ5/uYqQay7K7uRyw71A3O7odE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOZgSO4I1+0FTVCbbgsengN6sBytxq0D7hEw9WcbB19s2s8zCw1aDTtqaZI74E+LFavYwUsPhmKQo7q/CjVrXkdH3WzvtYYBH3UCNwHXA8Uwh9SmKf2S/tL2ueJwDbL8cIun7k5FHjbr3x5zRMOA6j4xnzlNuuGeNbVwm9ZqVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rKnUGT7j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rKnUGT7j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE3E152B;
	Sun,  9 Aug 2026 00:01:12 -0700 (PDT)
Received: from [10.57.4.198] (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF92B3F9A2;
	Sun,  9 Aug 2026 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786258876; bh=liX76EDjpuPfqNjDBiQ5/uYqQay7K7uRyw71A3O7odE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rKnUGT7jdSVCUZ6SfmwwHxkrWx9XG388ljgPHYH4WIGog+2sJG7lt+RDVp+qlO+Ow
	 LGvZ6C2QRBjZD9j756JoGQlmjKVDp/hVF6KE/Q9+qdxMM/aD8WAvB6jXJXqKAUNXYc
	 /UYv3IBnfxhucYCzQHWAswNCoLtYyCZJOzggpySw=
Message-ID: <82ad961e-6b87-482c-bbb1-f63a6974341e@arm.com>
Date: Sun, 9 Aug 2026 08:01:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com,
 Sashiko <sashiko-bot@kernel.org>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <20260809062549.1415955-16-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260809062549.1415955-16-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/9/26 07:25, Christian Loehle wrote:
> The Performance Limited status bits are sticky and write-zero-to-clear.
> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
> accesses.
> 
> cppc_set_perf_limited() currently reads the register, computes a new value,
> and writes it in a separate transaction. If the platform reports another
> excursion between those transactions, the stale write can clear that new
> event.
> 
> Write zero to the requested bits and one to the other defined status bits
> directly. Keep reserved bits zero as required for hardware status registers
> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
> 
> Reject SystemMemory descriptions which require read-modify-write to
> preserve the containing access unit, because the per-descriptor spinlock
> cannot interlock that RMW with platform updates. Also reject 64-bit
> SystemMemory descriptions on 32-bit kernels, where generic readq()/writeq()
> may be split into two 32-bit operations and cannot provide the required
> portable interlocked access. A naturally aligned full-width QWord remains
> supported on 64-bit kernels, where the architecture provides a native
> 64-bit MMIO accessor.
> 
> Performance Limited status is not required for CPPC control. If firmware
> describes it using an access that Linux cannot interlock safely, disable
> that status register instead of rejecting the processor's otherwise usable
> _CPC package.
> 
> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 67d7f81a21b7..9afc285c9314 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -414,6 +414,13 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
>  		       cpc_desc->cpu_id, cpc_desc->version, name);
>  		return -EINVAL;
>  	}
> +	if (reg_idx == PERF_LIMITED &&
> +	    (gas->bit_offset || gas->bit_width != access_width ||
> +	     (access_width == 64 && !IS_ENABLED(CONFIG_64BIT)))) {
> +		pr_err("CPU%d: Performance Limited register cannot use an interlocked SystemMemory access\n",
> +		       cpc_desc->cpu_id);
> +		return -EINVAL;
> +	}
>  
>  	return 0;
>  
> @@ -441,6 +448,14 @@ static int cpc_resolve_unsupported(struct cpc_desc *cpc_desc,
>  		if (!(unsupported & BIT(i)))
>  			continue;
>  
> +		/* CPPC control does not depend on Performance Limited status. */
> +		if (i == PERF_LIMITED) {
> +			pr_warn("CPU%d: ignoring inaccessible Performance Limited register\n",
> +				cpc_desc->cpu_id);
> +			cpc_disable_reg(cpc_desc, i);
> +			continue;
> +		}
> +
>  		if (i == DESIRED_PERF && cpc_immutable_autonomous(cpc_desc)) {
>  			pr_warn("CPU%d: ignoring inaccessible Desired Performance register in autonomous mode\n",
>  				cpc_desc->cpu_id);
> @@ -3081,9 +3096,6 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>   */
>  int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>  {
> -	u64 current_val, new_val;
> -	int ret;
> -
>  	/* Only bits 0 and 1 are valid */
>  	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
>  		return -EINVAL;
> @@ -3091,14 +3103,13 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>  	if (!bits_to_clear)
>  		return 0;
>  
> -	ret = cppc_get_perf_limited(cpu, &current_val);
> -	if (ret)
> -		return ret;
> -
> -	/* Clear the specified bits */
> -	new_val = current_val & ~bits_to_clear;
> -
> -	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
> +	/*
> +	 * Performance Limited is write-zero-to-clear.  Write one to the other
> +	 * defined sticky bits so a concurrently reported event is not cleared
> +	 * using a value obtained by an earlier, separate read transaction.
> +	 */
> +	return cppc_set_reg_val(cpu, PERF_LIMITED,
> +				CPPC_PERF_LIMITED_MASK & ~bits_to_clear);

Sashiko review:
"Does writing 0 to the reserved bits unconditionally clear them in this
write-zero-to-clear register?
Because CPPC_PERF_LIMITED_MASK masks off the upper reserved bits, the bitwise
AND results in 0 being written to bits 2-63. In a write-zero-to-clear (W0C)
register, 0 is the active clearing value, which could result in silent data loss
for sticky events in reserved bits defined by future ACPI versions.
While keeping reserved bits zero is the historical rule for standard
write-one-to-clear status registers, doing so here converts a small race
condition in the previous RMW logic into an unconditional clearing of all
reserved bits.
To safely preserve reserved bits in a W0C register, should this write 1s to the
reserved bits instead (for example, by simply writing ~bits_to_clear)?"

I won't adopt that proposal because ACPI 6.6 §4.6.1 explicitly requires
to write zero to reserved bits in status registers. We must not write 1s here.
