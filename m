From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Mon, 6 Jul 2015 17:05:29 +0100
Message-ID: <20150706160529.GC3182@x1>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150624113144.GL15013@x1>
 <1436173803.8279.1.camel@linux.intel.com>
 <CAMuHMdUhuC-8vfXKNLmONexnQeokX4xFLNR=MVXFOSWE1O3Hsg@mail.gmail.com>
 <1436175018.8279.4.camel@linux.intel.com>
 <20150706145039.GB3182@x1>
 <CAHp75VdGyfyfYV6q9vdqK5nYBMpPWFxr32eiXXn2ruUj4pg6BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38647 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbGFQFg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 12:05:36 -0400
Received: by wibdq8 with SMTP id dq8so158077910wib.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2015 09:05:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHp75VdGyfyfYV6q9vdqK5nYBMpPWFxr32eiXXn2ruUj4pg6BA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Mon, 06 Jul 2015, Andy Shevchenko wrote:

> On Mon, Jul 6, 2015 at 5:50 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> > On Mon, 06 Jul 2015, Andy Shevchenko wrote:
> >
> >> On Mon, 2015-07-06 at 11:24 +0200, Geert Uytterhoeven wrote:
> >> > On Mon, Jul 6, 2015 at 11:10 AM, Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> > > On Wed, 2015-06-24 at 12:31 +0100, Lee Jones wrote:
> >> > > > On Mon, 15 Jun 2015, Andy Shevchenko wrote:
>=20
> []
>=20
> >> > > > Applied, thanks.
> >> > >
> >> > > Hmm=E2=80=A6 Seems kinda mistake. I can't see this applied (an=
d required
> >> > > previous patches 4 and 5) to any of your branch neither in
> >> > > (today's)
> >> > > linux-next.
> >> >
> >> > New stuff applied after v4.1 couldn't show up in -next before v4=
=2E2
> >> > -rc1 was
> >> > released (which just happened last night)?
> >>
> >> Might be, I would like to resend new version of my series and that=
's
> >> why I would like to have a branch to check what is already applied=
=2E So,
> >> if I can't see it does it mean it is brewed in the private reposit=
ory?
> >
> > If you have patches that depend on this, they either need to come
> > through my tree, or you have to wait until the next kernel version
> > (which you probably don't want, right?).
> >
> > The alternative is that I unapply this patch and the whole lot can =
be
> > sucked up by the most appropriate subsystem.
>=20
> I resent a new version for other comments(still with all patches
> included). Meanwhile the patches 4-6 (from v4 or v5, where they are
> the same) could be applied in the first place. Can you clarify what
> exactly you have applied? The idea is to put the rest via your
> subsystem since it's most appropriate for this series.

Easiest thing for me to do is unapply.

We can take the whole series when all the Acks have been accrued.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
