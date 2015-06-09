From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query]: delayed wq not killed completely with
 cancel_delayed_work_sync()
Date: Tue, 9 Jun 2015 16:56:27 +0530
Message-ID: <20150609112627.GA27004@linux>
References: <CAKohpon4Fj3YFgEmGtKH9ePscgiuvq0_PfMMsEboQsaGxaTPfw@mail.gmail.com>
 <20150609111811.GA17763@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34695 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbFIL0c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2015 07:26:32 -0400
Received: by payr10 with SMTP id r10so12030630pay.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 04:26:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150609111811.GA17763@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09-06-15, 16:48, Viresh Kumar wrote:
> On 09-06-15, 16:43, Viresh Kumar wrote:
> > HI Tejun,
> >
> > We had few races in cpufreq core for some time now and we
> > are looking to fix them.
> >
> > Briefly, we run a delayed_work on each cpu at a fixed interval
> > (sampling rate) and when that expires that take a look at system
> > load and adjust frequency accordingly. We also requeue the
> > delayed-works from these handlers.
> >
> > The problem we are facing is NULL pointer dereference from
> > work handler..
> >
> > Before we set the pointers to NULL and free resource (for which
> > we are seeing the crashes), we cancel the delayed works with
> > cancel_delayed_work_sync(&dwork);
> >
> > We expect the work to not fire at all once this returns, but it
> > looks like the work handler does get called..
> >
> > The mainline version of cpufreq_governor.c is a bit older than
> > what we have, but I just wanted the clarification on the routine
> > itself.
> >
> > Thanks for reading this :)

And another query:

Do we have support for this kind of scenarios in wq framework ?

- Enqueue a single delayed work for a group of CPUs (and should fire
  on any one of them). We are doing this per-cpu today in cpufreq.
- It has to be a deffered one, so that if none of the CPUs from that
  group are online, we don't fire it.
- As the per-cpu workqueue thing is unnecessary burden on CPUs.

Thanks.

-- 
viresh
