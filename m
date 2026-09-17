Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A30599A2B;
	Thu, 17 Sep 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655708; cv=none; b=qQi6MOA2bxEO5SYs8fxzdx41Xa6DAb6MK1lgL7XDSpj9b0gSH3XETJedFaZ4Yzhp7Ci3KppVZ93hfD2BasWCjbDxpbL+n8ka7ILs0LepszrI3h9g8CxaHrkuuqkEcB+liuHZ0tvDCmrsrNp3+f1jxyT9DZLWyccrmoDeNTWIwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655708; c=relaxed/simple;
	bh=mobytS+1K2rkJCeo1bg8kHuJ2xKRSO5VB5xXMn9bBS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnYUHZ5Xx5zQKmr/3YxV63DQENJZThjPGvMptcZ1DwZCMNRFCHgxifsd4qB3EguHL4YoCMdmPzmU/0P+1V6ofrgR2K/mDP45AG9U8co8gVLmRojy+w7VyljJ541Bsh+7CYAtk20KqCYRdN8PED2xlL7MrQe5CNXk9YGPnSbDZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iqHXQy1J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iqHXQy1J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CAD1476;
	Thu, 17 Sep 2026 07:35:00 -0700 (PDT)
Received: from [192.168.178.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735AC3F86F;
	Thu, 17 Sep 2026 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789655704; bh=mobytS+1K2rkJCeo1bg8kHuJ2xKRSO5VB5xXMn9bBS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iqHXQy1JB2qQbP3MjChIwmtzj+93Umn86ZBQsDSTZGKWutkkKFuWxAmMh4B7G882X
	 t49S9TiQH/OuzPpJBUWpvJugzd9EYUqw5JPodoZqA2xm0egrEQGISGahSQQIcAPjYi
	 b6b5wjWLuz+I6I/cz1LfWsLlsqLcc06ls9uP3LJw=
Message-ID: <bddc9273-fe02-4984-bfe9-5078e9e6e111@arm.com>
Date: Thu, 17 Sep 2026 16:34:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arch_topology: use the boost frequencies for
 capacity_freq_ref
To: Oleg Keri <okerixx@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Sumit Gupta <sumitg@nvidia.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org
References: <20260917125112.2283-1-okerixx@gmail.com>
 <20260917125112.2283-3-okerixx@gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260917125112.2283-3-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.09.26 14:51, Oleg Keri wrote:
> capacity_freq_ref is latched from policy->cpuinfo.max_freq by
> init_cpu_capacity_callback() on CPUFREQ_CREATE_POLICY.
> cpufreq_frequency_table_cpuinfo() excludes CPUFREQ_BOOST_FREQ entries
> while boost is disabled, so on a system that boots with boost off the
> reference is the non-boost maximum and stays there.
> 
> Once boost is enabled the CPU runs above its reference.  On arm64, where
> the AMU drives frequency invariance, amu_scale_freq_tick() caps the scale
> at SCHED_CAPACITY_SCALE, so the scheduler cannot tell a boosted CPU from
> one at the sustained maximum, and arch_freq_get_on_cpu() cannot report
> above the reference, so cpuinfo_avg_freq is pinned to it.
> 
> CPPC based systems do not have the problem: their reference comes from
> highest_perf, and a disabled boost shows up as cpufreq pressure.  Do the
> same for frequency table drivers and take the highest valid table entry,
> boost entries included, as the reference.  With boost off
> cpufreq_update_pressure() then reports the difference as pressure.

Ah, you want to fix this for 'frequency table' drivers.

IMHO,
https://lore.kernel.org/r/20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com
is trying the same at the moment.

[...]
