From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: correct Kconfig dependency
Date: Mon, 14 Nov 2011 16:57:24 +0900
Message-ID: <CAJ0PZbSO7n7P0r_i+tOWmxtzxx0T9kTRgnC2eLXn9m69k5HsKw@mail.gmail.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Devfreq does not depend on OPP. The dependency is removed.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/devfreq/Kconfig |   41 +++++++++++++++++------------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 8fd34e7..87a742f 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -1,36 +1,29 @@
-config ARCH_HAS_DEVFREQ
-	bool
-	depends on ARCH_HAS_OPP
-	help
-	  Denotes that the architecture supports DEVFREQ. If the architecture
-	  supports multiple OPP entries per device and the frequency of the
-	  devices with OPPs may be altered dynamically, the architecture
-	  supports DEVFREQ.
-
 menuconfig PM_DEVFREQ
 	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
-	depends on PM_OPP && ARCH_HAS_DEVFREQ
 	help
-	  With OPP support, a device may have a list of frequencies and
-	  voltages available. DEVFREQ, a generic DVFS framework can be
-	  registered for a device with OPP support in order to let the
-	  governor provided to DEVFREQ choose an operating frequency
-	  based on the OPP's list and the policy given with DEVFREQ.
+	  A device may have a list of frequencies and voltages available.
+	  devfreq, a generic DVFS framework can be registered for a device
+	  in order to let the governor provided to devfreq choose an
+	  operating frequency based on the device driver's policy.

-	  Each device may have its own governor and policy. DEVFREQ can
+	  Each device may have its own governor and policy. Devfreq can
 	  reevaluate the device state periodically and/or based on the
-	  OPP list changes (each frequency/voltage pair in OPP may be
-	  disabled or enabled).
+	  notification to "nb", a notifier block, of devfreq.

-	  Like some CPUs with CPUFREQ, a device may have multiple clocks.
+	  Like some CPUs with CPUfreq, a device may have multiple clocks.
 	  However, because the clock frequencies of a single device are
-	  determined by the single device's state, an instance of DEVFREQ
+	  determined by the single device's state, an instance of devfreq
 	  is attached to a single device and returns a "representative"
-	  clock frequency from the OPP of the device, which is also attached
-	  to a device by 1-to-1. The device registering DEVFREQ takes the
-	  responsiblity to "interpret" the frequency listed in OPP and
+	  clock frequency of the device, which is also attached
+	  to a device by 1-to-1. The device registering devfreq takes the
+	  responsiblity to "interpret" the representative frequency and
 	  to set its every clock accordingly with the "target" callback
-	  given to DEVFREQ.
+	  given to devfreq.
+
+	  When OPP is used with the devfreq device, it is recommended to
+	  register devfreq's nb to the OPP's notifier head.  If OPP is
+	  used with the devfreq device, you may use OPP helper
+	  functions defined in devfreq.h.

 if PM_DEVFREQ

-- 
1.7.4.1
