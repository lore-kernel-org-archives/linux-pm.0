From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/2] thermal: of: Enable thermal_zoneX when sensor is
 correctly added
Date: Tue, 20 Jan 2015 18:26:09 +0000
Message-ID: <20150120182608.GA5760@e104805>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
 <1421667844-13627-3-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421667844-13627-3-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 19, 2015 at 11:44:04AM +0000, Lukasz Majewski wrote:
> Up till now the thermal_zone mode was by default "disabled". With this
> patch the default behavior was changed to "enable".
> 
> One can read the mode at:
> /sys/class/thermal/thermal_zone0/mode
> 
> Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

We are facing the same issue with Juno.  When registering thermal
zones from device tree they were coming up disabled.  I've tested it
on my Juno board and it fixes it.

Tested-by: Javi Merino <javi.merino@arm.com>

> ---
>  drivers/thermal/of-thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d717f3d..668fb1b 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -497,6 +497,9 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>  		if (sensor_specs.np == sensor_np && id == sensor_id) {
>  			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>  							 data, ops);
> +			if (!IS_ERR(tzd))
> +				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +
>  			of_node_put(sensor_specs.np);
>  			of_node_put(child);
>  			goto exit;
