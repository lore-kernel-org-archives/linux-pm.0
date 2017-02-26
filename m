From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [RESEND PATCH] PM / AVS: rockchip-io: add io selectors and
 supplies for rk3328
Date: Sun, 26 Feb 2017 13:48:40 -0800
Message-ID: <m2innw39on.fsf@baylibre.com>
References: <1487853191-10994-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1487853191-10994-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
 (David Wu's message of "Thu, 23 Feb 2017 20:33:11 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> writes:

> From: "david.wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> This adds the necessary data for handling io voltage domains on the rk3328.
> As interesting tidbit, the rk3328 only contains one iodomain area in the
> regular General Register Files (GRF).
>
> Signed-off-by: david.wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Reviewed-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Rafael, feel free to take directly.  I don't currently have any other
AVS stuff in the queue.

Kevin

> ---
>  .../bindings/power/rockchip-io-domain.txt          |  1 +
>  drivers/power/avs/rockchip-io-domain.c             | 41 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> index d23dc00..d3a5a93 100644
> --- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> +++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> @@ -33,6 +33,7 @@ Required properties:
>  - compatible: should be one of:
>    - "rockchip,rk3188-io-voltage-domain" for rk3188
>    - "rockchip,rk3288-io-voltage-domain" for rk3288
> +  - "rockchip,rk3328-io-voltage-domain" for rk3328
>    - "rockchip,rk3368-io-voltage-domain" for rk3368
>    - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
>    - "rockchip,rk3399-io-voltage-domain" for rk3399
> diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
> index 56bce19..8581252 100644
> --- a/drivers/power/avs/rockchip-io-domain.c
> +++ b/drivers/power/avs/rockchip-io-domain.c
> @@ -43,6 +43,10 @@
>  #define RK3288_SOC_CON2_FLASH0		BIT(7)
>  #define RK3288_SOC_FLASH_SUPPLY_NUM	2
>  
> +#define RK3328_SOC_CON4			0x410
> +#define RK3328_SOC_CON4_VCCIO2		BIT(7)
> +#define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
> +
>  #define RK3368_SOC_CON15		0x43c
>  #define RK3368_SOC_CON15_FLASH0		BIT(14)
>  #define RK3368_SOC_FLASH_SUPPLY_NUM	2
> @@ -166,6 +170,25 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
>  		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>  }
>  
> +static void rk3328_iodomain_init(struct rockchip_iodomain *iod)
> +{
> +	int ret;
> +	u32 val;
> +
> +	/* if no vccio2 supply we should leave things alone */
> +	if (!iod->supplies[RK3328_SOC_VCCIO2_SUPPLY_NUM].reg)
> +		return;
> +
> +	/*
> +	 * set vccio2 iodomain to also use this framework
> +	 * instead of a special gpio.
> +	 */
> +	val = RK3328_SOC_CON4_VCCIO2 | (RK3328_SOC_CON4_VCCIO2 << 16);
> +	ret = regmap_write(iod->grf, RK3328_SOC_CON4, val);
> +	if (ret < 0)
> +		dev_warn(iod->dev, "couldn't update vccio2 vsel ctrl\n");
> +}
> +
>  static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
>  {
>  	int ret;
> @@ -247,6 +270,20 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
>  	.init = rk3288_iodomain_init,
>  };
>  
> +static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
> +	.grf_offset = 0x410,
> +	.supply_names = {
> +		"vccio1",
> +		"vccio2",
> +		"vccio3",
> +		"vccio4",
> +		"vccio5",
> +		"vccio6",
> +		"pmuio",
> +	},
> +	.init = rk3328_iodomain_init,
> +};
> +
>  static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
>  	.grf_offset = 0x900,
>  	.supply_names = {
> @@ -312,6 +349,10 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
>  		.data = (void *)&soc_data_rk3288
>  	},
>  	{
> +		.compatible = "rockchip,rk3328-io-voltage-domain",
> +		.data = (void *)&soc_data_rk3328
> +	},
> +	{
>  		.compatible = "rockchip,rk3368-io-voltage-domain",
>  		.data = (void *)&soc_data_rk3368
>  	},
