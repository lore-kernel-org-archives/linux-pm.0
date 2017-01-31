From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Correct comment in irq_safe_dev_in_no_sleep_domain()
Date: Tue, 31 Jan 2017 17:17:37 +0100
Message-ID: <CAMuHMdXRvOTKCdvwy5JZM6RhSifse_goHubZq4FaMcOFE7x99g@mail.gmail.com>
References: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34448 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdAaQYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 11:24:13 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so19531707itb.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 08:24:13 -0800 (PST)
In-Reply-To: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>

Hi Ulf,

On Tue, Jan 31, 2017 at 5:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The earlier comment stated that the dev_warn_once() was going to be printed
> once per device. Let's fix that, as dev_warn_once() is printed only once,
> no matter of the device.

While I agree this makes the comment match the code, I think we would serve
the users better by printing the warning once per PM domain.
Currently the user cannot know if two or more PM domains cannot be powered
off due to IRQ safe devices.

Perhaps a flag can be added to generic_pm_domain.flags to remember
that the warning has been printed before?

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6b23d82..271e208 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -130,7 +130,7 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>
>         ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
>
> -       /* Warn once for each IRQ safe dev in no sleep domain */
> +       /* Warn once if IRQ safe dev in no sleep domain */
>         if (ret)
>                 dev_warn_once(dev, "PM domain %s will not be powered off\n",
>                                 genpd->name);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
