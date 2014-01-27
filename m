From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 3/9] idle: no more arch_cpu_idle_prepare() users
Date: Mon, 27 Jan 2014 01:08:18 -0500
Message-ID: <1390802904-28399-4-git-send-email-nicolas.pitre@linaro.org>
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

... so we can get rid of it entirely.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/linux/cpu.h | 1 -
 kernel/cpu/idle.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 03e235ad1b..218fab7521 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -221,7 +221,6 @@ void cpu_idle(void);
 void cpu_idle_poll_ctrl(bool enable);
 
 void arch_cpu_idle(void);
-void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
 void arch_cpu_idle_dead(void);
diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 988573a9a3..4e327e211b 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -52,7 +52,6 @@ static inline int cpu_idle_poll(void)
 }
 
 /* Weak implementations for optional arch specific functions */
-void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
 void __weak arch_cpu_idle_dead(void) { }
@@ -136,6 +135,5 @@ void cpu_startup_entry(enum cpuhp_state state)
 	boot_init_stack_canary();
 #endif
 	__current_set_polling();
-	arch_cpu_idle_prepare();
 	cpu_idle_loop();
 }
-- 
1.8.4.108.g55ea5f6
