From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 00/10] arm, arm64, cpufreq: frequency- and
 cpu-invariant accounting support for task scheduler
Date: Wed, 2 Aug 2017 14:04:00 +0100
Message-ID: <2a215872-d6fe-b4fc-3cf7-c9e11358dac2@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Russell,

On 27/07/17 20:33, Dietmar Eggemann wrote:

[...]

> Patch high level description:
> 
>    [   01/10] Fix to free cpumask cpus_to_visit
>    [   02/10] Default (empty, weak) arch_set_freq_scale() implementation
>    [03,04/10] Call arch_set_freq_scale() from two cpufreq drivers
>               (arm_big_little and cpufreq-dt)
>    [   05/10] FIE
>    [   06/10] Allow CIE inlining
>    [07,08/10] Enable frequency- and cpu-invariant accounting on arm

Would you have time to review patch 7 and 8. I already got an Acked-by
from the ARM64 maintainer for the arm64 related counterpart functionality.

Thanks,

-- Dietmar

[...]
