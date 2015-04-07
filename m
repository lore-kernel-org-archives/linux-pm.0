From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC/PATCH 1/4] ARM: cpuidle: Add cpuidle support for R-Car Gen2
 series
Date: Tue, 7 Apr 2015 10:44:07 +0900
Message-ID: <20150407014407.GC27486@verge.net.au>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <1428292244-2160-2-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36161 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbDGBoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 21:44:11 -0400
Content-Disposition: inline
In-Reply-To: <1428292244-2160-2-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

On Mon, Apr 06, 2015 at 12:50:41PM +0900, Keita Kobayashi wrote:
> Define ARM_RCAR_CPUIDLE config item to enable cpuidle
> support for Renesas R-Car Gen2 SoCs.
> 
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  drivers/cpuidle/Kconfig.arm | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 21340e0..ea9d61e 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -74,3 +74,11 @@ config ARM_MVEBU_V7_CPUIDLE
>  	depends on ARCH_MVEBU && !ARM64
>  	help
>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
> +
> +config ARM_RCAR_CPUIDLE
> +	bool "CPU Idle Driver for the R-Car SoCs"
> +	depends on ARCH_RCAR_GEN2
> +	select ARM_CPUIDLE
> +	select ARM_CPU_SUSPEND
> +	help
> +	  Select this to enable cpuidle for R-Car SoCs

I hate to be the harbinger of bad news but I don't believe this will
reliably work because ARM_CPUIDLE selects DT_IDLE_STATES and I believe that
Kconfig does not support recursive selection[1].

[1] http://lkml.iu.edu/hypermail/linux/kernel/1412.0/04004.html

I suggest changing select ARM_CPUIDLE to depends on ARM_CPUIDLE.
I would be tempted to make the same change for ARM_CPU_SUSPEND too.
