From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Sun, 10 Feb 2013 00:58:12 -0500
Message-ID: <8408629d64626937a5202751703dae7f41941f7a.1360475150.git.len.brown@intel.com>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360475903-30007-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

pm_idle is dead code on blackfin.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
---
 arch/blackfin/kernel/process.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/process.c
index 3e16ad9..8061426 100644
--- a/arch/blackfin/kernel/process.c
+++ b/arch/blackfin/kernel/process.c
@@ -39,12 +39,6 @@ int nr_l1stack_tasks;
 void *l1_stack_base;
 unsigned long l1_stack_len;
 
-/*
- * Powermanagement idle function, if any..
- */
-void (*pm_idle)(void) = NULL;
-EXPORT_SYMBOL(pm_idle);
-
 void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
 
@@ -81,7 +75,6 @@ void cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-		void (*idle)(void) = pm_idle;
 
 #ifdef CONFIG_HOTPLUG_CPU
 		if (cpu_is_offline(smp_processor_id()))
-- 
1.8.1.3.535.ga923c31
