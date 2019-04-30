From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 2/3] power: supply: Add driver for Microchip UCS1002
Date: Mon, 29 Apr 2019 18:16:19 -0700
Message-ID: <CAHQ1cqGnvyWxrqA2Bq92UEpo+OR-HSo-hwp6sh8P9x-YbTZZWQ@mail.gmail.com>
References: <20190429195349.20335-1-andrew.smirnov@gmail.com>
 <20190429195349.20335-3-andrew.smirnov@gmail.com> <20190429203601.GA22613@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429203601.GA22613@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 1:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Apr 29, 2019 at 12:53:48PM -0700, Andrey Smirnov wrote:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/power/supply/Kconfig         |   9 +
> >  drivers/power/supply/Makefile        |   1 +
> >  drivers/power/supply/ucs1002_power.c | 646 +++++++++++++++++++++++++++
> >  3 files changed, 656 insertions(+)
> >  create mode 100644 drivers/power/supply/ucs1002_power.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index e901b9879e7e..c614c8a196f3 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
> >        Say Y here to enable support for fuel gauge with SC27XX
> >        PMIC chips.
> >
> > +config CHARGER_UCS1002
> > +        tristate "Microchip UCS1002 USB Port Power Controller"
> > +     depends on I2C
> > +     depends on OF
> > +     select REGMAP_I2C
> > +     help
> > +       Say Y to enable support for Microchip UCS1002 Programmable
> > +       USB Port Power Controller with Charger Emulation.
> > +
> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index b731c2a9b695..c56803a9e4fe 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)        += axp288_charger.o
> >  obj-$(CONFIG_CHARGER_CROS_USBPD)     += cros_usbpd-charger.o
> >  obj-$(CONFIG_CHARGER_SC2731) += sc2731_charger.o
> >  obj-$(CONFIG_FUEL_GAUGE_SC27XX)      += sc27xx_fuel_gauge.o
> > +obj-$(CONFIG_CHARGER_UCS1002)        += ucs1002_power.o
> > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > new file mode 100644
> > index 000000000000..677f20a4d76f
> > --- /dev/null
> > +++ b/drivers/power/supply/ucs1002_power.c
> > @@ -0,0 +1,646 @@
> ...
> > +
> > +static enum power_supply_usb_type ucs1002_usb_types[] = {
> > +     POWER_SUPPLY_USB_TYPE_PD,
> > +     POWER_SUPPLY_USB_TYPE_SDP,
> > +     POWER_SUPPLY_USB_TYPE_DCP,
> > +     POWER_SUPPLY_USB_TYPE_CDP,
> > +     POWER_SUPPLY_USB_TYPE_UNKNOWN,
> > +};
> > +
> > +static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
> > +{
> > +     unsigned int mode;
> > +
> > +     if (val >= ARRAY_SIZE(ucs1002_usb_types))
> > +             return -EINVAL;
> > +
> I hate to bring it up that late, but I don't see a check
> against val being negative anywhere in the calling code.
>

Sure, I'll add it in v4

Thanks,
Andrey Smirnov
