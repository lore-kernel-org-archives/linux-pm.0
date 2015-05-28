From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Thu, 28 May 2015 04:09:24 +0200
Message-ID: <5147438.NJg8nCxJVn@vostro.rjw.lan>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54030 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751711AbbE1Bnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 21:43:53 -0400
In-Reply-To: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>

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
will be skipped by the loop).

It also is arguably unuseful to return states with exit_latency
equal to 0 from find_deepest_state(), so the function can be modified
to start the loop from index 0 and the "poll state" will be skipped by
it as a result of the check against latency_req.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
@@ -79,9 +79,9 @@ static int find_deepest_state(struct cpu
 			      bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
+	int i, ret = -ENXIO;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 

