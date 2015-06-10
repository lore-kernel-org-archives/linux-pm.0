From: Tejun Heo <tj@kernel.org>
Subject: Re: [Query]: delayed wq not killed completely with
 cancel_delayed_work_sync()
Date: Wed, 10 Jun 2015 16:07:47 +0900
Message-ID: <20150610070747.GL11955@mtj.duckdns.org>
References: <CAKohpon4Fj3YFgEmGtKH9ePscgiuvq0_PfMMsEboQsaGxaTPfw@mail.gmail.com>
 <20150609111811.GA17763@linux>
 <20150609112627.GA27004@linux>
 <20150610050353.GK11955@mtj.duckdns.org>
 <20150610062019.GA24662@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36483 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbFJHHy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 03:07:54 -0400
Received: by pabqy3 with SMTP id qy3so28930215pab.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 00:07:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150610062019.GA24662@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Yo,

On Wed, Jun 10, 2015 at 11:50:19AM +0530, Viresh Kumar wrote:
...
> > This does get tricky and I've been thinking about adding something
> > like kill_delayed_work() which cancels and disables the work item till
> > it gets reinitialized.  Hmmm...
> 
> I think its a good idea to get rid of such races. If you have
> something in mind and can code it quickly enough, I would be happy to
> test it for you. That will also help in my use case.

It's not a race per-se.  It's just that cancel[_delayed]_work_sync()
doesn't disable the work item after it got cancelled and the work item
can be reused afterwards by queueing it again.  If you don't shut down
somebody queueing it again (excluding the work itself), the work item
is being simply being reactivated after being cancelled.

This fits some use cases and even for full shut down cases, plugging
the external queueing source is often necessary no matter what, so I'm
a bit torn about introuding another cancel function.  Regardless,
let's first debug this one properly.

> > > And another query:
> > > 
> > > Do we have support for this kind of scenarios in wq framework ?
> > > 
> > > - Enqueue a single delayed work for a group of CPUs (and should fire
> > >   on any one of them). We are doing this per-cpu today in cpufreq.
> > > - It has to be a deffered one, so that if none of the CPUs from that
> > >   group are online, we don't fire it.
> 
> Urg, s/online/not-idle. IOW, the work shouldn't wake up CPUs from idle
> state.

I see.

> > > - As the per-cpu workqueue thing is unnecessary burden on CPUs.
> > 
> > I'm not sure I'm following
> 
> Above correction might make it better :)
> 
> > but shouldn't you be able to do the above
> > from cpu hotplug callbacks?
> 
> Sorry it wasn't about online CPUs. My fault.
> 
> > Or are you asking whether wq already has
> > something which would help implementing the above?
> 
> Okay, lemme explain a bit and then you can tell me what to do.
> 
> A group of CPUs which switch their DVFS (Dynamic voltage/frequency
> scaling) state together (or which share their clock rails) are
> considered specially in cpufreq. As changing frequency for any one of
> them will affect all others.
> 
> Today's governors (of course badly designed, and people are working on
> getting scheduler involved) run background work at regular intervals
> to find the per-cpu load for this group of CPUs. Any cpu can run the
> algorithm for the entire group. Earlier we were running this
> background work on only one CPU, but because its a deffered work it
> was missing cycles if that CPU was idle. And so we ended up adding the
> work per-cpu to fix that. We do check on the per-cpu handler if any
> other CPU had run the algo recently and in that case we return early
> from the handler.
> 
> What I was thinking was to get some kind of support for these requests
> from the wq core. So that we can ask the workqueue core to run a
> work-handler on any non-idle CPU from a group of CPUs.
> 
> Hope I made it more clear this time around.

Hmmm.... that's pretty specific.  The deferring is implemented from
the timer side, so as long as timer doesn't provide a mechanism to do
collective deferring (ie. deferring across multiple cpus), I don't
think it makes sense for wq to try to implement that.  :(

Thanks.

-- 
tejun
