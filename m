From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Fri, 14 Nov 2014 09:17:40 +0100
Message-ID: <CAMuHMdWR=o+JAN=ogbqeUR+8Ye=VG+Dri+D0Nmhd5mruYEzUtA@mail.gmail.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
	<3267963.fqUYb7m9Rv@vostro.rjw.lan>
	<7hsihx1bvo.fsf@deeprootsystems.com>
	<6900237.LSPrkZ5QMk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:43978 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbaKNIRl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 03:17:41 -0500
In-Reply-To: <6900237.LSPrkZ5QMk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Ji

Hi Rafael,

On Thu, Nov 6, 2014 at 1:54 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, November 05, 2014 03:11:23 PM Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> > On Wednesday, November 05, 2014 02:43:31 PM Kevin Hilman wrote:
>> >> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>> >> > On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
>> >> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >> >> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
>> >> >> >> Convert the prototype to return and int. This is just an initial step,
>> >> >> >> needed to support error handling.
>> >> >> >>
>> >> >> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> >>
>> >> >> Acked-by: Kevin Hilman <khilman@linaro.org>
>> >> >>
>> >> >> >> This patch is intended as fix for 3.18 rc[n]. Why?
>> >> >> >>
>> >> >> >> There are other SOC specific patches around that adds genpd support and which
>> >> >> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
>> >> >> >> during the next release cycle, let's change the prototype now instead.
>> >> >> >>
>> >> >> >> Further patches will add the actual error handling in genpd and these can then
>> >> >> >> be reviewed and tested thoroughly.
>> >> >> >
>> >> >> > So we have no users of ->attach_dev at the moment, right?
>> >> >>
>> >> >> Not in mainline, but there are a couple getting ready to hit -next, so
>> >> >> we wanted to fix this before they arrive so that adding the error
>> >> >> handling will be easier.
>> >> >
>> >> > BTW, while we are at it, can we also pass the domain itself to
>> >> > attach_dev() and detach_dev()? If anything it helps with debugging (you
>> >> > can print domain name from the callbacks).
>> >>
>> >> Agreed, and it makes it match the other callbacks (power_off, power_on)
>> >> which currently take struct generic_pm_domain *domain.
>> >>
>> >> Updated version of $SUBJECT patch below.
>> >
>> > The subject and changelog need to be updated too IMO.
>> >
>>
>> Right.  Here you go.
>
> I've replaced the Ulf's original with this one, thanks!

When do you plan to send a pull request for this to Linus?

There are PM domain drivers blocked on entering -next due to this
dependency. As they have to pass through arm-soc first, and the arm-soc
merge window will close soon, time is running out.

Alternatively, you could provide an immutable branch containing this fix
to unblock dependents.

Thanks for your understanding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
