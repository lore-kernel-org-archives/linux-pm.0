From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Tue, 12 Jan 2016 11:21:25 +0000
Message-ID: <20160112112125.GA7015@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
 <20160111220708.GK6344@twins.programming.kicks-ass.net>
 <20160112092752.GV1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33497 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcALLVH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 06:21:07 -0500
Content-Disposition: inline
In-Reply-To: <20160112092752.GV1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi,

On 12/01/16 14:57, Viresh Kumar wrote:
> On 11-01-16, 23:07, Peter Zijlstra wrote:
> > On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> > > +/**
> > > + * Iterate over governors
> > > + *
> > > + * cpufreq_governor_list is protected by cpufreq_governor_mutex.
> > > + */
> > > +static LIST_HEAD(cpufreq_governor_list);
> > > +static DEFINE_MUTEX(cpufreq_governor_mutex);
> > > +#define for_each_governor(__governor)				\
> > > +	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
> > 
> > So you could stuff the lockdep_assert_held() you later add intididually
> > into the for_each_governor macro, impossible to forget that way.
> 
> How exactly? I couldn't see how it can be done in a neat and clean
> way.
> 

I tried to see if something like for_each_domain() can be done, but here
we use list_for_each_entry() macro. Peter, do you mean something like
the following?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 78b1e2f..1a847a6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -39,6 +39,7 @@
 static LIST_HEAD(cpufreq_governor_list);
 static DEFINE_MUTEX(cpufreq_governor_mutex);
 #define for_each_governor(__governor)				\
+	lockdep_assert_held(&cpufreq_governor_mutex);		\
 	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
 
 /**
@@ -508,7 +509,6 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
 
-	lockdep_assert_held(&cpufreq_governor_mutex);
 	for_each_governor(t)
 		if (!strncasecmp(str_governor, t->name, CPUFREQ_NAME_LEN))
 			return t;

Since for_each_governor() is not used in if conditions that should be
fine?

Thanks,

- Juri
