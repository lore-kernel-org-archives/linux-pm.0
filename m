From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 19:04:46 +0100
Message-ID: <20080304190446.775165e3__38532.4603216306$1204654273$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<20080304172918.GA27332@one.firstfloor.org>
	<20080304183032.17084e39@mjolnir.drzeus.cx>
	<20080304174315.GB27332@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304174315.GB27332@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008 18:43:15 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> > And how can I tell if this handler has run? Not that it really matters I guess, as I don't think running it from the cpuidle governor is very sane.
>  
> After irq_enter->tick_nohz_update_jiffies() 
> 
> You might need a new callback into the idle governours for this though.
> 

I don't think I quite see the point. If we can't force an update, then
it doesn't really help us knowing if the jiffies value is stale or not.

Anyway, I'm running the following patch for now. I'll keep it on my
machine for a few days and see if I still hear crickets.

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 78d77c5..73f954d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -16,6 +16,9 @@
 
 #define BREAK_FUZZ	4	/* 4 us */
 
+static unsigned int min_deep_sleep = 0;
+static unsigned int failed_deep = 0;
+
 struct menu_device {
 	int		last_state_idx;
 
@@ -23,6 +26,8 @@ struct menu_device {
 	unsigned int	predicted_us;
 	unsigned int	last_measured_us;
 	unsigned int	elapsed_us;
+
+	unsigned long	last_deep;
 };
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -50,9 +55,33 @@ static int menu_select(struct cpuidle_device *dev)
 			break;
 		if (s->exit_latency > pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY))
 			break;
+
+		/*
+		 * In order to avoid the problem of "singing capacitors",
+		 * don't enter a deep sleep for short durations (2 ms seems
+		 * to do the trick). This will, hopefully, keep the problem
+		 * inaudible.
+		 */
+		if (min_deep_sleep && (s->flags & CPUIDLE_FLAG_DEEP)) {
+			if (time_before_eq(jiffies, data->last_deep +
+				HZ * min_deep_sleep / USEC_PER_SEC))
+				break;
+#if 0
+			if (min_deep_sleep > data->expected_us)
+				break;
+			if (min_deep_sleep > data->predicted_us)
+				break;
+			if (min_deep_sleep > data->last_measured_us)
+				break;
+#endif
+		}
 	}
 
 	data->last_state_idx = i - 1;
+
+	if (dev->states[i - 1].flags & CPUIDLE_FLAG_DEEP)
+		data->last_deep = jiffies;
+
 	return i - 1;
 }
 
@@ -80,6 +109,10 @@ static void menu_reflect(struct cpuidle_device *dev)
 	if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
 		measured_us = USEC_PER_SEC / HZ;
 
+	if ((target->flags & CPUIDLE_FLAG_DEEP) &&
+	    (cpuidle_get_last_residency(dev) < min_deep_sleep))
+		failed_deep++;
+
 	/* Predict time remaining until next break event */
 	if (measured_us + BREAK_FUZZ < data->expected_us - target->exit_latency) {
 		data->predicted_us = max(measured_us, data->last_measured_us);
@@ -103,6 +136,11 @@ static int menu_enable_device(struct cpuidle_device *dev)
 	struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
 
 	memset(data, 0, sizeof(struct menu_device));
+	/*
+	 * 0 might be slightly ahead of the current jiffies count, so
+	 * it's a bad initial value.
+	 */
+	data->last_deep = jiffies;
 
 	return 0;
 }
@@ -132,6 +170,11 @@ static void __exit exit_menu(void)
 	cpuidle_unregister_governor(&menu_governor);
 }
 
+module_param(min_deep_sleep, uint, 0644)
+MODULE_PARM_DESC(min_deep_sleep, "min time (us) to spend in deep sleep to avoid noise")
+
+module_param(failed_deep, uint, 0644)
+
 MODULE_LICENSE("GPL");
 module_init(init_menu);
 module_exit(exit_menu);


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
