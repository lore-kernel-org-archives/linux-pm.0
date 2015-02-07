From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RFT PATCH 2/4] compal-laptop: Check return value of
 power_supply_register
Date: Fri, 6 Feb 2015 18:42:45 -0800
Message-ID: <20150207024245.GB36295@fury.dvhart.com>
References: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
 <1422358221-13199-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422358221-13199-3-git-send-email-k.kozlowski@samsung.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 27, 2015 at 12:30:19PM +0100, Krzysztof Kozlowski wrote:
> The return value of power_supply_register() call was not checked and
> even on error probe() function returned 0. If registering failed then
> during unbind the driver tried to unregister power supply which was not
> actually registered.
> 
> This could lead to memory corruption because power_supply_unregister()
> unconditionally cleans up given power supply.
> 
> Fix this by checking return status of power_supply_register() call. In
> case of failure, unregister the hwmon device and fail the probe. Add a
> fixme note about missing hwmon_device_unregister() in driver removal.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 9be0fcb5ed46 ("compal-laptop: add JHL90, battery & hwmon interface")
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/platform/x86/compal-laptop.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
> index 15c0fab2bfa1..cf55a9246f12 100644
> --- a/drivers/platform/x86/compal-laptop.c
> +++ b/drivers/platform/x86/compal-laptop.c
> @@ -1036,12 +1036,16 @@ static int compal_probe(struct platform_device *pdev)
>  
>  	/* Power supply */
>  	initialize_power_supply_data(data);
> -	power_supply_register(&compal_device->dev, &data->psy);
> +	err = power_supply_register(&compal_device->dev, &data->psy);
> +	if (err < 0)
> +		goto psy_err;
>  
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
>  
> +psy_err:
> +	hwmon_device_unregister(hwmon_dev);
>  remove:
>  	sysfs_remove_group(&pdev->dev.kobj, &compal_platform_attr_group);
>  	return err;
> @@ -1072,6 +1076,7 @@ static int compal_remove(struct platform_device *pdev)
>  
>  	data = platform_get_drvdata(pdev);
>  	power_supply_unregister(&data->psy);
> +	/* FIXME: missing hwmon_device_unregister() */

Is this FIXME a leftover? Is there a reason we can't fix this now instead of
adding a FIXME?

-- 
Darren Hart
Intel Open Source Technology Center
