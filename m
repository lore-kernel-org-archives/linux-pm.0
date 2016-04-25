From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH 1/4] cpufreq: governor: support scheduler cpufreq
 callbacks on remote CPUs
Date: Mon, 25 Apr 2016 12:17:55 -0700
Message-ID: <20160425191755.GB18811@sky.smuckle.net>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
 <1975350.dnmiS2ECMV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35006 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbcDYTSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 15:18:01 -0400
Received: by mail-pf0-f171.google.com with SMTP id n1so72379527pfn.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 12:18:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1975350.dnmiS2ECMV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Wed, Apr 20, 2016 at 02:26:06PM +0200, Rafael J. Wysocki wrote:
> You could have added a cover [0/4] message which would have made it easier
> to reply to the entire series in general.  Let me do it here.

Will add that next time.

> Doing it the way it is done in this series would be fine by me in general
> (up to a few more or less minor comments), but it is still unclear to me
> how much of a difference these changes would make in terms of improved
> response times etc.

I spent some time last week constructing a test case where the
benefits could be seen. A task which was previously low utilization
wakes on CPU0 and becomes CPU bound. Just after that, a new task is
spawned on CPU0. The initial task utilization is high so ideally we
would like to see the frequency immediately rise, but in my test it
does not occur until the next tick. There is 7ms of delay in the trace
I've saved.

Unfortunately these patches alone will not address it. There are a
couple other issues which get in the way (which is why I didn't
respond here right away). Let me spend some more time on those and see
how it goes.

> > In preparation for the scheduler cpufreq callback happening
> > on remote CPUs, add support for this in the dbs governors.
> > The dbs governors make assumptions about the callback occurring
> > on the CPU being updated.
> 
> While the above is generally correct, it would be nice to say more about what
> happens in the patch.  Like:
> 
> "To that end, add a CPU number field to struct cpu_dbs_info and modify
> dbs_update_util_handler() to schedule IRQ works on target CPUs rather than on
> the local one only."

I'm happy to do that if it is what you'd like to see, but just
curious, isn't it really just restating the patch contents?

...
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> > index 3e0eb7c54903..1d5f4857ff80 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -122,6 +122,7 @@ struct cpu_dbs_info {
> >  	unsigned int prev_load;
> >  	struct update_util_data update_util;
> >  	struct policy_dbs_info *policy_dbs;
> > +	int cpu;
> >  };
> 
> Wouldn't it be better to add the cpu field to struct update_util_data and set
> it from cpufreq_add_update_util_hook()?
> 
> That would allow you to avoid adding the cpu field to struct sugov_cpu in the
> second patch at least.

Sure, will do.

thanks,
Steve
