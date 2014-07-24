From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv3 12/16] cpuidle: mvebu: add Armada 370 support
Date: Thu, 24 Jul 2014 11:17:09 +0200
Message-ID: <53D0CF15.2010703@linaro.org>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com> <1406120453-29291-13-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44386 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaGXJRK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 05:17:10 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so9285300wiv.7
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2014 02:17:08 -0700 (PDT)
In-Reply-To: <1406120453-29291-13-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/23/2014 03:00 PM, Thomas Petazzoni wrote:
> This commit adds the list of cpuidle states supported by the Armada
> 370 SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logi=
c
> around it to support this SoC.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 35 +++++++++++++++++++++++++++=
++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpu=
idle-mvebu-v7.c
> index 7252fd8..d23597f 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -70,11 +70,32 @@ static struct cpuidle_driver armadaxp_idle_driver=
 =3D {
>   	.state_count =3D 3,
>   };
>
> +static struct cpuidle_driver armada370_idle_driver =3D {
> +	.name			=3D "armada_370_idle",
> +	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		=3D {
> +		.enter			=3D mvebu_v7_enter_idle,
> +		.exit_latency		=3D 100,
> +		.power_usage		=3D 5,
> +		.target_residency	=3D 1000,
> +		.flags			=3D (CPUIDLE_FLAG_TIME_VALID |
> +					   MVEBU_V7_FLAG_DEEP_IDLE),
> +		.name			=3D "Deep Idle",
> +		.desc			=3D "CPU and L2 Fabric power down",
> +	},
> +	.state_count =3D 2,
> +};
> +
>   static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   {
> -
>   	mvebu_v7_cpu_suspend =3D pdev->dev.platform_data;
> -	return cpuidle_register(&armadaxp_idle_driver, NULL);
> +
> +	if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-xp"))
> +		return cpuidle_register(&armadaxp_idle_driver, NULL);
> +	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-370"))
> +		return cpuidle_register(&armada370_idle_driver, NULL);
> +	else
> +		return -EINVAL;
>   }
>
>   static struct platform_driver armadaxp_cpuidle_plat_driver =3D {
> @@ -87,6 +108,16 @@ static struct platform_driver armadaxp_cpuidle_pl=
at_driver =3D {
>
>   module_platform_driver(armadaxp_cpuidle_plat_driver);
>
> +static struct platform_driver armada370_cpuidle_plat_driver =3D {
> +	.driver =3D {
> +		.name =3D "cpuidle-armada-370",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D mvebu_v7_cpuidle_probe,
> +};
> +
> +module_platform_driver(armada370_cpuidle_plat_driver);
> +
>   MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>=
");
>   MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
>   MODULE_LICENSE("GPL");
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

