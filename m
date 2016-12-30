From: Augusto Mecking Caringi <augustocaringi@gmail.com>
Subject: [PATCH] PM / domains: Fix 'may be used uninitialized' build warning
Date: Fri, 30 Dec 2016 11:34:08 +0000
Message-ID: <1483097651-7172-1-git-send-email-augustocaringi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35931 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753820AbcL3Le6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 06:34:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: torvalds@linux-foundation.org, Augusto Mecking Caringi <augustocaringi@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following gcc warning:

drivers/base/power/domain.c: In function ‘genpd_runtime_resume’:
drivers/base/power/domain.c:642:14: warning: ‘time_start’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
   elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start)

The same problem (in another function in this same file) was fixed in
commit d33d5a6c88fc (avoid spurious "may be used uninitialized" warning)

Signed-off-by: Augusto Mecking Caringi <augustocaringi@gmail.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a5e1262..2997026 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -626,6 +626,7 @@ static int genpd_runtime_resume(struct device *dev)
 
  out:
 	/* Measure resume latency. */
+	time_start = 0;
 	if (timed && runtime_pm)
 		time_start = ktime_get();
 
-- 
2.7.4

