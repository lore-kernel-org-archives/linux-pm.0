From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RFC v2 5/6] arm: cpuidle: let genpd handle the cluster power
 transition with 'power-states'
Date: Wed, 11 Nov 2015 17:10:40 +0800
Message-ID: <CAN2waFvgQUO4Mda3bHEwRDEPO2T36DWXXWKuW6G9+o7mQ854VQ@mail.gmail.com>
References: <20151006022702.GA78570@linaro.org>
	<1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
	<1444141665-18534-6-git-send-email-mtitinger+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34503 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbKKJKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 04:10:41 -0500
Received: by ykfs79 with SMTP id s79so39320696ykf.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 01:10:40 -0800 (PST)
In-Reply-To: <1444141665-18534-6-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: khilman@kernel.org, rjw@rjwysocki.net, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Benoit Cousson <bcousson@baylibre.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 6 October 2015 at 22:27, Marc Titinger <mtitinger@baylibre.com> wrote:
> From: Marc Titinger <mtitinger@baylibre.com>
>
> Cpuidle now handles c-states and power-states differently. c-states do not decrement
>  the reference count for the CPUs in the cluster, while power-states i.e.
> cluster level states like 'CLUSTER_SLEEP_0' in the case of juno, will.
>
> The 'D1' fake device also registers intermediate power-state,
> for experimentation.
>
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  arch/arm64/boot/dts/arm/juno.dts |  2 +-
>  drivers/cpuidle/cpuidle-arm.c    | 52 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index cadc5de..0bb0dd7 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -47,7 +47,7 @@
>                         };
>
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
> -                               compatible = "arm,idle-state","arm,power-state";
> +                               compatible = "arm,power-state";
>                                 arm,psci-suspend-param = <0x1010000>;
>                                 local-timer-stop;
>                                 entry-latency-us = <800>;
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 7c791f9..8dd5dc3 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -40,7 +40,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>                                 struct cpuidle_driver *drv, int idx)
>  {
>         int ret;
> -       struct device *cpu_dev = get_cpu_device(dev->cpu);
>
>         if (!idx) {
>                 cpu_do_idle();
> @@ -50,18 +49,49 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>         ret = cpu_pm_enter();
>         if (!ret) {
>                 /*
> -                * Notify runtime PM as well of this cpu powering down
> -                * TODO: Merge CPU_PM and runtime PM.
> -                */
> -               RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
> -
> -               /*
>                  * Pass idle state index to cpu_suspend which in turn will
>                  * call the CPU ops suspend protocol with idle index as a
>                  * parameter.
>                  */
>                 arm_cpuidle_suspend(idx);
>
> +               cpu_pm_exit();
> +       }
> +
> +       return ret ? -1 : idx;
> +}
> +
> +/*
> + * arm_enter_power_state - delegate state trasition to genpd
> + *
> + * dev: cpuidle device
> + * drv: cpuidle driver
> + * idx: state index
> + *
> + * Called from the CPUidle framework to delegate a state transition
> + * to the generic domain. This will be a cluster poweroff state
> + * the Domain will chose to actually turn off the cluster based on
> + * the status of other CPUs, and devices and subdomains in the Cluster
> + * domain.
> +*/
> +static int arm_enter_power_state(struct cpuidle_device *dev,
> +               struct cpuidle_driver *drv, int idx)
> +{
> +       int ret;
> +       struct device *cpu_dev = get_cpu_device(dev->cpu);
> +
> +       BUG_ON(idx == 0);
> +
> +       ret = cpu_pm_enter();
> +       if (!ret) {
> +               /*
> +               * Notify runtime PM as well of this cpu powering down
> +               * TODO: Merge CPU_PM and runtime PM.
> +               */
> +               RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
[question]: Does it mean that above function will use the gpd->rpm->idle?
> +
> +               arm_cpuidle_suspend(idx);
> +
>                 RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
>                 cpu_pm_exit();
>         }
> @@ -69,6 +99,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>         return ret ? -1 : idx;
>  }
>
> +
>  static struct cpuidle_driver arm_idle_driver = {
>         .name = "arm_idle",
>         .owner = THIS_MODULE,
> @@ -90,9 +121,10 @@ static struct cpuidle_driver arm_idle_driver = {
>  };
>
>  static const struct of_device_id arm_idle_state_match[] __initconst = {
> -       { .compatible = "arm,idle-state",
> -         .data = arm_enter_idle_state },
> -       { },
> +       {.compatible = "arm,idle-state",
> +        .data = arm_enter_idle_state},
> +       {.compatible = "arm,power-state",
> +        .data = arm_enter_power_state},
>  };
>
>  /*
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
