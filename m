From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] cpuidle menu: Better idle duration measurement without
 using CPUIDLE_FLAG_TIME_INVALID
Date: Tue, 16 Dec 2014 11:57:03 +0100
Message-ID: <54900FFF.9050508@linaro.org>
References: <1418712728-2193-1-git-send-email-lenb@kernel.org> <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62381 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaLPK5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 05:57:05 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11993949wid.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2014 02:57:03 -0800 (PST)
In-Reply-To: <c55877aa13886c660da484118a96117f939553e3.1418712225.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

On 12/16/2014 07:52 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> When menu sees CPUIDLE_FLAG_TIME_INVALID, it ignores its timestamps,
> and assumes that idle lasted as long as the time till next predicted
> timer expiration.
>
> But if an interrupt was seen and serviced before that duration,
> it would actually be more accurate to use the measured time
> rather than rounding up to the next predicted timer expiration.
>
> And if an interrupt is seen and serviced such that the mesured time
> exceeds the time till next predicted timer expiration, then
> truncating to that expiration is the right thing to do --
> since we can never stay idle past that timer expiration.
>
> So the code can do a better job without
> checking for CPUIDLE_FLAG_TIME_INVALID.

Good point.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/cpuidle/governors/menu.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gover=
nors/menu.c
> index 659d7b0..4058079 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -396,8 +396,8 @@ static void menu_update(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev)
>   	 * power state and occurrence of the wakeup event.
>   	 *
>   	 * If the entered idle state didn't support residency measurements=
,
> -	 * we are basically lost in the dark how much time passed.
> -	 * As a compromise, assume we slept for the whole expected time.
> +	 * we use them anyway if they are short, and if long,
> +	 * truncate to the whole expected time.
>   	 *
>   	 * Any measured amount of time will include the exit latency.
>   	 * Since we are interested in when the wakeup begun, not when it
> @@ -405,22 +405,17 @@ static void menu_update(struct cpuidle_driver *=
drv, struct cpuidle_device *dev)
>   	 * the measured amount of time is less than the exit latency,
>   	 * assume the state was never reached and the exit latency is 0.
>   	 */
> -	if (unlikely(target->flags & CPUIDLE_FLAG_TIME_INVALID)) {
> -		/* Use timer value as is */
> -		measured_us =3D data->next_timer_us;
>
> -	} else {
> -		/* Use measured value */
> -		measured_us =3D cpuidle_get_last_residency(dev);
> +	/* measured value */
> +	measured_us =3D cpuidle_get_last_residency(dev);
>
> -		/* Deduct exit latency */
> -		if (measured_us > target->exit_latency)
> -			measured_us -=3D target->exit_latency;
> +	/* Deduct exit latency */
> +	if (measured_us > target->exit_latency)
> +		measured_us -=3D target->exit_latency;
>
> -		/* Make sure our coefficients do not exceed unity */
> -		if (measured_us > data->next_timer_us)
> -			measured_us =3D data->next_timer_us;
> -	}
> +	/* Make sure our coefficients do not exceed unity */
> +	if (measured_us > data->next_timer_us)
> +		measured_us =3D data->next_timer_us;
>
>   	/* Update our correction ratio */
>   	new_factor =3D data->correction_factor[data->bucket];
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

