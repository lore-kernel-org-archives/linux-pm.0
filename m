From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / sleep: Fix symbol name in a comment in kernel/power/main.c
Date: Wed, 13 May 2015 15:55:14 +0200
Message-ID: <2522466.1nvD3f7G6B@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -272,7 +272,7 @@ static inline void pm_print_times_init(v
 {
 	pm_print_times_enabled = !!initcall_debug;
 }
-#else /* !CONFIG_PP_SLEEP_DEBUG */
+#else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
