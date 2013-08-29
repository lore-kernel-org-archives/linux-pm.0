From: Prashant Gaikwad <pgaikwad@nvidia.com>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering
 safe state
Date: Thu, 29 Aug 2013 12:20:14 +0530
Message-ID: <521EEF26.80803@nvidia.com>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377287112-12018-1-git-send-email-ccross@android.com>
Sender: stable-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 24 August 2013 01:15 AM, Colin Cross wrote:
> Calling cpuidle_enter_state is expected to return with interrupts
> enabled, but interrupts must be disabled before starting the
> ready loop synchronization stage.  Call local_irq_disable after
> each call to cpuidle_enter_state for the safe state.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>   drivers/cpuidle/coupled.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index 2a297f8..db92bcb 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -460,6 +460,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
>   		}
>   		entered_state = cpuidle_enter_state(dev, drv,
>   			dev->safe_state_index);
> +		local_irq_disable();

Colin,

There is still some window where irq remains enabled after exiting safe 
state. It may introduce some corner case.
Instead of this can we pass a parameter to cpuidle_enter_state 
indicating that irq has to be enabled or not after exit from idle state, 
which would be false when entering safe state from coupled idle.

>   	}
>   
>   	/* Read barrier ensures online_count is read after prevent is cleared */
> @@ -485,6 +486,7 @@ retry:
>   
>   		entered_state = cpuidle_enter_state(dev, drv,
>   			dev->safe_state_index);
> +		local_irq_disable();
>   	}
>   
>   	if (cpuidle_coupled_clear_pokes(dev->cpu)) {
