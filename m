From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: conservative: Fix comment explaining frequency
 updates
Date: Wed, 16 Nov 2016 21:13:23 +0200
Message-ID: <d6b11e61-bfed-598b-b984-a6bdb24a2bbe@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The original comment about the frequency increase to maximum is wrong.

Both increase and decrease happen at steps.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index a48b724..7522ec6 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -55,8 +55,8 @@ static inline unsigned int get_freq_step(struct cs_dbs_tuners *cs_tuners,
  * sampling_down_factor, we check, if current idle time is more than 80%
  * (default), then we try to decrease frequency
  *
- * Any frequency increase takes it to the maximum frequency. Frequency reduction
- * happens at minimum steps of 5% (default) of maximum frequency
+ * Frequency updates happen at minimum steps of 5% (default) of maximum
+ * frequency
  */
 static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 {
-- 
2.7.4
