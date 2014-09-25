From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Thu, 25 Sep 2014 15:45:11 -0700
Message-ID: <7hppej8glk.fsf@deeprootsystems.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140925112122.GA22753@ulmo>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46250 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbaIYWpN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Sep 2014 18:45:13 -0400
In-Reply-To: <20140925112122.GA22753@ulmo> (Thierry Reding's message of "Thu,
	25 Sep 2014 13:21:24 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>

Thierry Reding <thierry.reding@gmail.com> writes:

> I just noticed these patches because they conflicted with some of the
> local patches I had to add a very similar framework. One of the reasons
> why I hadn't posted these publicly yet is because the platform where I
> want to use this (Tegra) is somewhat quirky when it comes to power
> domains.
>
> On Tegra these domains are called power gates and they currently have
> their own API. We've been looking at migrating things over to some
> generic framework for some time and PM domains do seem like a good fit.
> However one of the quirks regarding these domains on Tegra is that a
> fixed sequence exists that needs to be respected when enabling or
> disabling a power partition. The exact sequence can be found in the
> drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> function. Essentially we need to call into the clock and reset drivers
> at very specific moments during the operations that the PMC does.
>
> One solution to this would be to make the needed clocks and resets
> available to the power domain driver via DT, but then we have the
> problem that two drivers would be controlling the same resources. For
> example drivers could still want to disable the clock for more fine-
> grained power management. 

I think you're on the right path here.  You can get rid of this conflict
by removing the direct/manual clock management from the drivers, and
using runtime PM instead: s/clk_enable/pm_runtime_get_sync/,
s/clk_disable/pm_runtime_put_sync/.  When using runtime PM, those calls
trickle down through the power domain driver, which can manage the
device clocks, as well as any additional clocks and resets needed for
power gating.

> Furthermore for some devices it may turn out that turning the domain
> off and on introduces too much latency to be useful.

In these cases, you should use the per-device PM QoS framework to set
per-device latencies.  Then your power-domain can look up these
latencies and decide whether or not to actually power gate or not.

Kevin
