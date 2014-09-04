From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/4] thermal: rockchip: add driver for thermal
Date: Thu, 4 Sep 2014 10:06:00 -0700
Message-ID: <20140904170559.GB10224@core.coreip.homeip.net>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

On Wed, Sep 03, 2014 at 10:10:36AM +0800, Caesar Wang wrote:
> +static int rockchip_thermal_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_thermal_data *data = platform_get_drvdata(pdev);
> +
> +	rockchip_thermal_control(data, false);
> +
> +	thermal_zone_device_unregister(data->tz);
> +	cpufreq_cooling_unregister(data->cdev);
> +	cpufreq_cooling_unregister(data->cdev);

It looks like we are unregistering the same cooling device one too many times.

Thanks.

-- 
Dmitry
