From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] thermal: cpu_cooling: Make 'notify_device' static
Date: Thu, 15 Nov 2012 12:19:44 +0530
Message-ID: <1352962184-20970-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33638 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204Ab2KOGzk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 01:55:40 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so947636pbc.19
        for <linux-pm@vger.kernel.org>; Wed, 14 Nov 2012 22:55:40 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, hongbo.zhang@linaro.com, sachin.kamat@linaro.org, patches@linaro.org

Silences the following sparse warning:

drivers/thermal/cpu_cooling.c:67:31: warning:
symbol 'notify_device' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/cpu_cooling.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 392d57d..6f94c2c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -64,7 +64,7 @@ static unsigned int cpufreq_dev_count;
 
 /* notify_table passes value to the CPUFREQ_ADJUST callback function. */
 #define NOTIFY_INVALID NULL
-struct cpufreq_cooling_device *notify_device;
+static struct cpufreq_cooling_device *notify_device;
 
 /**
  * get_idr - function to get a unique id.
-- 
1.7.4.1

