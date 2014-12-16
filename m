From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] cpufreq: exynos5440: protect call to
 dev_pm_opp_get_opp_count with RCU lock
Date: Mon, 15 Dec 2014 17:01:07 -0800
Message-ID: <20141216010107.GA16947@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Stratos Karafotis <stratosk@semaphore.gr>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_get_opp_count() must be called with RCU lock held.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Again, not tested...


 drivers/cpufreq/exynos5440-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 21a90ed..588b9ee 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -373,7 +373,11 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 			"failed to init cpufreq table: %d\n", ret);
 		goto err_free_opp;
 	}
+
+	rcu_read_lock();
 	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
+	rcu_read_unlock();
+
 	exynos_sort_descend_freq_table();
 
 	if (of_property_read_u32(np, "clock-latency", &dvfs_info->latency))
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
