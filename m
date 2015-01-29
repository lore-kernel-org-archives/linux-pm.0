From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] PM: Convert dev_pm_put_subsys_data() into a void function
Date: Thu, 29 Jan 2015 18:46:00 +0100
Message-ID: <CAMuHMdWnW82Y1MhXS8rKGFsFAqKo4Qp-YPHLyhyX-Vs7fRqM=w@mail.gmail.com>
References: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
	<1422553145-14798-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34592 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbA2RqC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 12:46:02 -0500
Received: by mail-lb0-f174.google.com with SMTP id f15so30835139lbj.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2015 09:46:00 -0800 (PST)
In-Reply-To: <1422553145-14798-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, Jan 29, 2015 at 6:39 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Clients using the dev_pm_put_subsys_data() API isn't interested of a
> return value. They care only of decreasing a reference to the device's
> pm_subsys_data. So, let's convert the API to a void function, which
> anyway seems like reasonable thing to do.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
