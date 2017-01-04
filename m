From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/22] mfd: axp20x: add ADC cells for AXP20X and AXP22X
 PMICs
Date: Wed, 4 Jan 2017 11:56:37 +0000
Message-ID: <20170104115637.GC24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-5-quentin.schulz@free-electrons.com>
 <20170104115602.GB24058@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170104115602.GB24058@dell>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 04 Jan 2017, Lee Jones wrote:

> On Mon, 02 Jan 2017, Quentin Schulz wrote:
> 
> > This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
> > AXP221 and AXP223 MFD.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/mfd/axp20x.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Applied, thanks.

Whoops, wrong key combo!  Should have been:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index a33db5e..31a84d81 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -582,6 +582,9 @@ static struct mfd_cell axp20x_cells[] = {
> >  	}, {
> >  		.name		= "axp20x-regulator",
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp209-adc",
> > +	}, {
> >  		.name		= "axp20x-ac-power-supply",
> >  		.of_compatible	= "x-powers,axp202-ac-power-supply",
> >  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> > @@ -602,6 +605,9 @@ static struct mfd_cell axp221_cells[] = {
> >  	}, {
> >  		.name		= "axp20x-regulator",
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp221-adc"
> > +	}, {
> >  		.name		= "axp20x-usb-power-supply",
> >  		.of_compatible	= "x-powers,axp221-usb-power-supply",
> >  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> > @@ -615,6 +621,9 @@ static struct mfd_cell axp223_cells[] = {
> >  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
> >  		.resources		= axp22x_pek_resources,
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp221-adc"
> > +	}, {
> >  		.name			= "axp20x-regulator",
> >  	}, {
> >  		.name		= "axp20x-usb-power-supply",
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
