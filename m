From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Thu, 28 Aug 2014 18:11:43 +0200
Message-ID: <3440260.edal29kzlR@diego>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com> <2852853.mfRZfFVSev@wuerfel> <20140828143733.GA18084@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140828143733.GA18084@developer>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
> Ceasar and Arnd,
> 
> On Thu, Aug 28, 2014 at 10:48:23AM +0200, Arnd Bergmann wrote:
> > On Thursday 28 August 2014 08:59:19 Caesar Wang wrote:
> > > Thermal is TS-ADC Controller module supports user-defined mode and
> > > automatic mode.
> > > 
> > > User-defined mode refers,TSADC all the control signals entirely by
> > > software
> > > writing to register for direct control.
> > > 
> > > Automaic mode refers to the module automatically poll TSADC output,and
> > > the results Were checked.
> > > 
> > > If you find that the temperature High in a period of time, an interrupt
> > > is generated to the processor down-measures taken;if the temperature
> > > over a period of time High, the resulting TSHUT gave CRU module,let it
> > > reset the entire chip, or via GPIO give PMIC.
> > > 
> > > Signed-off-by: zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > Signed-off-by: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > 
> > Hi Caesar,
> > 
> > After looking at the driver (last time I only received the patch for
> > the binding), I have a more general comment:
> > 
> > This looks like a general-purpose ADC device, not an IP block that is
> > specific to thermal management. The binding looks ok for that purpose
> > but should probably be moved into
> > Documentation/devicetree/bindings/iio/adc/ as a minor change.
> 
> I agree with Arnd's point here. It makes sense to me to have this driver
> under the IIO umbrella.

interesting suggestion :-)

I've just taken another look at the registers of the ts-adc on the rk3066 
which is completely different from the rk3288 one. Interestingly the rk3066 one 
is "just" another saradc IP, so for this one it would really make sense.


> > On the driver side, I believe the correct way to deal with this setup
> > is to split your driver into a generic drivers/iio/adc/rockchips-tsadc.c
> > file, and a smaller thermal driver that uses the iio in-kernel interfaces,
> > ideally one that is independent of the underlying hardware and can
> > work on any ADC implementation.
> 
> Agreed. If you can write such interface and make your driver to work in
> such way, that would be great.

But I currently don't see how you would model the temperature handling parts 
from a generic thermal driver to a generic adc driver for the rk3288-tsadc.

I guess the general temperature irq handling would use iio-triggers? But how 
does the target temperature get into the TSADC_COMP1_INT register.

Also when getting the temperature, Caesar's driver compares it to its trip 
points and sets the next trip point depending on the current temperature 
(passive <-> critical) in rockchip_get_temp.

Maybe there is some completely easy way for this, but currently I don't see 
it.


Heiko
