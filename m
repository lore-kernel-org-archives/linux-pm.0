From: "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH v10 13/14] x86/i387.c: Initialize thread xstate only on CPU0 only once
Date: Tue, 13 Nov 2012 11:32:50 -0800
Message-ID: <1352835171-3958-14-git-send-email-fenghua.yu@intel.com>
References: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352835171-3958-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Asit K Mallick <asit.k.mallick@intel.com>, Tony Luck <tony.luck@intel.com>, Arjan Dan De Ven <arjan@linux.intel.com>, Suresh B Siddha <suresh.b.siddha@intel.com>, Len Brown <len.brown@intel.com>, "Srivatssa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chen Gong <gong.chen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, x86 <x86@kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

init_thread_xstate() is only called once to avoid overriding xstate_size during
boot time or during CPU hotplug.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/i387.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/i387.c b/arch/x86/kernel/i387.c
index 675a050..245a71d 100644
--- a/arch/x86/kernel/i387.c
+++ b/arch/x86/kernel/i387.c
@@ -175,7 +175,11 @@ void __cpuinit fpu_init(void)
 		cr0 |= X86_CR0_EM;
 	write_cr0(cr0);
 
-	if (!smp_processor_id())
+	/*
+	 * init_thread_xstate is only called once to avoid overriding
+	 * xstate_size during boot time or during CPU hotplug.
+	 */
+	if (xstate_size == 0)
 		init_thread_xstate();
 
 	mxcsr_feature_mask_init();
-- 
1.7.2
