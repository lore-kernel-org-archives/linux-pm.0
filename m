From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Mon, 10 Nov 2014 16:18:50 +0100
Message-ID: <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
	<7hr3xerdw6.fsf@deeprootsystems.com>
	<20141107215751.GA4439@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141107215751.GA4439@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

[...]

> I guess we do need it for 3.18, but when we are talking about 3.19,
> before we make any more changes can we outline how power domains are
> supposed to work?
>
> 1. How do we attach a device to power domain? Right now it seems that
> individual buses are responsible for attaching their devices to power
> domains. Should we move it into driver core (device_pm_add?) so that
> device starts its life in its proper power domain?

That was the initial approach.

To my understanding, Rafael's primary reason for not accepting that
was that it's not common, but it's platform-specific.
http://marc.info/?l=linux-pm&m=140243462304669&w=2

Now, even if we would reconsider doing as you propose, what would the
actual benefit be? Obviously, we would get less amount of code to
maintain, which is one reason, but are there more?

>
> 2. When do we power up the devices (and the domains)? Right now devices
> in ACPI power domain are powered when they are attached to the power
> domain (which coincides with probing), but generic power domains do not
> do that. Can we add a separate API to explicitly power up the device (and
> its domain if it is powered down) and do it again, either in device core
> or in individual buses. This way, regardless of runtime PM or not, we
> will have devices powered on when driver tries to bind to them. If
> binding fails we can power down the device.

Isn't that exactly what I implemented in [1], what am I missing?

>
> I've heard there is a concern about power domain bouncing up and down
> during probing. Is it really a concern? Would not we run into the same
> issues past booting up with aggressive PM policy? Anyway, we could
> probably work around this by refusing to actually power down the domains
> until we are done booting, similarly to who genpd_poweroff_unused works.

I haven't heard about this kind of issues, but I think your approach
seems reasonable.

Currently, I think we should focus on solving the problem in [1].
Those drivers/subsystems that use pm_runtime_set_active() during
->probe() are broken in this regards.

Now, if we move the attachment of devices to their PM domains from
buses into driver core, that could simplify [1]. Still, only if we
also decide to power on PM domains from driver core, else it wouldn't
matter much I think.


[1]
[PATCH v3 0/9] PM / Domains: Fix race conditions during boot
http://marc.info/?t=141320907000003&r=1&w=2

Kind regards
Uffe
