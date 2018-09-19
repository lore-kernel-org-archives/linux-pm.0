From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 12/12][RFC v3] x86-32, hibernate: Adjust in_suspend after resumed on 32bit system
Date: Wed, 19 Sep 2018 15:43:42 +0800
Message-ID: <e2b157a14ddadb557c07ed2e081637c0e1dbff5e.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Update the in_suspend variable to reflect the actual hibernation
status. Back-port from 64bit system.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_asm_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 01f653fae7bd..6fe383002125 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -103,5 +103,8 @@ ENTRY(restore_registers)
 
 	xorl	%eax, %eax
 
+	/* tell the hibernation core that we've just restored the memory */
+	movl	%eax, in_suspend
+
 	ret
 ENDPROC(restore_registers)
-- 
2.17.1
