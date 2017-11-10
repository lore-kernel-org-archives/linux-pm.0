From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] PM / Domain: renesas: Fix active wakeup behavior
Date: Fri, 10 Nov 2017 10:57:50 +0100
Message-ID: <CAPDyKFrJ67POYoB1PQUjWEWxgzcGuBRUMKSs5NmjoyLOFLuk4A@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:56827 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdKJJ5v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2017 04:57:51 -0500
Received: by mail-it0-f41.google.com with SMTP id r127so1023259itb.5
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2017 01:57:51 -0800 (PST)
In-Reply-To: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 9 November 2017 at 14:26, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>         Hi Rafael, Ulf, Kevin,
>
> If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
> used as a wakeup source, it must be kept active during system suspend.

Geert, I think we discussed this a bit already. I wonder if the above
is a correct statement for all devices in these PM domains, that has
wakeups?

Don't these SoCs make use of any external logic (out-of-band IRQ) to
deal with the wakeup IRQs?

For example, how is GPIO irqs dealt with in this regards?

If that is the case, you should really avoid using the big hammer
method of setting the GENPD_FLAG_ACTIVE_WAKEUP.

>
> Currently this is handled in device-specific drivers by explicitly
> increasing the use count of the module clock when the device is
> configured as a wakeup source, or if it is part of the wakeup path.
>
> However, this is merely a workaround.  The proper way to prevent the
> device from being stopped is to inform this requirement to the genpd
> core, using the new GENPD_FLAG_ACTIVE_WAKEUP flag introduced in commit
> 95a20ef6f7e54c6a ("PM / Domains: Allow genpd users to specify default
> active wakeup behavior").
>
> Hence this series does that for PM Domain drivers used on R-Car, RZ/A1,
> RZ/G1 SoCs, mimicking what is already done succesfully on SH/R-Mobile
> SoCs.  This will allow for the workarounds can be removed later.
>

[...]

Kind regards
Uffe
