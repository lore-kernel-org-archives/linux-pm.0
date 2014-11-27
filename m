From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers:cpufreq: Change policy->cpuinfo.transition_latency
 to correct value
Date: Thu, 27 Nov 2014 09:27:12 +0530
Message-ID: <CAKohpokKJB9wHNQLpBNnmupLp-oLCgn2XgL_u__S-Bszy5vNKw@mail.gmail.com>
References: <1417038987-3164-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35242 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbaK0D5N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 22:57:13 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so2868747oia.26
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 19:57:12 -0800 (PST)
In-Reply-To: <1417038987-3164-1-git-send-email-xerofoify@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 27 November 2014 at 03:26, Nicholas Krause <xerofoify@gmail.com> wrote:
> Changes policy->cpuinfo.transition_latency for 1000 to 1000000 nanoseconds
> as we are assuming the latency is 1 millisecond.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 2 +-
>  drivers/cpufreq/pxa3xx-cpufreq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> index e24269a..2b894aa 100644
> --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> @@ -372,7 +372,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
>         init_sdram_rows();
>
>         /* set default policy and cpuinfo */
> -       policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
> +       policy->cpuinfo.transition_latency = 1000000;

> -       policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
> +       policy->cpuinfo.transition_latency = 1000000;

I believe the FIXMEs are still valid and shouldn't be removed. As we are still
running under the assumption here instead of finding out how much is the
latency.
