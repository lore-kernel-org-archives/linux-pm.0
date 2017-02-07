From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal - Fix possible NULL derefrence.
Date: Tue, 07 Feb 2017 11:30:13 +0800
Message-ID: <1486438213.2645.1.camel@intel.com>
References: <CGME20170130050525epcas1p3686ebf52f0215eef64a358338843305d@epcas1p3.samsung.com>
         <1485752698-30248-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34829 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdBGDaS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Feb 2017 22:30:18 -0500
In-Reply-To: <1485752698-30248-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>

Just one comment,
the subject should be 
[PATCH] Thermal: imx_thermal : Fix possible NULL derefrence

On Mon, 2017-01-30 at 10:34 +0530, Shailendra Verma wrote:
> of_device_get_match_data could return NULL, and so can cause
> a NULL pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>

I think Eduardo will take this patch.

thanks,
rui
> ---
>  drivers/thermal/imx_thermal.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/imx_thermal.c
> b/drivers/thermal/imx_thermal.c
> index 06912f0..fb648a4 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -489,6 +489,10 @@ static int imx_thermal_probe(struct
> platform_device *pdev)
>  	data->tempmon = map;
>  
>  	data->socdata = of_device_get_match_data(&pdev->dev);
> +	if (!data->socdata) {
> +		dev_err(&pdev->dev, "no device match found\n");
> +		return -ENODEV;
> +	}
>  
>  	/* make sure the IRQ flag is clear before enabling irq on
> i.MX6SX */
>  	if (data->socdata->version == TEMPMON_IMX6SX) {
