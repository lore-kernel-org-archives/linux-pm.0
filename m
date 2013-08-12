From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/44] cpufreq: exynos: call cpufreq_frequency_table_put_attr()
Date: Mon, 12 Aug 2013 11:48:01 +0530
Message-ID: <CAKohponzE-Ea7ZDAK=hUoeqi-f2Cmyo9AocM1wSC1dcHdjAYzw@mail.gmail.com>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
	<c2157d44d4933c5fa9cea06e0d621786a3d03671.1376116345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42923 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab3HLGSC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 02:18:02 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so8706026obc.12
        for <linux-pm@vger.kernel.org>; Sun, 11 Aug 2013 23:18:01 -0700 (PDT)
In-Reply-To: <c2157d44d4933c5fa9cea06e0d621786a3d03671.1376116345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

On 10 August 2013 12:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
> they have called cpufreq_frequency_table_get_attr() in their init path.
>
> This driver was missing this part and is fixed with this patch.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index 1ac93e0..b9dfc91 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -336,12 +336,18 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         return 0;
>  }
>
> +static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)

s/init/exit ..

fixed in my repo..
