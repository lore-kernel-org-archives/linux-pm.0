From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Thu, 30 Mar 2017 22:22:24 +0200
Message-ID: <2683548.WpoELJxfrb@aspire.rjw.lan>
References: <20170324140900.7334-1-juri.lelli@arm.com> <1721120.3Th1GMboUn@aspire.rjw.lan> <cfffdfdd5251ae7921f65d1e0360a289@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53430 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754322AbdC3U2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 16:28:09 -0400
In-Reply-To: <cfffdfdd5251ae7921f65d1e0360a289@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikram Mulukutla <markivx@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, linux-kernel-owner@vger.kernel.org

On Thursday, March 30, 2017 08:50:11 AM Vikram Mulukutla wrote:
> 
> > OK
> > 
> > So there are two pieces here.
> > 
> > One is that if we want *all* drivers to work with schedutil, we need to 
> > keep
> > the kthread for the ones that will never be reworked (because nobody 
> > cares
> > etc).  But then perhaps the kthread implementation may be left alone 
> > (because
> > nobody cares etc).
> > 
> > The second one is that there are drivers operating in-context that work 
> > with
> > schedutil already, so I don't see major obstacles to making more 
> > drivers work
> > that way.  That would be only a matter of reworking the drivers in 
> > question.
> > 
> > Thanks,
> > Rafael
> 
> There are some MSM platforms that do need a kthread and would love to 
> use
> schedutil. This is all mainly due to the point that Vincent raised; 
> having
> to actually wait for voltage transitions before clock switches. I can't
> speak about the future, but that's the situation right now. Leaving the
> kthread alone for now would be appreciated!

I was not arguing for removing the kthread (quite opposite rather).

My point was that *if* it is viable to rework drivers to operate in-context,
that would be the way to go IMO instead of messing up with the kthread thing.

Thanks,
Rafael
