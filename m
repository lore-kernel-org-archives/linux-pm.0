From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] PM: Add pm_ops_ptr() macro
Date: Sat, 27 Apr 2013 11:54:50 +0900
Message-ID: <000001ce42f2$96128cc0$c237a640$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65239 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3D0Cyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 22:54:52 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, 'Pavel Machek' <pavel@ucw.cz>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Add pm_ops_ptr() macro that allows the .pm entry in the driver structures
to be assigned without having an #define xxx NULL for the case that PM is
not enabled.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/linux/pm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..bd50d15 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -55,8 +55,10 @@ struct device;
 
 #ifdef CONFIG_PM
 extern const char power_group_name[];		/* = "power" */
+#define pm_ops_ptr(_ptr)	(_ptr)
 #else
 #define power_group_name	NULL
+#define pm_ops_ptr(_ptr)	NULL
 #endif
 
 typedef struct pm_message {
-- 
1.7.2.5


