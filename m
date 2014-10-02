From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Rename cpu_data to cpuidle_data
Date: Thu, 2 Oct 2014 21:17:58 +0200
Message-ID: <CAMuHMdWSJ4URPS+c0yfGJ4_DXh1ZgWqycuawfrsaEERLm9UASg@mail.gmail.com>
References: <1412277154-5853-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:50857 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbaJBTSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 15:18:00 -0400
Received: by mail-la0-f51.google.com with SMTP id ge10so3021129lab.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2014 12:17:59 -0700 (PDT)
In-Reply-To: <1412277154-5853-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Oct 2, 2014 at 9:12 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The "cpu_data" are defined for some archs and thus conflicting with the
> "cpu_data" member in the struct gpd_cpu_data. This causes a compiler
> error for those archs.
>
> Let's fix it by rename the member to cpuidle_data. In this context it
> also seems appropriate to rename the struct to gpd_cpuidle_data to
> better reflect its use.

Thanks!

> Fixes: f48c767ce895 (PM / Domains: Move dev_pm_domain_attach|detach() to pm_domain.h)
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
