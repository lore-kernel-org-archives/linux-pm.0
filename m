From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 5/7] PM / devfreq: exynos-bus: add support for suspend OPP
Date: Mon, 19 Dec 2016 03:16:25 +0100
Message-ID: <1482113787-28422-6-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

Set the frequency of the suspend OPP, so that DevFreq
core can use it during system sleep/reboot/power-off.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/exynos-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 29866f7..16fb37a 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -389,6 +389,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	struct devfreq_passive_data *passive_data;
 	struct devfreq *parent_devfreq;
 	struct exynos_bus *bus;
+	struct dev_pm_opp *suspend_opp;
 	int ret, max_state;
 	unsigned long min_freq, max_freq;
 
@@ -449,6 +450,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	/* Check for suspend OPP and store the corresponding frequency. */
+	rcu_read_lock();
+	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
+	if (suspend_opp)
+		bus->devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
+	rcu_read_unlock();
+
 	/* Register opp_notifier to catch the change of OPP  */
 	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
 	if (ret < 0) {
-- 
2.7.3
