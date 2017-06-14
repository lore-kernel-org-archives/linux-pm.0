From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Wed, 14 Jun 2017 10:01:49 +0200
Message-ID: <CAMuHMdVa3eNF8ewB+iAw1AqUBGZU8mgg3y7H-kx_7hrx0W3BCw@mail.gmail.com>
References: <1497385659-2356-1-git-send-email-thara.gopinath@linaro.org> <1497385659-2356-3-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35399 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdFNIBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 04:01:51 -0400
Received: by mail-io0-f195.google.com with SMTP id f79so15363241ioi.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2017 01:01:50 -0700 (PDT)
In-Reply-To: <1497385659-2356-3-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Thara,

On Tue, Jun 13, 2017 at 10:27 PM, Thara Gopinath
<thara.gopinath@linaro.org> wrote:
> This patch extends the existing generic power domain debugfs.
> Changes involve the following
> - Introduce a unique debugfs entry for each generic power domain with the
>   following attributes
>         - current_state - Displays current state of the domain.
>         - devices - Displays the devices associated with this domain.
>         - sub_domains - Displays the sub power domains.
>         - active_time - Displays the time the domain was in active state
>                         in ms.
>         - total_idle_time - Displays the time the domain was in any of the idle
>                         states in ms.
>         - idle_states - Displays the various idle states and the time
>                         spent in each idle state in ms.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Thanks for your patch!

> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2322,21 +2322,189 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
>         return ret;
>  }
>
> -static int pm_genpd_summary_open(struct inode *inode, struct file *file)
> +static int pm_genpd_status_show(struct seq_file *s, void *data)
>  {
> -       return single_open(file, pm_genpd_summary_show, NULL);
> +       static const char * const status_lookup[] = {
> +               [GPD_STATE_ACTIVE] = "on",
> +               [GPD_STATE_POWER_OFF] = "off"
> +       };
> +
> +       struct generic_pm_domain *genpd = s->private;
> +       int ret = 0;
> +
> +       ret = genpd_lock_interruptible(genpd);
> +       if (ret)
> +               return -ERESTARTSYS;
> +
> +       if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))

WARN_ON_ONCE()?
If this ever triggers, it can be retriggered at will from userspace,
flooding the logs.

> +static int pm_genpd_idle_states_show(struct seq_file *s, void *data)
> +{
> +       struct generic_pm_domain *genpd = s->private;
> +       int i, ret = 0;

unsigned int i;

> +
> +       ret = genpd_lock_interruptible(genpd);
> +       if (ret)
> +               return -ERESTARTSYS;
> +
> +       seq_puts(s, "State          Time Spent(ms)\n");
> +
> +       for (i = 0; i < genpd->state_count; i++) {
> +               ktime_t delta = 0;
> +               s64 msecs;
> +
> +               if ((genpd->status == GPD_STATE_POWER_OFF) &&
> +                               (genpd->state_idx == i))
> +                       delta = ktime_sub(ktime_get(), genpd->accounting_time);
> +
> +               msecs = ktime_to_ms(
> +                       ktime_add(genpd->states[i].idle_time, delta));

The above two lines still fit on a single line, right?

> +static int pm_genpd_total_idle_time_show(struct seq_file *s, void *data)
> +{
> +       struct generic_pm_domain *genpd = s->private;
> +       ktime_t delta = 0, total = 0;
> +       int i, ret = 0;

unsigned int i;


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
