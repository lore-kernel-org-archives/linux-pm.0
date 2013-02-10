From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/16] mn10300 idle: delete pm_idle
Date: Sun, 10 Feb 2013 00:58:19 -0500
Message-ID: <03881a9fd8b1aa2817cf619eb4169cf762f178c2.1360475150.git.len.brown@intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-am33-list@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

pm_idle on mn10300 served no purpose.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-am33-list@redhat.com
---
 arch/mn10300/kernel/process.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
index eb09f5a..84f4e97 100644
--- a/arch/mn10300/kernel/process.c
+++ b/arch/mn10300/kernel/process.c
@@ -37,12 +37,6 @@
 #include "internal.h"
 
 /*
- * power management idle function, if any..
- */
-void (*pm_idle)(void);
-EXPORT_SYMBOL(pm_idle);
-
-/*
  * return saved PC of a blocked thread.
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
@@ -113,7 +107,6 @@ void cpu_idle(void)
 			void (*idle)(void);
 
 			smp_rmb();
-			idle = pm_idle;
 			if (!idle) {
 #if defined(CONFIG_SMP) && !defined(CONFIG_HOTPLUG_CPU)
 				idle = poll_idle;
-- 
1.8.1.3.535.ga923c31
