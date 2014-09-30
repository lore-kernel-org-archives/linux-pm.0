From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Tue, 30 Sep 2014 11:21:43 -0700
Message-ID: <7h61g5ynns.fsf@deeprootsystems.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40265 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbaI3SVp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 14:21:45 -0400
In-Reply-To: <1412081033-8136-4-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 30 Sep 2014 14:43:52 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> At ->probe() it's common practice for drivers/subsystems to bring their
> devices to full power and without depending on CONFIG_PM_RUNTIME.

If they're not using pm_runtime to bring the device to full power,
shouldn't these drivers be using pm_runtime_set_active()?  (or maybe
pm_runtime_force_resume()?)

Wouldn't using those force the genpd to stay powered on?

Kevin
