Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB7381B18;
	Mon, 16 Mar 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651341; cv=none; b=jLfq7vr5TQb6J2ztF3KPNm3ewbZ3nMZ8CznfgBbanKQCxxGna64gSpl5vppdmLWO+qmPqJ+k+OLncFbmgjTtXvqIdbCASZtyDsgyp2HR6Md9GtsJb817XcPh2VUU7ZoV+4Ov3Cd15dl1JZTPRyicG2ZMQlSaUEkGl7yYq1+6t8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651341; c=relaxed/simple;
	bh=pCU3ArB83GLUEr67Ft5BzirQf/RGFiR4NjupEoOpV2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh3WdTUP+a1Mm1+i8ELsC9Kdovc0I4l7OJtAAZUqXgN4LOWvHDPqMicy8ALirKyD6k/CDc8m8HBYlNN8p5A2JUxovmImDhmFbDeaBccxwGNL8LDP9ArwJpUMaxteSddx8zUPU49rVUcZMO8mU+OhnYer6haT68voMgPtQ8YHGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0B8C1477;
	Mon, 16 Mar 2026 01:55:32 -0700 (PDT)
Received: from [10.1.28.15] (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB173F73B;
	Mon, 16 Mar 2026 01:55:37 -0700 (PDT)
Message-ID: <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
Date: Mon, 16 Mar 2026 08:55:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 07:37, Maulik Shah wrote:
> CPU can get IPI interrupt from another CPU while it is executing
> cpuidle_select() or about to execute same. The selection do not account
> for pending interrupts and may continue to enter selected idle state only
> to exit immediately.
> 
> Example trace collected when there is cross CPU IPI.
> 
>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>  [007] 154.892211: ipi_entry: (Function call interrupts)
>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>  [007] 154.892214: ipi_exit: (Function call interrupts)
> 
> This impacts performance and the above count increments.
> 
> commit ccde6525183c ("smp: Introduce a helper function to check for pending
> IPIs") already introduced a helper function to check the pending IPIs and
> it is used in pmdomain governor to deny the cluster level idle state when
> there is a pending IPI on any of cluster CPUs.
> 
> This however does not stop CPU to enter CPU level idle state. Make use of
> same at CPUidle to deny the idle entry when there is already IPI pending.
> 
> With change observing glmark2 [1] off screen scores improving in the range
> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
> clusters each with 4 CPUs.
> 
> [1] https://github.com/glmark2/glmark2
> 
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>  	ktime_t time_start, time_end;
>  
> +	if (cpus_peek_for_pending_ipi(drv->cpumask))
> +		return -EBUSY;
> +
>  	instrumentation_begin();
>  
>  	/*
> 
> ---
> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> change-id: 20260316-cpuidle_ipi-4c64036f9a48
> 
> Best regards,

So we already do a per-CPU IPI need_resched() check in the idle path.
Your patch uses drv->cpumask, which will contain all CPUs, preventing idle entry if
any CPU has an IPI pending?
