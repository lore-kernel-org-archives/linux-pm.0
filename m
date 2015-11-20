From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH] PM / Domains: Allow runtime PM callbacks to be re-used
 during system PM
Date: Fri, 20 Nov 2015 14:17:50 +0900
Message-ID: <564EACFE.5030408@jinso.co.jp>
References: <1447778561-9767-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www1246.sakura.ne.jp ([219.94.162.56]:15138 "EHLO
	www1246.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbKTFRy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2015 00:17:54 -0500
In-Reply-To: <1447778561-9767-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Harunaga <nx-truong@jinso.co.jp>

Hi Ulf Hansson
Thanks for your fixed patch!

We have just patched and tested this patch on upstream v4.4-rc1 again.

Results:
The problem related Runtime PM has disappeared.
PM driver works well without any problems.

Thanks you and best regards.
Jinso/Cao Minh Hiep.


On 2015=E5=B9=B411=E6=9C=8818=E6=97=A5 01:42, Ulf Hansson wrote:
> Runtime PM centric subsystems/drivers may re-use their runtime PM
> callbacks for system PM. Typically that's done via using the runtime =
PM
> helpers, pm_runtime_force_suspend|resume().
>
> To genpd, this means its runtime PM callbacks may be invoked even whe=
n
> runtime PM has been disabled for the device. By checking this conditi=
on,
> it allows genpd to skip latency validation and measurement in the sys=
tem
> PM path. That's needed to enable drivers/subsystems to re-use the run=
time
> PM callbacks for system PM.
>
> Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from t=
he
> power off sequence")
> Reported-by: Cao Minh Hiep<cm-hiep@jinso.co.jp>
> Reported-by: Harunaga<nx-truong@jinso.co.jp>
> Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
> ---
>
> This patch has only been quick tested on ux500, so further tests are
> welcome and needed. It was reported [1] to point out a certain commit
> causing the regression, but further analyze actually tells that the
> problem been there longer.
>
> So, I decided to point the fixes tag to a commit from where it actual=
ly
> becomes quite simple to address the problem. Earlier than that, is ju=
st
> not worth the effort.
>
> [1]
> https://lkml.org/lkml/2015/11/16/748
>
> ---
>   drivers/base/power/domain.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.=
c
> index e03b1ad..8f0c2a3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -390,6 +390,7 @@ static int pm_genpd_runtime_suspend(struct device=
 *dev)
>   	struct generic_pm_domain *genpd;
>   	bool (*stop_ok)(struct device *__dev);
>   	struct gpd_timing_data *td =3D &dev_gpd_data(dev)->td;
> +	bool system_pm =3D !pm_runtime_enabled(dev);
>   	ktime_t time_start;
>   	s64 elapsed_ns;
>   	int ret;
> @@ -400,12 +401,18 @@ static int pm_genpd_runtime_suspend(struct devi=
ce *dev)
>   	if (IS_ERR(genpd))
>   		return -EINVAL;
>  =20
> +	/*
> +	 * A runtime PM centric subsystem/driver may re-use the runtime PM
> +	 * callbacks for system PM. In these cases, don't validate or measu=
re
> +	 * latencies.
> +	 */
>   	stop_ok =3D genpd->gov ? genpd->gov->stop_ok : NULL;
> -	if (stop_ok && !stop_ok(dev))
> +	if (!system_pm && stop_ok && !stop_ok(dev))
>   		return -EBUSY;
>  =20
>   	/* Measure suspend latency. */
> -	time_start =3D ktime_get();
> +	if (!system_pm)
> +		time_start =3D ktime_get();
>  =20
>   	ret =3D genpd_save_dev(genpd, dev);
>   	if (ret)
> @@ -417,6 +424,10 @@ static int pm_genpd_runtime_suspend(struct devic=
e *dev)
>   		return ret;
>   	}
>  =20
> +	/* Don't try poweroff in system PM as it's prevented anyway. */
> +	if (system_pm)
> +		return 0;
> +
>   	/* Update suspend latency value if the measured time exceeds it. *=
/
>   	elapsed_ns =3D ktime_to_ns(ktime_sub(ktime_get(), time_start));
>   	if (elapsed_ns > td->suspend_latency_ns) {
> @@ -453,6 +464,7 @@ static int pm_genpd_runtime_resume(struct device =
*dev)
>   {
>   	struct generic_pm_domain *genpd;
>   	struct gpd_timing_data *td =3D &dev_gpd_data(dev)->td;
> +	bool system_pm =3D !pm_runtime_enabled(dev);
>   	ktime_t time_start;
>   	s64 elapsed_ns;
>   	int ret;
> @@ -464,8 +476,8 @@ static int pm_genpd_runtime_resume(struct device =
*dev)
>   	if (IS_ERR(genpd))
>   		return -EINVAL;
>  =20
> -	/* If power.irq_safe, the PM domain is never powered off. */
> -	if (dev->power.irq_safe) {
> +	/* If power.irq_safe or system PM, the PM domain remains powered. *=
/
> +	if (dev->power.irq_safe || system_pm) {
>   		timed =3D false;
>   		goto out;
>   	}
> -- 1.9.1

