From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for PX30
Date: Tue, 15 May 2018 11:49:10 +0200
Message-ID: <7587293.TUNouLJ331@phil>
References: <1526376217-3833-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526376217-3833-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: khilman@baylibre.com, rafael.j.wysocki@intel.com, nm@ti.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi David,

looks good overall, some small things below.

Am Dienstag, 15. Mai 2018, 11:23:37 CEST schrieb David Wu:
> This adds the necessary data for handling io voltage domains on PX30.
> As interesting tidbit, the PX30 contains two separate iodomain areas.
> One in the regular General Register Files (GRF) and one in PMUGRF in the
> pmu power domain.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../bindings/power/rockchip-io-domain.txt          |  2 +
>  drivers/power/avs/rockchip-io-domain.c             | 68 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> index 4a4766e..c2595ba 100644
> --- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> +++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> @@ -31,6 +31,8 @@ SoC is on the same page.
>  
>  Required properties:
>  - compatible: should be one of:
> +  - "rockchip,px30-io-voltage-domain" for px30
> +  - "rockchip,px30-pmu-io-voltage-domain" for px30 pmu-domains
>    - "rockchip,rk3188-io-voltage-domain" for rk3188
>    - "rockchip,rk3228-io-voltage-domain" for rk3228
>    - "rockchip,rk3288-io-voltage-domain" for rk3288

please also define the px30-specific supply names as can be seen in that
file for the other socs.

Also, please include devicetree maintainers, when modifying
binding documents.


> +static const struct rockchip_iodomain_soc_data soc_data_px30 = {
> +	.grf_offset = 0x180,
> +	.supply_names = {
> +		NULL,
> +		"vccio6",
> +		"vccio1",
> +		"vccio2",
> +		"vccio3",
> +		"vccio4",
> +		"vccio5",
> +		"vccio_oscgpi",

vccio-oscgpi ... aka with a "-" instead of "_"

With the above fixed
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko
