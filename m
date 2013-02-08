From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq Fixes for 3.9
Date: Fri, 8 Feb 2013 11:02:01 +0530
Message-ID: <CAKohpokNg5KdTjR3JqMVZSw0=Rkqk+YMf5XpAimaXBRFsbFtiQ@mail.gmail.com>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
	<2896238.eRV3G7kyl2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2896238.eRV3G7kyl2@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: valdis.kletnieks@vt.edu, artem.savkov@gmail.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On 8 February 2013 05:03, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> I should have done that before, sorry about it.

np

> Can you please rework this series on top of linux-pm.git/pm-cpufreq and
> try to avoid introducing new issues this time?

Sorry for this. I didn't got any such issues on my system and i tried to think
as widely as possible. But still just a human with some mistakes :)

> If this works, we'll rebase all of the other new material on top of it,
> if possible.

To make your life a bit easy, i have got all cpufreq patches, that you & me
have got for 3.9, rebased over pm-cpufreq and these are:

f3843e0 cpufreq: exynos: simplify .init() for setting policy->cpus
7ea6658 cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
6002fd0 cpufreq/x86: Add P-state driver for sandy bridge.
bcfe254 cpufreq_stats: do not remove sysfs files if frequency table is
not present
6c82b96 cpufreq: Do not track governor name for scaling drivers with
internal governors.
2a6df07 cpufreq: Only call cpufreq_out_of_sync() for driver that
implement cpufreq_driver.target()
0893112 cpufreq: Retrieve current frequency from scaling drivers with
internal governors
e034e73 cpufreq: Fix locking issues
003da79 cpufreq: Create a macro for unlock_policy_rwsem{read,write}
0092c75 cpufreq: Remove unused HOTPLUG_CPU code
34d5833 cpufreq: governors: Fix WARN_ON() for multi-policy platforms
e1ee7c8 cpufreq: Convert the cpufreq_driver_lock to use RCU
e076b60 cpufreq: Convert the cpufreq_driver_lock to a rwlock
6d919f9 cpufreq: ondemand: Replace down_differential tuner with adj_up_threshold
80dd878 cpufreq / stats: Get rid of CPUFREQ_STATDEVICE_ATTR
a7e183d cpufreq: Don't check cpu_online(policy->cpu)
9db0116 cpufreq: add imx6q-cpufreq driver


I have pushed them in for-rafael branch in my repo. Look carefully at
the first two patches,
they were not present in your latest repo.

This was the exynos patch i was talking about:

f3843e0 cpufreq: exynos: simplify .init() for setting policy->cpus

I don't know if you dropped this one or what ?

7ea6658 cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
