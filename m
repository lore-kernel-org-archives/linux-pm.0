From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] thermal: imx: implement thermal alarm interrupt
 handling
Date: Mon, 5 Aug 2013 17:10:38 +0800
Message-ID: <20130805091036.GH24629@S2101-09.ap.freescale.net>
References: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
 <1375374792-32326-3-git-send-email-p.zabel@pengutronix.de>
 <20130805032254.GA24629@S2101-09.ap.freescale.net>
 <1375689012.4000.32.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:13727
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503Ab3HEJJp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2013 05:09:45 -0400
Content-Disposition: inline
In-Reply-To: <1375689012.4000.32.camel@pizza.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kernel@pengutronix.de

On Mon, Aug 05, 2013 at 09:50:12AM +0200, Philipp Zabel wrote:
> > Could imx_get_temp() be possibly called when mode is
> > !THERMAL_DEVICE_ENABLED?  If not, this will be a piece of code which
> > will never be called but simply confusing people.
> 
> yes:
>   echo disabled > /sys/class/thermal/thermal_zone0/mode
>   cat /sys/class/thermal/thermal_zone0/temp
> 
> Maybe I should extend the comment?
> 
Unnecessary.  I was missing a very valid use case.

<snip>

> > Running the driver in polling mode with step_wise governor, we can have
> > cooling device (cpufreq) enter different cooling level, when temperature
> > increases or decreases.  For example, imx6q runs at 1GHz before reaching
> > passive temperature 85C, and will slow down to 800 MHz when temperature
> > reaches 85C.  It will continue slowing down 400 MHz if temperature
> > continues increasing to, saying 87C.  And if temperature decreases, the
> > frequency will go back to 800 MHz and then 1 GHz.
> > 
> > With interrupt mode, thermal zone update will only be triggered by alarm
> > temperature.  That says cooling device will transit between different
> > cooling levels only when passive or critical temperature is reached in
> > raising thermal trend.  For above example, even when temperature
> > decreases back to something original below 85C, CPU will still run at
> > 400 MHz, I think.
> 
> I have not disabled the polling (with 0.5 Hz below and 1 Hz above the
> passive trip point), that still works as before.
> The interrupt only forces an additional measurement right after the
> alarm interrupt. I think for the step_wise governor we should probably
> also raise the polling frequency for a while after getting interrupted.
> 
Yeah, I forgot about that polling still works, and somehow was confused
by the temperature behavior change that is actually caused by the recent
step_wise governor updates.  Sorry for the noise.

<snip>

> > This is another thing that interrupt support changes comparing to
> > polling mode.  In polling mode, tempmon circuit consumes power only when
> > the measurement takes place, while now we have to keep the power on
> > since initialization.
> 
> That is correct. Is there any information about how much this circuit is
> actually consuming? Should this be made configurable?

I do not have the data.  Consuming less power is desirable, but I think
it's more important to keep chip safe.  That said, I'm happy with the
patch.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Certainly polling in 100 ms intervals will consume more energy, and 2 s
> intervals are short enough for all hardware configurations.

