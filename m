From: dirk.brandewie@gmail.com
Subject: [PATCH 4/5] intel_pstate: Use LFM bus ratio as min ratio/P state
Date: Wed, 12 Feb 2014 10:01:06 -0800
Message-ID: <1392228067-14817-5-git-send-email-dirk.j.brandewie@intel.com>
References: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Using LFM ratio provides better perf/watt vs min ratio.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b80c03d..ff45ce1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -356,7 +356,7 @@ static int byt_get_min_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_RATIOS, value);
-	return value & 0xFF;
+	return (value >> 8) & 0xFF;
 }
 
 static int byt_get_max_pstate(void)
-- 
1.8.3.1
