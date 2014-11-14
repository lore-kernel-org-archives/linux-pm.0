From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Move struct pm_domain_data to pm_domain.h
Date: Fri, 14 Nov 2014 08:41:32 +0100
Message-ID: <1415950892-4213-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:48566 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbaKNHlv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 02:41:51 -0500
Received: by mail-la0-f50.google.com with SMTP id hs14so8258801lab.23
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 23:41:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The definition of the struct pm_domain_data better belongs in the
header for the PM domains, let's move it there.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h        | 6 +-----
 include/linux/pm_domain.h | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 383fd68..45e3e78 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -538,11 +538,7 @@ enum rpm_request {
 };
 
 struct wakeup_source;
-
-struct pm_domain_data {
-	struct list_head list_node;
-	struct device *dev;
-};
+struct pm_domain_data;
 
 struct pm_subsys_data {
 	spinlock_t lock;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 2e0e06d..9d254e2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -100,6 +100,11 @@ struct gpd_timing_data {
 	bool cached_stop_ok;
 };
 
+struct pm_domain_data {
+	struct list_head list_node;
+	struct device *dev;
+};
+
 struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
-- 
1.9.1

