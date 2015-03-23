From: kongxinwei <xweikong@hotmail.com>
Subject: Re: [PATCH 1/3] thermal: hisilicon: add new hisilicon thermal sensor
 driver
Date: Mon, 23 Mar 2015 16:30:59 +0800
Message-ID: <BLU436-SMTP68AF510203FB039DA92B6CC10D0@phx.gbl>
References: <1426751849-10604-1-git-send-email-kong.kongxinwei@hisilicon.com> <1426751849-10604-2-git-send-email-kong.kongxinwei@hisilicon.com> <20150319141753.GB25967@leverpostej> <20150320060653.GC18907@leoy-linaro> <20150320112414.GD14766@leverpostej> <20150320145353.GA20461@leoy-linaro> <20150320155527.GJ14766@leverpostej> <20150323044612.GB20840@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from blu004-omc1s3.hotmail.com ([65.55.116.14]:63962 "EHLO
	BLU004-OMC1S3.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbCWIbH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 04:31:07 -0400
In-Reply-To: <20150323044612.GB20840@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: kongxinwei <kong.kongxinwei@hisilicon.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "rui.zhuang@intel.com" <rui.zhuang@intel.com>, "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 03/23/2015 12:46 PM, Leo Yan wrote:
> On Fri, Mar 20, 2015 at 03:55:27PM +0000, Mark Rutland wrote:
>>>> That may be the case in the code as it stands today, but per the binding
>>>> the trip points are the temperatures at which an action is to be taken.
>>>>
>>>> The thermal-zone has poilling-delay and polling-delay-passive, but
>>>> there's no reason you couldn't also use the interrupt to handle the
>>>> "hot" trip-point, adn the reset at the "critical" trip-point. All that's
>>>> missing is the plumbing in order to do so.
>>>>
>>>> So please co-ordinate with the thermal framework to do that.
>>> Let's dig further more for this point, so that we can get more specific
>>> gudiance and have a good preparation for next version's patch set.
>>>
>>> After i reviewed the thermal framework code, currently have one smooth
>>> way to co-ordinate the trip points w/t thermal framework: use the function
>>> *thermal_zone_device_register()* to register sensor, and can use the
>>> callback function .get_trip_temp to tell thermal framework for the
>>> trip points' temperature.
>>>
>>> For hisi thermal case, now the driver is using the function
>>> *thermal_zone_of_sensor_register* to register sensor, but use this way
>>> i have not found there have standard APIs which can be used by sensor
>>> driver to get the trip points info from thermal framework.
>>>
>>> I may miss something for thermal framework, so if have existed APIs to
>>> get the trip points, could pls point out?
>> I am only familiar with the binding, not the Linux implementation -- The
>> latter can change to accomodate your hardware without requiring binding
>> changes. Please co-ordinate with the thermal maintainers.
> Found the functions of_thermal_get_trip_points(tz) and of_thermal_get_ntrips(tz)
> will help for this.
>
>>>>>>> +       if (of_property_read_bool(np, "hisilicon,tsensor-bind-irq")) {
>>>>>>> +
>>>>>>> +               if (data->irq_bind_sensor != -1)
>>>>>>> +                       dev_warn(&pdev->dev, "irq has bound to index %d\n",
>>>>>>> +                                data->irq_bind_sensor);
>>>>>>> +
>>>>>>> +               /* bind irq to this sensor */
>>>>>>> +               data->irq_bind_sensor = index;
>>>>>>> +       }
>>>>>> I don't see why this should be specified in the DT. Why do you believe
>>>>>> it should?
>>>>> The thermal sensor module has four sensors, but have only one
>>>>> interrupt signal; This interrupt can only be used by one sensor;
>>>>> So want to use dts to bind the interrupt with one selected sensor.
>>>> That's not all that great, though I'm not exactly sure how the kernel
>>>> would select the best sensor to measure with. It would be good if you
>>>> could talk to the thermal maintainers w.r.t. this.
>>> This will be decided by the silicon, right? Every soc has different
>>> combination with cpu/gpu/vpu, so which part is hottest, this maybe
>>> highly dependent on individual SoC.
>>>
>>> S/W just need provide the flexibility so that later can choose
>>> the interrupt to bind with the sensor within the hottest part.
>> Then the property you care about is which sensor is closest to what is
>> likely to be the hottest component. Given that, the kernel can decide
>> how to use the interrupt.
> Will modify the driver to dynamically bind the interrupt to hottest
> sensor; Appreciate for good suggestion.
>
> Thanks,
> Leo Yan

Hi mark:
    Thank you for your comments,please wait the next version to slove your
presenting problem.

Thanks.
Xinwei

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

