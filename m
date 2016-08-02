From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access
 utilization data directly
Date: Tue, 2 Aug 2016 07:28:43 -0700
Message-ID: <20160802142843.GF9332@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <9887668.FEg7fVruKQ@vostro.rjw.lan>
 <20160801192850.GX19455@graphite.smuckle.net>
 <5472075.XX6bKsbQPI@vostro.rjw.lan>
 <20160802103817.GZ22472@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160802103817.GZ22472@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 02, 2016 at 11:38:17AM +0100, Juri Lelli wrote:
> > > Anyway one way that my patch differed was that I had used the flags
> > > field to keep the behavior the same for both RT and DL.
> 
> Do you mean "go to max" policy for both, until proper policies will be
> implemented in the future?

Yep.

> > That happens
> > > later on in this series for RT but the DL policy is modified as above.
> > > Can the DL policy be left as-is and discussed/modified in a separate
> > > series?
> 
> Not that we want to start discussing this point now, if we postpone the
> change for later, but I just wanted to point out a difference w.r.t.
> what the schedfreq thing was doing: it used to sum contributions from
> the different classes, instead of taking the max. We probably never
> really discussed on the list what is the right thing to do, though.

Yeah I figured that was worth deferring into its own patchset/thread.

cheers,
Steve
