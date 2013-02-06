From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 7/7] thermal: rcar: add Device Tree support
Date: Wed, 06 Feb 2013 13:37:27 +0800
Message-ID: <1360129047.2982.28.camel@rzhang1-mobl4>
References: <87y5f9pvxv.wl%kuninori.morimoto.gx@renesas.com>
	 <87obg5pvsd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30627 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab3BFFhb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 00:37:31 -0500
In-Reply-To: <87obg5pvsd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Thu, 2013-01-31 at 01:05 -0800, Kuninori Morimoto wrote:
> Support for loading the Renesas R-Car thermal module via devicetree.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |   29 ++++++++++++++++++++
>  drivers/thermal/rcar_thermal.c                     |    7 +++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> new file mode 100644
> index 0000000..28ef498
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -0,0 +1,29 @@
> +* Renesas R-Car Thermal
> +
> +Required properties:
> +- compatible		: "renesas,rcar-thermal"
> +- reg			: Address range of the thermal registers.
> +			  The 1st reg will be recognized as common register
> +			  if it has "interrupts".
> +
> +Option properties:
> +
> +- interrupts		: use interrupt
> +
> +Example (non interrupt support):
> +
> +thermal@e61f0100 {
> +	compatible = "renesas,rcar-thermal";
> +	reg = <0xe61f0100 0x38>;
> +};
> +
> +Example (interrupt support):
> +
> +thermal@e61f0000 {
> +	compatible = "renesas,rcar-thermal";
> +	reg = <0xe61f0000 0x14
> +		0xe61f0100 0x38
> +		0xe61f0200 0x38
> +		0xe61f0300 0x38>;
> +	interrupts = <0 69 4>;
> +};
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 80aae3c..3bd8918 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -477,9 +477,16 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id rcar_thermal_dt_ids[] __devinitconst = {
> +	{ .compatible = "renesas,rcar-thermal", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
> +
you do not need 
#ifdef CONFIG_OF
here?

thanks,
rui
>  static struct platform_driver rcar_thermal_driver = {
>  	.driver	= {
>  		.name	= "rcar_thermal",
> +		.of_match_table = rcar_thermal_dt_ids,
>  	},
>  	.probe		= rcar_thermal_probe,
>  	.remove		= rcar_thermal_remove,


