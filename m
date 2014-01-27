From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
Date: Mon, 27 Jan 2014 01:08:16 -0500
Message-ID: <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
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
i.e. when FIQs are actually used.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/process.c | 5 -----
 arch/arm/kernel/setup.c   | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15dd2..725b8c95e0 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -142,11 +142,6 @@ static void default_idle(void)
 	local_irq_enable();
 }
 
-void arch_cpu_idle_prepare(void)
-{
-	local_fiq_enable();
-}
-
 void arch_cpu_idle_enter(void)
 {
 	ledtrig_cpu(CPU_LED_IDLE_START);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 987a7f5bce..d027b1a6fe 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -789,6 +789,13 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
+static int __init init_fiq_boot_cpu(void)
+{
+	local_fiq_enable();
+	return 0;
+}
+late_initcall(init_fiq_boot_cpu);
+
 #ifdef CONFIG_KEXEC
 static inline unsigned long long get_total_mem(void)
 {
-- 
1.8.4.108.g55ea5f6
