From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Fri, 31 Mar 2017 08:26:52 +0100
Message-ID: <20170331072652.GJ19929@e106622-lin>
References: <20170324140900.7334-1-juri.lelli@arm.com>
 <1721120.3Th1GMboUn@aspire.rjw.lan>
 <cfffdfdd5251ae7921f65d1e0360a289@codeaurora.org>
 <2683548.WpoELJxfrb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932564AbdCaH07 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Mar 2017 03:26:59 -0400
Content-Disposition: inline
In-Reply-To: <2683548.WpoELJxfrb@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vikram Mulukutla <markivx@codeaurora.org>, Mark Brown <broonie@kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, linux-kernel-owner@vger.kernel.org

On 30/03/17 22:22, Rafael J. Wysocki wrote:
> On Thursday, March 30, 2017 08:50:11 AM Vikram Mulukutla wrote:
> > 
> > > OK
> > > 
> > > So there are two pieces here.
> > > 
> > > One is that if we want *all* drivers to work with schedutil, we need to 
> > > keep
> > > the kthread for the ones that will never be reworked (because nobody 
> > > cares
> > > etc).  But then perhaps the kthread implementation may be left alone 
> > > (because
> > > nobody cares etc).
> > > 
> > > The second one is that there are drivers operating in-context that work 
> > > with
> > > schedutil already, so I don't see major obstacles to making more 
> > > drivers work
> > > that way.  That would be only a matter of reworking the drivers in 
> > > question.
> > > 
> > > Thanks,
> > > Rafael
> > 
> > There are some MSM platforms that do need a kthread and would love to 
> > use
> > schedutil. This is all mainly due to the point that Vincent raised; 
> > having
> > to actually wait for voltage transitions before clock switches. I can't
> > speak about the future, but that's the situation right now. Leaving the
> > kthread alone for now would be appreciated!
> 
> I was not arguing for removing the kthread (quite opposite rather).
> 
> My point was that *if* it is viable to rework drivers to operate in-context,
> that would be the way to go IMO instead of messing up with the kthread thing.
> 

Right, I agree. Problem is that in principle we might still want to use
DEADLINE with the other platforms (MSM being a perfect example), so IMHO
we should still try to find a solution for the kthread anyway.
