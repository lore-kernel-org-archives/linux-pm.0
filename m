From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle: Using the wake_up_all_idle_cpus() to wake
 up all idle cpus
Date: Thu, 04 Sep 2014 15:01:30 +0200
Message-ID: <540862AA.7060907@linaro.org>
References: <1409815075-4180-1-git-send-email-chuansheng.liu@intel.com> <1409815075-4180-3-git-send-email-chuansheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64548 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaIDNBe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 09:01:34 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so10123420wes.19
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 06:01:33 -0700 (PDT)
In-Reply-To: <1409815075-4180-3-git-send-email-chuansheng.liu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>, peterz@infradead.org, luto@amacapital.net, rjw@rjwysocki.net, mingo@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com

On 09/04/2014 09:17 AM, Chuansheng Liu wrote:
> Currently kick_all_cpus_sync() or smp_call_function() can not
> break the polling idle cpu immediately.
>
> Here using wake_up_all_idle_cpus() which can wake up the polling idle
> cpu quickly is much helpful for power.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

So IIUC, kick_all_cpus_sync is a broken function, right ?

Wouldn't make sense to replace all calls to kick_all_cpus by=20
wake_up_all_idle_cpus ? and remove this broken function ?

> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> ---
>   drivers/cpuidle/cpuidle.c |    9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ee9df5e..d31e04c 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -223,7 +223,7 @@ void cpuidle_uninstall_idle_handler(void)
>   {
>   	if (enabled_devices) {
>   		initialized =3D 0;
> -		kick_all_cpus_sync();
> +		wake_up_all_idle_cpus();
>   	}
>   }
>
> @@ -530,11 +530,6 @@ EXPORT_SYMBOL_GPL(cpuidle_register);
>
>   #ifdef CONFIG_SMP
>
> -static void smp_callback(void *v)
> -{
> -	/* we already woke the CPU up, nothing more to do */
> -}
> -
>   /*
>    * This function gets called when a part of the kernel has a new la=
tency
>    * requirement.  This means we need to get all processors out of th=
eir C-state,
> @@ -544,7 +539,7 @@ static void smp_callback(void *v)
>   static int cpuidle_latency_notify(struct notifier_block *b,
>   		unsigned long l, void *v)
>   {
> -	smp_call_function(smp_callback, NULL, 1);
> +	wake_up_all_idle_cpus();
>   	return NOTIFY_OK;
>   }
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

