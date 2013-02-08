From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 2/2] cpufreq: conservative: Fix typos in comments
Date: Fri, 08 Feb 2013 19:24:24 +0200
Message-ID: <511534C8.1080502@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix a couple of typos in comments.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index e8bb915..4fd0006 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -25,7 +25,7 @@
 
 #include "cpufreq_governor.h"
 
-/* Conservative governor macors */
+/* Conservative governor macros */
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
 #define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
@@ -144,7 +144,7 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
-	 * ranges of freqency available to us otherwise we do not change it
+	 * ranges of frequency available to us otherwise we do not change it
 	*/
 	if (dbs_info->requested_freq > policy->max
 			|| dbs_info->requested_freq < policy->min)
-- 
1.8.1.2
