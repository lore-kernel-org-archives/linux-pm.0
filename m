From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to AXP813
Date: Thu, 7 Feb 2019 22:28:12 +0800
Message-ID: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
References: <20190207064535.9226-1-wens@csie.org> <20190207064535.9226-8-wens@csie.org>
 <20190207110247.GE20638@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207110247.GE20638@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2019 at 7:02 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 07 Feb 2019, Chen-Yu Tsai wrote:
>
> > From: Quentin Schulz <quentin.schulz@bootlin.com>
> >
> > The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> > supports this variant, we can add an mfd cell for it to use it.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > [wens@csie.org: add commit message]
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/mfd/axp20x.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 3c97f2c0fdfe..17b115845993 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
> >       DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> >  };
> >
> > +/* AXP803 and AXP813/AXP818 share the same interrupts */
> > +static struct resource axp803_usb_power_supply_resources[] = {
> > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> > +     DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>
> Nit: Why 2 spaces here?                              ^

2 spaces? I'm only seeing one.

> With that fixed, you can add my:
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
