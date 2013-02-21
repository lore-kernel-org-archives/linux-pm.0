From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 09/16] ia64 idle: delete pm_idle
Date: Thu, 21 Feb 2013 11:15:47 +0100
Message-ID: <5125F3D3.6040309@metafoo.de>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <7dc2a692a27e9c3da86acf150c4a89024e48bd05.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1067 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3BUKTd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 05:19:33 -0500
In-Reply-To: <7dc2a692a27e9c3da86acf150c4a89024e48bd05.1360475150.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-ia64@vger.kernel.org

On 02/10/2013 06:58 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> pm_idle() on ia64 was a synonym for default_idle().
> So simply invoke default_idle() directly.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-ia64@vger.kernel.org
> ---
>  arch/ia64/kernel/process.c | 3 ---
>  arch/ia64/kernel/setup.c   | 1 -
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index 31360cb..e34f565 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -57,8 +57,6 @@ void (*ia64_mark_idle)(int);
>  
>  unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
>  EXPORT_SYMBOL(boot_option_idle_override);
> -void (*pm_idle) (void);
> -EXPORT_SYMBOL(pm_idle);
>  void (*pm_power_off) (void);
>  EXPORT_SYMBOL(pm_power_off);
>  
> @@ -301,7 +299,6 @@ cpu_idle (void)
>  			if (mark_idle)
>  				(*mark_idle)(1);
>  
> -			idle = pm_idle;
>  			if (!idle)

Hm, if I'm not mistaken idle will uninitialized at this point, so this could
quite likely lead to a crash.

>  				idle = default_idle;
>  			(*idle)();
> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
> index aaefd9b..2029cc0 100644
> --- a/arch/ia64/kernel/setup.c
> +++ b/arch/ia64/kernel/setup.c
> @@ -1051,7 +1051,6 @@ cpu_init (void)
>  		max_num_phys_stacked = num_phys_stacked;
>  	}
>  	platform_cpu_init();
> -	pm_idle = default_idle;
>  }
>  
>  void __init

