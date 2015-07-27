From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Mon, 27 Jul 2015 22:27:48 +0100
Message-ID: <20150727212748.GF21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150727160447.GL1577@lahna.fi.intel.com>
 <20150727162413.GE21114@x1>
 <4701357.XbJcg3OWzk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4701357.XbJcg3OWzk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Rafael J. Wysocki wrote:

> On Monday, July 27, 2015 05:24:13 PM Lee Jones wrote:
> > On Mon, 27 Jul 2015, Mika Westerberg wrote:
> >=20
> > > On Mon, Jul 27, 2015 at 04:27:33PM +0100, Lee Jones wrote:
> > > > FAO Stephen Boyd,
> > > >=20
> > > > > Stephen, can you, please, have a look into patch 8 regarding =
to clock name
> > > > > matching and other stuff Lee asked?
> > > >=20
> > > > Patch 8:
> > > >=20
> > > >       "Can you review the clock implementation please?  It look=
s
> > > >       fragile to me as it relies heavily on device names constr=
ucted
> > > >       of MFD cell names and IDA numbers cat'ed together!"
> > >=20
> > > Lee, can you suggest an alternative then?
> > >=20
> > > Why we are doing it like this is that number of different LPSS de=
vices
> > > changes from SoC to SoC. In addition to that the device (called "=
slice")
> > > might have iDMA block or not.
> > >=20
> > > Since the drivers in question (pxa2xx-spi, i2c-designware and 825=
0_dw)
> > > use standard clk framework to request their clocks the Linux devi=
ce must
> > > have clock registered which matches the device in advance.
> > >=20
> > > Because we add the host controller device dynamically (from the M=
=46D
> > > driver) based on how many devices are actually present, we need s=
omehow
> > > predict what would be the correct name and instance number for th=
at
> > > device to get the clock for it. That's the reason we use IDA here=
 along
> > > with the cell name (or driver name).
> >=20
> > I'm sure there are perfectly viable reasons for you doing this.  An=
d I
> > don't know the CCF well enough to know whether it's the best idea o=
r
> > not, or else I would have made a suggestion rather than waiting all
> > this time.
> >=20
> > It's for this reason that I needed Mike (now Stephen) to take a loo=
k
> > and give me either an Ack, to say it's the best solution, or to
> > provide a better alternative.
> >=20
> > Until that happens, I'm stuck!
>=20
> Well, what if we had no one at hand to review that code?  Would that =
mean it
> would not be applicable forever?

No, but that's not the case is it?

I don't understand why Mike and Stephen aren't helping!

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
