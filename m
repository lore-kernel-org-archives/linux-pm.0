From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] PM / runtime: Use synchronous runtime PM call in
 rpm_put_suppliers()
Date: Wed, 22 Mar 2017 10:22:50 +0100
Message-ID: <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:55661 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933703AbdCVJfw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 05:35:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

rpm_put_suppliers() might be called as a result of pm_runtime_put_sync()
call, where the called explicitly wants to perform the operation in
synchronous way to avoid some deadlocks related to concurrent code
execution in the PM workers. However the current code for handling device
links always use asynchronous calls. This patch changes it to always use
the synchronous calls.

This patch fixes the potential deadlock, which appears during adding
runtime PM support to clock framework, which uses global mutex, which is
reentrant only for the current process, so trying to execute runtime PM
callback from the worker results in deadlock (the mentioned mutex is
already taken by the current process, which waits for execution of PM
worker).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Hi Rafael & Ulf,

This was the simplest way of fixing this issue. Other way would be to
propagate rpmflags to rpm_get/put_suppliers() to ensure that synchronous
calls will be also done on the linked devices. Which way is better in
your opinion?

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7bcf80fa9ada..b7df589ae579 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -292,7 +292,7 @@ static void rpm_put_suppliers(struct device *dev)
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
 		if (link->rpm_active &&
 		    READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
-			pm_runtime_put(link->supplier);
+			pm_runtime_put_sync(link->supplier);
 			link->rpm_active = false;
 		}
 }
-- 
1.9.1
