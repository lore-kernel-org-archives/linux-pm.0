From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/37] suspend: fix ia64 allmodconfig build
Date: Thu, 31 Jan 2008 23:36:56 -0500
Message-ID: <fbfe034f5ef51cdd8338a868a2101608f8c45757.1201840183.git.len.brown__41249.7370540679$1201843471$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

kernel/power/main.c:488: error: ‘pm_test_attr’ undeclared here (not in a function)

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5688168..050a607 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -53,10 +53,6 @@ int pm_notifier_call_chain(unsigned long val)
 			== NOTIFY_BAD) ? -EINVAL : 0;
 }
 
-#endif /* CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_SUSPEND
-
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -132,6 +128,7 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
+#endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_SUSPEND
 
@@ -495,7 +492,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
 #endif
-#ifdef CONFIG_PM_DEBUG
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_DEBUG)
 	&pm_test_attr.attr,
 #endif
 	NULL,
-- 
1.5.4.rc5.16.gc0279
