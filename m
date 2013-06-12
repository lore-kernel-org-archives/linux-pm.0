From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/8] cpuidle: Remove governor module format
Date: Wed, 12 Jun 2013 15:08:48 +0200
Message-ID: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33214 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3FLNIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:08:55 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so456026wib.12
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:08:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The governors are defined as module in the code, but the Kconfig options do not
allow to compile them as module. This is not really a problem but the init
order is: the cpuidle init functions (framework and driver) and then the
governors. That leads to some weirdness in the cpuidle framework because the
function cpuidle_register_device calls cpuidle_enable_device which in turns
fails at the first attempt because no governor is registered. When the
governor is registered, the framework calls cpuidle_enable_device again which
will invoke the __cpuidle_register_device function. Of course, in order to make
this to work, the return code of cpuidle_enable_device is not checked by the
caller in cpuidle_register_device.

Instead of having this cyclic call graph and relying on a positive side effect
of the hackish back and forth call to cpuidle_enable_device, let's fix the
init order for the governor in order to clean up the cpuidle_enable_device
function.

Remove the module init code and replaced it with postcore_initcall, so we have:

 * cpuidle framework : core_initcall
 * cpuidle governors : postcore_initcall
 * cpuidle drivers   : device_initcall

Remove exit module code as it is dead code (governors aren't compiled as
module).

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/ladder.c |   12 +-----------
 drivers/cpuidle/governors/menu.c   |   12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 9b78405..9f08e8c 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -192,14 +192,4 @@ static int __init init_ladder(void)
 	return cpuidle_register_governor(&ladder_governor);
 }
 
-/**
- * exit_ladder - exits the governor
- */
-static void __exit exit_ladder(void)
-{
-	cpuidle_unregister_governor(&ladder_governor);
-}
-
-MODULE_LICENSE("GPL");
-module_init(init_ladder);
-module_exit(exit_ladder);
+postcore_initcall(init_ladder);
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index fe343a0..743138c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -540,14 +540,4 @@ static int __init init_menu(void)
 	return cpuidle_register_governor(&menu_governor);
 }
 
-/**
- * exit_menu - exits the governor
- */
-static void __exit exit_menu(void)
-{
-	cpuidle_unregister_governor(&menu_governor);
-}
-
-MODULE_LICENSE("GPL");
-module_init(init_menu);
-module_exit(exit_menu);
+postcore_initcall(init_menu);
-- 
1.7.9.5

