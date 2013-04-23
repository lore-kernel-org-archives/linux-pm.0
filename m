From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: fix comment format
Date: Wed, 24 Apr 2013 01:11:09 +0200
Message-ID: <2392816.13e2puiPU5@vostro.rjw.lan>
References: <1366730924-20633-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42220 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab3DWXDF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Apr 2013 19:03:05 -0400
In-Reply-To: <1366730924-20633-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, linux-pm@vger.kernel.org

On Tuesday, April 23, 2013 05:28:44 PM Daniel Lezcano wrote:
> Fix comment format for the kernel doc script.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 49e8d30..c3a93fe 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -454,7 +454,7 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>  
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>  
> -/*
> +/**
>   * cpuidle_unregister: unregister a driver and the devices. This function
>   * can be used only if the driver has been previously registered through
>   * the cpuidle_register function.

Applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
