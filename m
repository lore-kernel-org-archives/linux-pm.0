From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC] soc: imx: gpc: Unregister pgc children on remove
Date: Tue,  3 Jul 2018 22:39:16 +0300
Message-ID: <652cc0c045dbd4490752ef117e98ffbcc84de822.1530646251.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the gpc device is removed the platform_devices for its
imx-pgc-power-domains are still registered and trying to probe gpc again
results in an error.

Fix this by iterating children inside imx_gpc_remove and calling
platfrom_device_unregister.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

This was prompted by the rejection of the following series:
	https://lkml.org/lkml/2018/7/2/534

Tested glxgears after rebinding gpc and etnaviv by echo to
/sys/bus/platform/drivers/{imx-gpc,etnaviv-gpu}/{unbind,bind}

When doing probe again it triggers a warning inside
driver_links_drivers_bound:

	WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);

This seems to be because devicelink code does not expect consumers to
bind before suppliers but GPC code adds PGC children during its
probe function and they register a device-link to their still-probing
parent.

The warning doesn't trigger on normal boot because the pgc driver is
registered after gpc and probing is not nested. The warning can be made
to reproduce in a normal boot by making imx_gpc_probe return
-EPROBE_DEFER once (no other changes required).

This does not seem to be a valid scenario for device links so fix this
by adding a check in imx_pgc_power_domain_probe to defer if parent is not
probed.

This check is not very nice, device_is_bound seems like something that
should be internal to the driver core.

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..b4acdfd3cffd 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -182,10 +182,13 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pm_domain *domain = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	if (!device_is_bound(dev->parent))
+		return -EPROBE_DEFER;
+
 	/* if this PD is associated with a DT node try to parse it */
 	if (dev->of_node) {
 		ret = imx_pgc_parse_dt(dev, domain);
 		if (ret)
 			return ret;
@@ -475,10 +478,19 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	}
 
 	return 0;
 }
 
+static int __imx_gpc_unregister_child(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
 static int imx_gpc_remove(struct platform_device *pdev)
 {
 	struct device_node *pgc_node;
 	int ret;
 
@@ -502,10 +514,13 @@ static int imx_gpc_remove(struct platform_device *pdev)
 		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
 		if (ret)
 			return ret;
+	} else {
+		device_for_each_child(&pdev->dev, NULL,
+				__imx_gpc_unregister_child);
 	}
 
 	return 0;
 }
 
-- 
2.17.1
