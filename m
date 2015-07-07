From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Tue, 7 Jul 2015 07:51:17 +0100
Message-ID: <20150707065117.GE3182@x1>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VdGyfyfYV6q9vdqK5nYBMpPWFxr32eiXXn2ruUj4pg6BA@mail.gmail.com>
 <20150706160529.GC3182@x1>
 <3134535.L6At3I31FS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3134535.L6At3I31FS@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Tue, 07 Jul 2015, Rafael J. Wysocki wrote:
> On Monday, July 06, 2015 05:05:29 PM Lee Jones wrote:
> > On Mon, 06 Jul 2015, Andy Shevchenko wrote:
> >=20
> > > On Mon, Jul 6, 2015 at 5:50 PM, Lee Jones <lee.jones@linaro.org> =
wrote:
> > > > On Mon, 06 Jul 2015, Andy Shevchenko wrote:
> > > >
> > > >> On Mon, 2015-07-06 at 11:24 +0200, Geert Uytterhoeven wrote:
> > > >> > On Mon, Jul 6, 2015 at 11:10 AM, Andy Shevchenko
> > > >> > <andriy.shevchenko@linux.intel.com> wrote:
> > > >> > > On Wed, 2015-06-24 at 12:31 +0100, Lee Jones wrote:
> > > >> > > > On Mon, 15 Jun 2015, Andy Shevchenko wrote:
> > >=20
> > > []
> > >=20
> > > >> > > > Applied, thanks.
> > > >> > >
> > > >> > > Hmm=E2=80=A6 Seems kinda mistake. I can't see this applied=
 (and required
> > > >> > > previous patches 4 and 5) to any of your branch neither in
> > > >> > > (today's)
> > > >> > > linux-next.
> > > >> >
> > > >> > New stuff applied after v4.1 couldn't show up in -next befor=
e v4.2
> > > >> > -rc1 was
> > > >> > released (which just happened last night)?
> > > >>
> > > >> Might be, I would like to resend new version of my series and =
that's
> > > >> why I would like to have a branch to check what is already app=
lied. So,
> > > >> if I can't see it does it mean it is brewed in the private rep=
ository?
> > > >
> > > > If you have patches that depend on this, they either need to co=
me
> > > > through my tree, or you have to wait until the next kernel vers=
ion
> > > > (which you probably don't want, right?).
> > > >
> > > > The alternative is that I unapply this patch and the whole lot =
can be
> > > > sucked up by the most appropriate subsystem.
> > >=20
> > > I resent a new version for other comments(still with all patches
> > > included). Meanwhile the patches 4-6 (from v4 or v5, where they a=
re
> > > the same) could be applied in the first place. Can you clarify wh=
at
> > > exactly you have applied? The idea is to put the rest via your
> > > subsystem since it's most appropriate for this series.
> >=20
> > Easiest thing for me to do is unapply.
> >=20
> > We can take the whole series when all the Acks have been accrued.
>=20
> So are there any ACKs missing from the last series posted by Andy?

Yes, I have requested a Clk Ack, as there are some, lets say
interesting code in the MFD driver which I am unsure about.  However,
we have caught Mike at an awkward time, as he is in the middle of
transitioning jobs.

Perhaps Stephen Boyd (now Cc'ed) might have a look.

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
