From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: s3c64xx: force regulator descriptor to NULL
 when disabled
Date: Mon, 5 Jan 2015 12:25:29 +0530
Message-ID: <CAKohpomzrWs_bRrLF=_NhxEUv2ZrngnT_+QETFXEdGaJURO8aw@mail.gmail.com>
References: <1420298974-3478-1-git-send-email-paolo.teti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55680 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbAEGz3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 01:55:29 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so59712343obc.10
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 22:55:29 -0800 (PST)
In-Reply-To: <1420298974-3478-1-git-send-email-paolo.teti@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paolo Teti <paolo.teti@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 3 January 2015 at 20:59, Paolo Teti <paolo.teti@gmail.com> wrote:
> Be sure 'vddarm' is NULL when regulator is disabled, otherwise few line
> later this test
>
> if (!vddarm && freq->frequency > clk_get_rate(policy->clk) / 1000)
>
> may be false braking assumption that if not regulator is available
> the maximum frequency We can support is the start-up frequency.
>
> Signed-off-by: Paolo Teti <paolo.teti@gmail.com>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> index 176e84c..8a9e082 100644
> --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> @@ -175,6 +175,8 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
>         } else {
>                 s3c64xx_cpufreq_config_regulator();
>         }
> +#else
> +       vddarm = NULL;
>  #endif

vddarm is a global variable in this file and so is by default initialized
to NULL. Why do you need to do this here as well ?
