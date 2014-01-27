From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 8/9] X86: remove redundant cpuidle_idle_call()
Date: Mon, 27 Jan 2014 01:08:23 -0500
Message-ID: <1390802904-28399-9-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/x86/kernel/process.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3fb8d95ab8..4505e2a950 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
  */
 void arch_cpu_idle(void)
 {
-	if (cpuidle_idle_call())
-		x86_idle();
-	else
-		local_irq_enable();
+	x86_idle();
 }
 
 /*
-- 
1.8.4.108.g55ea5f6

