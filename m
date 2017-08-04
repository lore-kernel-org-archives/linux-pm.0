From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 00/10] arm, arm64, cpufreq: frequency- and
 cpu-invariant accounting support for task scheduler
Date: Fri, 4 Aug 2017 18:38:43 +0100
Message-ID: <6dec7b60-e262-67ab-d29e-8537085dadcd@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdHDRir (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Aug 2017 13:38:47 -0400
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi Rafael,

On 27/07/17 20:33, Dietmar Eggemann wrote:

[...]

> Patch high level description:
> 
>    [   01/10] Fix to free cpumask cpus_to_visit
>    [   02/10] Default (empty, weak) arch_set_freq_scale() implementation
>    [03,04/10] Call arch_set_freq_scale() from two cpufreq drivers
>               (arm_big_little and cpufreq-dt)

Could you please have a look at patches 2-4 which touch the cpufreq
subsystem.

Thanks,

-- Dietmar

[....]
