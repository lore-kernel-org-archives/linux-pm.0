From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/16] cpuidle: make __cpuidle_get_cpu_driver() inline
Date: Thu,  3 Oct 2013 21:26:42 +0530
Message-ID: <d95bfe847f8c6a89442004d0897f8f9ef5a53300.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

__cpuidle_get_cpu_driver() is a single line function and so deserves to be
marked inline.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index ced1df6..25455e8 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -29,7 +29,7 @@ static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
  * Returns a pointer to struct cpuidle_driver or NULL if no driver has been
  * registered for @cpu.
  */
-static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
+static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
 {
 	return per_cpu(cpuidle_drivers, cpu);
 }
-- 
1.7.12.rc2.18.g61b472e
