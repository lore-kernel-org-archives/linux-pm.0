From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] PM / Domains: Respect errors from genpd's
 ->power_off() callback
Date: Mon, 20 Mar 2017 12:58:41 +0100
Message-ID: <CAMuHMdWTc3w36MdBtgrDAqNBK8xhQvSTEhe_4x=WiGML0y7fhA@mail.gmail.com>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org> <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34018 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdCTL6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:58:44 -0400
Received: by mail-it0-f68.google.com with SMTP id z70so1907340itb.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:58:43 -0700 (PDT)
In-Reply-To: <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Mar 20, 2017 at 11:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The current code in genpd_sync_power_off(), doesn't care about potential
> errors being returned from genpd's ->power_off() callback.
>
> Obviously this behaviour could lead to problems, such as incorrectly
> setting the genpd's status to GPD_STATE_POWER_OFF, but also to incorrectly
> decrease the subdomain count for the masters, which potentially allows them
> to be powered off in the next recursive call to genpd_sync_power_off().
>
> Let's fix this behaviour by bailing out when the ->power_off() callback
> returns an error code.
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
