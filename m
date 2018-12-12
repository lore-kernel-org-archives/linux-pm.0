From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/6] PM / Domains: Make genpd performance states orthogonal to the idlestates
Date: Wed, 12 Dec 2018 16:27:24 +0530
Message-ID: <48a7fc66faec9ac5c157b0cadcdaeb07bfe78781.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rnayak@codeaurora.org, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

It's quite questionable whether genpd internally should care about if the
corresponding PM domain for a device is powered on, as to allow setting a
new performance state for it. The assumptions creates an unnecessary
limitation at this point, for both consumers and providers, but more
importantly it also makes the code more complicated.

Therefore, let's simplify the code to allow setting a performance state, by
invoking the ->set_performance_state() callback, no matter whether the PM
domain is powered on or off.

Do note, this change means genpd providers needs to restore the performance
state themselves during power on, via the ->power_on() callback. Moreover,
they may also need to check that the PM domain is powered on, from their
->set_performance_state() callback, before deciding to update the state.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e554e6a82a2..4a4e39d12354 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -311,12 +311,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	 */
 
 update_state:
-	if (genpd_status_on(genpd)) {
-		ret = genpd->set_performance_state(genpd, state);
-		if (ret) {
-			gpd_data->performance_state = prev;
-			goto unlock;
-		}
+	ret = genpd->set_performance_state(genpd, state);
+	if (ret) {
+		gpd_data->performance_state = prev;
+		goto unlock;
 	}
 
 	genpd->performance_state = state;
@@ -347,15 +345,6 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-
-	if (unlikely(genpd->set_performance_state)) {
-		ret = genpd->set_performance_state(genpd, genpd->performance_state);
-		if (ret) {
-			pr_warn("%s: Failed to set performance state %d (%d)\n",
-				genpd->name, genpd->performance_state, ret);
-		}
-	}
-
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
 
-- 
2.19.1.568.g152ad8e3369a
