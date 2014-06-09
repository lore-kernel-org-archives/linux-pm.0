From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 5/7] cpufreq: intel_pstate: Remove redundant includes
Date: Tue, 10 Jun 2014 00:00:55 +0300
Message-ID: <53962087.8000706@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Also put them in alphabetical order.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/intel_pstate.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 26a0262..d4f0518 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -10,26 +10,13 @@
  * of the License.
  */
 
-#include <linux/kernel.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/ktime.h>
-#include <linux/hrtimer.h>
-#include <linux/tick.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/list.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/sysfs.h>
-#include <linux/types.h>
-#include <linux/fs.h>
 #include <linux/debugfs.h>
-#include <linux/acpi.h>
+#include <linux/module.h>
 #include <trace/events/power.h>
 
-#include <asm/div64.h>
-#include <asm/msr.h>
 #include <asm/cpu_device_id.h>
 
 #define BYT_RATIOS		0x66a
-- 
1.9.3
