From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 00/10] arm, arm64, cpufreq: frequency- and
 cpu-invariant accounting support for task scheduler
Date: Wed, 4 Oct 2017 10:41:14 +0200
Message-ID: <20171004084114.GA6547@kroah.com>
References: <20170926164115.32367-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdJDIlG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 04:41:06 -0400
Content-Disposition: inline
In-Reply-To: <20170926164115.32367-1-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

On Tue, Sep 26, 2017 at 05:41:05PM +0100, Dietmar Eggemann wrote:
> For a more accurate (i.e. frequency- and cpu-invariant) accounting
> the task scheduler needs a frequency-scaling and on a heterogeneous
> system a cpu-scaling correction factor.
> 
> This patch-set implements a Frequency Invariance Engine (FIE)
> based on the ratio of current frequency and maximum supported frequency
> (topology_get_freq_scale()) in the arch topology driver (arm, arm64) to
> provide such a frequency-scaling correction factor.
> This is a solution to get frequency-invariant accounting support for
> platforms without hardware-based performance tracking.
> 
> The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
> cpu-scaling correction factor was already introduced by the "Fix issues
> and factorize arm/arm64 capacity information code" patch-set [1] which
> went into v4.13.
> 
> This patch-set also enables the frequency- and cpu-invariant accounting
> support. Enabling here means to associate (wire) the task scheduler
> function name arch_scale_freq_capacity and arch_scale_cpu_capacity with
> the FIE and CIE function names from drivers/base/arch_topology.c. This
> replaces the scheduler's default FIE and CIE in kernel/sched/sched.h.
> 
> v4: review results:
> 
> There were no further comments during the v4 [2] review.

This patchset crosses a bunch of different subsystems, who do you
want/expect to be taking this through their tree?

thanks,

greg k-h
