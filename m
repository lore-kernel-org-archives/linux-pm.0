From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC][PATCH 1/7] cpufreq / sched: Make schedutil access
 utilization data directly
Date: Tue, 2 Aug 2016 15:43:43 +0100
Message-ID: <20160802144343.GC22472@e106622-lin>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <9887668.FEg7fVruKQ@vostro.rjw.lan>
 <20160801192850.GX19455@graphite.smuckle.net>
 <5472075.XX6bKsbQPI@vostro.rjw.lan>
 <20160802103817.GZ22472@e106622-lin>
 <20160802142843.GF9332@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39960 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934417AbcHBOue (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 10:50:34 -0400
Content-Disposition: inline
In-Reply-To: <20160802142843.GF9332@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On 02/08/16 07:28, Steve Muckle wrote:
> On Tue, Aug 02, 2016 at 11:38:17AM +0100, Juri Lelli wrote:
> > > > Anyway one way that my patch differed was that I had used the flags
> > > > field to keep the behavior the same for both RT and DL.
> > 
> > Do you mean "go to max" policy for both, until proper policies will be
> > implemented in the future?
> 
> Yep.
> 

OK, thanks for clarifying.

> > > That happens
> > > > later on in this series for RT but the DL policy is modified as above.
> > > > Can the DL policy be left as-is and discussed/modified in a separate
> > > > series?
> > 
> > Not that we want to start discussing this point now, if we postpone the
> > change for later, but I just wanted to point out a difference w.r.t.
> > what the schedfreq thing was doing: it used to sum contributions from
> > the different classes, instead of taking the max. We probably never
> > really discussed on the list what is the right thing to do, though.
> 
> Yeah I figured that was worth deferring into its own patchset/thread.
> 

Right. Makes sense to me to defer this point.

Best,

- Juri
