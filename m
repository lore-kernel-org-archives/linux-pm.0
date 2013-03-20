From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] thermal: Fix compiler warning
Date: Wed, 20 Mar 2013 18:38:07 -0300
Message-ID: <1363815487-7191-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50372 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3CTViJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 17:38:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>

The following warning is obtained when CONFIG_NET is not defined:

In file included from drivers/thermal/mvebu_thermal.c:27:0:
include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event'
defined but not used [-Wunused-function]

This patch fixes the warning by properly inlining
thermal_generate_netlink_event().

Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 include/linux/thermal.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f0bd7f9..fd7b8f3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -251,7 +251,7 @@ void thermal_unregister_governor(struct thermal_governor *);
 extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 						enum events event);
 #else
-static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 						enum events event)
 {
 	return 0;
-- 
1.7.8.6

