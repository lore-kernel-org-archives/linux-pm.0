From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: Show a list of available frequencies
Date: Fri, 11 Oct 2013 19:57:28 +0530
Message-ID: <CAKohpok6Pbq-ykeWKEfUo3=eC8bzkAUo_FTPN2zMMu44R-vuOA@mail.gmail.com>
References: <00bd01cec641$b4dbf150$1e93d3f0$%lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:35103 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3JKO13 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 10:27:29 -0400
Received: by mail-qc0-f178.google.com with SMTP id r5so2959665qcx.23
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2013 07:27:29 -0700 (PDT)
In-Reply-To: <00bd01cec641$b4dbf150$1e93d3f0$%lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jungseok Lee <jays.lee@samsung.com>
Cc: rjw@sisk.pl, amit.daniel@samsung.com, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kgene.kim@samsung.com

On 11/10/2013, Jungseok Lee <jays.lee@samsung.com> wrote:
> This patch adds freq_attr to show a list of exynos5440 scaling
> available frequencies through sysfs. Common exynos driver already
> supports this attribute.
>
> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
> b/drivers/cpufreq/exynos5440-cpufreq.c
> index 24df155..2cc4797 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -345,6 +345,11 @@ static int exynos_cpufreq_cpu_exit(struct
> cpufreq_policy *policy)
>  	return 0;
>  }
>
> +static struct freq_attr *exynos_cpufreq_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL,
> +};
> +
>  static struct cpufreq_driver exynos_driver = {
>  	.flags		= CPUFREQ_STICKY,
>  	.verify		= exynos_verify_speed,
> @@ -353,6 +358,7 @@ static struct cpufreq_driver exynos_driver = {
>  	.init		= exynos_cpufreq_cpu_init,
>  	.exit		= exynos_cpufreq_cpu_exit,
>  	.name		= CPUFREQ_NAME,
> +	.attr		= exynos_cpufreq_attr,
>  };
>
>  static const struct of_device_id exynos_cpufreq_match[] = {

Use cpufreq_generic_attr instead from rafael's bleeding-edge
branch
