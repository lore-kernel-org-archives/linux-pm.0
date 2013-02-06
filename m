From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/5] Thermal: fix a wrong comment
Date: Wed,  6 Feb 2013 12:30:02 +0800
Message-ID: <1360125006-25018-2-git-send-email-rui.zhang@intel.com>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756944Ab3BFEaN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 23:30:13 -0500
In-Reply-To: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: amit.daniel@samsung.com, gu1@aeroxteam.fr, hongbo.zhang@linaro.org, Zhang Rui <rui.zhang@intel.com>

"level" parameter of get_cpu_frequency equals cooling state
of cpu cooling device, and it starts from 0.

Fix the misleading comment.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 836828e..455c77a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -118,8 +118,8 @@ static int is_cpufreq_valid(int cpu)
 /**
  * get_cpu_frequency - get the absolute value of frequency from level.
  * @cpu: cpu for which frequency is fetched.
- * @level: level of frequency of the CPU
- *	e.g level=1 --> 1st MAX FREQ, LEVEL=2 ---> 2nd MAX FREQ, .... etc
+ * @level: level of frequency, equals cooling state of cpu cooling device
+ *	e.g level=0 --> 1st MAX FREQ, level=1 ---> 2nd MAX FREQ, .... etc
  */
 static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 {
-- 
1.7.9.5

