From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v2] cpufreq: conservative: Fix comment explaining frequency
 updates
Date: Wed, 16 Nov 2016 21:27:22 +0200
Message-ID: <4986155b-de07-1a4c-186c-71d90b12e75c@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.semaphore.gr ([138.201.185.188]:55964 "EHLO
        mail.semaphore.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbcKPT13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 14:27:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

The original comment about the frequency increase to maximum is wrong.

Both increase and decrease happen at steps.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 -> v2
Remove a trailing space

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
