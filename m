From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 7/9] PM: Make suspend_ops static
Date: Sat, 30 Jun 2007 23:09:57 +0200
Message-ID: <200706302309.58612.rjw__8937.6148222529$1183238007$gmane$org@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The variable suspend_ops representing the set of global platform-specific
suspend-related operations, used by the PM core, need not be exported outside of
kernel/power/main.c .  Make it static.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |    2 --
 kernel/power/main.c     |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.22-rc6-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/include/linux/suspend.h	2007-06-30 21:21:15.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/linux/suspend.h	2007-06-30 21:21:33.000000000 +0200
@@ -77,8 +77,6 @@ struct platform_suspend_ops {
 	void (*finish)(void);
 };
 
-extern struct platform_suspend_ops *suspend_ops;
-
 #ifdef CONFIG_PM
 /**
  * suspend_set_ops - set platform dependent suspend operations
Index: linux-2.6.22-rc6-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/main.c	2007-06-30 21:21:01.000000000 +0200
+++ linux-2.6.22-rc6-mm1/kernel/power/main.c	2007-06-30 21:21:33.000000000 +0200
@@ -30,7 +30,7 @@ BLOCKING_NOTIFIER_HEAD(pm_chain_head);
 
 DEFINE_MUTEX(pm_mutex);
 
-struct platform_suspend_ops *suspend_ops;
+static struct platform_suspend_ops *suspend_ops;
 
 /**
  *	suspend_set_ops - Set the global suspend method table.
