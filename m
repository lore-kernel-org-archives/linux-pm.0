From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 6/6] PM / Domains: Stop deferring probe at the end of initcall
Date: Thu, 28 Jun 2018 14:43:44 -0600
Message-ID: <20180628204344.13973-7-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexander Graf <agraf@suse.de>, Bjorn Andersson <bjorn.andersson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, boot-architecture@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

All PM domain drivers must be built-in (at least those using DT), so
there is no point deferring probe after initcalls are done. Continuing
to defer probe may prevent booting successfully even if managing PM
domains is not required. This can happen if the user failed to enable
the driver or if power-domains are added to a platform's DT, but there
is not yet a driver (e.g. a new DTB with an old kernel).

Call the driver core function driver_deferred_probe_check_init_done()
instead of just returning -EPROBE_DEFER to stop deferring probe when
initcalls are done.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
  - Update to new function name

 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4925af5c4cf0..8c12213875c6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 	}

 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
--
2.17.1
