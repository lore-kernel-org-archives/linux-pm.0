From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query]: delayed wq not killed completely with
 cancel_delayed_work_sync()
Date: Wed, 10 Jun 2015 12:49:21 +0530
Message-ID: <20150610071921.GB24662@linux>
References: <CAKohpon4Fj3YFgEmGtKH9ePscgiuvq0_PfMMsEboQsaGxaTPfw@mail.gmail.com>
 <20150609111811.GA17763@linux>
 <20150609112627.GA27004@linux>
 <20150610050353.GK11955@mtj.duckdns.org>
 <20150610062019.GA24662@linux>
 <20150610070747.GL11955@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34418 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933207AbbFJHT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 03:19:26 -0400
Received: by payr10 with SMTP id r10so29274123pay.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 00:19:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150610070747.GL11955@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10-06-15, 16:07, Tejun Heo wrote:
> It's not a race per-se.  It's just that cancel[_delayed]_work_sync()
> doesn't disable the work item after it got cancelled and the work item
> can be reused afterwards by queueing it again.  If you don't shut down
> somebody queueing it again (excluding the work itself), the work item
> is being simply being reactivated after being cancelled.

Right, it might be wrong in my case to use any such routines. As the
call sites need to fix this problem, a race or whatever.

> This fits some use cases and even for full shut down cases, plugging
> the external queueing source is often necessary no matter what, so I'm
> a bit torn about introuding another cancel function.  Regardless,
> let's first debug this one properly.

Got it.

> Hmmm.... that's pretty specific.  The deferring is implemented from
> the timer side, so as long as timer doesn't provide a mechanism to do
> collective deferring (ie. deferring across multiple cpus), I don't
> think it makes sense for wq to try to implement that.  :(

Fair enough. And it would be difficult to have something like this in
timers AFAICT. With timers, we choose the target CPU when the timer is
enqueued and so a single timer for a group of CPUs wouldn't work.

What I can do right away, is stop using per-cpu delayed work and use
per-cpu timers instead. And keep a single work which can be queued
from any of these CPUs. That will avoid queuing per-cpu works (might
be less racy). Might be worth giving a try.

Anyway, thanks for patience :)

-- 
viresh
