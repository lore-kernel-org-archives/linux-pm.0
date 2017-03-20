From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] PM / Domains: Clean up code validating genpd's status
Date: Mon, 20 Mar 2017 12:49:14 +0100
Message-ID: <CAMuHMdWPXja1b9c3EhqZX267BgQmVLUfu1E8Wdgb8nZ=E98r5g@mail.gmail.com>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org> <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34559 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753417AbdCTLt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:49:27 -0400
Received: by mail-it0-f68.google.com with SMTP id z70so1856512itb.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:49:21 -0700 (PDT)
In-Reply-To: <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Mar 20, 2017 at 11:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> There exists several similar validations of the genpd->status, against
> GPD_STATE_ACTIVE and GPD_STATE_POWER_OFF. Let's clean up this code by
> converting to use a helper macro, genpd_status_on().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
