From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] PM / Domains: Use the base device for driver_deferred_probe_check_state()
Date: Thu, 25 Apr 2019 11:04:10 +0200
Message-ID: <20190425090413.10700-2-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

When genpd fails to attach a device to one of its multiple PM domains, we
end up calling driver_deferred_probe_check_state() for the recently
allocated virtual device. This is wrong, as it's the base device that is
being probed. Fix this, by passing along the base device to
__genpd_dev_pm_attach() and use that instead.

Fixes: e01afc325025 ("PM / Domains: Stop deferring probe at the end of initcall")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8362dfe187f5..8aca1c9b4406 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2405,8 +2405,8 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
-				 bool power_on)
+static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
+				 unsigned int index, bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
@@ -2424,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(dev);
+		return driver_deferred_probe_check_state(base_dev);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
@@ -2480,7 +2480,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, 0, true);
+	return __genpd_dev_pm_attach(dev, dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
@@ -2533,7 +2533,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(virt_dev, index, false);
+	ret = __genpd_dev_pm_attach(virt_dev, dev, index, false);
 	if (ret < 1) {
 		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
-- 
2.17.1
