From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] cpufreq: scpi: invoke frequency-invariance setter function
Date: Tue, 20 Feb 2018 11:10:57 +0000
Message-ID: <20180220111057.14756-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
changed the cpufreq driver on juno from arm_big_little to scpi.

The scpi set_target function does not call the frequency-invariance
setter function arch_set_freq_scale() like the arm_big_little set_target
function does. As a result the task scheduler load and utilization
signals are not frequency-invariant on this platform anymore.

Fix this by adding a call to arch_set_freq_scale() into
scpi_cpufreq_set_target().

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index c32a833e1b00..3101d4e9c2de 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -51,13 +51,19 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
+	unsigned long freq = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	u64 rate = freq * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
-	if (!ret && (clk_get_rate(priv->clk) != rate))
-		ret = -EIO;
+	if (!ret) {
+		if (clk_get_rate(priv->clk) != rate)
+			ret = -EIO;
+
+		arch_set_freq_scale(policy->related_cpus, freq,
+				    policy->cpuinfo.max_freq);
+	}
 
 	return ret;
 }
-- 
2.11.0
