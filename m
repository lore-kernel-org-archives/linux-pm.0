From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 4/5] cpuidle: menu: Don't stay in shallow state for a long time
Date: Tue, 21 Aug 2018 10:35:23 +0200
Message-ID: <7779444.DV2K5n5ugl@aspire.rjw.lan>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org> <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, August 12, 2018 6:09:30 PM CEST Leo Yan wrote:
> To avoid staying in a shallow state for a long time, the menu governor
> relies on not stopping tick when detects the prediction is shorter than
> the tick event.  This is just luckily to cover most cases but cannot say
> it is completely safe.  For example, if the prediction is 2000us and the
> TICK_USEC=1000 so it's impossible to meet the condition
> 'data->predicted_us < TICK_USEC' and this lead to stop the tick for a
> shallow state; finally the CPU is possible to stay in this shallow state
> for very long time.
> 
> This patch checks the candidate idle state isn't deepest one and find if
> the timer will come after more than 2 times of the maximum target
> residency, though the governor selects a shallow state according to
> prediction, due the timer is most reliable waken up source but it will
> come very late, so the CPU has chance to stay in the shallow state
> for a long time; the patch doesn't stop the tick for this case so can
> avoid powernightmares issue.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 4f02207..566c65c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -284,6 +284,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
>  static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
>  				      struct menu_device *data, int idx)
>  {
> +	int max_target_residency;
> +
> +	max_target_residency = drv->states[drv->state_count-1].target_residency;

But this state may be disabled, may it not?

Thanks,
Rafael
