From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / Domains: Always enable debugfs support if available
Date: Thu, 11 Aug 2016 11:40:05 +0100
Message-ID: <1470912005-10914-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16129 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcHKKkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 06:40:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Debugfs support for PM domains is only enabled if both CONFIG_PM_DEBUG
and CONFIG_PM_ADVANCED_DEBUG are enabled. CONFIG_PM_ADVANCED_DEBUG is
described as "extra PM attributes in sysfs for low-level
debugging/testing" which does not seem related.

Given that the debugfs for PM domains only allows users to view the
state of the PM domains, always enable debugfs support for PM domains
if PM domains and debugfs support is enabled.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a1f2aff33997..058c8b6d2871 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
 /***        debugfs support        ***/
 
-#ifdef CONFIG_PM_ADVANCED_DEBUG
+#ifdef CONFIG_DEBUG_FS
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
@@ -1784,4 +1784,4 @@ static void __exit pm_genpd_debug_exit(void)
 	debugfs_remove_recursive(pm_genpd_debugfs_dir);
 }
 __exitcall(pm_genpd_debug_exit);
-#endif /* CONFIG_PM_ADVANCED_DEBUG */
+#endif /* CONFIG_DEBUG_FS */
-- 
2.1.4

