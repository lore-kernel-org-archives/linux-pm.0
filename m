From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 01/11] PM / Domains: Add a detach callback to the
 struct dev_pm_domain
Date: Mon, 22 Sep 2014 13:15:21 +0200
Message-ID: <CAMuHMdX7twqW5A1LS-RqoZHRmqZdLVCaACr45GrtyA843iVA_Q@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61256 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaIVLPX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Sep 2014 07:15:23 -0400
In-Reply-To: <1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.>

On Fri, Sep 19, 2014 at 8:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -619,6 +619,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
>   */
>  struct dev_pm_domain {
>         struct dev_pm_ops       ops;
> +       void (*detach)(struct device *, bool);

I think it would help to add the parameter names, especially for
the "bool" parameter:

void (*detach)(struct device *dev, bool power_off);

>  };
>
>  /*

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
