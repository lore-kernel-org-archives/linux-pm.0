From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 2/3] power: supply: Add driver for Microchip UCS1002
Date: Mon, 29 Apr 2019 12:10:27 -0700
Message-ID: <CAHQ1cqECkn3242zVb55ifmgEHdq0se91=PpS1zDL4wj2WdZmbw@mail.gmail.com>
References: <20190429054741.7286-1-andrew.smirnov@gmail.com>
 <20190429054741.7286-3-andrew.smirnov@gmail.com> <1556533656.2560.7.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556533656.2560.7.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 3:27 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Sonntag, den 28.04.2019, 22:47 -0700 schrieb Andrey Smirnov:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > > Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> [...]
> > +     /* Enable charge rationing by default */
> > > +   ret = regmap_update_bits(info->regmap, UCS1002_REG_GENERAL_CFG,
> > > +                            F_RATION_EN, F_RATION_EN);
> > > +   if (ret) {
> > > +           dev_err(dev, "Failed to read general config: %d\n", ret);
> > > +           return ret;
> > > +   }
> > +
> > > +   /*
> > > +    * Ignore the M1, M2, PWR_EN, and EM_EN pin states. Set active
> > > +    * mode selection to BC1.2 CDP.
> > > +    */
> > > +   ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> > > +                            V_SET_ACTIVE_MODE_MASK,
> > +                              V_SET_ACTIVE_MODE_BC12_CDP);
>
> This doesn't work as the F_PIN_IGNORE bit isn't set, so the the
> external strap settings are applied. I had to apply the following diff
> to make the driver behave as expected again:
>

Ugh, I missed this since pins on my board are set properly. Thanks for
catching that and sorry about the bug. Will fix in v3.

Thanks,
Andrey Smirnov
