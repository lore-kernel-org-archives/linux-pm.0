Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AC563FD5;
	Tue, 22 Sep 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093649; cv=none; b=L6AMiUcToGGC7ebxZzTUni4Wxq9EDmG9/6Nv7dJTxSfi+DGqZr9xfklEYd2Umt8RygpOst8c3zOF2FE+Kj21bJSf9AHcbSN75pzmvJoccwCPKt2C6IqCZPmkCo3CMOwAXqiC3eZK6kSKOt0F27A7MiCVJlfej9rlrrM4jRda9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093649; c=relaxed/simple;
	bh=CHmgmxub88Xrygqm1D/E4gpUPQCkatJllJy0+tqHrV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efKlEw1Jy0x2puKZFPvaBTcVJqm70Im5Zetqx5gy3UUdT7beVnTr3xUZlrp0n9oNpy33hOaS8wEMS6NJL0huauah5FHbwGkQIPb0AGxgLhNYxCE97ZcMdJDnVPuo1w3a4Sn0uNsgEAujMNQ5/P4srePALNMRe3eDzjTQwzLAx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ3dk0u5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ3dk0u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27ED1F000FF;
	Tue, 22 Sep 2026 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093647;
	bh=ENorQJ/pLh3pPA/2sJg/M7aUt54CHEBCt3OvYkywruk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KJ3dk0u53UyHdo8MUMbEJc+Q6GjkB7nePEU1r/iUnou6lgcF07QQGKmNPF6owynjA
	 brmhN9xePWg2kiaOYX5WD/RUONjKLGahkuYAvzfdkH+JrHy+Rm9/AKc8PO9y3v9s22
	 lf6pNZSh5+eUKN4cl1Xm48r0KKKmvqnprbXx2mgeR+GkrGGDYcZxII3XEs+JIwevr4
	 pALKzntLFWks4/AW2wPfBDzMit4HYfI2otNErskLQSSDEp2KDI904oSvXH4gEBa1vB
	 PskLsc9R3M/e7QYq1txbjLLDlPqV8Qow96tVMHG48dVi/LKGTW1uo3XpVWah0U/7hD
	 OiUjml68PB+8A==
Date: Tue, 22 Sep 2026 17:14:00 +0100
From: Will Deacon <will@kernel.org>
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] arm64: topology: fix arch_freq_get_on_cpu() overflow
 above 4.19 GHz
Message-ID: <arKpSGPXOCFF09hM@willie-the-truck>
References: <20260917182059.2851-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917182059.2851-1-okerixx@gmail.com>

On Thu, Sep 17, 2026 at 08:20:59PM +0200, Oleg Keri wrote:
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

The arm64 part looks fine to me, so for that:

Acked-by: Will Deacon <will@kernel.org>

However...

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

... does this introduce unnecessary 64-bit arithmetic for 32-bit
architectures that currently pass 'unsigned long' to the existing macro?

Will
