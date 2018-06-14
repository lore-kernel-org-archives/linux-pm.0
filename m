From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
Date: Thu, 14 Jun 2018 10:53:34 +0530
Message-ID: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
References: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

of_genpd_opp_to_performance_state() should return 0 for errors, but the
dummy routine isn't doing that. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9206a4fef9ac..139f79c8477a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -276,7 +276,7 @@ static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
 				  struct device_node *opp_node)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline int genpd_dev_pm_attach(struct device *dev)
-- 
2.18.0.rc1.242.g61856ae69a2c
