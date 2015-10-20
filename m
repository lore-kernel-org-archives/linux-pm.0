From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Alternative approach to solve the deferred probe (was: [GIT
 PULL] On-demand device probing)
Date: Tue, 20 Oct 2015 16:46:56 +0100
Message-ID: <20151020154656.GY32532@n2100.arm.linux.org.uk>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
 <20151019143045.GE32532@n2100.arm.linux.org.uk>
 <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@g>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 06:21:40PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Mon, Oct 19, 2015 at 5:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> > What you can do is print those devices which have failed to probe at
> >> > late_initcall() time - possibly augmenting that with reports from
> >> > subsystems showing what resources are not available, but that's only
> >> > a guide, because of the "it might or might not be in a kernel module"
> >> > problem.
> >>
> >> Well, adding those reports would give you a changelog similar to the
> >> one in this series...
> >
> > I'm not sure about that, because what I was thinking of is adding
> > a flag which would be set at late_initcall() time prior to running
> > a final round of deferred device probing.
> 
> Which round is the final round?
> That's the one which didn't manage to bind any new devices to drivers,
> which is something you only know _after_ the round has been run.
> 
> So I think we need one extra round to handle this.
> 
> > This flag would then be used in a deferred_warn() printk function
> > which would normally be silent, but when this flag is set, it would
> > print the reason for the deferral - and this would replace (or be
> > added) to the subsystems and drivers which return -EPROBE_DEFER.
> >
> > That has the effect of hiding all the deferrals up until just before
> > launching into userspace, which should then acomplish two things -
> > firstly, getting rid of the rather useless deferred messages up to
> > that point, and secondly printing the reason why the remaining
> > deferrals are happening.
> >
> > That should be a small number of new lines plus a one-line change
> > in subsystems and drivers.
> 
> Apart from the extra round we probably can't get rid of, that sounds OK to me.

Something like this.  I haven't put a lot of effort into it to change all
the places which return an -EPROBE_DEFER, and it also looks like we need
some helpers to report when we have only an device_node (or should that
be fwnode?)  See the commented out of_warn_deferred() in
drivers/gpio/gpiolib-of.c.  Adding this stuff in the subsystems searching
for resources should make debugging why things are getting deferred easier.

We could make driver_deferred_probe_report something that can be
deactivated again after the last deferred probe run, and provide the
user with a knob that they can turn it back on again.

I've tried this out on two of my platforms, including forcing
driver_deferred_probe_report to be enabled, and I get exactly one
deferred probe, so not a particularly good test.

The patch won't apply as-is to mainline for all files; it's based on my
tree which has some 360 additional patches (which seems to be about
normal for my tree now.)

 drivers/base/dd.c                       | 29 +++++++++++++++++++++++++++++
 drivers/base/power/domain.c             |  7 +++++--
 drivers/clk/clkdev.c                    |  9 ++++++++-
 drivers/gpio/gpiolib-of.c               |  5 +++++
 drivers/gpu/drm/bridge/dw_hdmi.c        |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c |  2 +-
 drivers/gpu/drm/imx/imx-ldb.c           |  5 +++--
 drivers/gpu/drm/msm/dsi/dsi.c           |  2 +-
 drivers/gpu/drm/msm/msm_drv.c           |  3 ++-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  3 ++-
 drivers/of/irq.c                        |  5 ++++-
 drivers/pci/host/pci-mvebu.c            |  1 +
 drivers/pinctrl/core.c                  |  5 +++--
 drivers/pinctrl/devicetree.c            |  4 ++--
 drivers/regulator/core.c                |  5 +++--
 include/linux/device.h                  |  1 +
 16 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..bb12224f2901 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -129,7 +129,29 @@ void driver_deferred_probe_del(struct device *dev)
 	mutex_unlock(&deferred_probe_mutex);
 }
 
+static bool driver_deferred_probe_report;
+
+/**
+ * dev_warn_deferred() - report why a probe has been deferred
+ */
+void dev_warn_deferred(struct device *dev, const char *fmt, ...)
+{
+	if (driver_deferred_probe_report) {
+		struct va_format vaf;
+		va_list ap;
+
+		va_start(ap, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &ap;
+
+		dev_warn(dev, "deferring probe: %pV", &vaf);
+		va_end(ap);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_warn_deferred);
+
 static bool driver_deferred_probe_enable = false;
+
 /**
  * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
  *
@@ -188,6 +210,13 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_workqueue(deferred_wq);
+
+	/* Now one final round, reporting any devices that remain deferred */
+	driver_deferred_probe_report = true;
+	driver_deferred_probe_trigger();
+	/* Sort as many dependencies as possible before exiting initcalls */
+	flush_workqueue(deferred_wq);
+
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c63d611..9f4d687d7268 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1997,8 +1997,8 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	pd = of_genpd_get_from_provider(&pd_args);
 	if (IS_ERR(pd)) {
-		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
-			__func__, PTR_ERR(pd));
+		dev_warn_deferred(dev, "%s() failed to find PM domain: %ld\n",
+				  __func__, PTR_ERR(pd));
 		of_node_put(dev->of_node);
 		return -EPROBE_DEFER;
 	}
@@ -2026,6 +2026,9 @@ int genpd_dev_pm_attach(struct device *dev)
 	ret = pm_genpd_poweron(pd);
 
 out:
+	if (ret)
+		dev_warn_deferred(dev, "%s() deferring probe: %d\n",
+				  __func__, ret);
 	return ret ? -EPROBE_DEFER : 0;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 779b6ff0c7ad..66f4212c63fd 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -201,7 +201,14 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
 	if (dev) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
-		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		if (IS_ERR(clk) && PTR_ERR(clk) == -EPROBE_DEFER) {
+			if (dev)
+				dev_warn_deferred(dev,
+						  "unable to locate clock for connection %s\n",
+						  con_id);
+			return clk;
+		}
+		if (!IS_ERR(clk))
 			return clk;
 	}
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fa6e3c8823d6..36f09ab1c215 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -101,6 +101,11 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 	pr_debug("%s: parsed '%s' property of node '%s[%d]' - status (%d)\n",
 		 __func__, propname, np->full_name, index,
 		 PTR_ERR_OR_ZERO(gg_data.out_gpio));
