From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 01 Dec 2014 13:54:56 +0100
Message-ID: <7885354.QleDlR7NUO@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58068 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbaLAMzM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 07:55:12 -0500
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, linux-pm@vger.kernel.org, catalin.marinas@arm.com, k.chander@samsung.com, santosh shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, olof@lixom.net

On Monday 01 December 2014 17:11:21 Viresh Kumar wrote:
> 
> DT based cpufreq drivers doesn't require much support from platform code now a
> days as most of the stuff is moved behind generic APIs. Like clk APIs for
> changing clock rates, regulator APIs for changing voltages, etc.
> 
> One of the bottleneck still left was how to select which cpufreq driver to probe
> for a given platform as there might be multiple drivers available.
> 
> Traditionally, we used to create platform devices from machine specific code
> which binds with a cpufreq driver. And while we moved towards DT based device
> creation, these devices stayed as is.
> 
> The problem is getting worse now as we have architectures now with Zero platform
> specific code. Forcefully these platforms have to create a new file in
> drivers/cpufreq/ to just add these platform devices in order to use the generic
> drivers like cpufreq-dt.c.
> 
> This has been discussed again and again, but with no solution yet. Last it was
> discussed here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html
> 
> This patch is an attempt towards getting the bindings.
> 
> We only need to have cpufreq drivers name string present in "compatible"
> property for the root node.. If a cpufreq driver with DT support exists with
> that name, then cpufreq core will create a platform device for that.
> 
> The first patch presents the new binding, second one creates another file
> responsible for creating platform devices for all DT based cpufreq drivers.
> 
> And later patches update platforms to migrate to it one by one.
> 
> A BLACKLIST of platforms already supported by these drivers is also created for
> backward compatibility of newer kernels with older DTs. And so for such
> platforms DT files aren't updated.
> 
> An initial RFC that presented the idea was discussed here:
> https://www.mail-archive.com/devicetree@vger.kernel.org/msg52509.html
> 
> Tested-ON: Exynos5250. (The last patch for exynos depends on some commits to be
> upstreamed in 3.19, presented here just for testing).

Thanks a lot for working on this, we really need to figure it out one day!

Your patches seem well-implemented, so if everybody thinks the general
approach is the best solution, we should do that. From my point of view,
there are two things I would do differently:

- In the DT binding, I would strongly prefer anything but the root compatible
  property as the key for the new platforms. Clearly we have to keep using
  it for the backwards-compatibility case, as you do, but I think there
  are more appropriate places to put it. Sorting from most favorite to least
  favorite, my list would be:
	1. a new property in /cpus/
	2. a new property each /cpus/cpu@... node.
	3. the compatible property of the /cpus node
	4. a top-level device node that gets turned into a platform device
	5. a new property in the / node
	6. a new property in the /chosen node
	7. the compatible property in the / node

- Implementation-wise, I don't think it's helpful to have a global function
  that registers a platform device to be consumed by the device driver. I'd
  rather just see a module_init function in each driver that rather than
  registering a platform_driver scans the DT properties. This is only really
  necessary when not using DT (omap2, omap3, davinci, loongson) or when
  passing additional resources or platform_data (kirkwood, but that can
  look up the "marvell,orion-system-controller" node if necessary).
  My preferred solution would be to eventually remove the platform_device
  registration for all DT users. If a driver needs a platform device pointer
  internally, it can use platform_create_bundle(), but that's probably not
  even necessary.

In short, I would suggest something along the lines of the patch below.

	Arnd
8<-----
[PATCH, RFC] cpufreq: dt: simplify and generalize probing

We should not have to create a platform device from platform specific code
in order to use the completely generic cpufreq-dt driver. This adds
a simpler method by creating a new standard property of the "/cpus" node
to look for, with a fallback for existing users. The list of existing
users needs to be completed, and the same change done for the other
DT based drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 6f5f5615fbf1..697b4dc47715 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -345,13 +345,50 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.attr = cpufreq_generic_attr,
 };
 
-static int dt_cpufreq_probe(struct platform_device *pdev)
+/*
+ * these machines are using the driver but provide no standard
+ * probing method, only for old machines with existing dtbs.
+ */
+static struct of_device_id legacy_machines = {
+	{ .compatible = "calxeda,highbank" },
+	{ .compatible = "renesas,sh7372" },
+	{ .compatible = "renesas,sh73a0"  },
+	{ .compatible = "samsung,exynos5250" },
+	{ .compatible = "samsung,exynos4210" },
+	{ .compatible = "xlnx,zynq-7000" },
+};
+
+static bool dt_cpufreq_available(void)
+{
+	struct device_node *node;
+	bool ret;
+
+	node = of_find_node_by_path("/cpus");
+	if (!node)
+		return 0;
+
+	/* the specific property needs to be debated */
+	ret = of_property_read_bool("linux,cpu-frequency-scaling");
+	of_node_put(node);
+	if (ret)
+		return 1;
+
+	node = of_find_node_by_path("/");
+	ret = of_match_device(&legacy_machines, node);
+	of_node_put(node);
+
+	return ret;
+}
+
+static int __init dt_cpufreq_probe(void)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	int ret;
 
+	if (!dt_cpufreq_available())
+		return -ENXIO;
 	/*
 	 * All per-cluster (CPUs sharing clock/voltages) initialization is done
 	 * from ->init(). In probe(), we just need to make sure that clk and
@@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
-	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
-
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(cpu_dev, "failed register driver: %d\n", ret);
 
 	return ret;
 }
+module_init(dt_cpufreq_probe);
 
-static int dt_cpufreq_remove(struct platform_device *pdev)
+static void __exit dt_cpufreq_remove(void)
 {
 	cpufreq_unregister_driver(&dt_cpufreq_driver);
-	return 0;
 }
-
-static struct platform_driver dt_cpufreq_platdrv = {
-	.driver = {
-		.name	= "cpufreq-dt",
-	},
-	.probe		= dt_cpufreq_probe,
-	.remove		= dt_cpufreq_remove,
-};
-module_platform_driver(dt_cpufreq_platdrv);
+module_exit(dt_cpufreq_remove);
 
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");

