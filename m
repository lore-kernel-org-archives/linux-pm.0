From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 06 May 2016 02:25:16 +0200
Message-ID: <1953902.drhraqW2It@vostro.rjw.lan>
References: <20160505234922.GA14673@sky.smuckle.net> <1961527.dEtpL4HAvs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60211 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752560AbcEFAWD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 20:22:03 -0400
In-Reply-To: <1961527.dEtpL4HAvs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Friday, May 06, 2016 02:09:07 AM Rafael J. Wysocki wrote:
> On Thursday, May 05, 2016 04:49:22 PM Steve Muckle wrote:
> > While working on a few patches for schedutil I noticed that the CFS
> > cpufreq hooks depend on PELT, which depends on CONFIG_SMP.
> > 
> > I compiled and ran a UP kernel with intel_pstate. Running a cpu-bound
> > task did not result in the frequency increasing beyond fmin. For some reason
> > ondemand is working for me with the same test, not sure why yet.
> > 
> > It appears dbs/intel-pstate/schedutil have a dependency on CONFIG_SMP
> > now. Or am I missing something?
> 
> You're right AFAICS.
> 
> For governors other than schedutil fixing that would be a matter of
> adding a !CONFIG_SMP variant of update_load_avg() that will call
> cpufreq_update_util() and do nothing else.  It doesn't matter what
> is passed via util and max then.

Maybe something like the below, FWIW, as a quick fix for 4.6?

---
 kernel/sched/fair.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/fair.c
===================================================================
--- linux-pm.orig/kernel/sched/fair.c
+++ linux-pm/kernel/sched/fair.c
@@ -3030,7 +3030,14 @@ static int idle_balance(struct rq *this_
 
 #else /* CONFIG_SMP */
 
-static inline void update_load_avg(struct sched_entity *se, int update_tg) {}
+static inline void update_load_avg(struct sched_entity *se, int not_used)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct rq *rq = rq_of(cfs_rq);
+
+	cpufreq_trigger_update(rq_clock(rq));
+}
+
 static inline void
 enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void

