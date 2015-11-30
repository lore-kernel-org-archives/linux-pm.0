From: dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
Date: Mon, 30 Nov 2015 18:21:24 +0800
Message-ID: <1448878884.29031.49.camel@mtksdaap41>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
	 <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
	 <20151130053845.GM3373@ubuntu> <1448875581.29031.14.camel@mtksdaap41>
	 <20151130093042.GA8556@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151130093042.GA8556@ubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-11-30 at 15:00 +0530, Viresh Kumar wrote:
> On 30-11-15, 17:26, dawei chien wrote:
> > On Mon, 2015-11-30 at 11:08 +0530, Viresh Kumar wrote:
> > > On 27-11-15, 17:32, Dawei Chien wrote:
> > > > MT8173 cpufreq driver use of_cpufreq_power_cooling_register registering
> > > > cooling devices with dynamic power coefficient.
> > > > 
> > > > Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > > ---
> > > > This patch is base on patchset:
> > > > https://lkml.org/lkml/2015/11/17/251
> > > > ---
> > > >  drivers/cpufreq/mt8173-cpufreq.c |   28 ++++++++++++++++++++--------
> > > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> > > > index 83001dc..4d39468 100644
> > > > --- a/drivers/cpufreq/mt8173-cpufreq.c
> > > > +++ b/drivers/cpufreq/mt8173-cpufreq.c
> > > > @@ -263,24 +263,34 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +#define DYNAMIC_POWER "dynamic-power-coefficient"
> > > > +
> > > >  static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
> > > >  {
> > > >  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> > > >  	struct device_node *np = of_node_get(info->cpu_dev->of_node);
> > > > +	u32 capacitance;
> > > >  
> > > >  	if (WARN_ON(!np))
> > > >  		return;
> > > >  
> > > >  	if (of_find_property(np, "#cooling-cells", NULL)) {
> > > > -		info->cdev = of_cpufreq_cooling_register(np,
> > > > -							 policy->related_cpus);
> > > > +		if (!info->cdev) {
> > > 
> > > Why will info->cdev be non-NULL here ?
> > 
> > This is a error-checking to avoid user or any script by command line hotplug CPU
> > more than two times, we don't need to register cooling device on this case.
> 
> Why?
As far as I know, user or shell script has the right for using command online/offline cpu.
Either user by console or shell script could make cpu2 online even cpu2 already onlined.
That could cause of_cpufreq_cooling_register execute many times for the
same cooling device.

"echo 1 > /sys/devices/system/cpu/cpu2/online"

With above hotplug command, mtk_cpufreq_ready will register cooling
device again as well, but fail since the cooling device already created,
so we might need not register cooling device again on this case.

> > I will remove it if you don't agree it.
> 
> No, my agreeing or not doesn't matter. If what you are doing is useful
> (and I am not able to understand it), then you should make me
> understand that and don't change your code.
> 
> But, I really do not get the reasoning behind the logic. Please
> elaborate that step by step.

Please refer to above explaining, thank you.

> > > > @@ -460,7 +470,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
> > > >  {
> > > >  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> > > >  
> > > > -	cpufreq_cooling_unregister(info->cdev);
> > > > +	if (info->cdev)
> > > > +		cpufreq_cooling_unregister(info->cdev);
> > > > +
> > > 
> > > Why do you need to update this?
> > 
> > This is a error-checking to avoid user or any script by command line
> > unplug CPU more than two times, we don't need to unregister cooling
> > device on this case.
> > 
> > I will remove it if you don't agree it.
> 
> Same here.
Please refer to the same reason as above. thank you.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