+
+//	if (gg_data.out_gpio == -EPROBE_DEFER)
+//		of_warn_deferred(np, "%s: unable to locate GPIO for %s[%d]\n",
+//				 __func__, propname, index);
+
 	return gg_data.out_gpio;
 }
 
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index cb8764eecd70..088f5dd58424 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1785,7 +1785,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
 		if (!hdmi->ddc) {
-			dev_dbg(hdmi->dev, "failed to read ddc node\n");
+			dev_warn_deferred(hdmi->dev, "failed to read ddc node\n");
 			return -EPROBE_DEFER;
 		}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 12b03b364703..3155798d8245 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1899,7 +1899,7 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dsi->supplies),
 				      dsi->supplies);
 	if (ret) {
-		dev_info(dev, "failed to get regulators: %d\n", ret);
+		dev_warn_deferred(dev, "failed to get regulators: %d\n", ret);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index abacc8f67469..0b57054c886a 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -595,8 +595,9 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 				else
 					return -EPROBE_DEFER;
 				if (!channel->panel) {
-					dev_err(dev, "panel not found: %s\n",
-						remote->full_name);
+					dev_warn_deferred(dev,
+							  "panel not found: %s\n",
+							  remote->full_name);
 					return -EPROBE_DEFER;
 				}
 			}
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 6edcd6f57e70..3ba94a2bca65 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -42,7 +42,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
 	of_node_put(phy_node);
 
 	if (!phy_pdev || !msm_dsi->phy) {
-		dev_err(&pdev->dev, "%s: phy driver is not ready\n", __func__);
+		dev_warn_deferred(&pdev->dev, "%s: phy driver is not ready\n", __func__);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 0339c5d82d37..e1cfcd38c0dd 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1117,7 +1117,8 @@ static int msm_pdev_probe(struct platform_device *pdev)
 		dev = bus_find_device_by_name(&platform_bus_type,
 				NULL, devnames[i]);
 		if (!dev) {
-			dev_info(&pdev->dev, "still waiting for %s\n", devnames[i]);
+			dev_warn_deferred(&pdev->dev, "waiting for %s\n",
+					  devnames[i]);
 			return -EPROBE_DEFER;
 		}
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 48cb19949ca3..bbf36f68d4e0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -600,7 +600,8 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 	if (!IS_ERR(clk)) {
 		rcrtc->extclock = clk;
 	} else if (PTR_ERR(rcrtc->clock) == -EPROBE_DEFER) {
-		dev_info(rcdu->dev, "can't get external clock %u\n", index);
+		dev_warn_deferred(rcdu->dev, "can't get external clock %u\n",
+				  index);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 55317fa9c9dc..2056bb9e4c43 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -404,8 +404,11 @@ int of_irq_get(struct device_node *dev, int index)
 		return rc;
 
 	domain = irq_find_host(oirq.np);
-	if (!domain)
+	if (!domain) {
+		dev_warn_deferred(dev, "%s() failed to locate IRQ domain\n",
+				  __func__);
 		return -EPROBE_DEFER;
+	}
 
 	return irq_create_of_mapping(&oirq);
 }
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0e9b82095dc9..b49ae4822a5b 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1203,6 +1203,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 
 	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
 	if (reset_gpio == -EPROBE_DEFER) {
+		dev_warn_deferred(dev, "unable to find reset gpio\n");
 		ret = reset_gpio;
 		goto err;
 	}
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9638a00c67c2..299aae3bca14 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -741,8 +741,9 @@ static int add_setting(struct pinctrl *p, struct pinctrl_map const *map)
 		 * OK let us guess that the driver is not there yet, and
 		 * let's defer obtaining this pinctrl handle to later...
 		 */
-		dev_info(p->dev, "unknown pinctrl device %s in map entry, deferring probe",
-			map->ctrl_dev_name);
+		dev_warn_deferred(p->dev,
+				  "unknown pinctrl device %s in map entry, deferring probe",
+				  map->ctrl_dev_name);
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe04e748dfe4..358f946471c9 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -115,8 +115,8 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 	for (;;) {
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-			dev_info(p->dev, "could not find pctldev for node %s, deferring probe\n",
-				np_config->full_name);
+			dev_warn_deferred(p->dev, "could not find pctldev for node %s, deferring probe\n",
+					  np_config->full_name);
 			of_node_put(np_pctldev);
 			/* OK let's just assume this will appear later then */
 			return -EPROBE_DEFER;
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8a34f6acc801..8d8ea0518283 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1410,8 +1410,9 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
 		} else {
-			dev_err(dev, "Failed to resolve %s-supply for %s\n",
-				rdev->supply_name, rdev->desc->name);
+			dev_warn_deferred(dev,
+					  "Failed to resolve %s-supply for %s\n",
+					  rdev->supply_name, rdev->desc->name);
 			return -EPROBE_DEFER;
 		}
 	}
diff --git a/include/linux/device.h b/include/linux/device.h
index 5d7bc6349930..5050ce7d73b3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1087,6 +1087,7 @@ extern void device_shutdown(void);
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(const struct device *dev);
 
+void dev_warn_deferred(struct device *dev, const char *fmt, ...);
 
 #ifdef CONFIG_PRINTK
 


-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
