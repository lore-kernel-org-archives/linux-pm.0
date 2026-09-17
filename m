Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AD4BD7BD;
	Thu, 17 Sep 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639091; cv=none; b=fiwNQEolMe694V6UgTAJQt+fF0Ad3fwSVxchrO9IDWv2jqi2OxgBkOrvswbedeuDoYswY++d980HEsUOneO+MCrIvP1GrxxokqRTGxPKTRBNgDcklW5E0qxjXEErXblk+IXzCuHNoKpjaol5K9aLUb5KdtAiZ2u6GZ3CWIPqfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639091; c=relaxed/simple;
	bh=VXqLon1IWeQzTI8dDj4hKxc7saHoW6A0Hg3046jh/QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX0Hulh9cBnqhj/pkmqtyjNaC9FK8gwPNv2MPWllPbZ3WcWL+0oK3pSWQs45Nd4MLzIAy60TUfGkPVKqaB1sL0PKY1zz4u6kCJFj7vQQPLUHJhSJ6IXftz3DjoEOUAuzD9vPkrYEEoqEE3K1iK5wk1LZ1qeCQqjRkUbqdc52wpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vja3M8VA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vja3M8VA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CA91476;
	Thu, 17 Sep 2026 02:57:58 -0700 (PDT)
Received: from [10.57.74.102] (unknown [10.57.74.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD88E3F7B4;
	Thu, 17 Sep 2026 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789639082; bh=VXqLon1IWeQzTI8dDj4hKxc7saHoW6A0Hg3046jh/QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vja3M8VABVOrmZ2ChYzc/upsrhetTGKhEnf/pEqYK+HiSbSu/clHPeW+o3eKoIK4Z
	 0+Wx3stikCeAmbXeqVmEvNHb/v78HBmo4ovtzTcV7kdJ1PuFCDwMqvcvyMeHDTyFTu
	 Uj8E/utZDL2YEdMx2GCJKyelvgXqlKah9PS1wewY=
Message-ID: <f8b0745c-d265-4112-90fe-79a08ad01553@arm.com>
Date: Thu, 17 Sep 2026 11:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: update capacity_freq_ref when the boost
 state changes
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
 <20260910063440.4677-3-okerixx@gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260910063440.4677-3-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.26 08:34, Oleg Keri wrote:
> capacity_freq_ref is latched from policy->cpuinfo.max_freq by
> init_cpu_capacity_callback() on CPUFREQ_CREATE_POLICY, and never
> updated afterwards.
> 
> cpufreq_frequency_table_cpuinfo() excludes CPUFREQ_BOOST_FREQ entries
> while boost is disabled, so on a system that boots with boost off the
> latched value is the non-boost maximum.  Enabling boost later raises
> policy->cpuinfo.max_freq but leaves capacity_freq_ref behind.
> 
> Two things then go wrong on arm64, where the AMU drives frequency
> invariance.  amu_scale_freq_tick() caps the computed scale at
> SCHED_CAPACITY_SCALE, so a CPU running above capacity_freq_ref
> saturates at 1024: the scheduler cannot tell a boosted CPU from one at
> the sustained maximum, and utilisation is underestimated.  And

IMHO, this is where the concept of 'cpufreq pressure' on CPU capacity
comes in.

The cpu_capacity value is calculated based on highest_perf.	(1)

In case you start with 'boost == 0' nominal_perf might might be lower
than highest_perf.

cpufreq_update_pressure() calculates this value:

cpufreq_pressure = Cmax * (1 - fcapped - fmax)			(2)

[ fcapped = policy->max, fmax = capacity_freq_ref ]

Example on RADXA Orion 06 CPU10:

$ grep . /sys/devices/system/cpu/cpu10/acpi_cppc/*
...
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:7876
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:800
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:2520
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:2520
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2500
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:6600   <-- hacked
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:1000
...

# cat /sys/devices/system/cpu/cpu10/cpu_capacity	<-- (1)
984

# cat /sys/devices/system/cpu/cpu10/cpufreq/boost
0

dmesg (added log)

[    8.065337] cpufreq_update_pressure(): policy->related_cpus=[10-11]
policy->max=2500000 pressure=173			<-- (2)

# echo 1 > /sys/devices/system/cpu/cpufreq/boost

# cat /sys/devices/system/cpu/cpu10/cpufreq/boost
1

dmesg (added log)

[38137.194134] cpufreq_update_pressure(): policy->related_cpus=[10-11]
policy->max=3031666 pressure=0				<-- (2)

The task scheduler gets informed via:

get_actual_cpu_capacity(int cpu)

  capacity = arch_scale_cpu_capacity(cpu);

  capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
                                            ^^^^^^^^^^^^^^^^^^^^
  return capacity;

[...]
