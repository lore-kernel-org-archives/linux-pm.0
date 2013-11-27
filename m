From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH RFC v3 06/12] arm: kvm: implement CPU PM notifier
Date: Tue, 26 Nov 2013 19:02:51 -0800
Message-ID: <20131127030251.GW9314@cbox>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-7-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40266 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758701Ab3K0DBR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 22:01:17 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so9007342pdj.32
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2013 19:01:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385033059-25896-7-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Nov 21, 2013 at 11:24:13AM +0000, Lorenzo Pieralisi wrote:
> Upon CPU shutdown and consequent warm-reboot, the hypervisor CPU state
> must be re-initialized. This patch implements a CPU PM notifier that
> upon warm-boot calls a KVM hook to reinitialize properly the hypervisor
> state so that the CPU can be safely resumed.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/kvm/arm.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 2a700e0..b18165c 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> @@ -853,6 +854,33 @@ static struct notifier_block hyp_init_cpu_nb = {
>  	.notifier_call = hyp_init_cpu_notify,
>  };
>  
> +#ifdef CONFIG_CPU_PM
> +static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
> +				    unsigned long cmd,
> +				    void *v)
> +{
> +	if (cmd == CPU_PM_EXIT) {
> +		cpu_init_hyp_mode(NULL);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block hyp_init_cpu_pm_nb = {
> +	.notifier_call = hyp_init_cpu_pm_notifier,
> +};
> +
> +static void __init hyp_cpu_pm_init(void)
> +{
> +	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
> +}
> +#else
> +static inline void hyp_cpu_pm_init(void)
> +{
> +}
> +#endif
> +
>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
> @@ -1013,6 +1041,8 @@ int kvm_arch_init(void *opaque)
>  		goto out_err;
>  	}
>  
> +	hyp_cpu_pm_init();
> +
>  	kvm_coproc_table_init();
>  	return 0;
>  out_err:
> -- 
> 1.8.4
> 
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
