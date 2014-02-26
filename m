From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH 2/3] cpufreq: stats: Fix error handling in
 __cpufreq_stats_create_table()
Date: Tue, 25 Feb 2014 19:38:34 -0800
Message-ID: <1393385915-19138-2-git-send-email-skannan@codeaurora.org>
References: <1789244.B5CzWbcp6h@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1789244.B5CzWbcp6h@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Saravana Kannan <skannan@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Remove sysfs group if __cpufreq_stats_create_table() fails after creating
one.

Change-Id: Icb0b44424cc4eb6c88be255e2839ef51c3f8779c
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e4bd27f..c52b440 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -216,7 +216,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy,
 	stat->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
 	if (!stat->time_in_state) {
 		ret = -ENOMEM;
-		goto error_out;
+		goto error_alloc;
 	}
 	stat->freq_table = (unsigned int *)(stat->time_in_state + count);
 
@@ -237,6 +237,8 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy,
 	stat->last_index = freq_table_get_index(stat, policy->cur);
 	spin_unlock(&cpufreq_stats_lock);
 	return 0;
+error_alloc:
+	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 error_out:
 	kfree(stat);
 	per_cpu(cpufreq_stats_table, cpu) = NULL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
