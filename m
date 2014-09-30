From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Tue, 30 Sep 2014 11:30:43 -0700
Message-ID: <7hr3ytx8oc.fsf@deeprootsystems.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40698 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbaI3Sap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 14:30:45 -0400
In-Reply-To: <1412081033-8136-4-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 30 Sep 2014 14:43:52 +0200")
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
> Align the generic PM domain to the behavior above, by enforcing a PM
> domain to be powered at initialization. Since all callers of
> pm_genpd_init() already provides "false" as the value for the "is_off"
> parameter

This is only true after PATCH 2/4 is applied.

The exynos code currently checks the hw state of its power domains will
call pm_genpd_init() with is_off = true any hw domains that are off.

Kevin
