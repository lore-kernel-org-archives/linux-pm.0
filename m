From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/27] cpufreq: brcmstb: Don't validate the frequency table
 twice
Date: Mon, 26 Feb 2018 10:38:49 +0530
Message-ID: <7d2bc4de102c81503c30a64503179c4ccebe6287.1519620578.git.viresh.kumar@linaro.org>
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
To: Rafael Wysocki <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core is already validating the CPU frequency table after
calling the ->init() callback of the cpufreq drivers and the drivers
don't need to do the same anymore. Though they need to set the
policy->freq_table field directly from the ->init() callback now.

Stop validating the frequency table from brcmstb driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 7281a2c19c36..6cdac1aaf23c 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -902,11 +902,7 @@ static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = cpufreq_table_validate_and_show(policy, freq_table);
-	if (ret) {
-		dev_err(dev, "invalid frequency table: %d\n", ret);
-		return ret;
-	}
+	policy->freq_table = freq_table;
 
 	/* All cores share the same clock and thus the same policy. */
 	cpumask_setall(policy->cpus);
-- 
2.15.0.194.g9af6a3dea062
