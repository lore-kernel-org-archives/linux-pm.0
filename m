Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772F4EB845;
	Thu, 17 Sep 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659169; cv=none; b=co3n/JxXcx/N2m9bxKZPAQrp4/wFhnjs4o2zwwOcOdd8aubKq4JEBZHLi57Bvzp0OG8qWgJXk74GYROewWsKM4XdiP/cc+snzn6qj4SmbLIA8xvIyYPK94VMCsf733FWl0dzaHDr8A9noMu+ENHtXaNbVJYL0FmZl0uKYacjwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659169; c=relaxed/simple;
	bh=/lyaH32OKU1SOpf305vXqxTeH/xsqm0UyZY95qb+8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCPIrrfhuxQtktZ5QmM23BuGzOw8S3Rzr8kJQV9edmsp6HGAdJ/r1nFWEVbUAAJ+HSsY4lyNXY4z3/tK3XHzL+h+mOnWRZwuyq8LqWfstrmwLHESHPXQK92ryHyVA1F65ycqZjK8iWmxeorqjwUDHJNkH9NaHxWGChhl6nKmMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VBBCKWga; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBBCKWga"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rg9kwtzkNVr89LUjHsPnBl0WVsm7riweLfXAeDfqeLM=; b=VBBCKWgaLxuV+mxuEtZNKirWZ3
	LEMS1qKp9j1ZAAyPKxgP9pNR/dipTRFAOv9+OjiZtbcZrwy84AdQk14tp5G8TONAfaYQJeh9fbqH3
	eb366isBMGLYXfbe94a10RysXpw4Nd7vwDNUt3ZK/WD56Zo6BEJbSytnvqrAoFAMTd793OnoCyBU/
	dTSFSwRPNHcx7Jh/7Dzpxc62rkNvpMEG1MpK8QCT6kXJOtSZ8O/w6+HbCrE2CFhgm+DZTMdnGWdZt
	b50RLyMlBKKaT8KfuVaNqA5+jM2GDc/o+BdDIgx2PAtzlWPUAsYXfd0mw+F5sjW3UMU+kqmkcjHvr
	LNnqynOg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7E66-00000008zmQ-0Q6p;
	Thu, 17 Sep 2026 15:32:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 489B1301BD5; Thu, 17 Sep 2026 17:32:24 +0200 (CEST)
Date: Thu, 17 Sep 2026 17:32:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Keri <okerixx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
Message-ID: <20260917153224.GJ4121339@noisy.programming.kicks-ass.net>
References: <20260917125112.2283-1-okerixx@gmail.com>
 <20260917125112.2283-2-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917125112.2283-2-okerixx@gmail.com>

On Thu, Sep 17, 2026 at 02:51:11PM +0200, Oleg Keri wrote:
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
> Use cap_scale(), which the scheduler already has for exactly this
> capacity scaling, so the multiply and the shift stay in 64 bits and
> only the final value is narrowed by the return type. Move the macro
> from the scheduler's private header to <linux/topology.h> so it can be
> used outside kernel/sched.
> 
> Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  arch/arm64/kernel/topology.c | 5 +----
>  include/linux/topology.h     | 2 ++
>  kernel/sched/sched.h         | 2 --
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..07b8c497c9e6 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -186,7 +186,6 @@ int arch_freq_get_on_cpu(int cpu)
>  	struct amu_cntr_sample *amu_sample;
>  	unsigned int start_cpu = cpu;
>  	unsigned long last_update;
> -	unsigned int freq = 0;
>  	u64 scale;
>  
>  	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> @@ -245,9 +244,7 @@ int arch_freq_get_on_cpu(int cpu)
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
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 709a2dcf4c73..0a4ee12a98d5 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -351,4 +351,6 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>  
> +#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)

This might not be a very good generic helper, since it relies on either
of the variables to be u64 for correctness.
