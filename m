From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 00/12] QorIQ TMU multi-sensor and HWMON support
Date: Wed, 20 Feb 2019 16:52:48 -0800
Message-ID: <20190221005246.GB31479@localhost.localdomain>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Andrey

On Mon, Feb 18, 2019 at 11:11:29AM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains patches adding support for HWMON integration,
> multi-sensor support as well as a small fix and general improvements
> (hopefully) for TMU driver I made while working on it on i.MX8MQ.
> 
> Feedback is welcome!

What branch is this patch series based off?

Would you mind re-sending the series based off my -linus branch?
There has been an addition on qoriq driver to support multiple sensors
and the code has shifted and your series does not apply over there.

> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (12):
>   thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
>   thermal: qoriq: Remove unnecessary DT node is NULL check
>   thermal: qoriq: Add local struct device pointer in qoriq_tmu_probe()
>   thermal: qoriq: Don't pass platform_device to qoriq_tmu_calibration()
>   thermal: qoriq: Convert driver to use devm_ioremap()
>   thermal: qoriq: Add hwmon support
>   thermal: qoriq: Convert driver to use regmap API
>   thermal: qoriq: Enable monitoring before querying temperature
>   thermal: qoriq: Do not report invalid temperature reading
>   thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
>   thermal: qoriq: Be more strict when parsing "thermal-sensors"
>   thermal: qoriq: Add support for multiple thremal sites
> 
>  drivers/thermal/qoriq_thermal.c | 326 ++++++++++++++++++--------------
>  drivers/thermal/thermal_hwmon.c |  28 +++
>  drivers/thermal/thermal_hwmon.h |   7 +
>  3 files changed, 214 insertions(+), 147 deletions(-)
> 
> -- 
> 2.20.1
> 
