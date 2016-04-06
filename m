From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/13] intel_idle: remove useless return from void function.
Date: Wed,  6 Apr 2016 17:00:48 -0400
Message-ID: <8b61348c03754d7ad6025b058ab74694ac99913f.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Richard Cochran <rcochran@linutronix.de>

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 012980a..6638a80 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1397,8 +1397,6 @@ static void __exit intel_idle_exit(void)
 	__unregister_cpu_notifier(&cpu_hotplug_notifier);
 
 	cpu_notifier_register_done();
-
-	return;
 }
 
 module_init(intel_idle_init);
-- 
2.8.0.rc4.16.g56331f8
