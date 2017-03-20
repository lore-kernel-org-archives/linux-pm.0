From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] PM / Domains: Don't warn about IRQ safe device for an
 always on PM domain
Date: Mon, 20 Mar 2017 12:59:32 +0100
Message-ID: <CAMuHMdVWO7H8o81Do0Y6KybQN-bXyeOMoy32h2XhNiLDsRjdEw@mail.gmail.com>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org> <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36319 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbdCTL7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:59:34 -0400
Received: by mail-it0-f66.google.com with SMTP id 190so6062015itm.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:59:33 -0700 (PDT)
In-Reply-To: <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Mar 20, 2017 at 11:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When an IRQ safe device is attached to a no sleep domain, genpd prints a
> warning once, as to indicate it is a suboptimal configuration from power
> consumption point of view.
>
> However the warning doesn't make sense for an always on domain, since it
> anyway remains powered on. Therefore, let's change to not print the warning
> for this configuration.
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
