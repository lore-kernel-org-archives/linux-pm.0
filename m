From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Tue, 28 Jul 2015 08:46:25 +0100
Message-ID: <20150728074625.GN21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150727212748.GF21114@x1>
 <20150727212934.GH21114@x1>
 <2258476.9C4JjWNs6u@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2258476.9C4JjWNs6u@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Jul 2015, Rafael J. Wysocki wrote:

> On Monday, July 27, 2015 10:29:34 PM Lee Jones wrote:
> > On Mon, 27 Jul 2015, Lee Jones wrote:
> >=20
> > > On Mon, 27 Jul 2015, Rafael J. Wysocki wrote:
> > >=20
> > > > On Monday, July 27, 2015 05:24:13 PM Lee Jones wrote:
> > > > > On Mon, 27 Jul 2015, Mika Westerberg wrote:
> > > > >=20
> > > > > > On Mon, Jul 27, 2015 at 04:27:33PM +0100, Lee Jones wrote:
> > > > > > > FAO Stephen Boyd,
> > > > > > >=20
> > > > > > > > Stephen, can you, please, have a look into patch 8 rega=
rding to clock name
> > > > > > > > matching and other stuff Lee asked?
> > > > > > >=20
> > > > > > > Patch 8:
> > > > > > >=20
> > > > > > >       "Can you review the clock implementation please?  I=
t looks
> > > > > > >       fragile to me as it relies heavily on device names =
constructed
> > > > > > >       of MFD cell names and IDA numbers cat'ed together!"
> > > > > >=20
> > > > > > Lee, can you suggest an alternative then?
> > > > > >=20
> > > > > > Why we are doing it like this is that number of different L=
PSS devices
> > > > > > changes from SoC to SoC. In addition to that the device (ca=
lled "slice")
> > > > > > might have iDMA block or not.
> > > > > >=20
> > > > > > Since the drivers in question (pxa2xx-spi, i2c-designware a=
nd 8250_dw)
> > > > > > use standard clk framework to request their clocks the Linu=
x device must
> > > > > > have clock registered which matches the device in advance.
> > > > > >=20
> > > > > > Because we add the host controller device dynamically (from=
 the MFD
> > > > > > driver) based on how many devices are actually present, we =
need somehow
> > > > > > predict what would be the correct name and instance number =
for that
> > > > > > device to get the clock for it. That's the reason we use ID=
A here along
> > > > > > with the cell name (or driver name).
> > > > >=20
> > > > > I'm sure there are perfectly viable reasons for you doing thi=
s.  And I
> > > > > don't know the CCF well enough to know whether it's the best =
idea or
> > > > > not, or else I would have made a suggestion rather than waiti=
ng all
> > > > > this time.
> > > > >=20
> > > > > It's for this reason that I needed Mike (now Stephen) to take=
 a look
> > > > > and give me either an Ack, to say it's the best solution, or =
to
> > > > > provide a better alternative.
> > > > >=20
> > > > > Until that happens, I'm stuck!
> > > >=20
> > > > Well, what if we had no one at hand to review that code?  Would=
 that mean it
> > > > would not be applicable forever?
> > >=20
> > > No, but that's not the case is it?
> > >=20
> > > I don't understand why Mike and Stephen aren't helping!
> >=20
> > I'll wait until tomorrow and if we haven't heard anything I'll make=
 a
> > decision.
>=20
> OK, thanks!
>=20
> BTW, I don't have the time to review every single patch using ACPI
> or one of the PM frameworks.  If people who use them make mistakes,
> it is their burden to fix those mistakes when they show up in testing=
=2E
>=20
> What's happening here is that Andy and Mika are taking the responsibi=
lity
> for fixing the new code if it turns out to be buggy and so it's their
> problem if it happens to be broken.
>=20
> And you can still revert commits that introduce bugs as a last resort=
=2E

I'm fine with that in principle.  My issue here was that it looks
wrong to me.  I just don't know enough about the inner workings of the
CCF to be able to say that for sure, or to provide a suitable
alternative.  I think, probably the correct thing to do is to have an
accompanying clock driver, but who knows (I guess Stephen and Mike to,
but are seemingly unwilling to help).

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
