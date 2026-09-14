Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FC47D464;
	Mon, 14 Sep 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403279; cv=none; b=KkQH2ZAWEHFQiyFdaElhKR4Hht5CWVss6Pyk4oXZ49xwSrIHPsk/62fWwhEw9j6tats5jCo87hIo8sIGmeddQecKURcgolMBQrU9M4n8aSZJwluIAGmRWt1ts5fuEVI3MU9qgw6cV/fRVAft2XUde+A7B5tNK16Qoh+jGTZNOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403279; c=relaxed/simple;
	bh=sQY0TThHghxIfp8KboBCBc75srHSsUEv16U815Yfydc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0dHnZE2AQ9PUdYoqu3YLcFuX2k5Sys/l204V1EqVL2sIpv+k83TcI4tSDTahvANHTWnA4NXYGHiqsSimDMST/KbWgZQtx8D7mMJtGteJZz0nTvftjR8g61yRe/L2A5Dz8leDJwTP8lKTRpPCmcS9BeVKFyUkrQ4CDFk7lH1+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cirAC4FG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cirAC4FG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702B8152B;
	Mon, 14 Sep 2026 09:27:53 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0413F86F;
	Mon, 14 Sep 2026 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789403277; bh=sQY0TThHghxIfp8KboBCBc75srHSsUEv16U815Yfydc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cirAC4FGrhJGYPUG7XRJUMiRncb9Y005W8jPcrGLfGenZTt1KgfL+E8HJKSuuju9E
	 nIPVRvh0KVqF82Dw4FPp8YPTT9z8V5Web9prKX60NeRf0sQQ4BnFcXKidrufjeoMoT
	 JVLNjGEK3cV0C//IxzagPJYj+bf+79c0SJzSt1Kc=
Message-ID: <2f7f671e-eace-4a6b-8a0b-20151f81d34d@arm.com>
Date: Mon, 14 Sep 2026 18:27:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sched/cpufreq: fix schedutil's boost frequency
 handling
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-pm@vger.kernel.org
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.09.26 10:30, Ananthu C V wrote:
> Schedutil's ability to reach boost frequencies depends on two values
> being correct: policy max, which caps the resolved target frequency,
> and the per-CPU capacity frequency reference, which anchors the
> utilization-to-frequency mapping.
> 
> This series fixes a few gaps in how these values are maintained across
> boost transitions:
> 
> The per-CPU capacity frequency reference is set once at policy
> creation and never updated when boost is enabled afterwards, leaving
> schedutil unable to target boost frequencies even at full utilization.
> Track the max available (boost inclusive) frequency before policy
> comes online and use it to seed the capacity_freq_ref value, allowing
> schedutil to utilize the boost frequency values when boost is enabled
> later.
> 
> The generic boost callback only raises cpuinfo max, never lowers it.
> Once boost is enabled, disabling it leaves cpuinfo max pinned at the
> boost ceiling, keeping policy max stuck there too. Also track the max
> available non-boost frequency and use the newly tracked max values to
> control boost frequencies when a frequency table is available, allowing
> the frequency to drop back to non boost values on boost disable. In
> the absense of a frequency table, the handling will fall back to using
> cpuinfo->max_freq, preserving the current behaviour.
> 
> Logs below for clear context:
> Intermediate values from the time_in_state output and logs from bench
> runs are truncated for brevity.
> 
> Before fix
> ----------
> 
> boost  policy0  policy12  policy6
> 
> 0
> 
> 4454400
> 
> 4723200
> 
> 4723200
> 
> 355200 36958
> 4454400 650
> 4588800 0
> 4723200 0
> 
> After fix
> ---------
> 
> boost  policy0  policy12  policy6
> 
> 0
> 
> 4454400
> 
> 4723200
> 
> 4454400
> 
> 0
> 
> 355200 40147
> 4454400 79
> 4588800 0
> 4723200 0
> 
> 355200 44834
> 4454400 93
> 4588800 25
> 4723200 569
> 
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---
> Ananthu C V (2):
>       arch_topology: seed capacity_freq_ref with boost-aware max freq
>       cpufreq: fix schedutil not returning to non-boost freq when boost is disabled
> 
>  drivers/base/arch_topology.c |  3 ++-
>  drivers/cpufreq/cpufreq.c    | 14 +++++++++++++-
>  drivers/cpufreq/freq_table.c | 11 +++++++++++
>  include/linux/cpufreq.h      |  2 ++
>  4 files changed, 28 insertions(+), 2 deletions(-)
> ---
> base-commit: 32b6ef9a5d0eca44f9cd91f52f4faa89f145a0de
> change-id: 20260804-schedutil-boost-frequency-handling-8e6bf2387a4a
IMHO, this makes sense, also the coordination via cpufreq_pressure
(policy->max).

On ARM64 Juno R0:

# cat /sys/devices/system/cpu/cpu*/cpu_capacity
446
1024
1024
446
446
446

# cat /sys/devices/system/cpu/cpufreq/boost
0

cat
/sys/devices/system/cpu/cpu{0,1}/cpufreq/scaling_{available,boost}_frequencies
450000 575000 700000
775000 850000
450000 625000 800000
950000 1100000

# cat /sys/devices/system/cpu/cpu{0,1}/cpufreq/cpuinfo_{min,max}_freq
450000
700000
450000
800000

# dmsg | grep policy

[3.323564] cpufreq_update_pressure(): policy->related_cpus=[0,3-5]
policy->max=700000 pressure=102                                      (*)
[3.333206] cpufreq_update_pressure(): policy->related_cpus=[1-2]
policy->max=800000 pressure=280


# echo 1 > /sys/devices/system/cpu/cpufreq/boost

# dmsg | grep policy

[ 1511.188932] policy->related_cpus=[1-2] pressure=0
[ 1511.189050] policy->related_cpus=[0,3-5] pressure=0

# echo 0 > /sys/devices/system/cpu/cpufreq/boost

# dmsg | grep policy

[  204.951039] cpufreq_update_pressure(): policy->related_cpus=[1-2]
policy->max=800000 pressure=280
[  204.951223] cpufreq_update_pressure(): policy->related_cpus=[0,3-5]
policy->max=700000 pressure=79                                       (*)

(*) This is the only small issue I see. The pressure=102 is pressure
based on purely uarch differences (max_capacity(0,3-5)=578) whereas
pressure=79 later is based on uarch + max frequency differences
(max_capacity(0,3-5)=446).
