From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / sleep: Fix test_suspend after sleep state rework
Date: Fri, 17 Feb 2017 14:18:44 +0100
Message-ID: <1487337524-26094-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:37008 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbdBQNSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 08:18:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When passing "test_suspend=mem" to the kernel:

    PM: can't test 'mem' suspend state

and the suspend test is not run.

Commit 406e79385f3223d8 ("PM / sleep: System sleep state selection
interface rework") changed pm_labels[] from a contiguous NULL-terminated
array to a sparse array (with the first element unpopulated), breaking
the assumptions of the iterator in setup_test_suspend().

Iterate from PM_SUSPEND_MIN to PM_SUSPEND_MAX - 1 to fix this.

Fixes: 406e79385f3223d8 ("PM / sleep: System sleep state selection interface rework")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/power/suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index bdff5ed57f10a5ef..5db217051232de97 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -166,7 +166,7 @@ static int __init setup_test_suspend(char *value)
 			return 0;
 	}
 
-	for (i = 0; pm_labels[i]; i++)
+	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
 		if (!strcmp(pm_labels[i], suspend_type)) {
 			test_state_label = pm_labels[i];
 			return 0;
-- 
1.9.1
