From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Thu, 8 Jun 2017 09:19:13 +0200
Message-ID: <CAKfTPtBvc-AiQ67P1L2bYtg=0vzzGwT=pTPM7thT-TxH-KKstg@mail.gmail.com>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35262 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHHTf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 03:19:35 -0400
Received: by mail-lf0-f50.google.com with SMTP id p189so14342483lfe.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 00:19:35 -0700 (PDT)
In-Reply-To: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, javi.merino@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng@hisilicon.com>, Jean Wangtao <jean.wangtao@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Kevin,

On 5 June 2017 at 11:07, Tao Wang <kevin.wangtao@hisilicon.com> wrote:
> cpu idle cooling driver performs synchronized idle injection across
> all cpu in same cluster, offers a new method to cooling down cpu,
> that is similar to intel_power_clamp driver, but is basically
> designed for ARM platform.
> Each cluster has its own idle cooling device, each core has its own
> idle injection thread, idle injection thread use play_idle to enter
> idle. In order to reach deepest idle state, all cores are aligned by
> jiffies. the injected idle ratio can be controlled through cooling
> device interface.
>
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> ---
>  drivers/thermal/Kconfig            |   13 +
>  drivers/thermal/Makefile           |    3 +
>  drivers/thermal/cpu_idle_cooling.c |  648 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 664 insertions(+)
>  create mode 100644 drivers/thermal/cpu_idle_cooling.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b5b5fac..f78e85c 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -154,6 +154,19 @@ config CPU_THERMAL
>
>           If you want this support, you should say Y here.
>
> +config CPU_IDLE_THERMAL
> +       tristate "generic cpu idle cooling support"
> +       depends on CPU_FREQ

Does CPU_IDLE_THERMAL really depend on CPU_FREQ ?
This dependency should be put for CPU_THERMAL_COMBO in the patch 2

> +       help
> +         This implements the generic cpu cooling mechanism through idle
> +         injection.
> +
> +         This will throttle cpu by injecting specified idle time in
> +         a fixed cycle. All cpu in same cluster will enter idle synchronously
> +         to reach deepest idle state when injecting idle.
> +
> +         If you want this support, you should say Y here.
> +
>  config CLOCK_THERMAL
>         bool "Generic clock cooling support"
>         depends on COMMON_CLK
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 094d703..a4db66e 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -26,6 +26,9 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   += clock_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>
> +# cpu idle cooling
> +obj-$(CONFIG_CPU_IDLE_THERMAL) += cpu_idle_cooling.o
> +
>  # platform thermal drivers
>  obj-y                          += broadcom/
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)     += qcom-spmi-temp-alarm.o
> diff --git a/drivers/thermal/cpu_idle_cooling.c b/drivers/thermal/cpu_idle_cooling.c
> new file mode 100644
> index 0000000..89a15c5
> --- /dev/null

[snip]
