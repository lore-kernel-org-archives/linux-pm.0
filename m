From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 21/27] cpufreq: scpi: Don't validate the frequency table twice
Date: Mon, 26 Feb 2018 10:39:04 +0530
Message-ID: <9a5c962bd3a225cfa87d6dcb0f6bb85697991c66.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core is already validating the CPU frequency table after
calling the ->init() callback of the cpufreq drivers and the drivers
don't need to do the same anymore. Though they need to set the
policy->freq_table field directly from the ->init() callback now.

Stop validating the frequency table from scpi driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index c32a833e1b00..7b31efe53252 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -150,13 +150,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	policy->driver_data = priv;
-
-	ret = cpufreq_table_validate_and_show(policy, freq_table);
-	if (ret) {
-		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
-			ret);
-		goto out_put_clk;
-	}
+	policy->freq_table = freq_table;
 
 	/* scpi allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
@@ -170,8 +164,6 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible = false;
 	return 0;
 
-out_put_clk:
-	clk_put(priv->clk);
 out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
-- 
2.15.0.194.g9af6a3dea062
