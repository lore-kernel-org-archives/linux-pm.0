From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/7] Cpuidle: Use actual state latency in menu governor
Date: Mon, 24 Feb 2014 23:35:40 +0100
Message-ID: <530BC93C.4090907@linaro.org>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org> <1393223377-5744-3-git-send-email-tuukka.tikkanen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:55012 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbaBXWfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 17:35:40 -0500
Received: by mail-wg0-f54.google.com with SMTP id l18so5325829wgh.9
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2014 14:35:39 -0800 (PST)
In-Reply-To: <1393223377-5744-3-git-send-email-tuukka.tikkanen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org

On 02/24/2014 07:29 AM, Tuukka Tikkanen wrote:
> Currently menu governor records the exit latency of the state it has
> chosen for the idle period. The stored latency value is then later
> used to calculate the actual length of the idle period. This value
> may however be incorrect, as the entered state may not be the one
> chosen by the governor. The entered state information is available,
> so we can use that to obtain the real exit latency.
>
> Signed-off-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/governors/menu.c |    7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gover=
nors/menu.c
> index e9a2a27..115386a 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -124,7 +124,6 @@ struct menu_device {
>
>   	unsigned int	next_timer_us;
>   	unsigned int	predicted_us;
> -	unsigned int	exit_us;
>   	unsigned int	bucket;
>   	unsigned int	correction_factor[BUCKETS];
>   	unsigned int	intervals[INTERVALS];
> @@ -298,7 +297,6 @@ static int menu_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev)
>   	}
>
>   	data->last_state_idx =3D 0;
> -	data->exit_us =3D 0;
>
>   	/* Special case when user has set very strict latency requirement =
*/
>   	if (unlikely(latency_req =3D=3D 0))
> @@ -359,7 +357,6 @@ static int menu_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev)
>   			continue;
>
>   		data->last_state_idx =3D i;
> -		data->exit_us =3D s->exit_latency;
>   	}
>
>   	return data->last_state_idx;
> @@ -410,8 +407,8 @@ static void menu_update(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev)
>   	 * We correct for the exit latency; we are assuming here that the
>   	 * exit latency happens after the event that we're interested in.
>   	 */
> -	if (measured_us > data->exit_us)
> -		measured_us -=3D data->exit_us;
> +	if (measured_us > target->exit_latency)
> +		measured_us -=3D target->exit_latency;
>
>
>   	/* Update our correction ratio */
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

