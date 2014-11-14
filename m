From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when
 genpd enabled
Date: Fri, 14 Nov 2014 08:29:06 +0100
Message-ID: <CAMuHMdXB-7vBqGZ_iMaZdDWDnnzpHZa4ECkDnojbDw=ds5eTWg@mail.gmail.com>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
	<1415917702-6742-2-git-send-email-khilman@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:64469 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbaKNH3I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 02:29:08 -0500
In-Reply-To: <1415917702-6742-2-git-send-email-khilman@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>

Hi Kevin,

On Thu, Nov 13, 2014 at 11:28 PM, Kevin Hilman <khilman@kernel.org> wrote:
> It makes little sense to use generic power domains without runtime PM.

Does it?
It still powers down the PM domains on system suspend (at least on my
boards ;-)

> Also, since the complexities of handling the !PM_RUNTIME case are
> causing more trouble and confusion than they're worth, let's simplify
> the world by making genpd always enable runtime PM.

What do other people think?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
