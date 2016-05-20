From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU offline/online locked
Date: Fri, 20 May 2016 23:33:13 +0200
Message-ID: <5580598.s7imtWPVt5@vostro.rjw.lan>
References: <19792191.esL3UuyORb@vostro.rjw.lan> <20160520022247.GS32001@vireshk-i7> <3805651.Y4agxXsfkM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46856 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751009AbcETV3i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 17:29:38 -0400
In-Reply-To: <3805651.Y4agxXsfkM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Friday, May 20, 2016 02:13:26 PM Rafael J. Wysocki wrote:
> On Friday, May 20, 2016 07:52:47 AM Viresh Kumar wrote:
> > On 20-05-16, 03:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
> > > should be carried out with CPU offline/online locked or races are
> > > possible otherwise, so make that happen.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > > 
> > > v1 -> v2: On a second thought, add the policy notifier in cpufreq_stats_init()
> > >   with CPU offline/online locked too.
> > > 
> > > ---
> > >  drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
> > > +++ linux-pm/drivers/cpufreq/cpufreq_stats.c
> > > @@ -317,10 +317,13 @@ static int __init cpufreq_stats_init(voi
> > >  	unsigned int cpu;
> > >  
> > >  	spin_lock_init(&cpufreq_stats_lock);
> > > +
> > > +	get_online_cpus();
> > > +
> > >  	ret = cpufreq_register_notifier(&notifier_policy_block,
> > >  				CPUFREQ_POLICY_NOTIFIER);
> > 
> > Why is this required to be protected ?
> 
> Last night I thought I saw a scenario in which that notifier could run
> in parallel with the loop below even with get_online_cpus() between them,
> but I don't see it right now.
> 
> Maybe I should not look at stuff late in the night ...
> 
> > >  	if (ret)
> > > -		return ret;
> > > +		goto out;
> > >  
> > >  	for_each_online_cpu(cpu)
> > >  		cpufreq_stats_create_table(cpu);
> > > @@ -332,21 +335,28 @@ static int __init cpufreq_stats_init(voi
> > >  				CPUFREQ_POLICY_NOTIFIER);
> > >  		for_each_online_cpu(cpu)
> > >  			cpufreq_stats_free_table(cpu);
> > 
> > Maybe we can make this for_each_possible_cpu() then, and so getting a
> > policy will fail for CPUs which aren't online.
> > 
> > And we wouldn't need to use get_online_cpus() then ?
> 
> That could be done, but then there would be nothing to prevent the
> policy notifier from running in parallel with the loop.
> 
> Something like the patch below should do the trick, though.

The policy rwsem is really only needed in cpufreq_stats_create_table(), because
the policy notifier is gone when _free_table() runs, so another version of the
patch goes below.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: stats: Fix race conditions on init and cleanup

Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
are not carried out with CPU offline/online locked, so races are
possible with respect to policy initialization and cleanup.

To prevent that from happening, change the loops to walk all possible
CPUs, as cpufreq_stats_create_table() and cpufreq_stats_free_table()
handle the case when there's no policy for the given CPU cleanly, but
also use policy->rwsem in cpufreq_stats_create_table() to prevent it
from racing with the policy notifier.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-pm/drivers/cpufreq/cpufreq_stats.c
@@ -238,7 +238,13 @@ static void cpufreq_stats_create_table(u
 	if (likely(!policy))
 		return;
 
+	/*
+	 * The policy notifier may run in parallel with this code, so use the
+	 * policy rwsem to avoid racing with it.
+	 */
+	down_write(&policy->rwsem);
 	__cpufreq_stats_create_table(policy);
+	up_write(&policy->rwsem);
 
 	cpufreq_cpu_put(policy);
 }
@@ -322,7 +328,7 @@ static int __init cpufreq_stats_init(voi
 	if (ret)
 		return ret;
 
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		cpufreq_stats_create_table(cpu);
 
 	ret = cpufreq_register_notifier(&notifier_trans_block,
@@ -330,12 +336,11 @@ static int __init cpufreq_stats_init(voi
 	if (ret) {
 		cpufreq_unregister_notifier(&notifier_policy_block,
 				CPUFREQ_POLICY_NOTIFIER);
-		for_each_online_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			cpufreq_stats_free_table(cpu);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 static void __exit cpufreq_stats_exit(void)
 {
@@ -345,7 +350,8 @@ static void __exit cpufreq_stats_exit(vo
 			CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
-	for_each_online_cpu(cpu)
+
+	for_each_possible_cpu(cpu)
 		cpufreq_stats_free_table(cpu);
 }
 

