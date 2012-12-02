From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 25/34] thermal: cpu_cooling: Make 'notify_device' static
Date: Sun,  2 Dec 2012 22:44:59 +0800
Message-ID: <1354459508-3707-25-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2LBOps (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:48 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Zhang Rui <rui.zhang@intel.com>

From: Sachin Kamat <sachin.kamat@linaro.org>

Silences the following sparse warning:

drivers/thermal/cpu_cooling.c:67:31: warning:
symbol 'notify_device' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
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
1.7.7.6

