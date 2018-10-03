From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpuidle: enter_state: Don't needlessly calculate diff time
Date: Wed, 03 Oct 2018 11:42:56 +0200
Message-ID: <1604543.39SsmLJHeg@aspire.rjw.lan>
References: <20180910214725.19525-1-kw@fieahl.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910214725.19525-1-kw@fieahl.im>
Sender: linux-kernel-owner@vger.kernel.org
To: Fieah Lim <kw@fieahl.im>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, September 10, 2018 11:47:25 PM CEST Fieah Lim wrote:
> Currently we use ktime_us_delta() to calculate last residency and
> state usage unconditionally, it makes no sense to do this calculation
> when we fails to enter any idle state.
> It can be optimize by moving the calculation after entered_state >= 0
> 
> While at it, merge those comment blocks into one and remove a
> space between type casting of diff.
> 
> This patch has no functional changes.
> 
> Signed-off-by: Fieah Lim <kw@fieahl.im>
> ---
> Changes from v1:
>  - Rewrite changelog as Rafael J. Wysocki suggested
> Changes from v2:
>  - Minor adjustment
> ---
>  drivers/cpuidle/cpuidle.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6df894d65d9e..40442c3631ce 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -247,17 +247,16 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	if (!cpuidle_state_is_coupled(drv, index))
>  		local_irq_enable();
>  
> -	diff = ktime_us_delta(time_end, time_start);
> -	if (diff > INT_MAX)
> -		diff = INT_MAX;
> -
> -	dev->last_residency = (int) diff;
> -
>  	if (entered_state >= 0) {
> -		/* Update cpuidle counters */
> -		/* This can be moved to within driver enter routine
> +		/* Update cpuidle counters
> +		 * This can be moved to within driver enter routine,
>  		 * but that results in multiple copies of same code.
>  		 */
> +		diff = ktime_us_delta(time_end, time_start);
> +		if (diff > INT_MAX)
> +			diff = INT_MAX;
> +
> +		dev->last_residency = (int)diff;
>  		dev->states_usage[entered_state].time += dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
>  	} else {
> 

Applied, thanks!
