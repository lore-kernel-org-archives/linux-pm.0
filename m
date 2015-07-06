From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in
 reverse order
Date: Mon, 06 Jul 2015 12:30:18 +0300
Message-ID: <1436175018.8279.4.camel@linux.intel.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150624113144.GL15013@x1> <1436173803.8279.1.camel@linux.intel.com>
	 <CAMuHMdUhuC-8vfXKNLmONexnQeokX4xFLNR=MVXFOSWE1O3Hsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUhuC-8vfXKNLmONexnQeokX4xFLNR=MVXFOSWE1O3Hsg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-07-06 at 11:24 +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 6, 2015 at 11:10 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, 2015-06-24 at 12:31 +0100, Lee Jones wrote:
> > > On Mon, 15 Jun 2015, Andy Shevchenko wrote:
> > >=20
> > > > The newly introduced device_for_each_child_reverse() would be=20
> > > > used
> > > > when MFD
> > > > core removes the device.
> > > >=20
> > > > After this patch applied the devices will be removed in a=20
> > > > reversed
> > > > order. This
> > > > behaviour is useful when devices have implicit dependency on=20
> > > > order,
> > > > i.e.
> > > > consider MFD device with serial bus controller, such as SPI,=20
> > > > and
> > > > DMA IP that is
> > > > attached to serial bus controller: before remove the DMA driver=
=20
> > > > we
> > > > have to be
> > > > ensured that no DMA transfers is ongoing and the requested=20
> > > > channel
> > > > are unused.
> > > >=20
> > > > Signed-off-by: Andy Shevchenko <
> > > > andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  drivers/mfd/mfd-core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > Applied, thanks.
> >=20
> > Hmm=E2=80=A6 Seems kinda mistake. I can't see this applied (and req=
uired
> > previous patches 4 and 5) to any of your branch neither in=20
> > (today's)
> > linux-next.
>=20
> New stuff applied after v4.1 couldn't show up in -next before v4.2
> -rc1 was
> released (which just happened last night)?

Might be, I would like to resend new version of my series and that's
why I would like to have a branch to check what is already applied. So,
if I can't see it does it mean it is brewed in the private repository?

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
