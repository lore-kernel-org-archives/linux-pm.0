From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 0/7] cpufreq / sched: cpufreq_update_util() flags and iowait boosting
Date: Mon, 08 Aug 2016 15:01:04 +0200
Message-ID: <2893698.pXQui9Dkv5@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <2815658.F6xEHcjr3t@vostro.rjw.lan> <20160808110822.GC6879@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160808110822.GC6879@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Doug Smythies <dsmythies@telus.net>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 08, 2016 01:08:22 PM Peter Zijlstra wrote:
> On Mon, Aug 01, 2016 at 06:30:27PM +0200, Rafael J. Wysocki wrote:
> > >  CPU_FREQ_GOV_SCHEDUTIL m -> y
> 
> > > ERROR: "runqueues" [kernel/sched/cpufreq_schedutil.ko] undefined!
> 
> > There are some export_symbol declarations missing, I'll fix that up.
> 
> Do you really need that thing to be a module? I would raelly like to not
> export runqueues. People have had 'crazy' ideas in the past.

It doesn't have to be a module, but it is today.

Well, I guess accessing scheduler data directly is a good enough resone for
making it non-modular. :-)

Thanks,
Rafael
