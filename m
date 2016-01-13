From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable polling
Date: Wed, 13 Jan 2016 23:07:46 +0100
Message-ID: <3835535.S7ikxthAoE@vostro.rjw.lan>
References: <1446590059-18897-1-git-send-email-riel@redhat.com> <CAPKp9ubg3V0979dGTGi+kjXGiBczCG2+QBGgfrZBKjMgSuhy-A@mail.gmail.com> <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56244 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753340AbcAMWHN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 17:07:13 -0500
In-Reply-To: <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, riel@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, arjan@linux.intel.com, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Wednesday, January 13, 2016 10:58:13 PM Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Jan 13, 2016 at 6:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Hi Rik,

[cut]

> >
> > diff --git i/drivers/cpuidle/governors/menu.c w/drivers/cpuidle/governors/menu.c
> > index 7b0971d97cc3..7c7f4059705a 100644
> > --- i/drivers/cpuidle/governors/menu.c
> > +++ w/drivers/cpuidle/governors/menu.c
> > @@ -330,7 +330,8 @@ static int menu_select(struct cpuidle_driver *drv,
> > struct cpuidle_device *dev)
> >          * We want to default to C1 (hlt), not to busy polling
> >          * unless the timer is happening really really soon.
> >          */
> > -       if (interactivity_req > 20 &&
> > +       if (((interactivity_req && interactivity_req > 20) ||
> 
> Well, if interactivity_req > 20, then it also is different from 0, so
> the first check should not be necessary here.
> 
> > +               data->next_timer_us > 20) &&
> 
> I guess that this simply restores the previous behavior on the
> platforms in question.
> 
> Now, the reason why it may matter is because
> CPUIDLE_DRIVER_STATE_START is 0 and so data->last_state_idx may end up
> as -1 on them.  So I think this piece of code only ever makes sense if
> CPUIDLE_DRIVER_STATE_START is 1.
> 
> >             !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
> >                 dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
> >                 data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> > --

So I'm wondering if the appended patch helps by any chance?

Rafael

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

