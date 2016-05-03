From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH -next 2/2] cpufreq: powernv: del_timer_sync when global and local pstate are equal
Date: Tue,  3 May 2016 15:10:48 +0530
Message-ID: <1462268448-19954-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Deleting pending gpstates->timer for the policy when global and local pstate
are equal while executing target_index(). This saves an unnecessary
irq call.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
Patch is based on Rafael's linux-next
 drivers/cpufreq/powernv-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 1f0e20c..54c4536 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -647,6 +647,8 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	 */
 	if (gpstate_id != freq_data.pstate_id)
 		queue_gpstate_timer(gpstates);
+	else
+		del_timer_sync(&gpstates->timer);
 
 gpstates_done:
 	freq_data.gpstate_id = gpstate_id;
-- 
2.5.5
