From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] PM / Domains: Fix race conditions during boot
Date: Tue, 30 Sep 2014 22:08:46 +0200
Message-ID: <6902885.zdj1puMRg5@vostro.rjw.lan>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65362 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750939AbaI3Tsu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 15:48:50 -0400
In-Reply-To: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On Tuesday, September 30, 2014 02:43:49 PM Ulf Hansson wrote:
> When there are more than one device in a PM domain these will obviously
> be probed at different times. Depending on timing and the implemented
> support for runtime PM in a driver/subsystem, genpd may be advised to
> power off a PM domain after a successful probe sequence.
>     
> Ideally we should have relied on the driver/subsystem, through runtime
> PM, to bring their device's PM domain into powered state prior doing
> probing if such requirement exist.
>     
> Since this is not a common practice by drivers/subsystems, enforcing
> such a change doesn't seem viable.
>     
> Instead, let's improve the situation, by preventing genpd from powering
> off any of the PM domains until late_init. At that point genpd already
> tries to power off unused PM domains, so it seems like a decent match.
>     
> Cases which can't be covered within the window of until late_init needs
> to be adressed separately and likely through a more common long term
> solution.

The history here is that we started with something like what the patches
do and then realized that on some systems we don't want certain power domains
to be powered on even for a while (for reasons I can't recall today,
unfortunately).  So this may not be the case any more, but I'm not actually
sure and it would be good to check.

Also I'm pretty sure we'd like to do the opposite (that is, leave things
in low-power states until we need to access them) going forward, so I'm
seeing this as a step back.

What's the real motivation here?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
