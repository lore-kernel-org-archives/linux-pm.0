From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: Only perform clocksource
 suspend/resume if enabled
Date: Thu, 18 Jun 2015 16:19:25 +0200
Message-ID: <CAMuHMdUiDVVY1YE1Pt3gsFfNrTRAHgLdQ_F8CXOKG5aKW1TeFQ@mail.gmail.com>
References: <1434622954-26747-1-git-send-email-geert+renesas@glider.be>
	<1434622954-26747-2-git-send-email-geert+renesas@glider.be>
	<1829815.c8lIHLtv9K@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34477 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbbFROT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 10:19:26 -0400
In-Reply-To: <1829815.c8lIHLtv9K@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Laurent,

On Thu, Jun 18, 2015 at 4:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 18 June 2015 12:22:33 Geert Uytterhoeven wrote:
>> Currently the sh_cmt clocksource timer is disabled or enabled
>> unconditionally on clocksource suspend resp. resume, even if a better
>> clocksource is present (e.g. arch_sys_counter) and the sh_cmt
>> clocksource is not enabled.

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Good catch. The patch looks good to me.

While the solution was simple, it was hard to catch (engineers and
lightbulbs... euh timers ;-)

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

> I've quickly checked the MTU2 and TMU timer drivers and they should be immune
> to the issue, but I'd appreciate if you could confirm that.

I had concluded the same, thanks for verifying!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
