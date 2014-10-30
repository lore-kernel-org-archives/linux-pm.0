From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/3] arm64: psci: fix cpu_suspend to check idle state
 type for index
Date: Thu, 30 Oct 2014 10:19:46 +0000
Message-ID: <20141030101946.GA17843@red-moon>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
 <1414641338-25279-2-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:50660 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757283AbaJ3KT4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 06:19:56 -0400
Content-Disposition: inline
In-Reply-To: <1414641338-25279-2-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <Vladimir.Murzin@arm.com>, will.deacon@arm.com

Hi Amit,

On Thu, Oct 30, 2014 at 03:55:37AM +0000, Amit Daniel Kachhap wrote:
> This fix rectifies the psci cpu_suspend to check the C-state type
> corresponding to the requested index.

Can you reword the commit log please ?

"This fix rectifies the psci cpu_suspend implementation to check the
PSCI power state parameter type field associated with the requested idle
state index."

> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm64/kernel/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 2178d6e..4ebc146 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -530,7 +530,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>  	if (WARN_ON_ONCE(!index || !state))
>  		return -EINVAL;
>  
> -	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
> +	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
>  		ret = psci_ops.cpu_suspend(state[index - 1], 0);
>  	else
>  		ret = __cpu_suspend(index, psci_suspend_finisher);
> -- 
> 1.9.1

Can you resend it as a single patch (ie this patch does not apply if
patch 1 is missing, and I am not sure we need patch 1) and send it to
Catalin and Will to merge it asap ?

Please add my:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks,
Lorenzo
