From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] idle: Remove cpu_idle() forward declarations
Date: Fri, 23 May 2014 10:54:22 +0200
Message-ID: <1400835265-21956-2-git-send-email-geert+renesas@glider.be>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:45489 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaEWIyn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 04:54:43 -0400
In-Reply-To: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

After all architectures were converted to the generic idle framework,
commit d190e8195b90bc1e65c494fe08e54e9e581bfd16 ("idle: Remove
GENERIC_IDLE_LOOP config switch") removed the last caller of cpu_idle().
The forward declarations in header files were forgotten.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/cpu.h | 1 -
 include/linux/smp.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 81887120395c..95978ad7fcdd 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -256,7 +256,6 @@ enum cpuhp_state {
 };
 
 void cpu_startup_entry(enum cpuhp_state state);
-void cpu_idle(void);
 
 void cpu_idle_poll_ctrl(bool enable);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 633f5edd7470..34347f26be9b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -13,8 +13,6 @@
 #include <linux/init.h>
 #include <linux/llist.h>
 
-extern void cpu_idle(void);
-
 typedef void (*smp_call_func_t)(void *info);
 struct call_single_data {
 	struct llist_node llist;
-- 
1.9.1

