From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Mon, 22 Jun 2015 09:30:20 +0200
Message-ID: <CAMuHMdVoHM=K-hgide0-2gpuAZgTkEqLAzhCGuGLHtEMtpAgyw@mail.gmail.com>
References: <1434622954-26747-1-git-send-email-geert+renesas@glider.be>
	<1434622954-26747-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34644 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbFVHaV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 03:30:21 -0400
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 18, 2015 at 12:22 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
> up with an infinite loop in genpd_dev_pm_{at,de}tach().
>
> This may happen due to a genpd.prepared_count imbalance.  This is a bug
> elsewhere, but it will result in a system lock up, possibly during
> reboot of an otherwise functioning system.
>
> To avoid this, put a limit on the maximum number of loop iterations,
> including a simple back-off mechanism.  If the limit is reached, the
> operation will just fail.  An error message is already printed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cdd547bd67df8218..aa06f60b98b8af35 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c

> @@ -2218,10 +2226,13 @@ int genpd_dev_pm_attach(struct device *dev)
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>
> -       while (1) {
> +       for (i = 0; i < GENPD_RETRIES; i++) {

Sorry, there's a declaration of "i" missing.

>                 ret = pm_genpd_add_device(pd, dev);
>                 if (ret != -EAGAIN)
>                         break;
> +
> +               if (i > GENPD_RETRIES / 2)
> +                       udelay(GENPD_DELAY_US);
>                 cond_resched();
>         }
>
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
