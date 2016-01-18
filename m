From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH 2/2] cpuidle: menu: Avoid pointless checks in menu_select()
Date: Mon, 18 Jan 2016 23:51:05 +0100
Message-ID: <3261340.TFhiL6Ldfm@vostro.rjw.lan>
References: <1621492.NI2xz9vt7M@vostro.rjw.lan> <7876665.vgkxSAt2aO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55482 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754981AbcARWuX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 17:50:23 -0500
In-Reply-To: <7876665.vgkxSAt2aO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If menu_select() cannot find a suitable state to return, it will
return the state index stored in data->last_state_idx.  This
means that it is pointless to look at the states whose indices
are less than or equal to data->last_state_idx in the main loop,
so don't do that.

Given that those checks are done on every idle state selection, this
change can save quite a bit of completely unnecessary overhead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---

I left a pointless Subject: tag in the patch body when I sent it last time,
so resend.

Note that this also is based on commit 9c4b2867ed7c (cpuidle: menu: Fix
menu_select() for CPUIDLE_DRIVER_STATE_START == 0) only present in linux-next ATM.

---
 drivers/cpuidle/governors/menu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -342,7 +342,7 @@ static int menu_select(struct cpuidle_dr
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 

