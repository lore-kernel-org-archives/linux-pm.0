Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667570809;
	Mon, 21 Sep 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998647; cv=none; b=IEnz7hwL1hKThOIe46C9nLzsgFUmH0QABk9iBQP2Z4skVCZ/Amr27okJ4gnoVu9pikbeTh3V1P4B3jXEmjWvGMeD1Cf5KX3vuu8ReogegFVBzhFGQG+x0b3hMoeMpfZ5S7XXvoXq7QmwV96CLe1lNvCaekmvVefGX4hst86dGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998647; c=relaxed/simple;
	bh=DjB3fpKqAp8686etMoCaKqxhPaFUQK7vXCBysnxb29c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJW5AigQUbmDeXSjIR/HpzZTRMd1EGcobZwfUhfrrWy/a/6mDV7zfiTkrDl3mZrkWiW4iECx2zsIzP6SEHoTUra/OflmN6dXNbwKX/5pf9URhcxcKxE5ctE/jCuVvDPlQGI2YdZwBT5qHRVppMhqoZinRmmYbP3Q6SDT97SN9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=elKUwwCq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="elKUwwCq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FCC219F6;
	Mon, 21 Sep 2026 06:50:41 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9437D3F528;
	Mon, 21 Sep 2026 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789998645; bh=DjB3fpKqAp8686etMoCaKqxhPaFUQK7vXCBysnxb29c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=elKUwwCqub7RIwV77IdsKQyaM87EwE3VLi531pEViltJiItG1HhW+lmj1VNLTK4Qx
	 6+h7C8XOgMDMcFVtEyt5gJHh1mO/Ga97VpFBOzCpuZFkv3mZL+nfl68VWS5QYVSEeM
	 mE8Wc7bBSS8dB7+phLxP9ufh8GoinSoZzhwwFKQk=
Message-ID: <2404d9c9-b66c-43ab-a42d-709486b0f250@arm.com>
Date: Mon, 21 Sep 2026 15:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: topology: fix arch_freq_get_on_cpu() overflow
 above 4.19 GHz
To: Oleg Keri <okerixx@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Sumit Gupta <sumitg@nvidia.com>, Beata Michalska <beata.michalska@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ananthu C V <ananthu.cv@oss.qualcomm.com>, linux-pm@vger.kernel.org
References: <20260917182059.2851-1-okerixx@gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260917182059.2851-1-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.09.26 20:20, Oleg Keri wrote:
> arch_freq_get_on_cpu() computes the product of the frequency scale and
> the reference frequency as a u64, but assigns it to an unsigned int
> before shifting it back down:
> 
> 	freq = scale * arch_scale_freq_ref(cpu);
> 	freq >>= SCHED_CAPACITY_SHIFT;
> 
> The product is truncated to 32 bits before the shift, so the result
> wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
> i.e. 4194304 kHz.
> 
> On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
> kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
> the CPU demonstrably runs at the boost frequency: a fixed workload
> completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
> kHz, matching the 1.171 frequency ratio.
> 
> Compute it with cap_scale(), turned into a static inline taking u64 and
> moved to <linux/sched/topology.h> so it is usable outside kernel/sched.
> 
> Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> ---
> Changes in v5:
> - cap_scale() becomes a static inline taking u64 arguments instead of
>   a macro, as Dietmar proposed and Peter agreed, after Peter pointed out
>   that the macro relies on one operand being u64.  It now lives in
>   <linux/sched/topology.h>, where SCHED_CAPACITY_SHIFT is visible,
>   rather than <linux/topology.h>.
> - Patch 2/2 of v4 is dropped: it duplicated Ananthu C V's series [1],
>   which I tested instead.  This fix is needed with that series, since
>   it puts the reference above 4194304 kHz from boot.
> - v4: https://lore.kernel.org/all/20260917125112.2283-1-okerixx@gmail.com/
> 
> [1] https://lore.kernel.org/all/20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com/
> 
>  arch/arm64/kernel/topology.c   | 6 ++----
>  include/linux/sched/topology.h | 5 +++++
>  kernel/sched/sched.h           | 2 --
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..39dd7f8575cd 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/percpu.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/sched/topology.h>
>  #include <linux/xarray.h>
>  
>  #include <asm/cpu.h>
> @@ -186,7 +187,6 @@ int arch_freq_get_on_cpu(int cpu)
>  	struct amu_cntr_sample *amu_sample;
>  	unsigned int start_cpu = cpu;
>  	unsigned long last_update;
> -	unsigned int freq = 0;
>  	u64 scale;
>  
>  	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> @@ -245,9 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
>  	 * (see amu_scale_freq_tick for details)
>  	 */
>  	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> -	return freq;
> +	return cap_scale(arch_scale_freq_ref(cpu), scale);
>  }
>  
>  static void amu_fie_setup(const struct cpumask *cpus)
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index b5d9d7c2b8ad..922b2f015e89 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -234,6 +234,11 @@ static inline void rebuild_sched_domains_energy(void)
>  }
>  #endif
>  
> +static inline u64 cap_scale(u64 value, u64 scale)
> +{
> +	return value * scale >> SCHED_CAPACITY_SHIFT;
> +}
> +
>  #ifndef arch_scale_cpu_capacity
>  /**
>   * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6c3ad70e58b8..45796fccdc84 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -236,8 +236,6 @@ static inline int task_has_dl_policy(struct task_struct *p)
>  	return dl_policy(p->policy);
>  }
>  
> -#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
> -
>  static inline void update_avg(u64 *avg, u64 sample)
>  {
>  	s64 diff = sample - *avg;
> 
> base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1



