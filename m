From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [patch] thermal: cpu_cooling: small memory leak on error
Date: Wed, 17 Dec 2014 10:56:29 +0530
Message-ID: <CAOh2x=kRssziL3yu=Fm-N3m0PV3gAMg1_D=9KLem54pr=VbxqA@mail.gmail.com>
References: <20141216235553.GG31467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:46267 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaLQF0b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 00:26:31 -0500
In-Reply-To: <20141216235553.GG31467@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Wed, Dec 17, 2014 at 5:25 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> There was a left over return here so the error handling isn't run.
> It leads to a small memory leak and a static checker warning.
>
>         drivers/thermal/cpu_cooling.c:351 __cpufreq_cooling_register()
>         info: ignoring unreachable code.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Fixes: f6859014c7e7 ("thermal: cpu_cooling: Store frequencies in
descending order")

>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 051eb48..9b45f64 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -347,7 +347,6 @@ __cpufreq_cooling_register(struct device_node *np,
>         cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
>                                           cpufreq_dev->max_level, GFP_KERNEL);
>         if (!cpufreq_dev->freq_table) {
> -               return ERR_PTR(-ENOMEM);
>                 cool_dev = ERR_PTR(-ENOMEM);
>                 goto free_cdev;
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
