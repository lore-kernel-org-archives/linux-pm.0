From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Mon, 17 Nov 2014 16:19:10 +0100
Message-ID: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The amba bus, amba drivers and a vast amount of platform drivers which
enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
their devices.

Instead, once they have turned on their PM resourses during ->probe()
and are ready to handle I/O, these invokes pm_runtime_set_active() to
synchronize its state towards the runtime PM core.

>From a runtime PM point of view this behavior is perfectly acceptable,
but we encounter probe failures if their corresponding devices resides
in the generic PM domain. The issues are observed for those devices,
which requires its PM domain to stay powered during ->probe() since
that's not being controlled.

While using the generic OF-based PM domain look-up, a device's PM
domain will be attached during the probe sequence. For this path, let's
fix the probe failures, by simply power on the PM domain right after
when it's been attached to the device.

The generic PM domain stays powered until all of its devices becomes
runtime PM enabled and runtime PM suspended.

The old SOCs which makes use of the generic PM domain but don't use the
generic OF-based PM domain look-up, will not be affected from this
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3989eb6..1bfb54c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2235,6 +2235,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
+	pm_genpd_poweron(pd);
 
 	return 0;
 }
-- 
1.9.1
