From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Date: Tue, 17 Jul 2018 11:05:49 +0200
Message-ID: <20180717090549.pbhpua443yqguyhy@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180717081507.GS2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717081507.GS2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 10:15:07AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 08:50:48AM +0200, Andreas Herrmann wrote:
> > I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
> > idle state before stopping the tick") causes severe performance drop
> > for systems using pcc-cpufreq driver. Depending on the number of CPUs
> > the system might be almost unusable. 
> 
> Have you looked at that driver? It features a global lock which is taken
> for all cpufreq operations. Once you get past a handful of cpus that
> will constrict your system exactly as you say.

Yes, I figured that already and you better use another cpufreq driver
on those systems. (But that such systems with this driver are almost
unusable is a new feature ;-)

> What kind of machine are you running this on, and can you configure the
> thing to use anything else?

Its an older system.

HP ProLiant DL580 Gen8, CPUs are Intel(R) Xeon(R) CPU E7-4890
4 nodes, With HT enabled 120 logical CPUs.

Yes you can configure it using something else.

For the record. On this and similar systems pcc-cpufreq driver is used
when BIOS setting for power management option "Power Regulator" is set
to

  "Dynamic Power Savings Mode"

AFAIK this is the default setting for this option. When changing this
setting to "OS Control Mode" intel_pstate driver should be loaded.

> If so, do so and never look back.

Ok, I am fine with this.


Thanks,

Andreas
