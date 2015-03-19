From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
Date: Thu, 19 Mar 2015 11:38:24 +0000
Message-ID: <20150319113824.GC4449@red-moon>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org>
 <20150319110806.GE24556@red-moon>
 <550AB298.6040907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550AB298.6040907-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 19, 2015 at 11:27:20AM +0000, Daniel Lezcano wrote:

[...]

> >>   	for_each_possible_cpu(cpu) {
> >>   		ret = arm_cpuidle_init(cpu);
> >> +
> >> +		/* This cpu does not support any idle states */
> >> +		if (ret == -ENOSYS)
> >> +			continue;
> >> +
> >>   		if (ret) {
> >>   			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> >> -			return ret;
> >> +			goto out_fail;
> >> +		}
> >> +
> >> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >> +		if (!dev) {
> >> +			pr_err("Failed to allocate cpuidle device\n");
> >> +			goto out_fail;
> >> +		}
> >> +
> >> +		dev->cpu = cpu;
> >> +		per_cpu(cpuidle_arm_dev, cpu) = dev;
> >> +
> >> +		ret = cpuidle_register_device(dev);
> >> +		if (ret) {
> >> +			pr_err("Failed to register cpuidle device for CPU %d\n",
> >> +			       cpu);
> >> +			kfree(dev);
> >> +			goto out_fail;
> >>   		}
> >>   	}
> >> +out:
> >> +	return ret;
> >
> > return 0;
> >
> >>
> >> -	return cpuidle_register(drv, NULL);
> >> +out_fail:
> >> +	for (cpu--; cpu <= 0; cpu--) {
> >
> > This loop is wrong.
> 
> Why is it wrong ? We have to initialize at cpu - 1 to unregister the 
> previous registered cpu, not the current one, no ?

Yes, but on cpu>=0 not cpu<=0

while (--cpu >= 0)

?

Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
