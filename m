From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Tue, 12 Jan 2016 16:58:43 +0100
Message-ID: <20160112155843.GL6357@twins.programming.kicks-ass.net>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
 <20160111220708.GK6344@twins.programming.kicks-ass.net>
 <20160112092752.GV1084@ubuntu>
 <20160112112125.GA7015@e106622-lin>
 <20160112115843.GD6357@twins.programming.kicks-ass.net>
 <20160112123651.GD7015@e106622-lin>
 <20160112152601.GA18734@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46144 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcALP6u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 10:58:50 -0500
Content-Disposition: inline
In-Reply-To: <20160112152601.GA18734@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Tue, Jan 12, 2016 at 03:26:01PM +0000, Juri Lelli wrote:
> > > 	#define for_each_governor(_g) \
> > > 		list_for_each_entry(_g, &cpufreq_governor_list, governor_list)
> > > 			if (lockdep_assert_held(..), false)
> > > 				;
> > > 			else
> > >=20
> > > Which should preserve C syntax rules.
> > >=20
> >=20
> > Oh, nice this! I'll try it.
> >=20
>=20
> This second approach doesn't really play well with lockdep_assert_hel=
d
> definition, right?

Right, the below however makes it work, except:

=2E./kernel/sched/core.c: In function =E2=80=98scheduler_ipi=E2=80=99:
=2E./kernel/sched/core.c:1831:32: warning: left-hand operand of comma e=
xpression has no effect [-Wunused-value]
  if (lockdep_assert_held(&lock), false)

Which is of course correct and very much on purpose :/

---

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c57e424d914b..caf7a89643d8 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -362,9 +362,9 @@ extern void lock_unpin_lock(struct lockdep_map *loc=
k);
=20
 #define lockdep_depth(tsk)	(debug_locks ? (tsk)->lockdep_depth : 0)
=20
-#define lockdep_assert_held(l)	do {				\
+#define lockdep_assert_held(l)	({				\
 		WARN_ON(debug_locks && !lockdep_is_held(l));	\
-	} while (0)
+		(void)l; })
=20
 #define lockdep_assert_held_once(l)	do {				\
 		WARN_ON_ONCE(debug_locks && !lockdep_is_held(l));	\
@@ -422,7 +422,7 @@ struct lock_class_key { };
=20
 #define lockdep_depth(tsk)	(0)
=20
-#define lockdep_assert_held(l)			do { (void)(l); } while (0)
+#define lockdep_assert_held(l)			({ (void)l; })
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
=20
 #define lockdep_recursing(tsk)			(0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77d97a6fc715..f6f36217133d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1817,6 +1817,8 @@ void sched_ttwu_pending(void)
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
=20
+raw_spinlock_t lock;
+
 void scheduler_ipi(void)
 {
 	/*
@@ -1826,6 +1828,9 @@ void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
=20
+	if (lockdep_assert_held(&lock), false)
+		;
+
 	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
 		return;
=20
