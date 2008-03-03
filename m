From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 3 Mar 2008 21:18:42 +0100
Message-ID: <20080303211842.6f492782__29771.7505055063$1204575735$gmane$org@mjolnir.drzeus.cx>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Many devices today are of a less than stellar quality, and singing
capacitors are a common problem. A high-pitch noise is created, caused
by power fluctuations as the processor enters and leaves deep sleep at
a high frequency.

Instead of just disabling the deep sleep (which wastes power). This
patch merely reduces the number of times it is entered so that the
frequency doesn't exceed 500 Hz. That should make sure the problem is
inaudible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
--

I've been playing around with this for a bit, and the jiffies approach
just had too many gotchas. So I tried using the information that was
already present in the menu governor. This is what I came up with.

It solves the primary problem of getting rid of the noise. I've also
tried some crude power measurements and I couldn't get any difference
with and without the patch. Powertop also nicely shows that the CPU is
still spending almost all of its time in C3. Therefore, I'm letting the
effects of it be enabled by default.

So I'm taking the [RFC] off it. Please still test and see that it
solves the issue on other machines, and the it does not cause any big
power surges.

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 78d77c5..d9c43e3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -16,6 +16,8 @@
 
 #define BREAK_FUZZ     4       /* 4 us */
 
+static unsigned int min_deep_sleep = 2000;
+
 struct menu_device {
        int             last_state_idx;
 
@@ -50,6 +52,19 @@ static int menu_select(struct cpuidle_device *dev)
                        break;
                if (s->exit_latency > pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY))
                        break;
+
+               /*
+                * In order to avoid the problem of "singing capacitors",
+                * don't enter a deep sleep for short durations (by
+                * default, nothing shorter than 2 ms). This will,
+                * hopefully, keep the problem inaudible.
+                */
+               if (s->flags & CPUIDLE_FLAG_DEEP) {
+                       if (min_deep_sleep > data->expected_us)
+                               break;
+                       if (min_deep_sleep > data->predicted_us)
+                               break;
+               }
        }
 
        data->last_state_idx = i - 1;
@@ -132,6 +147,9 @@ static void __exit exit_menu(void)
        cpuidle_unregister_governor(&menu_governor);
 }
 
+module_param(min_deep_sleep, uint, 0644)
+MODULE_PARM_DESC(min_deep_sleep, "min time (us) to spend in deep sleep to avoid noise")
+
 MODULE_LICENSE("GPL");
 module_init(init_menu);
 module_exit(exit_menu);



-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
