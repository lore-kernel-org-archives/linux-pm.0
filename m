From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Mon, 27 Jul 2015 17:24:13 +0100
Message-ID: <20150727162413.GE21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150727152733.GB21114@x1>
 <20150727160447.GL1577@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150727160447.GL1577@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Mika Westerberg wrote:

> On Mon, Jul 27, 2015 at 04:27:33PM +0100, Lee Jones wrote:
> > FAO Stephen Boyd,
> >=20
> > > Stephen, can you, please, have a look into patch 8 regarding to c=
lock name
> > > matching and other stuff Lee asked?
> >=20
> > Patch 8:
> >=20
> >       "Can you review the clock implementation please?  It looks
> >       fragile to me as it relies heavily on device names constructe=
d
> >       of MFD cell names and IDA numbers cat'ed together!"
>=20
> Lee, can you suggest an alternative then?
>=20
> Why we are doing it like this is that number of different LPSS device=
s
> changes from SoC to SoC. In addition to that the device (called "slic=
e")
> might have iDMA block or not.
>=20
> Since the drivers in question (pxa2xx-spi, i2c-designware and 8250_dw=
)
> use standard clk framework to request their clocks the Linux device m=
ust
> have clock registered which matches the device in advance.
>=20
> Because we add the host controller device dynamically (from the MFD
> driver) based on how many devices are actually present, we need someh=
ow
> predict what would be the correct name and instance number for that
> device to get the clock for it. That's the reason we use IDA here alo=
ng
> with the cell name (or driver name).

I'm sure there are perfectly viable reasons for you doing this.  And I
don't know the CCF well enough to know whether it's the best idea or
not, or else I would have made a suggestion rather than waiting all
this time.

It's for this reason that I needed Mike (now Stephen) to take a look
and give me either an Ack, to say it's the best solution, or to
provide a better alternative.

Until that happens, I'm stuck!

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
