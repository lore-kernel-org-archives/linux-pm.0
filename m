From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH V4 1/3] PM / Domains: Initial PM clock support for genpd
Date: Mon, 01 Dec 2014 17:09:45 -0800
Message-ID: <7h7fya502u.fsf@deeprootsystems.com>
References: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
	<1417434623-31301-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42585 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbaLBBJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 20:09:48 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so12105170pdj.9
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 17:09:47 -0800 (PST)
In-Reply-To: <1417434623-31301-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 1 Dec 2014 12:50:21 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Simon Horman <horms@verge.net.au>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> It's quite common for PM domains to use PM clocks. Typically from SOC
> specific code, the per device PM clock list is created and
> pm_clk_suspend|resume() are invoked to handle clock gating/ungating.
>
> A step towards consolidation is to integrate PM clock support into
> genpd, which is what this patch does.
>
> In this initial step, the calls to the pm_clk_suspend|resume() are
> handled within genpd, but the per device PM clock list still needs to
> be created from SOC specific code. It seems reasonable to have gendp to
> handle that as well, but that left to future patches to address.
>
> It's not every users of genpd that are keen on using PM clocks, thus we
> need to provide this a configuration option for genpd. Therefore let's
> add flag field in the genpd struct to keep this information and define
> a new GENDP_FLAG_PM_CLK bit for it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Kevin Hilman <khilman@linaro.org>

Are you also planning to add a way to enable this option from DT?

Kevin
