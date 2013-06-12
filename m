From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] cpuidle: Remove governor module format
Date: Thu, 13 Jun 2013 00:53:53 +0200
Message-ID: <1584034.uif9lZguq4@vostro.rjw.lan>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35434 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756907Ab3FLWol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Jun 2013 18:44:41 -0400
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Wednesday, June 12, 2013 03:08:48 PM Daniel Lezcano wrote:
> The governors are defined as module in the code, but the Kconfig options do not
> allow to compile them as module. This is not really a problem but the init
> order is: the cpuidle init functions (framework and driver) and then the
> governors. That leads to some weirdness in the cpuidle framework because the
> function cpuidle_register_device calls cpuidle_enable_device which in turns
> fails at the first attempt because no governor is registered. When the
> governor is registered, the framework calls cpuidle_enable_device again which
> will invoke the __cpuidle_register_device function. Of course, in order to make
> this to work, the return code of cpuidle_enable_device is not checked by the
> caller in cpuidle_register_device.
> 
> Instead of having this cyclic call graph and relying on a positive side effect
> of the hackish back and forth call to cpuidle_enable_device, let's fix the
> init order for the governor in order to clean up the cpuidle_enable_device
> function.
> 
> Remove the module init code and replaced it with postcore_initcall, so we have:
> 
>  * cpuidle framework : core_initcall
>  * cpuidle governors : postcore_initcall
>  * cpuidle drivers   : device_initcall
> 
> Remove exit module code as it is dead code (governors aren't compiled as
> module).
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

That's something I'd like to receive much earlier in the cycle (around -rc2).

Honestly, I'm not sure if it's going to make it into 3.11 even if nobody has
any comments.

Thanks,
Rafael


> ---
>  drivers/cpuidle/governors/ladder.c |   12 +-----------
>  drivers/cpuidle/governors/menu.c   |   12 +-----------
>  2 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 9b78405..9f08e8c 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -192,14 +192,4 @@ static int __init init_ladder(void)
>  	return cpuidle_register_governor(&ladder_governor);
>  }
>  
> -/**
> - * exit_ladder - exits the governor
> - */
> -static void __exit exit_ladder(void)
> -{
> -	cpuidle_unregister_governor(&ladder_governor);
> -}
> -
> -MODULE_LICENSE("GPL");
> -module_init(init_ladder);
> -module_exit(exit_ladder);
> +postcore_initcall(init_ladder);
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index fe343a0..743138c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -540,14 +540,4 @@ static int __init init_menu(void)
>  	return cpuidle_register_governor(&menu_governor);
>  }
>  
> -/**
> - * exit_menu - exits the governor
> - */
> -static void __exit exit_menu(void)
> -{
> -	cpuidle_unregister_governor(&menu_governor);
> -}
> -
> -MODULE_LICENSE("GPL");
> -module_init(init_menu);
> -module_exit(exit_menu);
> +postcore_initcall(init_menu);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
