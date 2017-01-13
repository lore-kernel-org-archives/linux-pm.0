From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RESEND PATCH 1/2] PM / Domains: Rename functions in genpd for power on/off
Date: Fri, 13 Jan 2017 11:53:58 -0800
Message-ID: <m260li68ix.fsf@baylibre.com>
References: <1484241463-28435-1-git-send-email-ulf.hansson@linaro.org>
        <1484241463-28435-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33784 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdAMTyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 14:54:00 -0500
Received: by mail-pf0-f171.google.com with SMTP id y143so35820348pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2017 11:54:00 -0800 (PST)
In-Reply-To: <1484241463-28435-2-git-send-email-ulf.hansson@linaro.org> (Ulf
        Hansson's message of "Thu, 12 Jan 2017 18:17:42 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Currently the mix of genpd_poweron(), genpd_power_on(),
> genpd_sync_poweron() and the ->power_on() callback, makes a bit difficult
> to follow the path of execution. The similar applies to the functions
> dealing with power off.
>
> In a way to improve this understanding, let's do the following renaming:
>
> genpd_power_on() ->  _genpd_power_on()
> genpd_poweron() -> genpd_power_on()
> genpd_sync_poweron() -> genpd_sync_power_on()
>
> genpd_power_off() -> _genpd_power_off()
> genpd_poweroff() -> genpd_power_off()
> genpd_sync_poweroff() -> genpd_sync_power_off()
> genpd_poweroff_unused() -> genpd_power_off_unused()
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>
