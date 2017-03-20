From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] PM / Domains: Enable users of genpd to specify always
 on PM domains
Date: Mon, 20 Mar 2017 12:54:07 +0100
Message-ID: <CAMuHMdVrxfoyPK8A7WBcxbjdJUuyz=7Yb4wZn6denEU8R+ZMgg@mail.gmail.com>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org> <1490005163-28633-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38379 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbdCTLzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:55:07 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so29648806itc.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:54:09 -0700 (PDT)
In-Reply-To: <1490005163-28633-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, Mar 20, 2017 at 11:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The current way to implement an always on PM domain consists of returning
> -EBUSY from the ->power_off() callback. This is a bit different compared to
> using the always on genpd governor, which prevents the PM domain from being
> powered off via runtime suspend, but not via system suspend.
>
> The approach to return -EBUSY from the ->power_off() callback to support
> always on PM domains in genpd is suboptimal. That is because it requires
> genpd to follow the regular execution path of the power off sequence, which
> ends by invoking the ->power_off() callback.
>
> To enable genpd to early abort the power off sequence for always on PM
> domains, it needs static information about these configurations. Therefore
> let's add a new genpd configuration flag, GENPD_FLAG_ALWAYS_ON.
>
> Users of the new GENPD_FLAG_ALWAYS_ON flag, are by genpd required to make
> sure the PM domain is powered on before calling pm_genpd_init(). Moreover,
> users don't need to implement the ->power_off() callback, as genpd doesn't
> ever invoke it.
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
