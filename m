From: Tejun Heo <tj@kernel.org>
Subject: Re: [Query]: delayed wq not killed completely with
 cancel_delayed_work_sync()
Date: Wed, 10 Jun 2015 14:03:53 +0900
Message-ID: <20150610050353.GK11955@mtj.duckdns.org>
References: <CAKohpon4Fj3YFgEmGtKH9ePscgiuvq0_PfMMsEboQsaGxaTPfw@mail.gmail.com>
 <20150609111811.GA17763@linux>
 <20150609112627.GA27004@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34646 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbFJFEC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 01:04:02 -0400
Received: by payr10 with SMTP id r10so27085289pay.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 22:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150609112627.GA27004@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hey, Viresh.

On Tue, Jun 09, 2015 at 04:56:27PM +0530, Viresh Kumar wrote:
> On 09-06-15, 16:48, Viresh Kumar wrote:
> > On 09-06-15, 16:43, Viresh Kumar wrote:
> > > HI Tejun,
> > >
> > > We had few races in cpufreq core for some time now and we
> > > are looking to fix them.
> > >
> > > Briefly, we run a delayed_work on each cpu at a fixed interval
> > > (sampling rate) and when that expires that take a look at system
> > > load and adjust frequency accordingly. We also requeue the
> > > delayed-works from these handlers.
> > >
> > > The problem we are facing is NULL pointer dereference from
> > > work handler..
> > >
> > > Before we set the pointers to NULL and free resource (for which
> > > we are seeing the crashes), we cancel the delayed works with
> > > cancel_delayed_work_sync(&dwork);
> > >
> > > We expect the work to not fire at all once this returns, but it
> > > looks like the work handler does get called..

cancel_delayed_work_sync() can reliably shoot down a self-requeueing
delayed work item but it doesn't do anything about queueings which
aren't from the work item itself, so, to shutdown a recurring work
item, you'd need to first block external queueing and then do
cancel_delayed_work_sync().  If you're already doing this but still
seeing the work item executing afterwards, it's a workqueue bug but
the code in that area has been stable for years, so I'd be surprised
if there's a bug like that but you never know.

This does get tricky and I've been thinking about adding something
like kill_delayed_work() which cancels and disables the work item till
it gets reinitialized.  Hmmm...

> And another query:
> 
> Do we have support for this kind of scenarios in wq framework ?
> 
> - Enqueue a single delayed work for a group of CPUs (and should fire
>   on any one of them). We are doing this per-cpu today in cpufreq.
> - It has to be a deffered one, so that if none of the CPUs from that
>   group are online, we don't fire it.
> - As the per-cpu workqueue thing is unnecessary burden on CPUs.

I'm not sure I'm following but shouldn't you be able to do the above
from cpu hotplug callbacks?  Or are you asking whether wq already has
something which would help implementing the above?

Thanks.

-- 
tejun
