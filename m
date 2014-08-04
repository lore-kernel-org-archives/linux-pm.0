From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpu0: Do not print error message when deferring
Date: Mon, 4 Aug 2014 19:04:44 +0530
Message-ID: <CAKohpomjjuq5P5UdEnNgZKR-BMzbkYvhrEgL1Mge8w63Lhb29g@mail.gmail.com>
References: <1407156483-15730-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33412 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbaHDNep (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 09:34:45 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so4345197obc.22
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2014 06:34:44 -0700 (PDT)
In-Reply-To: <1407156483-15730-1-git-send-email-mpa@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>

On 4 August 2014 18:18, Markus Pargmann <mpa@pengutronix.de> wrote:
> -EPROBE_DEFER is no real error. We are just waiting unti the necessary
> components are ready. The driver core infrastructure will also print an
> appropriate info message.
>
> This patch changes the error message to a debug message.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index ee1ae303a07c..26405d5c7a1f 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -137,7 +137,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>                  * not yet registered, we should try defering probe.
>                  */
>                 if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
> -                       dev_err(cpu_dev, "cpu0 regulator not ready, retry\n");
> +                       dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
>                         ret = -EPROBE_DEFER;
>                         goto out_put_node;
>                 }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
