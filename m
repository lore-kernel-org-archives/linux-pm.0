From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 1/6] driver: cpuidle-big-little: add of_device_id structure
Date: Wed, 28 May 2014 10:58:32 +0200
Message-ID: <5385A538.8020504@linaro.org>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com> <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org> <1400227438-27155-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400227438-27155-2-git-send-email-chander.kashyap@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, tomasz.figa@gmail.com, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 05/16/2014 10:03 AM, Chander Kashyap wrote:
> This driver will be used by many big.Little Soc's. As of now it does
> string matching of hardcoded compatible string to init the driver. Th=
is
> comparison list will keep on growing with addition of new SoC's.
> Hence add of_device_id structure to collect the compatible strings of
> SoC's using this driver.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-big_little.c |   11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/c=
puidle-big_little.c
> index b45fc62..4cd02bd 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -163,14 +163,23 @@ static int __init bl_idle_driver_init(struct cp=
uidle_driver *drv, int cpu_id)
>   	return 0;
>   }
>
> +static const struct of_device_id compatible_machine_match[] =3D {
> +	{ .compatible =3D "arm,vexpress,v2p-ca15_a7" },
> +	{},
> +};
> +
>   static int __init bl_idle_init(void)
>   {
>   	int ret;
> +	struct device_node *root =3D of_find_node_by_path("/");
> +
> +	if (!root)
> +		return -ENODEV;
>
>   	/*
>   	 * Initialize the driver just for a compliant set of machines
>   	 */
> -	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
> +	if (!of_match_node(compatible_machine_match, root))
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
