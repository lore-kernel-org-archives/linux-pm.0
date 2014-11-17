From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2] cpu_pm: fix unmet dependency for CPU_PM
Date: Mon, 17 Nov 2014 01:29:20 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1411170128560.11690@knanqh.ubzr>
References: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:64195 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaKQG3Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 01:29:24 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so1606857qcy.32
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2014 22:29:23 -0800 (PST)
In-Reply-To: <1416204764-8912-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux@arm.linux.org.uk, ccross@android.com

On Mon, 17 Nov 2014, Pankaj Dubey wrote:

> If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
> we are getting following config warning.
> 
> warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
> dependencies (SUSPEND || CPU_IDLE)
> 
> It has been noticed that CPU_PM dependencies in this file are not really
> required so let's remove these dependencies from CPU_PM.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> This patch is second attempt to fix this config issue. Patch v1 and related
> discussion can be found here [1]
> 1: https://lkml.org/lkml/2014/11/14/673
> 
>  kernel/power/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index bbef57f..1eb7da7 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -308,4 +308,3 @@ config PM_GENERIC_DOMAINS_OF
>  
>  config CPU_PM
>  	bool
> -	depends on SUSPEND || CPU_IDLE
> -- 
> 1.7.9.5
> 
> 
