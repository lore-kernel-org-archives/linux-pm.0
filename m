From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] [RFC] PM / Domains: Join state name and index in
 debugfs output
Date: Mon, 29 Feb 2016 13:04:32 +0100
Message-ID: <CAPDyKFpcXBcdvWL7q_Oazzc8xBP_qsrhuXcAzih8i2bzBCDVQg@mail.gmail.com>
References: <1456246158-19673-1-git-send-email-geert+renesas@glider.be>
	<1456246158-19673-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34966 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbcB2MEd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 07:04:33 -0500
Received: by mail-wm0-f41.google.com with SMTP id l68so59011000wml.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 04:04:32 -0800 (PST)
In-Reply-To: <1456246158-19673-2-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23 February 2016 at 17:49, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> For low-power states, the state index is part of the state, hence join
> them with a hyphen in the /sys/kernel/debug/pm_genpd/pm_genpd_summary
> output. E.g. "off 0" becomes "off-0".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Alternative separators could be ":" or "/".
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 01015d85ab6493fc..9e59543d314c4b0b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1892,7 +1892,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>         if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>                 goto exit;
>         if (genpd->status == GPD_STATE_POWER_OFF)
> -               snprintf(state, sizeof(state), "%s %u",
> +               snprintf(state, sizeof(state), "%s-%u",
>                          status_lookup[genpd->status], genpd->state_idx);
>         else
>                 snprintf(state, sizeof(state), "%s",
> --
> 1.9.1
>
