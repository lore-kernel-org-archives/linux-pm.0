From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering safe state
Date: Wed, 28 Aug 2013 23:28:33 +0200
Message-ID: <16805669.URyPi50bbV@vostro.rjw.lan>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40182 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab3H1VRt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Aug 2013 17:17:49 -0400
In-Reply-To: <1377287112-12018-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Friday, August 23, 2013 12:45:10 PM Colin Cross wrote:
> Calling cpuidle_enter_state is expected to return with interrupts
> enabled, but interrupts must be disabled before starting the
> ready loop synchronization stage.  Call local_irq_disable after
> each call to cpuidle_enter_state for the safe state.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Colin Cross <ccross@android.com>

I've queued up all thress for 3.12, but I wonder what stable versions they
should be included into?  All of them or just a subset?

Rafael


> ---
>  drivers/cpuidle/coupled.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index 2a297f8..db92bcb 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -460,6 +460,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>  		}
>  		entered_state = cpuidle_enter_state(dev, drv,
>  			dev->safe_state_index);
> +		local_irq_disable();
>  	}
>  
>  	/* Read barrier ensures online_count is read after prevent is cleared */
> @@ -485,6 +486,7 @@ retry:
>  
>  		entered_state = cpuidle_enter_state(dev, drv,
>  			dev->safe_state_index);
> +		local_irq_disable();
>  	}
>  
>  	if (cpuidle_coupled_clear_pokes(dev->cpu)) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
