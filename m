From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Mon, 18 Jan 2016 11:20:34 +0530
Message-ID: <20160118055034.GC30762@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
 <20160112110658.GG1084@ubuntu>
 <20160115163031.GU18603@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34304 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbcARFul (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 00:50:41 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so156471876pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2016 21:50:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160115163031.GU18603@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 15-01-16, 16:30, Juri Lelli wrote:
> But governor_enabled seems to not be checked anymore outside cpufreq.c
> (see also 01/19), as it was in the commit you are referring to.

Okay, I must have told you this earlier but anyway ..

governor_enabled was introduced long back to keep governor state
changes serialized. Because of the complex cases we had in hand
(governor-per-policy or system wide governors, etc.), it failed to do
so. Though simple races were avoided with it, complex ones still came
back to haunt us.

We fixed that by managing state changes within ondemand and
conservative governors instead and that worked very well.

Then I wrote a patch to kill the stupid code around governor_enabled
thing, but I got into few races. Those races happened because of
userspace governor, which was getting into invalid states on some
extreme cases (These were caught using the test-suite I wrote and you
perhaps used it).

And I never came back to fix those corner cases ..

You can try that on ARM or x86 by running following command from my
test-suite (I remember that you are using it, right?):

./runme.sh -f sp1 or sp2 or sp3

Only one of sp1, sp2 or sp3 is required..

> Now that
> users of this should be holding policy->rwsem, so that should suffice
> for protecting governor_enabled, as governor_enabled is only changed
> inside here.

If we can get rid of the rwsem dropping problem, then yeah this can be
killed for sure.

> I run some test on a x86 box I setup and didn't see anything related to
> this. I'll wait to get the first 0-day report anyway.

Okay, so run the above test and make sure you have following enabled
in your configuration:

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

> > > -	mutex_lock(&cpufreq_governor_mutex);
> > >  	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
> > >  	    || (!policy->governor_enabled
> > >  	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
> > > -		mutex_unlock(&cpufreq_governor_mutex);
> > >  		return -EBUSY;
> > >  	}
> > 
> > Actually the above checks should also be removed as the governors are
> > responsible for maintaining their state machines. But
> > userspace/powersave/performance don't have that support yet and so
> > these checks save them from going into undefined states.
> > 
> > Over that, above and below checks are incomplete..
> > 
> 
> You mean we need an additional patch that extends the checks performed?

Yeah, we need to add some state-management code in
userspace/powersave/performance governors as well.

-- 
viresh
