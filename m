From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2 2/8] cpuidle: record the overhead of idle entry
Date: Tue, 17 Oct 2017 02:05:39 +0200
Message-ID: <10643458.iWc7GTROAz@aspire.rjw.lan>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com> <2672521.fEEa1b19Vu@aspire.rjw.lan> <6f17f378-defc-c668-de00-250da5c41b87@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f17f378-defc-c668-de00-250da5c41b87@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, October 16, 2017 5:11:57 AM CEST Li, Aubrey wrote:
> On 2017/10/14 8:35, Rafael J. Wysocki wrote:
> > On Saturday, September 30, 2017 9:20:28 AM CEST Aubrey Li wrote:
> >> Record the overhead of idle entry in micro-second
> >>
> > 
> > What is this needed for?
> 
> We need to figure out how long of a idle is a short idle and recording
> the overhead is for this purpose. The short idle threshold is based
> on this overhead.

I don't really understand this statement.

Pretent I'm not familiar with this stuff and try to explain it to me. :-)

> > 
> >> +void cpuidle_entry_end(void)
> >> +{
> >> +	struct cpuidle_device *dev = cpuidle_get_device();
> >> +	u64 overhead;
> >> +	s64 diff;
> >> +
> >> +	if (dev) {
> >> +		dev->idle_stat.entry_end = local_clock();
> >> +		overhead = div_u64(dev->idle_stat.entry_end -
> >> +				dev->idle_stat.entry_start, NSEC_PER_USEC);
> > 
> > Is the conversion really necessary?
> > 
> > If so, then why?
> 
> We can choose nano-second and micro-second. Given that workload results
> in the short idle pattern, I think micro-second is good enough for the
> real workload.
> 
> Another reason is that prediction from idle governor is micro-second, so
> I convert it for comparing purpose.
> > 
> > And if there is a good reason, what about using right shift to do
> > an approximate conversion to avoid the extra division here?
> 
> Sure >> 10 works for me as I don't think here precision is a big deal.
> 
> > 
> >> +		diff = overhead - dev->idle_stat.overhead;
> >> +		dev->idle_stat.overhead += diff >> 3;
> > 
> > Can you please explain what happens in the two lines above?
> 
> Online average computing algorithm, stolen from update_avg() @ kernel/sched/core.c.

OK

Maybe care to add a comment to that effect?

Thanks,
Rafael
