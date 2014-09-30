From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Tue, 30 Sep 2014 15:24:29 +0200
Message-ID: <CAMuHMdVzt2QoAk4ge7UyaA=F_iOf_7BQ8ycw15OAo4Twidd9ow@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:62603 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaI3NYb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 09:24:31 -0400
Received: by mail-la0-f42.google.com with SMTP id mk6so3901197lab.29
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 06:24:29 -0700 (PDT)
In-Reply-To: <1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On Tue, Sep 30, 2014 at 2:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
> parameter, let's make it clear by removing this option.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
