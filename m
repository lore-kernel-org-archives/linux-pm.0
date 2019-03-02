From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Sat, 2 Mar 2019 18:30:08 +0800
Message-ID: <20190302103008.GA7086@chenyu-office.sh.intel.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 01, 2019 at 09:39:27AM -0800, Srinivas Pandruvada wrote:
> On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This is how I would fix the issue reported in BZ 200759 (see this
> > patch series
> > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
> > 
> > Patch [1/2] causes intel_pstate to update all policies if it gets a
> > _PPC change
> > notification and sees a global turbo disable/enable change.
> > 
> > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > those cases.
> > 
> > The patches here have not been tested yet, so testing would be much
> > appreciated.
> > 
> > Of course, comments are welcome too!
> 
> This is the only platform, someone reported such issue.
> Can we solve this by some udev rules and offline/online cpu 1-3 on
> power source change?
>
Sound reasonable, we can deal with this BIOS problem in user space
too. But if cpu0 could not be offline, how could cpu0's policy
be updated?

Thanks,
Yu

> There are examples of changing governors on power source change.
> https://bbs.archlinux.org/viewtopic.php?id=207186
> 
> Here instead of changing governor just
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> echo 0 >
> /sys/devices/system/cpu/cpu2/online
> echo 1 >
> /sys/devices/system/cpu/cpu2/online
> echo 0 >
> /sys/devices/system/cpu/cpu3/online
> echo 1 >
> /sys/devices/system/cpu/cpu3/online
> 
> Thanks,
> Srinivas
> 
> > 
> > Thanks,
> > Rafael
> > 
> 
