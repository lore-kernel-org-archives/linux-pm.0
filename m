From: <check.kernel@gmail.com>
Subject: (unknown)
Date: Fri, 14 Aug 2015 16:53:52 +0800
Message-ID: <1439542432-487-1-git-send-email-check.kernel@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f195.google.com ([209.85.192.195]:32972 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbbHNIya (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 04:54:30 -0400
Subject: 
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ethan du <duhui@xiaomi.com>, Linghua Gu <gulinghua@xiaomi.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dongdong Yang <yangdongdong@xiaomi.com>

>From c24574f0f0fc34204353a73f431d2be6908e90b2 Mon Sep 17 00:00:00 2001
From: yangdongdong <yangdongdong@xiaomi.com>
Date: Wed, 12 Aug 2015 12:10:51 +0800
Subject: [PATCH] power: align wakeup_sources format

This aligns every column of elements in wakeup_sources to
conveniently check any specific column for suspicious power
consumption wakeup source or for other easily readable purpose.

Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
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

On Thursday, August 13, 2015 10:24:49 AM check.kernel@gmail.com wrote:
> From: yangdongdong <yangdongdong@xiaomi.com>
>
> This aligns every column of elements in wakeup_sources to
> conveniently check any specific column for suspicious power
> consumption wakeup source or for other easily readable purpose.
>
> Signed-off-by: yangdongdong <yangdongdong@xiaomi.com>

Is yangdongdong your real name, ie. one you would use when checking in
at a hotel etc.?  If not, it is not appropriate for signing off a patch.

Thanks,
Rafael


My surname is Yang, and given name is Dongdong. It is my real name and be
printed at my passport. Thanks for your prudence to confirm it with me.
BTW, Andy Yang is my English name when I worked for foreign company.

Best Regards,
Dongdong Yang
