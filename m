From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH-REPOST] thermal: of: look for sensor driver parent node
 if device node missing
Date: Fri, 25 Jul 2014 10:30:36 +0100
Message-ID: <20140725093036.GB2865@e104805>
References: <1406279971-14957-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57405 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaGYJaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 05:30:39 -0400
In-Reply-To: <1406279971-14957-1-git-send-email-ldewangan@nvidia.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[Fixed Eduardo's email *again*]

On Fri, Jul 25, 2014 at 10:19:31AM +0100, Laxman Dewangan wrote:
> There are some mfd devices which supports junction thermal interrupt
> like ams,AS3722. The DT binding of these devices are defined as the
> flat and drivers for sub module of such devices are registered as
> the mfd_add_devices. In this method, the sub devices registered as
> platform driver and these do not have the of_node pointer on their
> device structure. In this case, use the parent of_node pointer to
> get the required of_node pointer.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> I typed differnet email ID for Eduardo and so it did not reach to him.
> Resending the patch with correct ID.
> 
>  drivers/thermal/of-thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7..85a7d71 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -396,6 +396,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
>  		return ERR_PTR(-EINVAL);
>  
>  	sensor_np = dev->of_node;
> +	if (!sensor_np && dev->parent)
> +		sensor_np = dev->parent->of_node;
>  
>  	for_each_child_of_node(np, child) {
>  		struct of_phandle_args sensor_specs;
> -- 
> 1.8.1.5
> 
> 

