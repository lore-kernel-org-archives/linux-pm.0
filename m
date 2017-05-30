From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/7] thermal: max77620: fix device-node reference
 imbalance
Date: Tue, 30 May 2017 15:59:10 -0700
Message-ID: <41a7b947-579f-e9ba-188d-699e7ff0b27d@linux.vnet.ibm.com>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-7-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530162554.26159-7-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 05/30/2017 09:25 AM, Johan Hovold wrote:
> The thermal child device reuses the parent MFD-device device-tree node
> when registering a thermal zone, but did not take a reference to the
> node.
> 
> This leads to a reference imbalance, and potential use-after-free, when
> the node reference is dropped by the platform-bus device destructor
> (once for the child and later again for the parent).
> 
> Fix this by dropping any reference already held to a device-tree node
> and getting a reference to the parent's node which will be balanced on
> reprobe or on platform-device release, whichever comes first.
> 
> Note that simply clearing the of_node pointer on probe errors and on
> driver unbind would not allow the use of device-managed resources as
> specifically thermal_zone_of_sensor_unregister() claims that a valid
> device-tree node pointer is needed during deregistration (even if it
> currently does not seem to use it).
> 
> Fixes: ec4664b3fd6d ("thermal: max77620: Add thermal driver for reporting junction temp")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/thermal/max77620_thermal.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
> index e9a1fe342760..71d35f3c9215 100644
> --- a/drivers/thermal/max77620_thermal.c
> +++ b/drivers/thermal/max77620_thermal.c
> @@ -104,8 +104,6 @@ static int max77620_thermal_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	pdev->dev.of_node = pdev->dev.parent->of_node;
> -
>  	mtherm->dev = &pdev->dev;
>  	mtherm->rmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!mtherm->rmap) {
> @@ -113,6 +111,14 @@ static int max77620_thermal_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Drop any current reference to a device-tree node and get a
> +	 * reference to the parent's node which will be balanced on reprobe or
> +	 * on platform-device release.
> +	 */
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node = of_node_get(pdev->dev.parent->of_node);
> +

This seems like needless churn. Can't this just be squashed into patch #7?

-Tyrel

>  	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
>  				mtherm, &max77620_thermal_ops);
>  	if (IS_ERR(mtherm->tz_device)) {
> 
