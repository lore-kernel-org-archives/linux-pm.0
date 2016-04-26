From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return
 value
Date: Tue, 26 Apr 2016 12:31:03 +0100
Message-ID: <20160426113103.GB2204@red-moon>
References: <1461669301-30834-1-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53707 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593AbcDZLbD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Apr 2016 07:31:03 -0400
Content-Disposition: inline
In-Reply-To: <1461669301-30834-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Apr 26, 2016 at 12:15:01PM +0100, James Morse wrote:
> arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
> by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
> update 'ret' with this value, meaning we always signal success to
> cpuidle_enter_state(), causing it to update the usage counters as if we
> succeeded.
> 
> Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 545069d5fdfb..e342565e8715 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -50,7 +50,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>  		 * call the CPU ops suspend protocol with idle index as a
>  		 * parameter.
>  		 */
> -		arm_cpuidle_suspend(idx);
> +		ret = arm_cpuidle_suspend(idx);
>  
>  		cpu_pm_exit();
>  	}
> -- 
> 2.8.0.rc3
> 
