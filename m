From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Tue, 23 Jun 2015 09:16:21 +0200
Message-ID: <CAMuHMdVPs4M+4wvNHWCFKe0rxJfDPF-K+zCFgRm-MdRUY4D-Eg@mail.gmail.com>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
	<1434958282-27376-1-git-send-email-geert+renesas@glider.be>
	<5913118.ZpKlm0JFgd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34833 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbbFWHQV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:16:21 -0400
In-Reply-To: <5913118.ZpKlm0JFgd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rafael,

On Tue, Jun 23, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, June 22, 2015 09:31:22 AM Geert Uytterhoeven wrote:
>> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
>> up with an infinite loop in genpd_dev_pm_{at,de}tach().
>>
>> This may happen due to a genpd.prepared_count imbalance.  This is a bug
>> elsewhere, but it will result in a system lock up, possibly during
>> reboot of an otherwise functioning system.
>>
>> To avoid this, put a limit on the maximum number of loop iterations,
>> including a simple back-off mechanism.  If the limit is reached, the
>> operation will just fail.  An error message is already printed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This was too late for my first 4.2 pull request, but I may push it in the
> second half of the merge window.  Does it depend on anything?

Not that I'm aware of.

It applies fine on v4.1 or next-20150622.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
