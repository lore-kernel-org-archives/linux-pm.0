From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Fri, 29 Feb 2008 19:38:12 +0100
Message-ID: <20080229193812.31f45b0c__21435.8212579556$1204313647$gmane$org@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Many devices today are of a less than stellar quality, and singing
transistors are a common problem. A high-pitch noise is created, caused
by power fluctuations as the processor enters and leaves deep sleep at
a high frequency.

Instead of just disabling the deep sleep (which wastes power). This
patch merely reduces the number of times it is entered so that the
frequency doesn't exceed 500 Hz. That should make sure the problem is
inaudible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
--

The basic idea is above, but the implementation doesn't quite work. It seems jiffies is not a good time source in this scenario. The time spent in C3 takes a much bigger hit than I expect. The fact that powertop says that it has an average residency of 200 ms in C2 tells me that those should have been spent in C3.

So, pointers on what else to do?

(Patch also needs an on/off switch, but that's a later problem)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 78d77c5..171d838 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -16,6 +16,12 @@
 
 #define BREAK_FUZZ     4       /* 4 us */
 
+/*
+ * The minimum number of ticks needed to not oscillate faster than
+ * 500 Hz.
+ */
+#define MIN_DEEP_INTERVAL (HZ / 500)
+
 struct menu_device {
        int             last_state_idx;
 
@@ -23,6 +29,8 @@ struct menu_device {
        unsigned int    predicted_us;
        unsigned int    last_measured_us;
        unsigned int    elapsed_us;
+
+       unsigned long   last_deep_jif;
 };
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -50,9 +58,16 @@ static int menu_select(struct cpuidle_device *dev)
                        break;
                if (s->exit_latency > pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY))
                        break;
+               if ((dev->states[i].flags & CPUIDLE_FLAG_DEEP) &&
+                       time_before_eq(jiffies, data->last_deep_jif + MIN_DEEP_INTERVAL))
+                       break;
        }
 
        data->last_state_idx = i - 1;
+
+       if (dev->states[i - 1].flags & CPUIDLE_FLAG_DEEP)
+               data->last_deep_jif = jiffies;
+
        return i - 1;
 }
 


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
