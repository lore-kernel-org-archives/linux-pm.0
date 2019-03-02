From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Sat, 02 Mar 2019 08:24:54 -0800
Message-ID: <426011fc8925a3fd27737f22d39ea6fc04c67404.camel@linux.intel.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
         <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
         <20190302103008.GA7086@chenyu-office.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302103008.GA7086@chenyu-office.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 2019-03-02 at 18:30 +0800, Yu Chen wrote:
> On Fri, Mar 01, 2019 at 09:39:27AM -0800, Srinivas Pandruvada wrote:
> > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > This is how I would fix the issue reported in BZ 200759 (see this
> > > patch series
> > > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > .
> > > 
> > > Patch [1/2] causes intel_pstate to update all policies if it gets
> > > a
> > > _PPC change
> > > notification and sees a global turbo disable/enable change.
> > > 
> > > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > > those cases.
> > > 
> > > The patches here have not been tested yet, so testing would be
> > > much
> > > appreciated.
> > > 
> > > Of course, comments are welcome too!
> > 
> > This is the only platform, someone reported such issue.
> > Can we solve this by some udev rules and offline/online cpu 1-3 on
> > power source change?
> > 
> 
> Sound reasonable, we can deal with this BIOS problem in user space
> too. But if cpu0 could not be offline, how could cpu0's policy
> be updated?
I thought CPU0 is not a problem as the _PPC is sent on this and
policies gets updated from the following log.

# Unplug

[   25.775643] CPU 0: _PPC is 6 - frequency  limited
[   25.775660] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 
1700000
[   25.775666] intel_pstate: cpu:0 max_state 17 min_policy_perf:8
max_policy_perf:17
[   25.775670] intel_pstate: cpu:0 global_min:8 global_max:30
[   25.775674] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8

"REDUCED FREQUENCY ABOVE AFTER UNPLUG"


# Re-plug

[   36.979264] CPU 0: _PPC is 6 - frequency  limited
[   36.979276] intel_pstate: policy->max > max non turbo frequency
[   36.979280] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 
3000000
[   36.979283] intel_pstate: cpu:0 max_state 30 min_policy_perf:8
max_policy_perf:30
[   36.979286] intel_pstate: cpu:0 global_min:8 global_max:30
[   36.979289] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8

Thanks,
Srinivas

> 
> Thanks,
> Yu
> 
> > There are examples of changing governors on power source change.
> > https://bbs.archlinux.org/viewtopic.php?id=207186
> > 
> > Here instead of changing governor just
> > echo 0 > /sys/devices/system/cpu/cpu1/online
> > echo 1 > /sys/devices/system/cpu/cpu1/online
> > echo 0 >
> > /sys/devices/system/cpu/cpu2/online
> > echo 1 >
> > /sys/devices/system/cpu/cpu2/online
> > echo 0 >
> > /sys/devices/system/cpu/cpu3/online
> > echo 1 >
> > /sys/devices/system/cpu/cpu3/online
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > Thanks,
> > > Rafael
> > > 
