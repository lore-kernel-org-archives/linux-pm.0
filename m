From: Joe Perches <joe@perches.com>
Subject: [PATCH 06/27] power: wakeup: Remove use of seq_printf return value
Date: Sat, 21 Feb 2015 18:53:33 -0800
Message-ID: <1b5eb664ab9313f1c5b9868819e1960d5dc597ac.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:42654 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752420AbbBVCyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Feb 2015 21:54:52 -0500
In-Reply-To: <cover.1424573328.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The seq_printf return value, because it's frequently misused,
will eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/power/wakeup.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index c2744b3..23fe220 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -842,7 +842,6 @@ static int print_wakeup_source_stats(struct seq_file *m,
 	unsigned long active_count;
 	ktime_t active_time;
 	ktime_t prevent_sleep_time;
-	int ret;
 
 	spin_lock_irqsave(&ws->lock, flags);
 
@@ -865,17 +864,16 @@ static int print_wakeup_source_stats(struct seq_file *m,
 		active_time = ktime_set(0, 0);
 	}
 
-	ret = seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t"
-			"%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
-			ws->name, active_count, ws->event_count,
-			ws->wakeup_count, ws->expire_count,
-			ktime_to_ms(active_time), ktime_to_ms(total_time),
-			ktime_to_ms(max_time), ktime_to_ms(ws->last_time),
-			ktime_to_ms(prevent_sleep_time));
+	seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
+		   ws->name, active_count, ws->event_count,
+		   ws->wakeup_count, ws->expire_count,
+		   ktime_to_ms(active_time), ktime_to_ms(total_time),
+		   ktime_to_ms(max_time), ktime_to_ms(ws->last_time),
+		   ktime_to_ms(prevent_sleep_time));
 
 	spin_unlock_irqrestore(&ws->lock, flags);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.1.2

