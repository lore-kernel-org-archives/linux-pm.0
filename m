From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] power: supply: Add driver for Microchip UCS1002
Date: Fri, 26 Apr 2019 10:04:37 -0700
Message-ID: <20190426170437.GA9087@roeck-us.net>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
 <20190417084457.28747-3-andrew.smirnov@gmail.com>
 <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_53vo__70Xm5pOoLvqPG2iNN32VP5cbFCatDq=o0GLYzsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Chris Health <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 26, 2019 at 06:51:51PM +0200, Enric Balletbo Serra wrote:
> Hi Andrey,
> 
> Many thanks to push this upstream. Actually this the fifth version [1]
> of this patchset. I think that is interesting for the maintainers
> maintain the history and the changelog.
> 
> [1] https://lkml.org/lkml/2016/3/14/233
> 
> Missatge de Andrey Smirnov <andrew.smirnov@gmail.com> del dia dc., 17
> d’abr. 2019 a les 10:46:
> >
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Health <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---

...

> > +       static const int bit_weights_uAh[BITS_PER_TYPE(u32)] = {
> > +               0, 0, 0, 0, 0, 0, 3, 5,
> > +
> 
> nit: I personally don't like these empty lines here.
> 
I stumbled over those as well, but then I realized that they
split up the 32 bit into bytes, so it does make some sense. 

Guenter
