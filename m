From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: armada: add support for suspend/resume
Date: Fri, 19 Aug 2016 21:06:34 +0800
Message-ID: <1471611994.2691.72.camel@intel.com>
References: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754174AbcHSNGj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 09:06:39 -0400
In-Reply-To: <1469097807-17748-1-git-send-email-jaz@semihalf.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grzegorz Jaszczyk <jaz@semihalf.com>, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, ezequiel.garcia@free-electrons.com
Cc: mw@semihalf.com, alior@marvell.com

On 四, 2016-07-21 at 12:43 +0200, Grzegorz Jaszczyk wrote:
> There is no need to implement subroutine for suspend since there is
> no
> data to store before suspending.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>

Ezequiel,

what do you think of this patch?

thanks,
rui
> ---
>  drivers/thermal/armada_thermal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/thermal/armada_thermal.c
> b/drivers/thermal/armada_thermal.c
> index ae75328..65f9838 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -304,12 +304,26 @@ static int armada_thermal_exit(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> +static int armada_thermal_resume(struct device *dev)
> +{
> +	struct thermal_zone_device *thermal =
> +		dev_get_drvdata(dev);
> +	struct armada_thermal_priv *priv = thermal->devdata;
> +
> +	priv->data->init_sensor(to_platform_device(dev), priv);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(armada_thermal_pm_ops, NULL,
> armada_thermal_resume);
> +
>  static struct platform_driver armada_thermal_driver = {
>  	.probe = armada_thermal_probe,
>  	.remove = armada_thermal_exit,
>  	.driver = {
>  		.name = "armada_thermal",
>  		.of_match_table = armada_thermal_id_table,
> +		.pm = &armada_thermal_pm_ops,
>  	},
>  };
>  
