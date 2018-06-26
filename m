From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Tue, 26 Jun 2018 12:06:16 +0200
Message-ID: <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan> <20180620103558.GA6242@sirena.org.uk>
 <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com> <20180620132507.GE6242@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620132507.GE6242@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
>
> > > The flip side of that is that either suspend and resume or poweroff are
> > > broken for userspace unless they know about this magic sysfs file which
> > > isn't great either.
>
> > But to me that isn't that much different from an RTC wake alarm, say.
>
> > Enabling it to wake up the system in general isn't sufficient, you
> > also need to actually set the alarm using a different interface.

The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
It is also more natural for the user, who expects to need to find some way to
configure the wake-up time.

> It seems more like hardware breakage we're trying to fix than a feature
> - it's not like it's adding something we didn't have already (like
> setting a time in an alarm where the alarm is an additional thing), more
> just trying to execute on an existing user interface successfully.  I
> can see that there's a case that it doesn't map very well onto the
> standard interfaces so perhaps we have to add something on the side as
> the hardware is just too horrible to fit in with the standard interfaces
> and we have to do that.

My main worry is usability: with a separate sysfs file, we need to document the
file, and the user needs to be aware of it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
