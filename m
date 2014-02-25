From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 7/7] Cpuidle: poll state can measure residency
Date: Tue, 25 Feb 2014 11:56:39 +0100
Message-ID: <530C76E7.8090607@linaro.org>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org> <1393223377-5744-8-git-send-email-tuukka.tikkanen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393223377-5744-8-git-send-email-tuukka.tikkanen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/24/2014 07:29 AM, Tuukka Tikkanen wrote:
> For some platforms, a poll state is inserted in the cpuidle driver st=
ates.
> The flags for the state do not indicate that timekeeping is not affec=
ted.
> As the state does not do anything apart from calling cpu_relax(), the
> times returned by ktime_get should remain valid. Add the missing flag=
=2E

Yes, but it is done with the interrupt enabled, so the interrupt handle=
r=20
+ softirq handler times will be accounted in the residency time.

I am not sure adding this flag is good.

> Signed-off-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
> ---
>   drivers/cpuidle/driver.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 06dbe7c..136d6a2 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -209,7 +209,7 @@ static void poll_idle_init(struct cpuidle_driver =
*drv)
>   	state->exit_latency =3D 0;
>   	state->target_residency =3D 0;
>   	state->power_usage =3D -1;
> -	state->flags =3D 0;
> +	state->flags =3D CPUIDLE_FLAG_TIME_VALID;
>   	state->enter =3D poll_idle;
>   	state->disabled =3D false;
>   }
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
