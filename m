From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix latency for cpufreq_info
Date: Mon, 14 Jul 2014 12:00:14 +0530
Message-ID: <CAKohpo=R4sjEGUFDt2yubfTQ+r1FO5RtFBYg8XROH-SYu90Zew@mail.gmail.com>
References: <1405319337-11368-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48405 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaGNGaP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 02:30:15 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so3557786obc.8
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2014 23:30:14 -0700 (PDT)
In-Reply-To: <1405319337-11368-1-git-send-email-xerofoify@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 14 July 2014 11:58, Nicholas Krause <xerofoify@gmail.com> wrote:
> This fixes the latency for the cpufreq policy to 1 million nanoseconds
> that calls the function pxa_cpu_init for the member of the structure
> called cpuinfo.transition_latency.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> index e24269a..e08bb98 100644
> --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> @@ -372,7 +372,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
>         init_sdram_rows();
>
>         /* set default policy and cpuinfo */
> -       policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
> +       policy->cpuinfo.transition_latency = 1000000;
>
>         /* Generate pxa25x the run cpufreq_frequency_table struct */
>         for (i = 0; i < NUM_PXA25x_RUN_FREQS; i++) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
