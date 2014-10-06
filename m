From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Mon, 6 Oct 2014 09:26:26 +0530
Message-ID: <CAKohpokiKnXe+UiQBJnyry+FqWT=HgyijLNFWZ0tUj6DygzELQ@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
	<20140927224434.19023.35708@quantum>
	<CAKohpo=8ernJ=bMJKB5K90nsvy4UpJH67dOnFCi80uyRR3EDvw@mail.gmail.com>
	<20141005004102.4379.42626@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141005004102.4379.42626@quantum>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mike Turquette <mike.turquette@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 5 October 2014 06:11, Mike Turquette <mike.turquette@linaro.org> wrote:
> For reference, here is a patch that I've had locally in my tree for a
> couples months. I'm using it while prototyping some ways to integrate
> CPUfreq with the scheduler. It is almost identical to Thomas's approach
> but it doesn't try to mask off some flags. Additionally it does NOT
> change the u8 return type, which is currently how struct
> cpufreq_driver->flags is defined today. This is probably not good and
> should be an unsigned int or unsigned long so that the api is a bit more
> forward-looking.

Probably yes.

> From 0053dfc6b09fa0c5923b7dcba23b67c1c005cb88 Mon Sep 17 00:00:00 2001
> From: Mike Turquette <mturquette@linaro.org>
> Date: Sun, 3 Aug 2014 21:25:38 -0700
> Subject: [PATCH] cpufreq: new function to query driver for flags
>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1abb44d..515e905 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2003,6 +2003,15 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_target);
>
> +u8 cpufreq_driver_get_flags(void)
> +{
> +       if (!cpufreq_driver)
> +               return 0;

Probably you need to return some error here. How would the caller know if
there is no cpufreq-driver there..

> +       return cpufreq_driver->flags;
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_driver_get_flags);
> +
>  /*
>   * when "event" is CPUFREQ_GOV_LIMITS
>   */
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 221f0eb..5a97f5f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -417,6 +417,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
>  int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                                    unsigned int target_freq,
>                                    unsigned int relation);
> +u8 cpufreq_driver_get_flags(void);
>  int cpufreq_register_governor(struct cpufreq_governor *governor);
>  void cpufreq_unregister_governor(struct cpufreq_governor *governor);
>
> --
> 1.8.3.2
>
