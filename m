From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/7] drivers/cpuidle: Convert non-modular drivers to use
 builtin_driver_register
Date: Mon, 11 May 2015 19:13:07 +0200
Message-ID: <5550E323.1080800@linaro.org>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com> <1431287385-1526-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431287385-1526-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 05/10/2015 09:49 PM, Paul Gortmaker wrote:
> All these drivers are configured with Kconfig options that are
> declared as bool.  Hence it is not possible for the code
> to be built as modular.  However the code is currently using the
> module_platform_driver() macro for driver registration.
>
> While this currently works, we really don't want to be including
> the module.h header in non-modular code, which we'll be forced
> to do, pending some upcoming code relocation from init.h into
> module.h.  So we fix it now by using the non-modular equivalent.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Sounds reasonable.

   -- Daniel

> ---
>   drivers/cpuidle/cpuidle-at91.c    | 3 +--
>   drivers/cpuidle/cpuidle-calxeda.c | 3 +--
>   drivers/cpuidle/cpuidle-zynq.c    | 3 +--
>   3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-at91.c b/drivers/cpuidle/cpuidle=
-at91.c
> index f2446c78d87c..9c5853b6ca4a 100644
> --- a/drivers/cpuidle/cpuidle-at91.c
> +++ b/drivers/cpuidle/cpuidle-at91.c
> @@ -62,5 +62,4 @@ static struct platform_driver at91_cpuidle_driver =3D=
 {
>   	},
>   	.probe =3D at91_cpuidle_probe,
>   };
> -
> -module_platform_driver(at91_cpuidle_driver);
> +builtin_platform_driver(at91_cpuidle_driver);
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpui=
dle-calxeda.c
> index 9445e6cc02be..c13feec89ea1 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -75,5 +75,4 @@ static struct platform_driver calxeda_cpuidle_plat_=
driver =3D {
>           },
>           .probe =3D calxeda_cpuidle_probe,
>   };
> -
> -module_platform_driver(calxeda_cpuidle_plat_driver);
> +builtin_platform_driver(calxeda_cpuidle_plat_driver);
> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle=
-zynq.c
> index 543292b1d38e..6f4257fc56e5 100644
> --- a/drivers/cpuidle/cpuidle-zynq.c
> +++ b/drivers/cpuidle/cpuidle-zynq.c
> @@ -73,5 +73,4 @@ static struct platform_driver zynq_cpuidle_driver =3D=
 {
>   	},
>   	.probe =3D zynq_cpuidle_probe,
>   };
> -
> -module_platform_driver(zynq_cpuidle_driver);
> +builtin_platform_driver(zynq_cpuidle_driver);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
