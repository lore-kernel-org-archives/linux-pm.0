From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 1/2] PM / Domains: Restore alignment of slaves in debugfs output
Date: Wed, 24 Feb 2016 10:31:12 +0100
Message-ID: <CAKXjFTPLi0+L-Q1gaRRWgkLRyi5ArgrsUtn_YoXDExAy8OaQQg@mail.gmail.com>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33724 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcBXJbN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2016 04:31:13 -0500
Received: by mail-oi0-f53.google.com with SMTP id j125so11251016oih.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2016 01:31:13 -0800 (PST)
In-Reply-To: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On Tue, Feb 23, 2016 at 5:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The slave domains are no longer aligned with the table header in the
> /sys/kernel/debug/pm_genpd/pm_genpd_summary output. Worse, the alignment
> differs depending on the actual name of the state.
>
> Format the state name and index into a buffer, and print that like
> before to restore alignment.
>
> Use "%u" for unsigned int while we're at it.
>
> Fixes: fc5cbf0c94b6f7fd ("PM / Domains: Support for multiple states")

Thanks for fixing this. My power domains had all equal size names and
i had not noticed the unaligned columns on the summary.

Regards
Axel

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e8ca290dbf9d5ea6..01015d85ab6493fc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1882,6 +1882,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>         struct pm_domain_data *pm_data;
>         const char *kobj_path;
>         struct gpd_link *link;
> +       char state[16];
>         int ret;
>
>         ret = mutex_lock_interruptible(&genpd->lock);
> @@ -1890,12 +1891,13 @@ static int pm_genpd_summary_one(struct seq_file *s,
>
>         if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>                 goto exit;
> -       seq_printf(s, "%-30s  %s", genpd->name, status_lookup[genpd->status]);
> -
>         if (genpd->status == GPD_STATE_POWER_OFF)
> -               seq_printf(s, " %-13d ", genpd->state_idx);
> +               snprintf(state, sizeof(state), "%s %u",
> +                        status_lookup[genpd->status], genpd->state_idx);
>         else
> -               seq_printf(s, " %-15s ", "");
> +               snprintf(state, sizeof(state), "%s",
> +                        status_lookup[genpd->status]);
> +       seq_printf(s, "%-30s  %-15s ", genpd->name, state);
>
>         /*
>          * Modifications on the list require holding locks on both
> --
> 1.9.1
>
