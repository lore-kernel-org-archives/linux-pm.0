From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when
 genpd enabled
Date: Sat, 15 Nov 2014 13:32:01 +0100
Message-ID: <CAMuHMdVrpwg2pYxUhA5oRgd1g2DmLuSb2jR3ywz8hkjms7UBcw@mail.gmail.com>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
	<1415917702-6742-2-git-send-email-khilman@kernel.org>
	<CAMuHMdXB-7vBqGZ_iMaZdDWDnnzpHZa4ECkDnojbDw=ds5eTWg@mail.gmail.com>
	<7ha93t8z1q.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:39204 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbaKOMcD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Nov 2014 07:32:03 -0500
In-Reply-To: <7ha93t8z1q.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>

Hi Kevin,

On Fri, Nov 14, 2014 at 6:36 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Thu, Nov 13, 2014 at 11:28 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> It makes little sense to use generic power domains without runtime PM.
>>
>> Does it?
>> It still powers down the PM domains on system suspend (at least on my
>> boards ;-)
>
> Sure, but your devices are also using runtime PM, so I'm not sure how
> does that change my statement above?

I do mean with CONFIG_PM_RUNTIME turned off.

If PM domain support is disabled, s2ram will not power down the PM domains.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
