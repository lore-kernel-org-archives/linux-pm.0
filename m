From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 08/21] cpuidle: use cpuidle_disabled() instead of "off"
Date: Wed, 25 Sep 2013 23:52:05 +0200
Message-ID: <52435B05.9030201@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <19979ce88726285c72dd6fe3d7b370d53669443c.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19979ce88726285c72dd6fe3d7b370d53669443c.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> We have a routine for getting value of "off", better call that instea=
d of using
> "off" directly.

We are in the fast path, I am not sure invoking a function here is
better than using directly the static variable.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8c91bad..aec9029 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -119,7 +119,7 @@ int cpuidle_idle_call(void)
>  	struct cpuidle_driver *drv;
>  	int next_state, entered_state;
> =20
> -	if (off)
> +	if (cpuidle_disabled())
>  		return -ENODEV;
> =20
>  	if (!initialized)
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
