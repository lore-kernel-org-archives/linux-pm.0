From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
Date: Tue, 10 Jun 2014 14:11:31 +0200
Message-ID: <CAJZ5v0hUT0QPGWeDM9WoxnobaL5eoNi5UFrUUZrQ1gSBCX=aVg@mail.gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
	<1402397497-26737-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34549 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaFJMLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 08:11:32 -0400
In-Reply-To: <1402397497-26737-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Tomasz Figa <t.figa@samsung.com>

On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Tomasz Figa <t.figa@samsung.com>
>
> On a number of platforms, devices are part of controllable power
> domains, which need to be enabled before such devices can be accessed
> and may be powered down when the device is idle to save some power.
> This means that on systems that support power domain control using
> generic power domains subsystem, it is necessary to add device to its
> power domain before binding a driver to it and remove it from its power
> domain after its driver is unbound to make sure that an unused device
> does not affect power domain state.
>
> Since this is not limited to particular busses and specific
> archs/platforms,

Actually, this isn't correrct.  It is limited to the platforms that
use Device Trees now.

Moreover, it is not consistent with the way we add devices to the ACPI PM
domain, which is the ACPI counterpart of this.

Rafael
