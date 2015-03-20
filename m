From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Fri, 20 Mar 2015 22:53:53 +0800
Message-ID: <20150320145353.GA20461@leoy-linaro>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150319141753.GB25967@leverpostej>
 <20150320060653.GC18907@leoy-linaro>
 <20150320112414.GD14766@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150320112414.GD14766@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: kongxinwei <kong.kongxinwei@hisilicon.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 20, 2015 at 11:24:14AM +0000, Mark Rutland wrote:
> > > > +       ret = of_property_read_u32(np, "hisilicon,tsensor-thres-temp",
> > > > +                                  &sensor->thres_temp);
> > > > +       if (ret) {
> > > > +               dev_err(&pdev->dev, "failed to get thres value %d: %d\n",
> > > > +                       index, ret);
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       ret = of_property_read_u32(np, "hisilicon,tsensor-reset-temp",
> > > > +                                  &sensor->reset_temp);
> > > > +       if (ret) {
> > > > +               dev_err(&pdev->dev, "failed to get reset value %d: %d\n",
> > > > +                       index, ret);
> > > > +               return ret;
> > > > +       }
> > > 
> > > I see now that these properties result in the HW being programmed. You
> > > should figure out how to reconcile these with thermal-zone trip points
> > > rather than having parallel properties.
> >  
> > Set "tsensor-thres-temp" to register so that if thermal reaches the
> > threshold, the sensor will trigger h/w interrupt.
> > 
> > Set "tsensor-reset-temp" to register so that if thermal reaches the
> > reset value, the sensor will assert SoC reset signal to trigger h/w
> > reset.
> 
> I understand this.
> 
> > This is different w/t thermal-zone trip points, the trip points are
> > used for timer polling.
> 
> That may be the case in the code as it stands today, but per the binding
> the trip points are the temperatures at which an action is to be taken.
> 
> The thermal-zone has poilling-delay and polling-delay-passive, but
> there's no reason you couldn't also use the interrupt to handle the
> "hot" trip-point, adn the reset at the "critical" trip-point. All that's
> missing is the plumbing in order to do so.
> 
> So please co-ordinate with the thermal framework to do that.

Let's dig further more for this point, so that we can get more specific
gudiance and have a good preparation for next version's patch set.

After i reviewed the thermal framework code, currently have one smooth
way to co-ordinate the trip points w/t thermal framework: use the function
*thermal_zone_device_register()* to register sensor, and can use the
callback function .get_trip_temp to tell thermal framework for the
trip points' temperature.

For hisi thermal case, now the driver is using the function
*thermal_zone_of_sensor_register* to register sensor, but use this way
i have not found there have standard APIs which can be used by sensor
driver to get the trip points info from thermal framework.

I may miss something for thermal framework, so if have existed APIs to
get the trip points, could pls point out?

> > Do u think below modification is more reasonable?
> > 
> > - Set "tsensor-thres-temp" = 700000, which equal to thermal-zone
> >   passive trip point, so that we can use h/w interrupt to update the
> >   thermal value immediately, rather than using polling method w/t long
> >   delay;
> > 
> > - Set "tsensor-reset-temp" = <100000>, which is higher than
> >   thermal-zone critical trip point, so that the s/w reset method has
> >   higher priority than h/w reset; we also can easily know the reset is
> >   caused by thermal framework; "tsensor-reset-temp" is only used to
> >   protect h/w circuit.
> 
> As mentioned above, I think that you should co-ordinate with the thermal
> framework. You're worknig around limitations inthe code as it stands
> today rather than solving the fundamental issue.
> 
> > > > +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq")) {
> > > > +
> > > > +               if (data->irq_bind_sensor != -1)
> > > > +                       dev_warn(&pdev->dev, "irq has bound to index %d\n",
> > > > +                                data->irq_bind_sensor);
> > > > +
> > > > +               /* bind irq to this sensor */
> > > > +               data->irq_bind_sensor = index;
> > > > +       }
> > > 
> > > I don't see why this should be specified in the DT. Why do you believe
> > > it should?
> > 
> > The thermal sensor module has four sensors, but have only one
> > interrupt signal; This interrupt can only be used by one sensor;
> > So want to use dts to bind the interrupt with one selected sensor.
> 
> That's not all that great, though I'm not exactly sure how the kernel
> would select the best sensor to measure with. It would be good if you
> could talk to the thermal maintainers w.r.t. this.

This will be decided by the silicon, right? Every soc has different
combination with cpu/gpu/vpu, so which part is hottest, this maybe
highly dependent on individual SoC.

S/W just need provide the flexibility so that later can choose
the interrupt to bind with the sensor within the hottest part.

> > > > +static int hisi_thermal_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct hisi_thermal_data *data;
> > > > +       struct resource *res;
> > > > +       int i;
> > > > +       int ret;
> > > > +
> > > > +       if (!cpufreq_get_current_driver()) {
> > > > +               dev_dbg(&pdev->dev, "no cpufreq driver!");
> > > > +               return -EPROBE_DEFER;
> > > > +       }
> > > 
> > > Surely we care about not burning out the board even if we don't have
> > > cpufreq?
> > > 
> > > Is there any ordering guarantee between the probing of this driver and
> > > cpufreq?
> > 
> > Yes, here need binding the thermal sensor w/t cpu cooling device,
> > and cpu cooling device is based on cpufreq driver.
> 
> Sure, but if you don't have a cooling device you still want the critical
> temperature reset and so on, no?

Okay, let's remove this dependency.

Thanks,
Leo Yan
