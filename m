From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v5 2/3] power: supply: Add driver for Microchip UCS1002
Date: Tue, 30 Apr 2019 21:22:38 -0700
Message-ID: <CAHQ1cqHnAS4kb76cTNfLX=YJsRT+dOJhwONGLCAdErh0KBTWyw@mail.gmail.com>
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
 <20190501033434.18548-3-andrew.smirnov@gmail.com> <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7002fe8e-7686-fe84-374f-766f99f8317d@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 8:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 4/30/19 8:34 PM, Andrey Smirnov wrote:
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
>
> Please indent the tristate line with a tab instead of spaces.
>

OK, will do.

Thanks,
Andrey Smirnov
