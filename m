From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Thu, 6 Nov 2014 08:36:20 +0100
Message-ID: <CAMuHMdWRXA6pXob=Hacosfic1jeLmo79T-YCKQ77aJbVisZm-Q@mail.gmail.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
	<20141105013353.GA19238@dtor-ws>
	<7h7fz92rqk.fsf@deeprootsystems.com>
	<3267963.fqUYb7m9Rv@vostro.rjw.lan>
	<7hsihx1bvo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:59523 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaKFHgW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 02:36:22 -0500
In-Reply-To: <7hsihx1bvo.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>

On Thu, Nov 6, 2014 at 12:11 AM, Kevin Hilman <khilman@kernel.org> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Thu, 30 Oct 2014 13:02:49 +0100
> Subject: [PATCH] PM / Domains: Change prototype for the attach and detach
>  callbacks
>
> Convert the prototypes to return an int in order to support error
> handling in these callbacks.
>
> Also, as suggested by Dmitry Torokhov, pass the domain pointer for use
> inside the callbacks, and so that they match the existing
> power_on/power_off callbacks which currently take the domain pointer.
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [khilman: added domain as parameter to callbacks, as suggested by Dmitry]

OK, so back to the signature of the original version...

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
