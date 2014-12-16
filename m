From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] cpuidle ladder: Better idle duration measurement
 without using CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 12:07:52 +0100
Message-ID: <54901288.7000006@linaro.org>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org> <83e27d4a9f387aa9781de927ea7f436f388de7bd.1418712225.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <83e27d4a9f387aa9781de927ea7f436f388de7bd.1418712225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 12/16/2014 07:52 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> When the ladder governor sees the CPUIDLE_FLAG_TIME_INVALID flag,
> it unconditionally causes a state promotion by setting last_residency
> to a number higher than the state's promotion_time:
>
> last_residency =3D last_state->threshold.promotion_time + 1
>
> It does this for fear that cpuidle_get_last_residency()
> will be in-accurate, because cpuidle_enter_state() invoked
> a state with CPUIDLE_FLAG_TIME_INVALID.
>
> But the only state with CPUIDLE_FLAG_TIME_INVALID is
> acpi_safe_halt(), which may return well after its actual
> idle duration because it enables interrupts, so cpuidle_enter_state()
> also measures interrupt service time.
>
> So what?  In ladder, a huge invalid last_residency has exactly
> the same effect as the current code -- it unconditionally
> causes a state promotion.
>
> In the case where the idle residency plus measured interrupt
> handling time is less than the state's demotion_time -- we should
> use that timestamp to give ladder a chance to demote, rather than
> unconditionally promoting.
>
> This can be done by simply ignoring the CPUIDLE_FLAG_TIME_INVALID,
> and using the "invalid" time, as it is either equal to what we are
> doing today, or better.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

a dumb question: is someone still using the ladder governor nowadays ?

> ---
>   drivers/cpuidle/governors/ladder.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/gov=
ernors/ladder.c
> index 37263d9..401c010 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -79,12 +79,7 @@ static int ladder_select_state(struct cpuidle_driv=
er *drv,
>
>   	last_state =3D &ldev->states[last_idx];
>
> -	if (!(drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_INVALID)) {
> -		last_residency =3D cpuidle_get_last_residency(dev) - \
> -					 drv->states[last_idx].exit_latency;
> -	}
> -	else
> -		last_residency =3D last_state->threshold.promotion_time + 1;
> +	last_residency =3D cpuidle_get_last_residency(dev) - drv->states[la=
st_idx].exit_latency;
>
>   	/* consider promotion */
>   	if (last_idx < drv->state_count - 1 &&
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
