From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 00/10] arm, arm64, cpufreq: frequency- and
 cpu-invariant accounting support for task scheduler
Date: Wed, 4 Oct 2017 14:28:04 +0200
Message-ID: <CAJZ5v0g6MidVErfSmtbguuR6nUzV25z3+ZcDMOrcW5hpim0xDQ@mail.gmail.com>
References: <20170926164115.32367-1-dietmar.eggemann@arm.com> <20171004084114.GA6547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004084114.GA6547@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 4, 2017 at 10:41 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 26, 2017 at 05:41:05PM +0100, Dietmar Eggemann wrote:
>> For a more accurate (i.e. frequency- and cpu-invariant) accounting
>> the task scheduler needs a frequency-scaling and on a heterogeneous
>> system a cpu-scaling correction factor.
>>
>> This patch-set implements a Frequency Invariance Engine (FIE)
>> based on the ratio of current frequency and maximum supported frequency
>> (topology_get_freq_scale()) in the arch topology driver (arm, arm64) to
>> provide such a frequency-scaling correction factor.
>> This is a solution to get frequency-invariant accounting support for
>> platforms without hardware-based performance tracking.
>>
>> The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
>> cpu-scaling correction factor was already introduced by the "Fix issues
>> and factorize arm/arm64 capacity information code" patch-set [1] which
>> went into v4.13.
>>
>> This patch-set also enables the frequency- and cpu-invariant accounting
>> support. Enabling here means to associate (wire) the task scheduler
>> function name arch_scale_freq_capacity and arch_scale_cpu_capacity with
>> the FIE and CIE function names from drivers/base/arch_topology.c. This
>> replaces the scheduler's default FIE and CIE in kernel/sched/sched.h.
>>
>> v4: review results:
>>
>> There were no further comments during the v4 [2] review.
>
> This patchset crosses a bunch of different subsystems, who do you
> want/expect to be taking this through their tree?

Dietmar asked me and I can handle it it that's not an issue.

Thanks,
Rafael
