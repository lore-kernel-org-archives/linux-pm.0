From: Mohamed Wasif <m.wasif@samsung.com>
Subject: [PATCH 1/1] cpufreq: Fix NULL pointer comparison warning
Date: Tue, 06 Dec 2016 15:47:55 +0530
Message-ID: <1481019475-26636-1-git-send-email-m.wasif@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Mohamed Wasif <m.wasif@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vidushi.koul@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace direct comparisons to NULL
This problem was detected by checkpatch.

Signed-off-by: Mohamed Wasif <m.wasif@samsung.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6e6c1fb..ca3542e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -590,7 +590,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 
 		t = find_governor(str_governor);
 
-		if (t == NULL) {
+		if (!t) {
 			int ret;
 
 			mutex_unlock(&cpufreq_governor_mutex);
@@ -601,7 +601,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 				t = find_governor(str_governor);
 		}
 
-		if (t != NULL) {
+		if (t) {
 			*governor = t;
 			err = 0;
 		}
-- 
1.7.9.5
