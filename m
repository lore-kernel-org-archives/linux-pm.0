From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 17:35:51 -0400
Message-ID: <20160318173551.675ff6e5@annuminas.surriel.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbcCRVgZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 17:36:25 -0400
In-Reply-To: <003301d18144$87bb8df0$9732a9d0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On Fri, 18 Mar 2016 11:32:28 -0700
"Doug Smythies" <dsmythies@telus.net> wrote:

> Energy:
> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> 
> Trace data (very crude summary):
> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)

This is a bit of a big hammer, but since the polling loop already uses
full CPU power anyway, this could be harmless, and solve your problem.

---8<---

Subject: cpuidle: break out of idle polling loop after HLT threshold

Staying in the poll loop can be beneficial for workloads that
wake back up very, very quickly, but staying in the poll loop
for too long can waste a lot of power.

Break out of the idle polling loop if the system has spent more
time in the loop than the threshold for entering the next power
saving mode.

The poll loop uses full CPU power already, so this will not
increase the power use of the poll loop.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/driver.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 389ade4572be..a5dfeafd243f 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -181,10 +181,29 @@ static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 static int poll_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
 {
+	/*
+	 * Polling is state 0; break out of the polling loop after the
+	 * threshold for the next power state has passed. Doing this several
+	 * times in a row should cause the menu governor to immediately
+	 * select a deeper power state.
+	 */
+	u64 limit = drv->states[1].target_residency * NSEC_PER_USEC;
+	ktime_t start = ktime_get();
+	int i = 0;
+
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		while (!need_resched())
+		while (!need_resched()) {
+			ktime_t now;
 			cpu_relax();
+
+			/* Occasionally check for a timeout. */
+			if (!(i % 1000)) {
+				now = ktime_get();
+				if (ktime_to_ns(ktime_sub(now, start)) > limit)
+					break;
+			}
+		}
 	}
 	current_clr_polling();
 
