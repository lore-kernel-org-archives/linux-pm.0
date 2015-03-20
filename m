From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Fri, 20 Mar 2015 11:24:14 +0000
Message-ID: <20150320112414.GD14766@leverpostej>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150319141753.GB25967@leverpostej>
 <20150320060653.GC18907@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150320060653.GC18907@leoy-linaro>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: kongxinwei <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhuang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

> > > +       ret = of_property_read_u32(np, "hisilicon,tsensor-thres-temp",
> > > +                                  &sensor->thres_temp);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "failed to get thres value %d: %d\n",
> > > +                       index, ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret = of_property_read_u32(np, "hisilicon,tsensor-reset-temp",
> > > +                                  &sensor->reset_temp);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "failed to get reset value %d: %d\n",
> > > +                       index, ret);
> > > +               return ret;
> > > +       }
> > 
> > I see now that these properties result in the HW being programmed. You
> > should figure out how to reconcile these with thermal-zone trip points
> > rather than having parallel properties.
>  
> Set "tsensor-thres-temp" to register so that if thermal reaches the
> threshold, the sensor will trigger h/w interrupt.
> 
> Set "tsensor-reset-temp" to register so that if thermal reaches the
> reset value, the sensor will assert SoC reset signal to trigger h/w
> reset.

I understand this.

> This is different w/t thermal-zone trip points, the trip points are
> used for timer polling.

That may be the case in the code as it stands today, but per the binding
the trip points are the temperatures at which an action is to be taken.

The thermal-zone has poilling-delay and polling-delay-passive, but
there's no reason you couldn't also use the interrupt to handle the
"hot" trip-point, adn the reset at the "critical" trip-point. All that's
missing is the plumbing in order to do so.

So please co-ordinate with the thermal framework to do that.

> Do u think below modification is more reasonable?
> 
> - Set "tsensor-thres-temp" = 700000, which equal to thermal-zone
>   passive trip point, so that we can use h/w interrupt to update the
>   thermal value immediately, rather than using polling method w/t long
>   delay;
> 
> - Set "tsensor-reset-temp" = <100000>, which is higher than
>   thermal-zone critical trip point, so that the s/w reset method has
>   higher priority than h/w reset; we also can easily know the reset is
>   caused by thermal framework; "tsensor-reset-temp" is only used to
>   protect h/w circuit.

As mentioned above, I think that you should co-ordinate with the thermal
framework. You're worknig around limitations inthe code as it stands
today rather than solving the fundamental issue.

> > > +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq")) {
> > > +
> > > +               if (data->irq_bind_sensor != -1)
> > > +                       dev_warn(&pdev->dev, "irq has bound to index %d\n",
> > > +                                data->irq_bind_sensor);
> > > +
> > > +               /* bind irq to this sensor */
> > > +               data->irq_bind_sensor = index;
> > > +       }
> > 
> > I don't see why this should be specified in the DT. Why do you believe
> > it should?
> 
> The thermal sensor module has four sensors, but have only one
> interrupt signal; This interrupt can only be used by one sensor;
> So want to use dts to bind the interrupt with one selected sensor.

That's not all that great, though I'm not exactly sure how the kernel
would select the best sensor to measure with. It would be good if you
could talk to the thermal maintainers w.r.t. this.

> > > +static int hisi_thermal_probe(struct platform_device *pdev)
> > > +{
> > > +       struct hisi_thermal_data *data;
> > > +       struct resource *res;
> > > +       int i;
> > > +       int ret;
> > > +
> > > +       if (!cpufreq_get_current_driver()) {
> > > +               dev_dbg(&pdev->dev, "no cpufreq driver!");
> > > +               return -EPROBE_DEFER;
> > > +       }
> > 
> > Surely we care about not burning out the board even if we don't have
> > cpufreq?
> > 
> > Is there any ordering guarantee between the probing of this driver and
> > cpufreq?
> 
> Yes, here need binding the thermal sensor w/t cpu cooling device,
> and cpu cooling device is based on cpufreq driver.

Sure, but if you don't have a cooling device you still want the critical
temperature reset and so on, no?

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
