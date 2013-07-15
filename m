From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT
 infrastructure
Date: Mon, 15 Jul 2013 16:05:20 +0200
Message-ID: <1373897120.4172.57.camel@weser.hi.pengutronix.de>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>
	  <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>
	  <loom.20130715T124843-388@post.gmane.org> <51E3EC2C.2030803@ti.com>
	 <1373893198.4172.28.camel@weser.hi.pengutronix.de>
	 <51E3F864.1060000@ti.com> <51E3FAE7.3090609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218Ab3GOOHv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 10:07:51 -0400
In-Reply-To: <51E3FAE7.3090609@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org

Am Montag, den 15.07.2013, 09:36 -0400 schrieb Eduardo Valentin:
[...]
> 
> 
> as simple as the following:
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 3ab8294..486881c 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -20,6 +20,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpumask.h>
> 
>  static unsigned int transition_latency;
>  static unsigned int voltage_tolerance; /* in percentage */
> @@ -28,6 +31,7 @@ static struct device *cpu_dev;
>  static struct clk *cpu_clk;
>  static struct regulator *cpu_reg;
>  static struct cpufreq_frequency_table *freq_table;
> +static struct thermal_cooling_device *cdev;
> 
>  static int cpu0_verify_speed(struct cpufreq_policy *policy)
>  {
> @@ -256,6 +260,9 @@ static int cpu0_cpufreq_probe(struct platform_device
> *pdev)
>                 goto out_free_table;
>         }
> 
> +       if (!of_property_read_bool(np, "needs-cooling"))
> +               cdev = cpufreq_cooling_register(cpu_present_mask);
> +
>         of_node_put(np);
>         of_node_put(parent);
>         return 0;
> @@ -269,6 +276,7 @@ out_put_node:
> 
>  static int cpu0_cpufreq_remove(struct platform_device *pdev)
>  {
> +       cpufreq_cooling_unregister(cdev);
>         cpufreq_unregister_driver(&cpu0_cpufreq_driver);
>         opp_free_cpufreq_table(cpu_dev, &freq_table);
> 
> > For instance, assuming that all systems will need a cpufreq cooling
> > device is a flaw, because that is not the case. Thus, it makes sense to
> > have a property, say at the cpu node, to determine that it needs
> > cooling. However, that won't be saying how it would cool off.
> 
> 
> Then you would define your cpu0 node as:
> 
> 		cpu@0 {
> 			/* OMAP443x variants OPP50-OPPNT */
> 			operating-points = <
> 				/* kHz    uV */
> 				300000  1025000
> 				600000  1200000
> 				800000  1313000
> 				1008000 1375000
> 			>;
> 			clock-latency = <300000>; /* From legacy driver */
> 			needs-cooling; /* make sure we have cpufreq-cooling */
> 		};
> 
> Because in that system we actually need to take care of the cpu thermal.
> 
I don't see what not registering the cooling device is buying us (aside
from a small resource saving). The cpu is one potential source of heat
in a system, so we may want to reference it in a thermal zone, so to me
it makes sense to always register the cooling device.

> 
> > 
> > 
> >>
> >>> I could try to push something following the same idea as the one I am
> >>> trying to sell with this series for sensor devices. For instance, in a
> >>> sensor node I am attaching a phandle to describe how thermal fw must
> >>> behave. Then the sensor driver it is supposed to load the thermal data
> >>> into the thermal fw. Same could apply for instance for cpufreq cooling
> >>> device. at the cpu node we could have a 'cooling_device' node at the cpu
> >>> node, while loading cpufreq-cpu0.
> >>
> >> I think a separate cooling_device node may be only necessary if we stuff
> >> additional info in there. If it's just a plain cooling device I think it
> >> is reasonable for the cpufreq driver to just register a cooling device
> >> if the thermal framework is there.
> > 
> > no, I think this is not what we want, because, as I said, not all cpus
> > will need cooling. Just because the thermal framework is there does not
> > mean your cpu needs cooling. As you can see, the thermal framework is
> > not only for cpu cooling. It can be used for any other thermal need.
> > Besides one needs to cover for the case where you are building for
> > multiple platform support. Assuming system needs based on Kconfig setup
> > is not very likely to scale in this case.
> > 
> >>
> >> I would really like the information about a thermal zone to hang off one
> >> dt node rather than being scattered over several nodes. This way it may
> > 
> > Again, thermal framework is not about only cpu(freq) cooling. Thermal
> > zone info can (and will) be hanged off in one dt node. But please don't
> > mix concepts. Just because a cooling device is part of a thermal zone,
> > it does not mean it is only used there and that it can be defined there.
> > One can use a cooling device in different thermal zones.
> > 
> >> be easy to reference a cooling device in different thermal zones with
> >> different weight, etc. As long as we define a thermal zone to always be
> >> defined by a single sensor the right place seems to be the proposed
> >> subnode to the sensor. If we want a zone to have more than one sensor,
> >> we might even want a separate dt node for the thermal zone, referencing
> >> both sensors and cooling devices through phandles.
> > 
> > I still don't get why and how defining a thermal zone inside a sensor
> > phandle can prevent us defining a cooling device in different device
> > phandle.
> 
> 
> Then you can keep everything about your thermal zone in one single
> phandle, as follows, but remember, this is is the info about the thermal
> zone, not about a cooling device. For instance, that is the zone built
> on top of a bandgap sensor:
> 	bandgap {
> 		reg = <0x4a002260 0x4 0x4a00232C 0x4>;
> 		compatible = "ti,omap4430-bandgap";
> 		thermal_zone {
> 			type = "CPU";
> 			mask = <0x03>; /* trips writability */
> 			passive_delay = <250>; /* milliseconds */
> 			polling_delay = <1000>; /* milliseconds */
> 			governor = "step_wise";
> 			trips {
> 				alert@100000{
> 					temperature = <100000>;
> 					hysteresis = <0>;
> 					type = <1>;
> 				};
> 				crit@125000{
> 					temperature = <125000>;
> 					hysteresis = <0>;
> 					type = <3>;
> 				};
> 			};
> 			bind_params {
> 				action@0{
> 					cooling_device = "thermal-cpufreq";
> 					weight = <100>; /* percentage */
> 					mask = <0x01>;
> 				};
> 			};
> 		};
> 	};
> 
> 
> And you see that, in this case, the bandgap sensor driver does not need
> to worry about loading the cpufreq cooling device anymore. Who is
> responsible of doing that is the cpufreq driver, with the above
> proposal, when it makes sense and when there is a need.

Yes, this makes perfect sense to me. What I would like is to have the
links more specific in the devicetree, so to me this stringmatching
thing doesn't look too appealing, as it makes it harder to follow the
links just looking at the DT. That's why I would prefer them to be
phandles, so I could do something like:

bind_params {
	action@0 {
		cooling_device = <&cpu@0>;
		weight = <40>; /* percentage */
		mask = <0x01>;
	};
	action@1 {
		cooling_device = <&gpu3d>;
		weigth = <60>;
		mask = <0x01>;
};

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

