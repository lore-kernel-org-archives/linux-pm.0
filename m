From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] driver: cpuidle: cpuidle-big-little: init driver
 for Exynos5420
Date: Tue, 22 Apr 2014 12:39:29 +0200
Message-ID: <535646E1.80205@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org> <1398080958-21677-3-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398080958-21677-3-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <k.chander@samsung.org>
List-Id: linux-pm@vger.kernel.org

On 04/21/2014 01:49 PM, Chander Kashyap wrote:
> Add "samsung,exynos5420" compatible string to initialize generic
> big-little cpuidle driver for Exynos5420.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.org>
> ---

To be migrated to platform_driver but until that:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>   drivers/cpuidle/cpuidle-big_little.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> index b45fc62..d0fac53 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -170,7 +170,8 @@ static int __init bl_idle_init(void)
>   	/*
>   	 * Initialize the driver just for a compliant set of machines
>   	 */
> -	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
> +	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7") &&
> +		(!of_machine_is_compatible("samsung,exynos5420")))
>   		return -ENODEV;
>   	/*
>   	 * For now the differentiation between little and big cores
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
