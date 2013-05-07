From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH, RFC 03/22] cpuidle: calxeda: select ARM_CPU_SUSPEND
Date: Tue, 07 May 2013 16:42:07 -0500
Message-ID: <5189752F.8030405@gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de> <1367507786-505303-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:37764 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab3EGVmK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2013 17:42:10 -0400
In-Reply-To: <1367507786-505303-4-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 05/02/2013 10:16 AM, Arnd Bergmann wrote:
> Like other ARM specific drivers, this one requires ARM_CPU_SUSPEND,
> as shown by this linker error:
> 
> drivers/built-in.o: In function `calxeda_pwrdown_idle':
> drivers/cpuidle/cpuidle-calxeda.c:84: undefined reference to `cpu_suspend'
> drivers/cpuidle/cpuidle-calxeda.c:86: undefined reference to `cpu_resume'
> 
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/cpuidle/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c4cc27e..e21cdfa 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -36,6 +36,7 @@ if CPU_IDLE
>  config CPU_IDLE_CALXEDA
>  	bool "CPU Idle Driver for Calxeda processors"
>  	depends on ARCH_HIGHBANK
> +	select ARM_CPU_SUSPEND
>  	help
>  	  Select this to enable cpuidle on Calxeda processors.
>  
> 

