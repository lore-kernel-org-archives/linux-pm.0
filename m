From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 02/30] thermal: cpu_cooling: remove trailing white spaces
Date: Wed, 17 Apr 2013 13:11:55 -0400
Message-ID: <1366218743-20841-3-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936120Ab3DQRNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 13:13:38 -0400
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove unnecessary white spaces.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 778c43d..d0d6a0c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -131,14 +131,13 @@ static int get_property(unsigned int cpu, unsigned long input,
 	int descend = -1;
 	struct cpufreq_frequency_table *table =
 					cpufreq_frequency_get_table(cpu);
-	
+
 	if (!output)
 		return -EINVAL;
 
 	if (!table)
 		return -EINVAL;
 
-	
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		/* ignore invalid entries */
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-- 
1.8.2.1.342.gfa7285d

