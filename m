From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/9] ARM: EXYNOS: cpuidle: fix AFTR mode check
Date: Fri, 20 Dec 2013 22:16:12 +0100
Message-ID: <52B4B39C.2010202@linaro.org>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com> <1387565251-7051-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387565251-7051-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 12/20/2013 07:47 PM, Bartlomiej Zolnierkiewicz wrote:
> The EXYNOS cpuidle driver code assumes that cpuidle core will handle
> dev->state_count smaller than drv->state_count but currently this is
> untrue (dev->state_count is used only for handling cpuidle state sysf=
s
> entries and drv->state_count is used for all other cases) and will no=
t
> be fixed in the future as dev->state_count is planned to be removed.
>
> Fix the issue by checking for the max supported idle state in AFTR
> state's ->enter handler (exynos4_enter_lowpower()) and entering AFTR
> mode only when cores other than CPU0 are offline.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>   arch/arm/mach-exynos/cpuidle.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cp=
uidle.c
> index da65b03..f57cb91 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -172,8 +172,8 @@ static int exynos4_enter_lowpower(struct cpuidle_=
device *dev,
>   {
>   	int new_index =3D index;
>
> -	/* This mode only can be entered when other core's are offline */
> -	if (num_online_cpus() > 1)
> +	/* AFTR can only be entered when cores other than CPU0 are offline =
*/
> +	if (num_online_cpus() > 1 || dev->cpu !=3D 0)
>   		new_index =3D drv->safe_state_index;
>
>   	if (new_index =3D=3D 0)
> @@ -235,10 +235,6 @@ static int exynos_cpuidle_probe(struct platform_=
device *pdev)
>   		device =3D &per_cpu(exynos4_cpuidle_device, cpu_id);
>   		device->cpu =3D cpu_id;
>
> -		/* Support IDLE only */
> -		if (cpu_id !=3D 0)
> -			device->state_count =3D 1;
> -
>   		ret =3D cpuidle_register_device(device);
>   		if (ret) {
>   			dev_err(&pdev->dev, "failed to register cpuidle device\n");
>

Hi Bartlomiej,

thanks for this cleanup. May be you can also add another patch to switc=
h=20
to the generic cpuidle_register function ?

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
