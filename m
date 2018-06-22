From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 12/12] mfd: cros_ec: Add throttler sub-device
Date: Thu, 21 Jun 2018 19:06:47 -0700
Message-ID: <20180622020646.GB180395@ban.mtv.corp.google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-13-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621015237.100100-13-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 20, 2018 at 06:52:37PM -0700, Matthias Kaehlcke wrote:
> Instantiate the CrOS EC throttler if it is enabled in the kernel
> configuration.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
> Changes in v4:
> - register throttler in cros_ec_dev.c instead of cros_ec.c
> 
> Changes in v3:
> - patch added to series
> ---
>  drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index eafd06f62a3a..9e56c2793075 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -383,6 +383,22 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static const struct mfd_cell ec_throttler_cells[] = {
> +	{ .name = "cros-ec-throttler" }
> +};
> +
> +static void cros_ec_throttler_register(struct cros_ec_dev *ec)
> +{
> +	int ret;
> +
> +	ret = mfd_add_devices(ec->dev, 0, ec_throttler_cells,
> +			      ARRAY_SIZE(ec_throttler_cells),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec->dev,
> +			"failed to add cros-ec-throttler device: %d\n", ret);
> +}
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -422,6 +438,9 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER))
> +		cros_ec_throttler_register(ec);
> +
>  	/* Take control of the lightbar from the EC. */
>  	lb_manual_suspend_ctrl(ec, 1);
>  
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 
