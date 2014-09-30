From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/4] ARM: exynos: Ensure PM domains are powered at initialization
Date: Tue, 30 Sep 2014 11:33:18 -0700
Message-ID: <7hiok5x8k1.fsf@deeprootsystems.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40798 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaI3SdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 14:33:20 -0400
In-Reply-To: <1412081033-8136-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 30 Sep 2014 14:43:51 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> At ->probe() it's common practice for drivers/subsystems to bring their
> devices to full power and without depending on CONFIG_PM_RUNTIME.
>
> We could also expect that drivers/subsystems requires their device's
> corresponding PM domains to be powered, to successfully complete a
> ->probe() sequence.
>
> Align to the behavior above, by ensuring all PM domains are powered
> prior initialization of a generic PM domain.
>
> Do note, since the generic PM domain will try to power off unused PM
> domains at late_init, there are no increased power consumption over
> time.

IMO "no increased power consumption" is a bit misleading because
boot-time power consumption may have a major increase when all power
domains are powered on.  Sure, they will eventually (hopefully) be
turned off in after late_initcall, but there will still be an impact.

I guess the Samsung folks should comment here on whether that is
significant.

Kevin
