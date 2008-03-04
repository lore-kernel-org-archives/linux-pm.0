From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 07:14:23 +0100
Message-ID: <20080304071423.0e6b71c1__14429.7425322749$1204611543$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304040048.GA31562@codemonkey.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Many devices today are of a less than stellar quality, and singing
capacitors are a common problem. A high-pitch noise is created, caused
by power fluctuations as the processor enters and leaves deep sleep at
a high frequency.

Instead of just disabling the deep sleep (which wastes power), this
patch allows you to reduces the number of times it is entered so that
the frequency can be kept inaudible.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
--

I'm not religious about the default value, and since Dave Jones piped
in I guess one of my major arguments are gone. :)

Here's the same patch with the default set to 0 (effectively disabling
the patch).

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 78d77c5..d9c43e3 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -16,6 +16,8 @@
 
 #define BREAK_FUZZ     4       /* 4 us */
 
+static unsigned int min_deep_sleep = 0;
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
+                * don't enter a deep sleep for short durations (a value
+                * of 2 ms is usually sufficient). This will, hopefully,
+                * keep the problem inaudible.
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
