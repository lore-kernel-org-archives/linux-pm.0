From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 13/30] thermal: cpu_cooling: remove checkpatch.pl warning
Date: Wed, 17 Apr 2013 13:12:06 -0400
Message-ID: <1366218743-20841-14-git-send-email-eduardo.valentin@ti.com>
References: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366218743-20841-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Simple code style fix.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d046cd5..1ddfb15 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -184,7 +184,7 @@ static int get_property(unsigned int cpu, unsigned long input,
 	}
 
 	if (property == GET_FREQ)
-		level = descend ? input : (max_level - input -1);
+		level = descend ? input : (max_level - input - 1);
 
 	for (i = 0, j = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		/* ignore invalid entry */
-- 
1.8.2.1.342.gfa7285d
