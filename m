From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 09/11] ARM: mvebu: Register notifier callback for the
 cpuidle transition
Date: Thu, 03 Apr 2014 10:18:20 +0200
Message-ID: <533D194C.6020700@linaro.org>
References: <1396005211-15573-1-git-send-email-gregory.clement@free-electrons.com> <1396005211-15573-10-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396005211-15573-10-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/28/2014 12:13 PM, Gregory CLEMENT wrote:
> In order to have well encapsulated code, we use notifier callbacks fo=
r
> CPU_PM_ENTER and CPU_PM_EXIT inside the mvebu power management code.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-mvebu/pmsu.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 968c8c02c126..9ea2bb44d573 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -18,6 +18,7 @@
>
>   #define pr_fmt(fmt) "mvebu-pmsu: " fmt
>
> +#include <linux/cpu_pm.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
>   #include <linux/of_address.h>
> @@ -263,4 +264,21 @@ static noinline void armada_370_xp_pmsu_idle_res=
tore(void)
>   	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
>   }
>
> +static int armada_370_xp_cpu_pm_notify(struct notifier_block *self,
> +				    unsigned long action, void *hcpu)
> +{
> +	if (action =3D=3D CPU_PM_ENTER) {
> +		unsigned int hw_cpu =3D cpu_logical_map(smp_processor_id());
> +		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
> +	} else if (action =3D=3D CPU_PM_EXIT) {
> +		armada_370_xp_pmsu_idle_restore();
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block armada_370_xp_cpu_pm_notifier =3D {
> +	.notifier_call =3D armada_370_xp_cpu_pm_notify,
> +};
> +
>   early_initcall(armada_370_xp_pmsu_init);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
