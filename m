From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Wed, 26 Nov 2014 17:00:11 +0000
Message-ID: <5476071B.1060705@arm.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34120 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbaKZRAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:00:16 -0500
In-Reply-To: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>

Hi Viresh,

On 26/11/14 08:46, Viresh Kumar wrote:
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
> We only need to have one entry in cpus@cpu0 node which will match with drivers
> name.
>

This seems fundamentally broken as the driver always needs to
unconditionally refer to cpu0. Furthermore the node need not be called
cpu0 as the name depends on its reg field.

> We can then add another file drivers/cpufreq/device_dt.c, which will add a
> platform device with the name it finds from cpus@cpu0 node and existing drivers
> will work without any change. Or something else if somebody have a better
> proposal. But lets fix the bindings first.

IIUC you will retain the existing list of cpufreq-dt platform device
creation as is. If not that breaks compatibility with old DT.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   .../devicetree/bindings/cpufreq/drivers.txt        | 53 ++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/cpufreq/drivers.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/drivers.txt b/Documentation/devicetree/bindings/cpufreq/drivers.txt
> new file mode 100644
> index 0000000..bd14917
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/drivers.txt
> @@ -0,0 +1,53 @@
> +Binding to select which cpufreq driver to register
> +
> +It is a generic DT binding for selecting which cpufreq-driver to register for
> +any platform.
> +
> +The property  listed below must be defined under node /cpus/cpu@0 node. We don't
> +support multiple CPUFreq driver currently for different cluster and so this
> +information isn't required to be present in CPUs of all clusters.
> +
> +Required properties:
> +- None
> +
> +Optional properties:
> +- dvfs-method: CPUFreq driver to probe. For example: "arm-bL-cpufreq-dt",
> +  "cpufreq-dt", etc
> +

You should manage this with compatible rather than a new property as
it's not a real hardware property. IMHO Rob's suggestion[1] should work
fine.

IIUC, you can have the driver which create this platform device if DT
has generic compatible unconditionally(e.g "cpufreq-dt" as you have
chosen above). For all existing DT you can create a blacklist of
compatibles to match(as it doesn't have the generic compatible) covering
all the existing platforms using cpufreq-dt driver, there by you can
even remove the platform device creating from multiple places.
IMO something like the patch below should work(not tested, also
late_initcall is used just to demonstrate the idea)

Rob, please correct me if my understanding is wrong.

Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256191.html

--->8

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index f657c571b18e..19a616e298e0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -387,6 +387,32 @@ static struct platform_driver dt_cpufreq_platdrv = {
  };
  module_platform_driver(dt_cpufreq_platdrv);

+static const struct of_device_id compatible_machine_match[] = {
+       /* All new machines must have the below compatible to use this 
driver */
+       { .compatible = "cpufreq-generic-dt" },
+       /* BLACKLIST of existing users of cpufreq-dt below */
+       { .compatible = "samsung,exynos5420" },
+       { .compatible = "samsung,exynos5800" },
+       {},
+};
+
+static int cpufreq_generic_dt_init(void)
+{
+       struct device_node *root = of_find_node_by_path("/");
+       struct platform_device_info devinfo = { .name = "cpufreq-dt", };
+       /*
+        * Initialize the device for the platforms either
+        * blacklisted or compliant to generic compatible
+        */
+       if (!of_match_node(compatible_machine_match, root))
+               return -ENODEV;
+
+       /* Instantiate cpufreq-dt */
+       platform_device_register_full(&devinfo);
+       return 0;
+}
+late_initcall(cpufreq_generic_dt_init);
+

