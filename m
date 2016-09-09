From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Fri, 09 Sep 2016 23:57:21 +0200
Message-ID: <21371892.ALJNnHKoBY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Everyone,

This is a new iteration of the "iowait boost" series.

The first two patches (adding the SCHED_CPUFREQ_IOWAIT flag and changing
schedutil to use it) don't seem to be controversial, so they go unchanged
(not RFC any more though) and the only difference is the intel_pstate
part.

Since we still get some unconclusive results with the new algorithm
for Core processors, patch [3/3] in this series modifies the Atom
algorithm to use SCHED_CPUFREQ_IOWAIT instead of the get_cpu_iowait_time_us()
interface (which isn't particularly reliable) as the first step.

Going forward we would like to modify intel_pstate to select P-states
proportional to utilization (with IOwait boosting and possibly some other
tweaks) on all processors, but there still are some factors to determine
in that area, so let's make this simple change to start with.

Thanks,
Rafael
