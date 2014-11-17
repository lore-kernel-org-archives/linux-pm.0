From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2] cpu_pm: fix unmet dependency for CPU_PM
Date: Mon, 17 Nov 2014 11:42:44 +0530
Message-ID: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43728 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbaKQGTI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 01:19:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux@arm.linux.org.uk, nico@linaro.org, ccross@android.com, Pankaj Dubey <pankaj.dubey@samsung.com>

If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
we are getting following config warning.

warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
dependencies (SUSPEND || CPU_IDLE)

It has been noticed that CPU_PM dependencies in this file are not really
required so let's remove these dependencies from CPU_PM.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
This patch is second attempt to fix this config issue. Patch v1 and related
discussion can be found here [1]
1: https://lkml.org/lkml/2014/11/14/673

 kernel/power/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index bbef57f..1eb7da7 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -308,4 +308,3 @@ config PM_GENERIC_DOMAINS_OF
 
 config CPU_PM
 	bool
-	depends on SUSPEND || CPU_IDLE
-- 
1.7.9.5

