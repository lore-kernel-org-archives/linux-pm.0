From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 08/12][v4] x86-32, hibernate: Use the page size macro instead of constant value
Date: Fri, 21 Sep 2018 14:28:01 +0800
Message-ID: <36f19e1280b5962e1e516fce4407473f8941d49a.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Convert the hard code into PAGE_SIZE for better scalability.

No functional change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_asm_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index f0627cf30a36..f5103ae96582 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -52,7 +52,7 @@ copy_loop:
 	movl	pbe_address(%edx), %esi
 	movl	pbe_orig_address(%edx), %edi
 
-	movl	$1024, %ecx
+	movl	$(PAGE_SIZE >> 2), %ecx
 	rep
 	movsl
 
-- 
2.17.1
