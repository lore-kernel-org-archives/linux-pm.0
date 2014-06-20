From: pramod gurav <pramod.gurav.etc@gmail.com>
Subject: Re: [PATCH] cpuidle: Fix Coding style reported by checkpatch.pl
Date: Fri, 20 Jun 2014 16:28:32 +0530
Message-ID: <CAMf-jSm=YK4AN9-enh_8F4DYf-JGpv_=FRYdgYTt5P_EvSsE8g@mail.gmail.com>
References: <1403261865-7472-1-git-send-email-pramod.gurav.etc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:51049 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965650AbaFTK6e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jun 2014 06:58:34 -0400
In-Reply-To: <1403261865-7472-1-git-send-email-pramod.gurav.etc@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Pramod Gurav <pramod.gurav.etc@gmail.com>

+linux-pm

On Fri, Jun 20, 2014 at 4:27 PM, Pramod Gurav
<pramod.gurav.etc@gmail.com> wrote:
> Fixed: ERROR: do not use assignment in if condition
> Fixed: WARNING: EXPORT_SYMBOL should immediately follow its function
> Fixed: WARNING: line over 80 characters in a comment
>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Signed-off-by: Pramod Gurav <pramod.gurav.etc@gmail.com>
> ---
>  drivers/cpuidle/cpuidle.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8236746..2c8752e 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -179,7 +179,9 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
>  void cpuidle_install_idle_handler(void)
>  {
>         if (enabled_devices) {
> -               /* Make sure all changes finished before we switch to new idle */
> +               /*
> +                * Make sure all changes finished before we switch to new idle
> +                */
>                 smp_wmb();
>                 initialized = 1;
>         }
> @@ -204,7 +206,6 @@ void cpuidle_pause_and_lock(void)
>         mutex_lock(&cpuidle_lock);
>         cpuidle_uninstall_idle_handler();
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
>
>  /**
> @@ -215,7 +216,6 @@ void cpuidle_resume_and_unlock(void)
>         cpuidle_install_idle_handler();
>         mutex_unlock(&cpuidle_lock);
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>
>  /* Currently used in suspend/resume path to suspend cpuidle */
> @@ -267,9 +267,11 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>         if (ret)
>                 return ret;
>
> -       if (cpuidle_curr_governor->enable &&
> -           (ret = cpuidle_curr_governor->enable(drv, dev)))
> -               goto fail_sysfs;
> +       if (cpuidle_curr_governor->enable) {
> +               ret = cpuidle_curr_governor->enable(drv, dev);
> +               if (ret)
> +                       goto fail_sysfs;
> +       }
>
>         smp_wmb();
>
> @@ -283,7 +285,6 @@ fail_sysfs:
>
>         return ret;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_enable_device);
>
>  /**
> @@ -311,7 +312,6 @@ void cpuidle_disable_device(struct cpuidle_device *dev)
>         cpuidle_remove_device_sysfs(dev);
>         enabled_devices--;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>
>  static void __cpuidle_unregister_device(struct cpuidle_device *dev)
> @@ -399,7 +399,6 @@ out_unregister:
>         __cpuidle_unregister_device(dev);
>         goto out_unlock;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_register_device);
>
>  /**
> @@ -423,7 +422,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>
>         cpuidle_resume_and_unlock();
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>
>  /**
> --
> 1.7.9.5
>



-- 
Thanks and Regards
Pramod
