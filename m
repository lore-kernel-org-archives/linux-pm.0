From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Tue, 30 Sep 2014 15:21:34 +0200
Message-ID: <CAMuHMdVAtEZQPctS3PjoDZXKQFTDYxBcsMAKu15x=hfwf61rmg@mail.gmail.com>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
	<1412081033-8136-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44128 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaI3NVg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 09:21:36 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so3100528lbi.8
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 06:21:34 -0700 (PDT)
In-Reply-To: <1412081033-8136-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

On Tue, Sep 30, 2014 at 2:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> There are currently no users of this API, let's remove it.
>
> Additionally, if such feature would be needed future wise, a better
> option is likely use pm_runtime_set_active|suspended() in some form.
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
