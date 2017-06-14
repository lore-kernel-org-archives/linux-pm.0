From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Wed, 14 Jun 2017 10:26:58 +0200
Message-ID: <CAMuHMdXNdgegJ40k8QZ-B09Q1uT=jt+W=gMDUfBVi=u690LKYw@mail.gmail.com>
References: <1497385659-2356-1-git-send-email-thara.gopinath@linaro.org> <1497385659-2356-3-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37737 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdFNI1B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 04:27:01 -0400
Received: by mail-it0-f51.google.com with SMTP id m47so51517897iti.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2017 01:27:00 -0700 (PDT)
In-Reply-To: <1497385659-2356-3-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Thara,

On Tue, Jun 13, 2017 at 10:27 PM, Thara Gopinath
<thara.gopinath@linaro.org> wrote:
> +static int pm_genpd_idle_states_show(struct seq_file *s, void *data)
> +{
> +       struct generic_pm_domain *genpd = s->private;
> +       int i, ret = 0;
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
> +               seq_printf(s, "S%-15i %lld\n", i, msecs);
> +       }

The ms values are misaligned by one space, compared to the table header:

    State          Time Spent(ms)
    S0               0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
