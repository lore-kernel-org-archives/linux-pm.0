From: <check.kernel@gmail.com>
Subject: [PATCH] power: align wakeup_sources format
Date: Wed, 12 Aug 2015 14:12:38 +0800
Message-ID: <1439359958-12199-1-git-send-email-check.kernel@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32915 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267AbbHLGNW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 02:13:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ethan du <duhui@xiaomi.com>, Linghua Gu <gulinghua@xiaomi.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yangdongdong <yangdongdong@xiaomi.com>

From: yangdongdong <yangdongdong@xiaomi.com>

This aligns every column of elements in wakeup_sources to
conveniently check any specific column for suspicious power
consumption wakeup source or for other easily readable purpose.

Signed-off-by: yangdongdong <yangdongdong@xiaomi.com>
Signed-off-by: Linghua Gu <gulinghua@xiaomi.com>
---
 drivers/base/power/wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 51f15bc..b6fe9e6 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -998,7 +998,7 @@ static int print_wakeup_source_stats(struct seq_file *m,
 		active_time = ktime_set(0, 0);
 	}
 
-	seq_printf(m, "%-12s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
+	seq_printf(m, "%-32s\t%lu\t\t%lu\t\t%lu\t\t%lu\t\t%lld\t\t%lld\t\t%lld\t\t%lld\t\t%lld\n",
 		   ws->name, active_count, ws->event_count,
 		   ws->wakeup_count, ws->expire_count,
 		   ktime_to_ms(active_time), ktime_to_ms(total_time),
@@ -1018,7 +1018,7 @@ static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
 {
 	struct wakeup_source *ws;
 
-	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
+	seq_puts(m, "name\t\t\t\t\tactive_count\tevent_count\twakeup_count\t"
 		"expire_count\tactive_since\ttotal_time\tmax_time\t"
 		"last_change\tprevent_suspend_time\n");
 
-- 
2.5.0

The signed name is updated from "Andy Yang" to yangdongdong.

Best Regards,
Andy

On Wed, Aug 12, 2015 at 12:31:14PM +0800, check.kernel@gmail.com wrote:
> From: yangdongdong <yangdongdong@xiaomi.com>

Use the same name here as you used for the signed-off-by: line please.

Please fix and resend.

thanks,

greg k-h
