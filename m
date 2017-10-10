From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: cpuidle: Correct driver unregistration if
 init fails
Date: Wed, 11 Oct 2017 00:00:33 +0200
Message-ID: <CAJZ5v0h6BMTpFb1L5-ZAaupAiFApz+i-hYjDgfW4Fs0Dk_J1dg@mail.gmail.com>
References: <1507614476-16054-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:50238 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755586AbdJJWAe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 18:00:34 -0400
In-Reply-To: <1507614476-16054-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Oct 10, 2017 at 7:47 AM, Leo Yan <leo.yan@linaro.org> wrote:
> If cpuidle init fails, the code misses to unregister the driver for
> current CPU. Furthermore, we also need to rollback to cancel all
> previous CPUs registration; but the code retrieves driver handler by
> using function cpuidle_get_driver(), this function returns back
> current CPU driver handler but not previous CPU's handler, which leads
> to the failure handling code cannot unregister previous CPUs driver.
>
> This commit fixes two mentioned issues, it adds error handling path
> 'goto out_unregister_drv' for current CPU driver unregistration; and
> it is to replace cpuidle_get_driver() with cpuidle_get_cpu_driver(),
> the later function can retrieve driver handler for previous CPUs
> according to the CPU device handler so can unregister the driver
> properly.
>
> This patch also adds extra error handling paths 'goto out_kfree_dev'
> and 'goto out_kfree_drv' and adjusts the freeing sentences for previous
> CPUs; so make the code more readable for freeing 'dev' and 'drv'
> structures.
>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")

Daniel, any comments here and on the [2/2]?

> ---
>  drivers/cpuidle/cpuidle-arm.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 52a7505..f47c545 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -104,13 +104,13 @@ static int __init arm_idle_init(void)
>                 ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
>                 if (ret <= 0) {
>                         ret = ret ? : -ENODEV;
> -                       goto init_fail;
> +                       goto out_kfree_drv;
>                 }
>
>                 ret = cpuidle_register_driver(drv);
>                 if (ret) {
>                         pr_err("Failed to register cpuidle driver\n");
> -                       goto init_fail;
> +                       goto out_kfree_drv;
>                 }
>
>                 /*
> @@ -128,14 +128,14 @@ static int __init arm_idle_init(void)
>
>                 if (ret) {
>                         pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> -                       goto out_fail;
> +                       goto out_unregister_drv;
>                 }
>
>                 dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>                 if (!dev) {
>                         pr_err("Failed to allocate cpuidle device\n");
>                         ret = -ENOMEM;
> -                       goto out_fail;
> +                       goto out_unregister_drv;
>                 }
>                 dev->cpu = cpu;
>
> @@ -143,21 +143,25 @@ static int __init arm_idle_init(void)
>                 if (ret) {
>                         pr_err("Failed to register cpuidle device for CPU %d\n",
>                                cpu);
> -                       kfree(dev);
> -                       goto out_fail;
> +                       goto out_kfree_dev;
>                 }
>         }
>
>         return 0;
> -init_fail:
> +
> +out_kfree_dev:
> +       kfree(dev);
> +out_unregister_drv:
> +       cpuidle_unregister_driver(drv);
> +out_kfree_drv:
>         kfree(drv);
>  out_fail:
>         while (--cpu >= 0) {
>                 dev = per_cpu(cpuidle_devices, cpu);
> +               drv = cpuidle_get_cpu_driver(dev);
>                 cpuidle_unregister_device(dev);
> -               kfree(dev);
> -               drv = cpuidle_get_driver();
>                 cpuidle_unregister_driver(drv);
> +               kfree(dev);
>                 kfree(drv);
>         }
>
> --
> 2.7.4
>
