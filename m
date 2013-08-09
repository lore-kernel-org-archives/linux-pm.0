From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [RFC PATCH] cpuidle: fix device->state_count handling
Date: Fri, 09 Aug 2013 17:47:52 +0200
Message-ID: <22200721.zOZJVq5p47@amdc1227>
References: <8500767.uCb7Y0sjbx@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <8500767.uCb7Y0sjbx@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Bart,

On Friday 09 of August 2013 13:59:27 Bartlomiej Zolnierkiewicz wrote:
> Use device->state_count instead of driver->state_count in
> cpuidle_play_dead(), ladder_select_state() and menu_select().
> 
> This allows cpuidle drivers to override maximum allowable
> state number for a given device, which is what some cpuidle
> drivers would like to do (i.e. EXYNOS cpuidle driver).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Alternatively, we can make EXYNOS cpuidle driver work without
> device->state_count (at a some tiny performance cost?). This
> would allow us to remove device->state_count completely as it
> is not needed by any other cpuidle driver currently (AFAICS).
> 
>  drivers/cpuidle/cpuidle.c          |    2 +-
>  drivers/cpuidle/governors/ladder.c |    2 +-
>  drivers/cpuidle/governors/menu.c   |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Index: b/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- a/drivers/cpuidle/cpuidle.c	2013-08-08 14:36:09.611488750 +0200
> +++ b/drivers/cpuidle/cpuidle.c	2013-08-08 14:39:02.291486116 +0200
> @@ -57,7 +57,7 @@ int cpuidle_play_dead(void)
>  		return -ENODEV;
> 
>  	/* Find lowest-power state that supports long-term idle */
> -	for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i--)
> +	for (i = dev->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i--)
>  		if (drv->states[i].enter_dead)
>  			return drv->states[i].enter_dead(dev, i);
> 
> Index: b/drivers/cpuidle/governors/ladder.c
> ===================================================================
> --- a/drivers/cpuidle/governors/ladder.c	2013-08-08 14:36:09.611488750
> +0200 +++ b/drivers/cpuidle/governors/ladder.c	2013-08-08
> 14:39:02.299486116 +0200 @@ -87,7 +87,7 @@ static int
> ladder_select_state(struct cp
>  		last_residency = last_state->threshold.promotion_time + 1;
> 
>  	/* consider promotion */
> -	if (last_idx < drv->state_count - 1 &&
> +	if (last_idx < dev->state_count - 1 &&
>  	    !drv->states[last_idx + 1].disabled &&
>  	    !dev->states_usage[last_idx + 1].disable &&
>  	    last_residency > last_state->threshold.promotion_time &&
> Index: b/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- a/drivers/cpuidle/governors/menu.c	2013-08-08 14:36:09.611488750
> +0200 +++ b/drivers/cpuidle/governors/menu.c	2013-08-08
> 14:39:02.299486116 +0200 @@ -312,7 +312,7 @@ static int
> menu_select(struct cpuidle_dr
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
> -	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
> 

Looks good to me. Have my

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
