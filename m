From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: Battery temperature
Date: Thu, 2 Nov 2017 15:01:37 +0000
Message-ID: <20171102150137.00004eb0@huawei.com>
References: <fd2a5fff-de60-fd71-cc91-198ff2565d4b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9937 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755772AbdKBPC3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 11:02:29 -0400
In-Reply-To: <fd2a5fff-de60-fd71-cc91-198ff2565d4b@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>

On Mon, 30 Oct 2017 09:26:33 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> We have a device with a series of rechargeable batteries.
> 
> The chargers are bq24725 and the batteries have a thermistor
> for temperature monitoring. This thermistor is connected to
> a standard adc component (ads1015).

Immediate thought is that we need to represent this device explicitly.
So for this we have the existing drivers/hwmon/ntc_thermistor driver.

> This means that the value
> the kernel knows for the temperature is in volts (from the
> iio driver). We can also monitor the charging current and the
> battery voltage for each battery/charger (also with that very
> same adc). A gpio pin indicates if external AC power is present.

A little nasty but not really in IIO scope. I presume there are
other devices with AC connection monitoring as a gpio that is polled?

Would probably expect that to be a extcon driver perhaps?


> This gpio pin has to be polled, i.e. it is not possible to hook
> up interrupts for it.
> 
> We currently have this "working" without the concept of neither
> battery nor charger manager in the kernel. It is all handled
> from user space by writing to
> 
>     /sys/class/power_supply/bq24735@<i2c-bus-and-addr>/status
> 
> to en-/disable charging and by monitoring the adc voltages
> and doing the unit conversion to degrees Celsius in user space.
> 
> IIUC, ideally there should be in-kernel charger-managers and
> battery objects for each charger/battery.

Potentially a generic charger manager might work well.

> 
> I wonder if there is any existing way to do the non-linear
> conversion from the iio-adc volt-reading of the thermistor to
> the desired unit of degrees-celsius, or if I need to write
> something myself?

Table and interpolation based in the above mentioned driver.

> 
> I do see the generic-adc-battery driver, which sounds about
> right, but it has no DT binding and it also has its
> cal_charge() callback which is presumably difficult to handle
> from DT? We have no way to get at the battery charge level,
> short of inaccurate guesses based on the battery voltage. The
> driver also appears to have no concept of battery temperature,
> but I suppose it could be extended with that? Not sure if it's
> even applicable, I'm fumbling...

Potentially you could probably make it work.  There will need to
be some sort of platform specific glue driver to pull it all together

That glue driver could then register an instance of generic adc battery
and provide the necessary platform data.

How that connects everything together could be handled via dt bindings.

> 
> I may have completely misunderstood how this is supposed to be
> hooked up in an ideal world.

Nope, just at tricky problem to solve neatly ;)

Jonathan

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
