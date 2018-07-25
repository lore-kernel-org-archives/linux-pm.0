From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Date: Tue, 24 Jul 2018 17:06:28 -0700
Message-ID: <20180725000628.GO129942@google.com>
References: <20180724234636.57137-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 24, 2018 at 04:46:34PM -0700, Matthias Kaehlcke wrote:
> There are three thermal stages defined in the PMIC:
> 
> stage 1: warning
> stage 2: system should shut down
> stage 3: emergency shut down
> 
> By default the PMIC assumes that the OS isn't doing anything and thus
> at stage 2 it does a partial PMIC shutdown and at stage 3 it kills
> all power. When switching between thermal stages the PMIC generates an
> interrupt which is handled by the driver. The partial PMIC shutdown at
> stage 2 can be disabled by software, which allows the OS to initiate a
> shutdown at stage 2 with a thermal zone configured accordingly.
> 
> If a critical trip point is configured in the thermal zone the driver
> adjusts the stage 1-3 temperature thresholds to (closely) match the
> critical temperature with a stage 2 threshold (125/130/135/140 °C).
> If a suitable match is found the partial shutdown at stage 2 is
> disabled. If for some reason the system doesn't shutdown at stage 2
> the emergency shutdown at stage 3 kicks in.
> 
> The partial shutdown at stage 2 remains enabled in these cases:
> - no critical trip point defined
> - the temperature of the critical trip point is < 125°C
> - the temperature of the critical trip point is > 140°C and no
>   ADC channel is configured (thus the OS is not notified when the critical
>   temperature is reached)
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v5:
> - patch added to the series
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 161 ++++++++++++++++++++++---
>  1 file changed, 142 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
> index ad4f3a8d6560..936e4dde4298 100644
> --- a/drivers/thermal/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom-spmi-temp-alarm.c
>
> ...
>
> +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> +					     int temp)
> +{
> +	u8 reg;
> +	bool disable_s2_shutdown = false;
> +	int ret;
> +
> +	WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +	/*
> +	 * Default: S2 and S3 shutdown enabled, thresholds at
> +	 * 105C/125C/145C, monitoring at 25Hz
> +	 */
> +	reg = SHUTDOWN_CTRL1_RATE_25HZ;
> +
> +	if ((temp == THERMAL_TEMP_INVALID) ||
> +	    (temp < STAGE2_THRESHOLD_MIN)) {
> +		chip->thresh = THRESH_MIN;
> +		goto skip;
> +	}
> +
> +	if (temp <= STAGE2_THRESHOLD_MAX) {
> +		chip->thresh = THRESH_MAX -
> +			((STAGE2_THRESHOLD_MAX - temp) /
> +			 TEMP_THRESH_STEP);
> +		disable_s2_shutdown = true;
> +	} else {
> +		chip->thresh = THRESH_MAX;
> +
> +		if (!IS_ERR(chip->adc))

Note to self: with commit 7a4ca51b7040 ("thermal/drivers/qcom-spmi:
Use devm_iio_channel_get") this should be 'if (chip->adc)'.
