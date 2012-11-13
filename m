From: "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH v10 07/14] x86-64, hotplug: Add start_cpu0() entry point to head_64.S
Date: Tue, 13 Nov 2012 11:32:44 -0800
Message-ID: <1352835171-3958-8-git-send-email-fenghua.yu@intel.com>
References: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Asit K Mallick <asit.k.mallick@intel.com>, Tony Luck <tony.luck@intel.com>, Arjan Dan De Ven <arjan@linux.intel.com>, Suresh B Siddha <suresh.b.siddha@intel.com>, Len Brown <len.brown@intel.com>, "Srivatssa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chen Gong <gong.chen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, x86 <x86@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

start_cpu0() is defined in head_64.S for 64-bit. The function sets up stack and
jumps to start_secondary() for CPU0 wake up.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/head_64.S |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 94bf9cc..980053c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -252,6 +252,22 @@ ENTRY(secondary_startup_64)
 	pushq	%rax		# target address in negative space
 	lretq
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
+ * up already except stack. We just set up stack here. Then call
+ * start_secondary().
+ */
+ENTRY(start_cpu0)
+	movq stack_start(%rip),%rsp
+	movq	initial_code(%rip),%rax
+	pushq	$0		# fake return address to stop unwinder
+	pushq	$__KERNEL_CS	# set correct cs
+	pushq	%rax		# target address in negative space
+	lretq
+ENDPROC(start_cpu0)
+#endif
+
 	/* SMP bootup changes these two */
 	__REFDATA
 	.align	8
-- 
1.7.2
