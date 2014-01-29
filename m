From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2 4/6] SH: remove redundant cpuidle_idle_call()
Date: Wed, 29 Jan 2014 12:45:11 -0500
Message-ID: <1391017513-12995-5-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 2ea4483fd7..be616ee0cf 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -16,7 +16,6 @@
 #include <linux/thread_info.h>
 #include <linux/irqflags.h>
 #include <linux/smp.h>
-#include <linux/cpuidle.h>
 #include <linux/atomic.h>
 #include <asm/pgalloc.h>
 #include <asm/smp.h>
@@ -40,8 +39,7 @@ void arch_cpu_idle_dead(void)
 
 void arch_cpu_idle(void)
 {
-	if (cpuidle_idle_call())
-		sh_idle();
+	sh_idle();
 }
 
 void __init select_idle_routine(void)
-- 
1.8.4.108.g55ea5f6

