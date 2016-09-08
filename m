From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Thu, 08 Sep 2016 03:15:49 +0200
Message-ID: <1871376.PL6g3cMFjd@vostro.rjw.lan>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan> <3823270.hR1Z92UVHK@vostro.rjw.lan> <1473295771.154359.44.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55509 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751580AbcIHBJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 21:09:55 -0400
In-Reply-To: <1473295771.154359.44.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Wednesday, September 07, 2016 05:49:31 PM Srinivas Pandruvada wrote:
> On Thu, 2016-09-08 at 02:44 +0200, Rafael J. Wysocki wrote:
> > On Wednesday, September 07, 2016 05:35:50 PM Srinivas Pandruvada
> > wrote:
> > > 
> > > On Wed, 2016-09-07 at 17:22 -0700, Steve Muckle wrote:
> > > > 
> > > > On Sat, Sep 03, 2016 at 02:56:48AM +0200, Rafael J. Wysocki
> > > > wrote:
> > > > > 
> > > > > 
> > > > > Please let me know what you think and if you can run some
> > > > > benchmarks you
> > > > > care about and see if the changes make any difference (this way
> > > > > or
> > > > > another),
> > > > > please do that and let me know what you've found.
> > > > 
> > > > LGTM (I just reviewed the first and last patch, skipping the
> > > > intel_pstate ones).
> > > > 
> > > > I was unable to see a conclusive power regression in Android
> > > > audio,
> > > > video or
> > > > idle usecases on my hikey 96board.
> > > Did you see any performance regression on Android workloads?
> > 
> > That's with schedutil and IOwait boost.  Why would performance
> > regress?
> Some Android tests reach thermal limits and aggressive throttling
> causes performance issues. 

I see, OK.

Thanks,
Rafael

