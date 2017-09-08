From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V2] thermal/drivers/generic-iio-adc: Switch tz request
 to devm version
Date: Fri, 8 Sep 2017 12:43:34 +0530
Message-ID: <59B2431E.3050706@nvidia.com>
References: <20170908025606.GA2755@localhost.localdomain> <1504854117-18392-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504854117-18392-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Friday 08 September 2017 12:31 PM, Daniel Lezcano wrote:
> Everything mentionned here:
>   https://lkml.org/lkml/2016/4/20/850
>
> This driver was added before the devm_iio_channel_get() function version was
> merged. The sensor should be released before the iio channel, thus we had to
> use the non-devm version of thermal_zone_of_sensor_register().
>
> Now the devm_iio_channel_get() is available, do the corresponding change in
> this driver and remove gadc_thermal_remove().
>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

Thanks,
Laxman
