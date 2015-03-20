From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Fri, 20 Mar 2015 14:06:53 +0800
Message-ID: <20150320060653.GC18907@leoy-linaro>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150319141753.GB25967@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34085 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbCTGHF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 02:07:05 -0400
Received: by pdbni2 with SMTP id ni2so99088294pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 23:07:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150319141753.GB25967@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: kongxinwei <kong.kongxinwei@hisilicon.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

hi Mark,

Thanks for reviewing, pls see below questions.

On Thu, Mar 19, 2015 at 02:17:53PM +0000, Mark Rutland wrote:
> On Thu, Mar 19, 2015 at 07:57:27AM +0000, kongxinwei wrote:
> > This patch adds the support for hisilicon thermal sensor, within
> > hisilicon SoC. there will register sensors for thermal framework
> > and use device tree to bind cooling device.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> > ---
> >  drivers/thermal/Kconfig        |   8 +
> >  drivers/thermal/Makefile       |   1 +
> >  drivers/thermal/hisi_thermal.c | 531 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 540 insertions(+)
> >  create mode 100644 drivers/thermal/hisi_thermal.c

[...]

> > +       ret = of_property_read_u32(np, "hisilicon,tsensor-thres-temp",
> > +                                  &sensor->thres_temp);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to get thres value %d: %d\n",
> > +                       index, ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = of_property_read_u32(np, "hisilicon,tsensor-reset-temp",
> > +                                  &sensor->reset_temp);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to get reset value %d: %d\n",
> > +                       index, ret);
> > +               return ret;
> > +       }
> 
> I see now that these properties result in the HW being programmed. You
> should figure out how to reconcile these with thermal-zone trip points
> rather than having parallel properties.
 
Set "tsensor-thres-temp" to register so that if thermal reaches the
threshold, the sensor will trigger h/w interrupt.

Set "tsensor-reset-temp" to register so that if thermal reaches the
reset value, the sensor will assert SoC reset signal to trigger h/w
reset.

This is different w/t thermal-zone trip points, the trip points are
used for timer polling. Do u think below modification is more
reasonable?

- Set "tsensor-thres-temp" = 700000, which equal to thermal-zone
  passive trip point, so that we can use h/w interrupt to update the
  thermal value immediately, rather than using polling method w/t long
  delay;

- Set "tsensor-reset-temp" = <100000>, which is higher than
  thermal-zone critical trip point, so that the s/w reset method has
  higher priority than h/w reset; we also can easily know the reset is
  caused by thermal framework; "tsensor-reset-temp" is only used to
  protect h/w circuit.

	tsensor: tsensor@0,f7030700 {
		acpu1_sensor {
			hisilicon,tsensor-id = <1>;
			hisilicon,tsensor-lag-value = <10>;
			hisilicon,tsensor-thres-temp = <70000>;
			hisilicon,tsensor-reset-temp = <100000>;
		};
	};

	thermal-zones {

                ...

		cluster1: cluster1 {
			polling-delay-passive = <1000>; /* milliseconds */
			polling-delay = <5000>; /* milliseconds */

			/* sensor	ID */
			thermal-sensors = <&tsensor  1>;

			trips {
				cluster1_alert: cluster1_alert {
					temperature = <70000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "passive";
				};
				cluster1_crit: cluster1_crit {
					temperature = <90000>; /* millicelsius */
					hysteresis = <2000>; /* millicelsius */
					type = "critical";
				};
			};
        };

> > +
> > +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq")) {
> > +
> > +               if (data->irq_bind_sensor != -1)
> > +                       dev_warn(&pdev->dev, "irq has bound to index %d\n",
> > +                                data->irq_bind_sensor);
> > +
> > +               /* bind irq to this sensor */
> > +               data->irq_bind_sensor = index;
> > +       }
> 
> I don't see why this should be specified in the DT. Why do you believe
> it should?

The thermal sensor module has four sensors, but have only one
interrupt signal; This interrupt can only be used by one sensor;
So want to use dts to bind the interrupt with one selected sensor.

> [...]
> 
> > +static int hisi_thermal_probe(struct platform_device *pdev)
> > +{
> > +       struct hisi_thermal_data *data;
> > +       struct resource *res;
> > +       int i;
> > +       int ret;
> > +
> > +       if (!cpufreq_get_current_driver()) {
> > +               dev_dbg(&pdev->dev, "no cpufreq driver!");
> > +               return -EPROBE_DEFER;
> > +       }
> 
> Surely we care about not burning out the board even if we don't have
> cpufreq?
> 
> Is there any ordering guarantee between the probing of this driver and
> cpufreq?

Yes, here need binding the thermal sensor w/t cpu cooling device,
and cpu cooling device is based on cpufreq driver.

Thanks,
Leo Yan
