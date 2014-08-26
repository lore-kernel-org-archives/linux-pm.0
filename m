From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/9] PM / Domains: Add generic OF-based power domain
 look-up
Date: Tue, 26 Aug 2014 15:15:18 +0200
Message-ID: <1409058918.2911.55.camel@paszta.hi.pengutronix.de>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
	 <1409054837-5667-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbaHZNPj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Aug 2014 09:15:39 -0400
In-Reply-To: <1409054837-5667-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, linux-acpi@vger.kernel.org, Simon Horman <horms@verge.net.au>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>linux-a

Hi Ulf,

Am Dienstag, den 26.08.2014, 14:07 +0200 schrieb Ulf Hansson:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This patch introduces generic code to perform power domain look-up using
> device tree and automatically bind devices to their power domains.
> Generic device tree binding is introduced to specify power domains of
> devices in their device tree nodes.
> 
> Backwards compatibility with legacy Samsung-specific power domain
> bindings is provided, but for now the new code is not compiled when
> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
> will change as soon as Exynos power domain code gets converted to use
> the generic framework in further patch.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you for updating this series. I've tested patches 1-4
using the PU power domain on i.MX6.

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

