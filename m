From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in
 intel_pstate and schedutil
Date: Thu, 08 Sep 2016 10:30:54 -0700
Message-ID: <1473355854.154359.60.camel@linux.intel.com>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
         <1473295771.154359.44.camel@linux.intel.com>
         <1871376.PL6g3cMFjd@vostro.rjw.lan> <2303537.JZt6x46p7y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16937 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752787AbcIHRa4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Sep 2016 13:30:56 -0400
In-Reply-To: <2303537.JZt6x46p7y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Thu, 2016-09-08 at 17:02 +0200, Rafael J. Wysocki wrote:
> On Thursday, September 08, 2016 03:15:49 AM Rafael J. Wysocki wrote:
> > 
> > On Wednesday, September 07, 2016 05:49:31 PM Srinivas Pandruvada
> > wrote:
> > > 
> > > On Thu, 2016-09-08 at 02:44 +0200, Rafael J. Wysocki wrote:
> > > > 
> > > > On Wednesday, September 07, 2016 05:35:50 PM Srinivas
> > > > Pandruvada
> > > > wrote:
> > > > > 
> > > > > 
> > > > > On Wed, 2016-09-07 at 17:22 -0700, Steve Muckle wrote:
> > > > > > 
> > > > > > 
> > > > > > On Sat, Sep 03, 2016 at 02:56:48AM +0200, Rafael J. Wysocki
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > Please let me know what you think and if you can run some
> > > > > > > benchmarks you
> > > > > > > care about and see if the changes make any difference
> > > > > > > (this way
> > > > > > > or
> > > > > > > another),
> > > > > > > please do that and let me know what you've found.
> > > > > > 
> > > > > > LGTM (I just reviewed the first and last patch, skipping
> > > > > > the
> > > > > > intel_pstate ones).
> > > > > > 
> > > > > > I was unable to see a conclusive power regression in
> > > > > > Android
> > > > > > audio,
> > > > > > video or
> > > > > > idle usecases on my hikey 96board.
> > > > > Did you see any performance regression on Android workloads?
> > > > 
> > > > That's with schedutil and IOwait boost.  Why would performance
> > > > regress?
> > > Some Android tests reach thermal limits and aggressive throttling
> > > causes performance issues. 
> > 
> > I see, OK.
> 
> But in that case Steve would see a power regression as well IMO.
>   It would
> be rather difficult to reach thermal limits without consuming more
> energy,
> wouldn't it? :-)
Yes. It depends on workloads. Idle and AV tests which tend to use HW
encoding/decoding don't stress CPU enough in my experience. May be
something like CPU Mark or Disk mark score.

Anyway this shouldn't be a reason for not including a change.

Thanks,
Srinivas

> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
