From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Remove legacy API for adding devices
 through DT
Date: Thu, 25 Sep 2014 18:35:23 +0200
Message-ID: <CAMuHMdWQ7dqGAh0Ls=tuV-Qr-wVWY4w0_CNLaRjz04eDyF20qg@mail.gmail.com>
References: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:58780 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaIYQfZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 12:35:25 -0400
Received: by mail-la0-f49.google.com with SMTP id pn19so12672084lab.8
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2014 09:35:23 -0700 (PDT)
In-Reply-To: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>

On Thu, Sep 25, 2014 at 5:49 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> There are no active clients of the legacy API and we now also have a
> better way to handle genpd DT support. So let's remove the legacy API.
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
