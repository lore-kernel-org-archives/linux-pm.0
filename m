From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable polling
Date: Fri, 15 Jan 2016 01:46:10 +0100
Message-ID: <2379818.mUY3ZAH25Y@vostro.rjw.lan>
References: <1446590059-18897-1-git-send-email-riel@redhat.com> <3835535.S7ikxthAoE@vostro.rjw.lan> <56977B2C.4070600@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51585 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754529AbcAOApf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2016 19:45:35 -0500
In-Reply-To: <56977B2C.4070600@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, riel@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, arjan@linux.intel.com, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thursday, January 14, 2016 10:40:44 AM Sudeep Holla wrote:
> 
> On 13/01/16 22:07, Rafael J. Wysocki wrote:
> > On Wednesday, January 13, 2016 10:58:13 PM Rafael J. Wysocki wrote:
> 
> [..]
> 
> >
> > So I'm wondering if the appended patch helps by any chance?
> >
> 
> Yes it does fix. As you mentioned earlier, CPUIDLE_DRIVER_STATE_START is
> 0 on ARM platforms and hence data->last_state_idx ended up as -1.
> 
> You can add by Tested-by when you push this change. Thanks for the quick
> fix.

No problem, thanks for testing!

Below it goes again with a changelog and all.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: menu: Fix menu_select() for CPUIDLE_DRIVER_STATE_START == 0

Commit a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable
polling) exposed a bug in menu_select() causing it to return -1
on systems with CPUIDLE_DRIVER_STATE_START equal to zero, although
it should have returned 0.  As a result, idle states are not entered
by CPUs on those systems.

Namely, on the systems in question data->last_state_idx is initially
equal to -1 and the above commit modified the condition that would
have caused it to be changed to 0 to be less likely to trigger which
exposed the problem.  However, setting data->last_state_idx initially
to -1 doesn't make sense at all and on the affected systems it should
always be set to CPUIDLE_DRIVER_STATE_START (ie. 0) unconditionally,
so make that happen.

Fixes: a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable polling)
Reported-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -294,8 +294,6 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
-
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0))
 		return 0;
@@ -326,14 +324,19 @@ static int menu_select(struct cpuidle_dr
 	if (latency_req > interactivity_req)
 		latency_req = interactivity_req;
 
-	/*
-	 * We want to default to C1 (hlt), not to busy polling
-	 * unless the timer is happening really really soon.
-	 */
-	if (interactivity_req > 20 &&
-	    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
-		dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
+	if (CPUIDLE_DRIVER_STATE_START > 0) {
+		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+		/*
+		 * We want to default to C1 (hlt), not to busy polling
+		 * unless the timer is happening really really soon.
+		 */
+		if (interactivity_req > 20 &&
+		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
+			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
+			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+	} else {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+	}
 
 	/*
 	 * Find the idle state with the lowest power while satisfying

