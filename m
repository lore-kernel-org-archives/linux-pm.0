From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] PM / sleep: fix device reference leak in test_suspend
Date: Tue,  1 Nov 2016 11:49:56 +0100
Message-ID: <1477997396-29476-1-git-send-email-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36606 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168617AbcKAKuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 06:50:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

Make sure to drop the reference taken by class_find_device() after
opening the rtc device.

Fixes: 77437fd4e61f ("pm: boot time suspend selftest")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 kernel/power/suspend_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index 084452e34a12..bdff5ed57f10 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -203,8 +203,10 @@ static int __init test_suspend(void)
 
 	/* RTCs have initialized by now too ... can we use one? */
 	dev = class_find_device(rtc_class, NULL, NULL, has_wakealarm);
-	if (dev)
+	if (dev) {
 		rtc = rtc_class_open(dev_name(dev));
+		put_device(dev);
+	}
 	if (!rtc) {
 		printk(warn_no_rtc);
 		return 0;
-- 
2.7.3

