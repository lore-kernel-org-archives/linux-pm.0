From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Tue, 12 Jan 2016 12:36:51 +0000
Message-ID: <20160112123651.GD7015@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
 <20160111220708.GK6344@twins.programming.kicks-ass.net>
 <20160112092752.GV1084@ubuntu>
 <20160112112125.GA7015@e106622-lin>
 <20160112115843.GD6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34064 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbcALMga (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 07:36:30 -0500
Content-Disposition: inline
In-Reply-To: <20160112115843.GD6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12/01/16 12:58, Peter Zijlstra wrote:
> On Tue, Jan 12, 2016 at 11:21:25AM +0000, Juri Lelli wrote:
> > I tried to see if something like for_each_domain() can be done, but here
> > we use list_for_each_entry() macro. Peter, do you mean something like
> > the following?
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 78b1e2f..1a847a6 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -39,6 +39,7 @@
> >  static LIST_HEAD(cpufreq_governor_list);
> >  static DEFINE_MUTEX(cpufreq_governor_mutex);
> >  #define for_each_governor(__governor)				\
> > +	lockdep_assert_held(&cpufreq_governor_mutex);		\
> >  	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> 
> That fails for things like:
> 
> 	if (blah)
> 		for_each_governor(...) {
> 		}
> 
> which looks like valid C -- even though our Coding Style says the if
> should have { } on.
> 
> I was thinking of either open coding the for statement and adding it to
> the first statement like:
> 
> 	#define for_each_governor(__g) \
> 		for (_g = list_first_entry(&cpufreq_governor_list, typeof(*_g), governor_list, lockdep_assert_held(), \
> 		     ..... )
> 
> Or use something like this:
> 
>   lkml.kernel.org/r/20150422154212.GE3007@worktop.Skamania.guest
> 
> 	#define for_each_governor(_g) \
> 		list_for_each_entry(_g, &cpufreq_governor_list, governor_list)
> 			if (lockdep_assert_held(..), false)
> 				;
> 			else
> 
> Which should preserve C syntax rules.
> 

Oh, nice this! I'll try it.

Thanks,

- Juri
