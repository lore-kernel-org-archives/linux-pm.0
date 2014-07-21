From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] cpuidle: exynos: Allow to use the driver without
 AFTR
Date: Mon, 21 Jul 2014 11:53:32 +0200
Message-ID: <53CCE31C.90300@linaro.org>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sachin Kamat <sachin.kamat@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 07/21/2014 10:36 AM, Krzysztof Kozlowski wrote:
> Allow the driver to be used when AFTR enter function is not provided
> (device platform data is NULL).
>
> This actually does not give any special energy-saving benefits but
> allows to track the idle time of each core. Additionally it is a safe
> way to validate supplied platform data.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I think we already talk about this in the mailing list several times.
It does not make sense to enable the cpuidle driver for WFI just for th=
e=20
sake of tracking via sysfs some idle timings.

Using the cpuidle driver means using the underlying cpuidle=20
infrastructure with all the stats computation in the governor.

If there is a *real* need of a WFI cpuidle driver, then a generic WFI=20
cpuidle driver could be implemented to supersede this one.

It took a while to cleanup this driver and remove all the hacks around=20
this AFTR state... :)



> ---
>   drivers/cpuidle/cpuidle-exynos.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuid=
le-exynos.c
> index 7c0151263828..5325a394be7e 100644
> --- a/drivers/cpuidle/cpuidle-exynos.c
> +++ b/drivers/cpuidle/cpuidle-exynos.c
> @@ -77,7 +77,10 @@ static int exynos_cpuidle_probe(struct platform_de=
vice *pdev)
>   {
>   	int ret;
>
> +	/* If NULL enter only WFI */
>   	exynos_enter_aftr =3D (void *)(pdev->dev.platform_data);
> +	if (!exynos_enter_aftr)
> +		exynos_idle_driver.state_count =3D 1;
>
>   	ret =3D cpuidle_register(&exynos_idle_driver, NULL);
>   	if (ret) {
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
