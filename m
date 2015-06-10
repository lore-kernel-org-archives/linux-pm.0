From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query]: delayed wq not killed completely with
 cancel_delayed_work_sync()
Date: Wed, 10 Jun 2015 11:50:19 +0530
Message-ID: <20150610062019.GA24662@linux>
References: <CAKohpon4Fj3YFgEmGtKH9ePscgiuvq0_PfMMsEboQsaGxaTPfw@mail.gmail.com>
 <20150609111811.GA17763@linux>
 <20150609112627.GA27004@linux>
 <20150610050353.GK11955@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33896 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbFJGUY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 02:20:24 -0400
Received: by payr10 with SMTP id r10so28286232pay.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 23:20:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150610050353.GK11955@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Tejun,

Thanks for your response :)

On 10-06-15, 14:03, Tejun Heo wrote:
> cancel_delayed_work_sync() can reliably shoot down a self-requeueing
> delayed work item but it doesn't do anything about queueings which
> aren't from the work item itself, so, to shutdown a recurring work
> item, you'd need to first block external queueing and then do
> cancel_delayed_work_sync().

Fair enough.

> If you're already doing this but still

Fingers crossed :)

> seeing the work item executing afterwards, it's a workqueue bug but
> the code in that area has been stable for years, so I'd be surprised
> if there's a bug like that but you never know.

I really believe/hope I am doing this properly. But will crosscheck
that again.

> This does get tricky and I've been thinking about adding something
> like kill_delayed_work() which cancels and disables the work item till
> it gets reinitialized.  Hmmm...

I think its a good idea to get rid of such races. If you have
something in mind and can code it quickly enough, I would be happy to
test it for you. That will also help in my use case.

> > And another query:
> > 
> > Do we have support for this kind of scenarios in wq framework ?
> > 
> > - Enqueue a single delayed work for a group of CPUs (and should fire
> >   on any one of them). We are doing this per-cpu today in cpufreq.
> > - It has to be a deffered one, so that if none of the CPUs from that
> >   group are online, we don't fire it.

Urg, s/online/not-idle. IOW, the work shouldn't wake up CPUs from idle
state.

> > - As the per-cpu workqueue thing is unnecessary burden on CPUs.
> 
> I'm not sure I'm following

Above correction might make it better :)

> but shouldn't you be able to do the above
> from cpu hotplug callbacks?

Sorry it wasn't about online CPUs. My fault.

> Or are you asking whether wq already has
> something which would help implementing the above?

Okay, lemme explain a bit and then you can tell me what to do.

A group of CPUs which switch their DVFS (Dynamic voltage/frequency
scaling) state together (or which share their clock rails) are
considered specially in cpufreq. As changing frequency for any one of
them will affect all others.

Today's governors (of course badly designed, and people are working on
getting scheduler involved) run background work at regular intervals
to find the per-cpu load for this group of CPUs. Any cpu can run the
algorithm for the entire group. Earlier we were running this
background work on only one CPU, but because its a deffered work it
was missing cycles if that CPU was idle. And so we ended up adding the
work per-cpu to fix that. We do check on the per-cpu handler if any
other CPU had run the algo recently and in that case we return early
from the handler.

What I was thinking was to get some kind of support for these requests
from the wq core. So that we can ask the workqueue core to run a
work-handler on any non-idle CPU from a group of CPUs.

Hope I made it more clear this time around.

-- 
viresh
