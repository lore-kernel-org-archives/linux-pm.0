Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0424EC663;
	Wed, 16 Sep 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557174; cv=none; b=A+HvlugEfBmNxHJC9iUyBrzLmFMtIS89lQJIz33JNZmrSiWKZlffh3pAdeFzWm5Iqx6HtvE7TyUmoVDR1IpzfZ5Ta0b4CqpnE4H0+VnHc05QhKXd2TprNjs5vKjH3Oo8AGbbPqI5Dv8h9E8VOLpL/dn4rRyN+L1xezUngIU5XXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557174; c=relaxed/simple;
	bh=1q9E++OoHeScrVvGyvWBXSXKeDF+J5fHPuPcW2aD7z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JywpIWO24EBEWiJRQN7g5UpSSLCB2ebLTovCGPBpSp80Yb2bV49kzVJWBGw8RYRRuKIX5JPQgc0Impk7f1P/jnBrhLbN/2KIRUmCqQBhnEz0ZWY/konaD73newvVwGBFtA4h3s8hf/AstO0GSzn9W6w1cA61g0PMsyvXMpOzqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sGBeAie5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sGBeAie5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB547152B;
	Wed, 16 Sep 2026 04:12:31 -0700 (PDT)
Received: from [10.0.129.72] (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9E463F86F;
	Wed, 16 Sep 2026 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789557155; bh=1q9E++OoHeScrVvGyvWBXSXKeDF+J5fHPuPcW2aD7z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGBeAie5sU6JFx++lyn4pjUV7iZ4IQwzvBZDIejbwq4+0Owvmh7MxZxizdtgNHsOv
	 OeA5cglS8X9OqvutD9Hv/MbEKGfWOa+2hSeZhvn7pK9e0iExMusLrn0d7JZNUrfnTV
	 VYi69x/OCpBmhu8xSOJamu6HijvVJ78mHWT1QTgE=
Message-ID: <ea2c4680-ccee-4ad5-978c-95dade454091@arm.com>
Date: Wed, 16 Sep 2026 12:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path
 candidates
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik
 <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260916100116.701206-1-christian.loehle@arm.com>
 <20260916100116.701206-3-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260916100116.701206-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 11:01, Christian Loehle wrote:
> Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
> slow-path selectors can choose the same CPU before either task is enqueued.
> 
> Use reservoir sampling in the tie branch, resetting the candidate count
> when a lower advertised exit latency is found. Use the per-CPU scheduler
> PRNG and reciprocal_scale() to avoid variable division or a second scan.
> 
> This reduces deterministic convergence without reserving the chosen CPU.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/fair.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff5793bddc35..6836a8364440 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -24,6 +24,7 @@
>  #include <linux/mmap_lock.h>
>  #include <linux/hugetlb_inline.h>
>  #include <linux/jiffies.h>
> +#include <linux/math.h>
>  #include <linux/mm_api.h>
>  #include <linux/highmem.h>
>  #include <linux/hrtimer.h>
> @@ -8459,6 +8460,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>  {
>  	unsigned long load, min_load = ULONG_MAX;
>  	unsigned int min_exit_latency = UINT_MAX;
> +	unsigned int nr_candidates = 0;
>  	int least_loaded_cpu = this_cpu;
>  	int shallowest_idle_cpu = -1;
>  	int i;
> @@ -8482,9 +8484,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>  			if (idle && idle->exit_latency < min_exit_latency) {
>  				min_exit_latency = idle->exit_latency;
>  				shallowest_idle_cpu = i;
> +				nr_candidates = 1;
> -			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -				   shallowest_idle_cpu == -1) {
> -				shallowest_idle_cpu = i;
> +			} else if (!idle || idle->exit_latency == min_exit_latency) {


Sashiko:
"Can this branch cause the CPU picker to replace an optimal idle CPU with
a non-idle CPU?
In sched_balance_find_dst_group_cpu(), if a !idle CPU is scanned after an
idle CPU has already been found, min_exit_latency will be < UINT_MAX.
However, the condition !idle || idle->exit_latency == min_exit_latency
unconditionally evaluates to true for !idle CPUs.
This allows the !idle CPU to increment nr_candidates and enter the
reservoir, treating its unknown latency as a tie with the optimal known
latency. It then has a 1/nr_candidates chance to overwrite the optimal
shallowest_idle_cpu choice.
Doesn't this reintroduce a scan-order bias during normal load balancing where
non-idle CPUs can replace optimal idle CPUs just because they appear later
in the scan?"

Disagree, this is in the if block of if (available_idle_cpu(i)), so except for
the obvious race which is deliberately taken in the original code too, this
can't be right?

> +				nr_candidates++;
> +				if (nr_candidates == 1 ||
> +				    !reciprocal_scale(sched_rng(), nr_candidates))
> +					shallowest_idle_cpu = i;
>  			}
>  		} else if (shallowest_idle_cpu == -1) {
>  			load = cpu_load(cpu_rq(i));

