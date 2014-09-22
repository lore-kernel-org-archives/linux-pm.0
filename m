From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 04/11] PM / Domains: Add APIs to attach/detach a PM
 domain for a device
Date: Mon, 22 Sep 2014 13:12:16 +0200
Message-ID: <CAMuHMdVAoM+z07Scni7iUDcqupJYuMqDDFPAccCA3vR0jqrbBA@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<1411151264-16245-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:55017 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVLMS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Sep 2014 07:12:18 -0400
In-Reply-To: <1411151264-16245-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.>

On Fri, Sep 19, 2014 at 8:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c

> @@ -82,3 +84,53 @@ int dev_pm_put_subsys_data(struct device *dev)
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
> +
> +/**
> + * dev_pm_domain_attach - Attach a device to its PM domain.
> + * @dev: Device to attach.
> + * @power_on: Used to indicate whether we should power on the device.
> + *
> + * The @dev may only be attached to a single PM domain. By iterating through
> + * the available alternatives we try to find a valid PM domain for the device.
> + * As attachement succeeds, the ->detach() callback in the struct dev_pm_domain

attachment

> + * should be assigned by the corresponding attach function.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
