From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 3 Jul 2017 09:53:23 +0100
Message-ID: <20170703085323.ph5drwiisjxmfhri@localhost.localdomain>
References: <cover.1499061617.git.baolin.wang@linaro.org>
 <dc4200357a69f0c0bca5404b9e1da8b486452731.1499061617.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38126 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752411AbdGCIyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 04:54:39 -0400
Content-Disposition: inline
In-Reply-To: <dc4200357a69f0c0bca5404b9e1da8b486452731.1499061617.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

On Mon, Jul 03, 2017 at 02:07:15PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
<snip>
>  /*********************************************************************
>   *		Battery properties
>   *********************************************************************/
> @@ -607,6 +647,22 @@ static int wm831x_power_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	power->usb_phy = devm_usb_get_phy_by_phandle(&pdev->dev,
> +						     "usb-phy", 0);
> +	if (IS_ERR(power->usb_phy)) {
> +		ret = PTR_ERR(power->usb_phy);
> +		dev_err(&pdev->dev, "Failed to find USB phy: %d\n", ret);
> +		goto err_bat_irq;
> +	}
> +

We should probably update the binding documentation for this as
well: mfd/wm831x.txt

Also I am not sure this needs to be implemented now, but what is
the plan regarding pdata systems? Generally the driver supports
both and it would be nice to know there is a way forward for that
even if we don't implement it yet.

Thanks,
Charles
