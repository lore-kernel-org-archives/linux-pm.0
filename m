From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Stop BUGing the system
Date: Thu, 18 Dec 2014 07:38:42 +0530
Message-ID: <CAKohponF61J6pWOtfg_722dQDbXtxrmt2dG+rKY7SKbE3xKGZg@mail.gmail.com>
References: <1418831495-26958-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:62814 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaLRCIn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 21:08:43 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so524708obc.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 18:08:42 -0800 (PST)
In-Reply-To: <1418831495-26958-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 17 December 2014 at 21:21, Nishanth Menon <nm@ti.com> wrote:
> CPUFRreq subsystem is not a system catastrophic failure point.
> Failures in these cases DONOT need complete system shutdown with BUG.
> just refuse to let cpufreq function should be good enough.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/cpufreq/cpufreq.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a09a29c..a5aa2fa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -281,7 +281,10 @@ static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
>  static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>                 struct cpufreq_freqs *freqs, unsigned int state)
>  {
> -       BUG_ON(irqs_disabled());
> +       if (irqs_disabled()) {
> +               WARN(1, "IRQs disabled!\n");
> +               return;
> +       }

What about:

> +               if (WARN(irqs_disabled(), "IRQs disabled!\n")
> +                       return;

Same for the last change as well..

>
>         if (cpufreq_disabled())
>                 return;
> @@ -1253,9 +1256,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>                         /*
>                          * Reaching here after boot in a few seconds may not
>                          * mean that system will remain stable at "unknown"
> -                        * frequency for longer duration. Hence, a BUG_ON().
> +                        * frequency for longer duration. Hence, a WARN().
>                          */
> -                       BUG_ON(ret);
> +                       if (ret) {
> +                               WARN(1, "SYSTEM operating at invalid freq %u", policy->cur);
> +                               goto err_out_unregister;
> +                       }

And I still don't agree for this one. We shouldn't keep on working on a
potentially unstable frequency.
