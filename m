From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 12/21] cpuidle: call cpuidle_get_driver() from after taking
 cpuidle_driver_lock
Date: Thu, 26 Sep 2013 00:04:39 +0200
Message-ID: <52435DF7.8040307@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <193825f6c2fb70462f6da2cc60e7c6c02682d6c5.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <193825f6c2fb70462f6da2cc60e7c6c02682d6c5.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> cpuidle_driver_lock is taken correctly at most of the places but at f=
ew places
> calls to cpuidle_get_driver() are done from outside of this lock.
>=20
> Fix them by calling cpuidle_get_driver() after taking cpuidle_driver_=
lock.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/driver.c | 3 ++-
>  drivers/cpuidle/sysfs.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 6279e1c..7b2510a 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -340,10 +340,11 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
>   */
>  void cpuidle_driver_unref(void)
>  {
> -	struct cpuidle_driver *drv =3D cpuidle_get_driver();
> +	struct cpuidle_driver *drv;
> =20
>  	spin_lock(&cpuidle_driver_lock);
> =20
> +	drv =3D cpuidle_get_driver();
>  	if (drv && !WARN_ON(drv->refcnt <=3D 0))
>  		drv->refcnt--;
> =20
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 8739cc0..a022393 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -52,9 +52,10 @@ static ssize_t show_current_driver(struct device *=
dev,
>  				   char *buf)
>  {
>  	ssize_t ret;
> -	struct cpuidle_driver *cpuidle_driver =3D cpuidle_get_driver();
> +	struct cpuidle_driver *cpuidle_driver;
> =20
>  	spin_lock(&cpuidle_driver_lock);
> +	cpuidle_driver =3D cpuidle_get_driver();
>  	if (cpuidle_driver)
>  		ret =3D sprintf(buf, "%s\n", cpuidle_driver->name);
>  	else
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
