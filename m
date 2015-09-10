From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Remove name based API for genpd
Date: Thu, 10 Sep 2015 16:08:47 +0200
Message-ID: <CAMuHMdXmECGYOYKms9Dg8Bx6D2NAYk4uJiz-3GHWy21xK_gzJQ@mail.gmail.com>
References: <1441893650-19923-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35049 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbIJOIs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 10:08:48 -0400
Received: by obuk4 with SMTP id k4so35508859obu.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2015 07:08:47 -0700 (PDT)
In-Reply-To: <1441893650-19923-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Thu, Sep 10, 2015 at 4:00 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> As all users of the named based APIs now have converted to the non-named
> based APIs, the time has come to remove them.
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
