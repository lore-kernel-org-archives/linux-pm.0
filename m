Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1F4DA535;
	Wed, 16 Sep 2026 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555987; cv=none; b=EE4yAF5aQyn6IcTBKp2vKE5cwNg5AxcdYBTo0WKsBXWgZbNVUF/5G3ml3ca5GOrO/pS5dYZMkC5LIC5waNu6WrV8uxYF9EWtAc1xV1i8WRqkmYlJyea/qomav6xfwrx0ZlopOLum+wPpPPj2OvetYqR+OGuZVt70uAL3aP71NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555987; c=relaxed/simple;
	bh=RhduKqcItE584Gog2HHjq9v4nZ1t5cRd+2u1AHvp/Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKozzlqqHXwjVwzrgvZG7bzLAT6Qg3178HVeMzFUzmPxznXgho6U9rkIHrFXxN+VqONwtrNn4RZQ+7ygyZNkbU4FIZsTvbCHNaYFStxWUxIcZ+EOESCJQzbGXpWprhm7nO8CECOCS1Svb15BTY3dymTlJGod7uB9vvNNFwtKf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k+QPQZ+7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k+QPQZ+7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21DB1152B;
	Wed, 16 Sep 2026 03:52:34 -0700 (PDT)
Received: from [192.168.178.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862EB3F882;
	Wed, 16 Sep 2026 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789555957; bh=RhduKqcItE584Gog2HHjq9v4nZ1t5cRd+2u1AHvp/Pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k+QPQZ+7lFhCUxzwB5qWc/aVin1L+Ty0HMKoeDTdKQNkahM0tK+cYSMFOw9EPXdAo
	 tX5VERC5gj1tGwCTKOJI9xmdx7BHPsNI6W1G5AhCwLINtZMxU0+AaaM9dXBVOgrIGo
	 o1IbXWjEdyKMbcLMH+LPLmm7NStwCDN4mFkR0t0o=
Message-ID: <55538466-2203-42ec-a0bd-b743c04a3b38@arm.com>
Date: Wed, 16 Sep 2026 12:52:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: topology: fix arch_freq_get_on_cpu()
 overflow above 4.19 GHz
To: Oleg Keri <okerixx@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org, jonathan.cameron@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com
References: <20260910063440.4677-1-okerixx@gmail.com>
 <20260910063440.4677-2-okerixx@gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260910063440.4677-2-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.26 08:34, Oleg Keri wrote:

[...]

> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index d28438f8b83f..0eca321ff113 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -245,8 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
>  	 * (see amu_scale_freq_tick for details)
>  	 */
>  	scale = arch_scale_freq_capacity(cpu);
> -	freq = scale * arch_scale_freq_ref(cpu);
> -	freq >>= SCHED_CAPACITY_SHIFT;
> +	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;
>  	return freq;
>  }

In task scheduler code we use cap_scale(v, s) for CPU capacity related
scaling.

We could move its definition from private task scheduler include file
kernel/sched/sched.h to include/linux/topology.h to be able to use it
also outside the task scheduler?

Only compile tested on arm64 and x86.

-->8--

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0eca321ff113..180a7aa97752 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -186,7 +186,6 @@ int arch_freq_get_on_cpu(int cpu)
      struct amu_cntr_sample *amu_sample;
      unsigned int start_cpu = cpu;
      unsigned long last_update;
-     unsigned int freq = 0;
      u64 scale;

      if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
@@ -245,8 +244,7 @@ int arch_freq_get_on_cpu(int cpu)
      * (see amu_scale_freq_tick for details)
      */
      scale = arch_scale_freq_capacity(cpu);
-     freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;
-     return freq;
+     return cap_scale(arch_scale_freq_ref(cpu), scale);
 }

 static void amu_fie_setup(const struct cpumask *cpus)
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 709a2dcf4c73..0a4ee12a98d5 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -351,4 +351,6 @@ static inline unsigned long
topology_get_cpu_scale(int cpu)

 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);

+#define cap_scale(v, s)               ((v)*(s) >> SCHED_CAPACITY_SHIFT)
+
 #endif /* _LINUX_TOPOLOGY_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c3ad70e58b8..45796fccdc84 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -236,8 +236,6 @@ static inline int task_has_dl_policy(struct
task_struct *p)
        return dl_policy(p->policy);
 }

-#define cap_scale(v, s)               ((v)*(s) >> SCHED_CAPACITY_SHIFT)
-
 static inline void update_avg(u64 *avg, u64 sample)
 {
        s64 diff = sample - *avg;

