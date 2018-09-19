From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 10/12][RFC v3] x86-32, hibernate: Switch to relocated restore code during resume on 32bit system
Date: Wed, 19 Sep 2018 15:43:12 +0800
Message-ID: <7a562ef6f77ff83c1fbdc6a2ecc7af387ce1fd71.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Code should be executed in a safe page during page
restoring, as the page where instruction is running
during resume might be scribbled and causes issues.

Backport the code from 64 bit system to fix this bug.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 4 ++++
 arch/x86/power/hibernate_asm_32.S | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index a44bdada4e4e..a9861095fbb8 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -158,6 +158,10 @@ asmlinkage int swsusp_arch_resume(void)
 
 	temp_pgt = __pa(resume_pg_dir);
 
+	error = relocate_restore_code();
+	if (error)
+		return error;
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6b2b94937113..e9adda6b6b02 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -39,6 +39,13 @@ ENTRY(restore_image)
 	movl	restore_cr3, %ebp
 
 	movl	mmu_cr4_features, %ecx
+
+	/* jump to relocated restore code */
+	movl	relocated_restore_code, %eax
+	jmpl	*%eax
+
+/* code below has been relocated to a safe page */
+ENTRY(core_restore_code)
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
-- 
2.17.1
