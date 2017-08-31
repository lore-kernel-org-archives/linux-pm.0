From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] ARM: cpuidle: Avoid memleak if init fail
Date: Thu, 31 Aug 2017 22:24:36 +0200
Message-ID: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:51758 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdHaUZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 16:25:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Leo Yan <leo.yan@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

In case there are no DT idle states defined or
cpuidle_register_driver() fails, the copy of the idle driver is leaked:

    unreferenced object 0xede0dc00 (size 1024):
    comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
    hex dump (first 32 bytes):
    94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00 ................
    57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00 WFI.............
    backtrace:
    [<c1295f04>] arm_idle_init+0x44/0x1ac
    [<c0301e6c>] do_one_initcall+0x3c/0x16c
    [<c1200d70>] kernel_init_freeable+0x110/0x1d0
    [<c0cb3624>] kernel_init+0x8/0x114
    [<c0307a98>] ret_from_fork+0x14/0x3c

So fix this by freeing the unregistered copy in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
---
 drivers/cpuidle/cpuidle-arm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 7080c38..52a7505 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -104,13 +104,13 @@ static int __init arm_idle_init(void)
 		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
 		if (ret <= 0) {
 			ret = ret ? : -ENODEV;
-			goto out_fail;
+			goto init_fail;
 		}
 
 		ret = cpuidle_register_driver(drv);
 		if (ret) {
 			pr_err("Failed to register cpuidle driver\n");
-			goto out_fail;
+			goto init_fail;
 		}
 
 		/*
@@ -149,6 +149,8 @@ static int __init arm_idle_init(void)
 	}
 
 	return 0;
+init_fail:
+	kfree(drv);
 out_fail:
 	while (--cpu >= 0) {
 		dev = per_cpu(cpuidle_devices, cpu);
-- 
2.7.4
