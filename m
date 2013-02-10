From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/16] microblaze idle: delete pm_idle
Date: Sun, 10 Feb 2013 00:58:18 -0500
Message-ID: <fe98b401efe3034c1684b8625ac266601c3b4ad1.1360475150.git.len.brown@intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, microblaze-uclinux@itee.uq.edu.au
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

pm_idle on microblaze served no purpose.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: microblaze-uclinux@itee.uq.edu.au
---
 arch/microblaze/kernel/process.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index a5b74f7..6ff2dcf 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -41,7 +41,6 @@ void show_regs(struct pt_regs *regs)
 				regs->msr, regs->ear, regs->esr, regs->fsr);
 }
 
-void (*pm_idle)(void);
 void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
@@ -98,8 +97,6 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
-
 		if (!idle)
 			idle = default_idle;
 
-- 
1.8.1.3.535.ga923c31
