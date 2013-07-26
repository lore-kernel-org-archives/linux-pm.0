From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] cpufreq-cpu0: support Device Tree initialisation
Date: Fri, 26 Jul 2013 14:43:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307261431510.22137@axis700.grange>
References: <Pine.LNX.4.64.1307261214430.22137@axis700.grange>
 <51F2698A.5020904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F2698A.5020904@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Nishanth

On Fri, 26 Jul 2013, Nishanth Menon wrote:

> On 07/26/2013 05:19 AM, Guennadi Liakhovetski wrote:
> > Currently the cpufreq-cpu0 driver doesn't support Device Tree probing. To
> > support it we add an OF match table to it. In principle this alone is
> > enough to get the driver working with DT devices, but then the driver
> > rewrites the .of_node field of the probed device with a different one,
> > which isn't clean. To avoid this we use the cpu0 system device for clock
> > and OPP handling, similar to what the arm_big_little CPUFreq driver does.
> > This is also less intrusive, since the cpu0 device's .of_node field is
> > initially NULL, since this isn't a DT device.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >   drivers/cpufreq/cpufreq-cpu0.c |   14 +++++++++++---
> >   1 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> > index ad1fde2..d2ad7b8 100644
> > --- a/drivers/cpufreq/cpufreq-cpu0.c
> > +++ b/drivers/cpufreq/cpufreq-cpu0.c
> > @@ -12,6 +12,7 @@
> >   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> > 
> >   #include <linux/clk.h>
> > +#include <linux/cpu.h>
> >   #include <linux/cpufreq.h>
> >   #include <linux/err.h>
> >   #include <linux/module.h>
> > @@ -194,7 +195,7 @@ static int cpu0_cpufreq_probe(struct platform_device
> > *pdev)
> >   		goto out_put_parent;
> >   	}
> > 
> > -	cpu_dev = &pdev->dev;
> > +	cpu_dev = get_cpu_device(0);
> >   	cpu_dev->of_node = np;
> > 
> >   	cpu_reg = devm_regulator_get(cpu_dev, "cpu0");
> > @@ -289,10 +290,17 @@ static int cpu0_cpufreq_remove(struct platform_device
> > *pdev)
> >   	return 0;
> >   }
> > 
> > +static const struct of_device_id cpu0_cpufreq_of_match[] = {
> > +	{.compatible = "cpufreq-cpu0"},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, cpu0_cpufreq_of_match);
> > +
> >   static struct platform_driver cpu0_cpufreq_platdrv = {
> >   	.driver = {
> > -		.name	= "cpufreq-cpu0",
> > -		.owner	= THIS_MODULE,
> > +		.name		= "cpufreq-cpu0",
> > +		.of_match_table	= cpu0_cpufreq_of_match,
> > +		.owner		= THIS_MODULE,
> >   	},
> >   	.probe		= cpu0_cpufreq_probe,
> >   	.remove		= cpu0_cpufreq_remove,
> > 
> Did we not go down this approach[1] previously? Could you explain why this
> path is different now?

Yes, you're right, I forgot about that discussion, sorry. But my 
motivation was the following: yes, I'm aware, that the DT should only 
describe real hardware _devices_ and hardware _properties_. But this patch 
- just like your original patch - don't add a pseudo _device_ or 
_property_, but a compatibility string. So, to me it was like "a class of 
all systems, where the CPU performance can be scaled using one power 
supply and one clock. Isn't this a hardware feature? We already have CPU 
nodes in DT, this would be just (an additional) compatibility string to 
them? I'll be happy to drop this patch and revive yours, if we manage to 
agree upon the scope.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
