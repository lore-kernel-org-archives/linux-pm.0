From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 05/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Thu, 20 Oct 2016 14:21:27 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE459A@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource@diasemi.com>
 <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:6025 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932526AbcJTOVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 10:21:35 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Keerthy' <a0393675@ti.com>, 'Eduardo Valentin' <edubezval@gmail.com>, 'LINUX-KERNEL' <linux-kernel@vger.kernel.org>, 'LINUX-PM' <linux-pm@vger.kernel.org>, 'Zhang Rui' <rui.zhang@intel.com>

On 20 October 2016 14:03 Steve Twiss wrote:

> On  07 October 2016 06:29 Keerthy wrote:
> > On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
> > >
> > > +	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
> > > +	mutex_init(&thermal->lock);
> >
> > thermal_zone_device_register itself does
> > INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> >
> > refer: drivers/thermal/thermal_core.c
> >
> > It does a periodic monitoring of the temperature as well. Do you really
> > want to have an additional work for monitoring temperature in your
> > driver also?
> 
> The thermal triggering mechanism is interrupt based and happens when the
> temperature rises above a given threshold level. The component cannot
> return an exact temperature, it only has knowledge if the temperature is
> above or below a given threshold value. A status bit must be polled to
> detect when the temperature falls below that threshold level again.
> 
> If I was to use the core's polling_delay it would request get_temp() every
> x milliseconds. This would work: I could test the status bit to decide if
> the temperature was above or below the threshold, and enable or disable
> the interrupt accordingly. But during normal operation, when the temperature
> is in the normal range, I would be polling through I2C every x milliseconds
> instead of just waiting for an IRQ trigger event before starting my polling
> operations to detect when the temperature level fell below the threshold.
> 
> Since an over-temperature is supposed to be a very rare event, I decided to
> go with the IRQ based trigger and then kick-off a separate work-queue to
> poll the status bit and detect when the temperature dropped below the
> threshold level. This seemed a more efficient way of handling this.
> 
> I have looked through thermal core, and there doesn't seem to be an
> obvious way of toggling on/off thermal core polling when I need to poll the
> temperature through get_temp(). So, I was going to stick with this method
> for PATCH V2.

Ok. There doesn't seem to be any formal way to do this in the thermal core, 
but after a second look, it seems like I can hijack the polling_delay value and
turn the polling on and off from my device driver. There is no API to do this,
but it seems to be possible.

I start with polling off, wait for an over-temperature IRQ trigger and tweak
the polling_delay value, say, like this:

static irqreturn_t da9062_thermal_irq_handler(int irq, void *data) {
	struct da9062_thermal *thermal = data;
	disable_irq_nosync(thermal->irq);
	thermal->zone->polling_delay = 3000;
	thermal_zone_device_update(thermal->zone);
	return IRQ_HANDLED;
}

Then when polling starts and get_temp() is called, I can re-enable the IRQ again
if the temperature has dropped.
At that point I can also turn off the thermal core polling by re-writing the 
polling_delay. Like this:

static int da9062_thermal_get_temp(struct thermal_zone_device *z,
				   int *temp)
{
	struct da9062_thermal *thermal = z->devdata;
	...
	/* if temp has dropped */
	thermal->zone->polling_delay = 0;
	enable_irq(thermal->irq);
}

I'm not certain if this is acceptable, accessing the thermal core like this.
I will send this patch separately as a RFC I think.

Regards,
Steve
