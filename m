From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC v2 03/16] PM / Domains: Support IRQ safe PM domains
Date: Mon, 29 Jun 2015 15:10:52 +0200
Message-ID: <CAMuHMdUQy7b2UWJVe6oc2r3EpiAur3BChOYWeGY61NYUJNPFow@mail.gmail.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
	<1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33346 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbbF2NKw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 09:10:52 -0400
Received: by oiyy130 with SMTP id y130so117341000oiy.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2015 06:10:52 -0700 (PDT)
In-Reply-To: <1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, agross@codeaurora.org

Sorry, I forgot a few comments...

On Sat, Jun 27, 2015 at 5:02 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt

> +context, may contain IRQ safe devices. Such domain may only contain only IRQ

Double "only".

> +safe devices or IRQ safe sub-domains.

> @@ -532,15 +608,18 @@ static int pm_genpd_runtime_resume(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /* If power.irq_safe, the PM domain is never powered off. */
> -       if (dev->power.irq_safe) {
> +       /*
> +        * As we dont power off a non IRQ safe domain, which holds a

Bogus "a" at the end.

> +        * an IRQ safe device, we dont need to restore power to it.
> +        */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
