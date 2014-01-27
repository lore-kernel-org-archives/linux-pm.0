From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
Date: Mon, 27 Jan 2014 01:08:17 -0500
Message-ID: <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

ARM and ARM64 are the only two architectures implementing
arch_cpu_idle_prepare() simply to call local_fiq_enable().

We have secondary_start_kernel() already calling local_fiq_enable() and
this is done a second time in arch_cpu_idle_prepare() in that case. And
enabling FIQs has nothing to do with idling the CPU to start with.

So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
at late_initcall time but this shouldn't make a difference in practice
given that FIQs are not currently used on ARM64.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm64/kernel/process.c | 5 -----
 arch/arm64/kernel/setup.c   | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89985..f6c733da67 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -84,11 +84,6 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
-void arch_cpu_idle_prepare(void)
-{
-	local_fiq_enable();
-}
-
 /*
  * This is our default idle handler.
  */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bd9bbd0e44..259557983a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -255,6 +255,13 @@ static int __init arm64_device_init(void)
 }
 arch_initcall(arm64_device_init);
 
+static int __init init_fiq_boot_cpu(void)
+{
+	local_fiq_enable();
+	return 0;
+}
+late_initcall(init_fiq_boot_cpu);
+
 static DEFINE_PER_CPU(struct cpu, cpu_data);
 
 static int __init topology_init(void)
-- 
1.8.4.108.g55ea5f6
