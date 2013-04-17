From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 05/30] thermal: cpu_cooling: remove compiler warning
Date: Wed, 17 Apr 2013 13:11:58 -0400
Message-ID: <1366218743-20841-6-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57939 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935968Ab3DQROq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 13:14:46 -0400
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

level will be used only if GET_FREQ mode is requested.
There is no potential harm with current code. But for
cleaning the compilation log, this patch initializes
level to zero.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 64dc4dd..bdc4233 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -126,7 +126,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 	unsigned int* output, enum cpufreq_cooling_property property)
 {
 	int i, j;
-	unsigned long max_level = 0, level;
+	unsigned long max_level = 0, level = 0;
 	unsigned int freq = CPUFREQ_ENTRY_INVALID;
 	int descend = -1;
 	struct cpufreq_frequency_table *table =
-- 
1.8.2.1.342.gfa7285d

