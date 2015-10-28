From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from
 update_sampling_rate()
Date: Wed, 28 Oct 2015 14:26:22 +0530
Message-ID: <20151028085622.GI30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <4304226.RJrgDykfyW@vostro.rjw.lan>
 <20151028064317.GB30039@ubuntu>
 <1614479.PJ5OqJLPyG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35354 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbbJ1I41 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 04:56:27 -0400
Received: by pasz6 with SMTP id z6so980659pas.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 01:56:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1614479.PJ5OqJLPyG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 08:46, Rafael J. Wysocki wrote:
> On Wednesday, October 28, 2015 12:13:17 PM Viresh Kumar wrote:
> > Actually yeah, but then the fourth patch of this series uses the
> > timer_mutex to fix a long standing problem (which was fixed by hacking
> > the code earlier). And so we need to take the lock for the entire
> > dbs_timer() routine.

Well, there is another reason why the lock is taken for the complete
dbs_timer() routine. There are two parts of that routine:
- Checking if load evaluation is required or not + updating the
  last-update time.
- The second is the load evaluation + freq change thing.

Lock around the first check makes sure that timer handlers of other
CPUs don't do load evaluation in parallel and that they don't do it
before the sampling period.

Lock around the second part makes sure there is only one thread which
is doing load evaluation + freq update. The other thread being
cpufreq_governor_limits(). And so the same lock taken across that part
as well.

> I don't actually think that that patch is correct and even if it is,
> we'll only need to do that *after* that patch, so at least it would be
> fair to say a word about it in the changelog, wouldn't it?

Hmm, If you agree about the above reasoning, then we may not require
an update to the changelog, otherwise I will mention that in the
changelog of this patch.

> > Yeah, we are calling dbs_check_cpu(dbs_data, cpu) from that path,
> > which will reevaluate the load.
> 
> Which means that we should take the lock around dbs_check_cpu() everywhere
> in a consistent way.

We already do this from everywhere.

> Which in turn means that the lock actually does more
> than you said.

What I described towards the top is probably a better answer to the
earlier query.

> My point is basically that we seem to have a vague idea about what the lock
> is used for, while we need to know exactly why we need it.

I am totally with you on this, we have surely screwed up on locking
for a long time in cpufreq. And we should know exactly why we want to
change it now.

-- 
viresh
