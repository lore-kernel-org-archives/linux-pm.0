From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv3 13/16] cpuidle: mvebu: add Armada 38x support
Date: Thu, 24 Jul 2014 11:17:37 +0200
Message-ID: <53D0CF31.8000607@linaro.org>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com> <1406120453-29291-14-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:44271 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbaGXJRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 05:17:40 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so2396575wes.37
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2014 02:17:37 -0700 (PDT)
In-Reply-To: <1406120453-29291-14-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 07/23/2014 03:00 PM, Thomas Petazzoni wrote:
> This commit adds the list of cpuidle states supported by the Armada
> 38x SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logi=
c
> around it to support this SoC.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 29 +++++++++++++++++++++++++++=
+-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpu=
idle-mvebu-v7.c
> index d23597f..45371bb 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -1,5 +1,5 @@
>   /*
> - * Marvell Armada 370 and Armada XP SoC cpuidle driver
> + * Marvell Armada 370, 38x and XP SoC cpuidle driver
>    *
>    * Copyright (C) 2014 Marvell
>    *
> @@ -86,6 +86,21 @@ static struct cpuidle_driver armada370_idle_driver=
 =3D {
>   	.state_count =3D 2,
>   };
>
> +static struct cpuidle_driver armada38x_idle_driver =3D {
> +	.name			=3D "armada_38x_idle",
> +	.states[0]		=3D ARM_CPUIDLE_WFI_STATE,
> +	.states[1]		=3D {
> +		.enter			=3D mvebu_v7_enter_idle,
> +		.exit_latency		=3D 10,
> +		.power_usage		=3D 5,
> +		.target_residency	=3D 100,
> +		.flags			=3D CPUIDLE_FLAG_TIME_VALID,
> +		.name			=3D "Idle",
> +		.desc			=3D "CPU and SCU power down",
> +	},
> +	.state_count =3D 2,
> +};
> +
>   static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
>   {
>   	mvebu_v7_cpu_suspend =3D pdev->dev.platform_data;
> @@ -94,6 +109,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_=
device *pdev)
>   		return cpuidle_register(&armadaxp_idle_driver, NULL);
>   	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-370"))
>   		return cpuidle_register(&armada370_idle_driver, NULL);
> +	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-38x"))
> +		return cpuidle_register(&armada38x_idle_driver, NULL);
>   	else
>   		return -EINVAL;
>   }
> @@ -118,6 +135,16 @@ static struct platform_driver armada370_cpuidle_=
plat_driver =3D {
>
>   module_platform_driver(armada370_cpuidle_plat_driver);
>
> +static struct platform_driver armada38x_cpuidle_plat_driver =3D {
> +	.driver =3D {
> +		.name =3D "cpuidle-armada-38x",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D mvebu_v7_cpuidle_probe,
> +};
> +
> +module_platform_driver(armada38x_cpuidle_plat_driver);
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

