From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 6/9] ARM: zynq: cpuidle: Remove pointless code
Date: Wed, 20 Aug 2014 13:41:52 -0700
Message-ID: <1408567315-28479-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The core is not powered down, it is pointless to call the cpu_pm notifiers and
switch to the global timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-and-tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/cpuidle/cpuidle-zynq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index aded75928028..c61b8b2a7c77 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -26,7 +26,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/cpu_pm.h>
 #include <linux/cpuidle.h>
 #include <linux/platform_device.h>
 #include <asm/proc-fns.h>
@@ -38,15 +37,9 @@
 static int zynq_enter_idle(struct cpuidle_device *dev,
 			   struct cpuidle_driver *drv, int index)
 {
-	/* Devices must be stopped here */
-	cpu_pm_enter();
-
 	/* Add code for DDR self refresh start */
 	cpu_do_idle();
 
-	/* Add code for DDR self refresh stop */
-	cpu_pm_exit();
-
 	return index;
 }
 
@@ -59,8 +52,7 @@ static struct cpuidle_driver zynq_idle_driver = {
 			.enter			= zynq_enter_idle,
 			.exit_latency		= 10,
 			.target_residency	= 10000,
-			.flags			= CPUIDLE_FLAG_TIME_VALID |
-						  CPUIDLE_FLAG_TIMER_STOP,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
 			.name			= "RAM_SR",
 			.desc			= "WFI and RAM Self Refresh",
 		},
-- 
2.0.1.1.gfbfc394
