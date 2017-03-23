From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for
 bcm2835 SoC
Date: Thu, 23 Mar 2017 19:52:09 +0100 (CET)
Message-ID: <859108212.127796.1490295129267@email.1und1.de>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
 <CABMQnVJx10e2qm0N=C_vxU9WAQGUJ3ZyAUgrK7WQZoxm9+P0wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABMQnVJx10e2qm0N=C_vxU9WAQGUJ3ZyAUgrK7WQZoxm9+P0wg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Nobuhiro,

> Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org> hat am 23. März 2017 um 17:53 geschrieben:
> 
> 
> Hi, Stefan.
> 
> 2017-03-13 7:11 GMT+09:00 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>:
> > Add basic thermal driver for bcm2835 SoC.
> >
> > This driver currently make sure that tsense HW block is set up
> > correctly.
> >
> > Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> > Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> > ---
> >  drivers/thermal/Kconfig           |    8 +
> >  drivers/thermal/Makefile          |    1 +
> >  drivers/thermal/bcm2835_thermal.c |  315 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 324 insertions(+)
> >  create mode 100644 drivers/thermal/bcm2835_thermal.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 776b343..3bd2406 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -453,4 +453,12 @@ config ZX2967_THERMAL
> >           the primitive temperature sensor embedded in zx2967 SoCs.
> >           This sensor generates the real time die temperature.
> >
> > +config BCM2835_THERMAL
> > +       tristate "Thermal sensors on bcm2835 SoC"
> > +       depends on ARCH_BCM2835 || COMPILE_TEST
> > +       depends on HAS_IOMEM
> > +       depends on THERMAL_OF
> > +       help
> > +         Support for thermal sensors on Broadcom bcm2835 SoCs.
> > +
> >  endif
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 7adae20..f23cde0 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -58,3 +58,4 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> >  obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
> >  obj-$(CONFIG_GENERIC_ADC_THERMAL)      += thermal-generic-adc.o
> >  obj-$(CONFIG_ZX2967_THERMAL)   += zx2967_thermal.o
> > +obj-$(CONFIG_BCM2835_THERMAL)  += bcm2835_thermal.o
> > diff --git a/drivers/thermal/bcm2835_thermal.c b/drivers/thermal/bcm2835_thermal.c
> > new file mode 100644
> > index 0000000..a9768f1
> > --- /dev/null
> > +++ b/drivers/thermal/bcm2835_thermal.c
> 
> <snip>
> 
> > +static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
> > +       .get_temp = bcm2835_thermal_get_temp,
> > +};
> > +
> > +static const struct of_device_id bcm2835_thermal_of_match_table[];
> 
> bcm2835_thermal_of_match_table has been defined twice.
> I think that it is better to define bcm2835_thermal_of_match_table below
> or move bcm2835_thermal_probe to bottom.

thanks for catching. I'm currently waiting for feedback from Eduardo and Rob before sending a new version.

Stefan

> 
> Best regards,
>   Nobuhiro
> 
> -- 
> Nobuhiro Iwamatsu
>    iwamatsu at {nigauri.org / debian.org}
>    GPG ID: 40AD1FA6
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
