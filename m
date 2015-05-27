From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Wed, 27 May 2015 03:36:26 +0200
Message-ID: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64852 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751472AbbE0BK5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 21:10:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
entry in the cpuidle driver's table of states is overwritten with
the default "poll" entry by the core.  The "state" defined by the
"poll" entry doesn't provide ->enter_dead and ->enter_freeze
callbacks and its exit_latency is 0.

For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_START
in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
will be skipped by the loop) and in find_deepest_state() (since
exit_latency is 0, the "poll state" will become the default if the
"s->exit_latency <= latency_req" check is replaced with
"s->exit_latency < latency_req" which may only matter for drivers
providing different states with the same exit_latency).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -65,7 +65,7 @@ int cpuidle_play_dead(void)
 		return -ENODEV;
 
 	/* Find lowest-power state that supports long-term idle */
-	for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i--)
+	for (i = drv->state_count - 1; i >= 0; i--)
 		if (drv->states[i].enter_dead)
 			return drv->states[i].enter_dead(dev, i);
 
@@ -79,13 +79,13 @@ static int find_deepest_state(struct cpu
 			      bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
+	int i, ret = -ENXIO;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
-		if (s->disabled || su->disable || s->exit_latency <= latency_req
+		if (s->disabled || su->disable || s->exit_latency < latency_req
 		    || s->exit_latency > max_latency
 		    || (s->flags & forbidden_flags)
 		    || (freeze && !cpuidle_has_enter_freeze(s)))

