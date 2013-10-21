From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: exynos: Show a list of available frequencies
Date: Mon, 21 Oct 2013 13:00:02 +0530
Message-ID: <CAKohponOQ=FB6vY+6J+qNCd8+gNn4sCwzdNV56_VtVdwavWOwg@mail.gmail.com>
References: <00a301cec935$786cf7e0$6946e7a0$%lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:37007 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab3JUHaD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 03:30:03 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so2232759qac.18
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2013 00:30:03 -0700 (PDT)
In-Reply-To: <00a301cec935$786cf7e0$6946e7a0$%lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jungseok Lee <jays.lee@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>

On 15 October 2013 05:01, Jungseok Lee <jays.lee@samsung.com> wrote:
> This patch adds freq_attr to show a list of exynos5440 scaling
> available frequencies through sysfs. Common exynos driver already
> supports this attribute.
>
> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> ---
> Changes since v1:
> - Used a generic attribute, not a specific one.
>
>  drivers/cpufreq/exynos5440-cpufreq.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index 06b73e8..fecc3da 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -330,6 +330,7 @@ static struct cpufreq_driver exynos_driver = {
>         .init           = exynos_cpufreq_cpu_init,
>         .exit           = cpufreq_generic_exit,
>         .name           = CPUFREQ_NAME,
> +       .attr           = cpufreq_generic_attr,
>  };
>
>  static const struct of_device_id exynos_cpufreq_match[] = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
