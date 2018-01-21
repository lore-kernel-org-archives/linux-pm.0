From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 03/16] iio: adc: axp20x_adc: make it possible to
 probe from DT
Date: Sun, 21 Jan 2018 12:22:52 +0000
Message-ID: <20180121122252.5f0c1741@archlinux>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
        <063c68ec080a999e10bf33e417c974142ddaaf9a.1516012352.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbeAUMW6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Jan 2018 07:22:58 -0500
In-Reply-To: <063c68ec080a999e10bf33e417c974142ddaaf9a.1516012352.git-series.quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com, julian.calaby@gmail.com

On Mon, 15 Jan 2018 11:33:37 +0100
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> To prepare for a future patch that will add a DT node for the ADC, make
> axp20x_adc able to probe from DT and get the per-variant data from
> of_device_id.data since platform_device_id.driver_data won't be set when
> probing by DT.
> 
> Leave the ability to probe via platform for driver compatibility with
> old DTs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Looks good to me. 

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

If anyone wants to comment I won't be pushing out in a non rebasing form
until at least next weekend.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 3fc1b06..3968053 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -515,6 +515,13 @@ static const struct axp_data axp22x_data = {
>  	.maps = axp22x_maps,
>  };
>  
> +static const struct of_device_id axp20x_adc_of_match[] = {
> +	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
> +	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
> +
>  static const struct platform_device_id axp20x_adc_id_match[] = {
>  	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
>  	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> @@ -543,7 +550,16 @@ static int axp20x_probe(struct platform_device *pdev)
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
> +	if (!pdev->dev.of_node) {
> +		const struct platform_device_id *id;
> +
> +		id = platform_get_device_id(pdev);
> +		info->data = (struct axp_data *)id->driver_data;
> +	} else {
> +		struct device *dev = &pdev->dev;
> +
> +		info->data = (struct axp_data *)of_device_get_match_data(dev);
> +	}
>  
>  	indio_dev->name = platform_get_device_id(pdev)->name;
>  	indio_dev->info = info->data->iio_info;
> @@ -606,6 +622,7 @@ static int axp20x_remove(struct platform_device *pdev)
>  static struct platform_driver axp20x_adc_driver = {
>  	.driver = {
>  		.name = "axp20x-adc",
> +		.of_match_table = of_match_ptr(axp20x_adc_of_match),
>  	},
>  	.id_table = axp20x_adc_id_match,
>  	.probe = axp20x_probe,
