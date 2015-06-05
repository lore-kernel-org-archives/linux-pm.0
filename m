From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC 1/7] thermal: qcom: tsens: Add a skeletal tsens drivers
Date: Fri, 05 Jun 2015 16:49:08 -0700
Message-ID: <7hpp59zpfv.fsf@deeprootsystems.com>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
	<1429796773-7151-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429796773-7151-2-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Thu, 23 Apr 2015 19:16:07 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Rajendra,

Rajendra Nayak <rnayak@codeaurora.org> writes:

> tsens is qualcomms' thermal temperature sensor device. It
> supports reading temperatures from multiple thermal sensors
> present on various QCOM SoCs.
> Calibration data is generally read from a eeprom device.
>
> Add a skeleton driver with all the necessary abstractions so
> a variety of qcom device families which support tsens can
> add driver extensions.
>
> Also add the required device tree bindings which can be used
> to descibe the tsens device in DT.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

[...]

> +	ret = tmdev->ops->calibrate(tmdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "tsens calibration failed\n");
> +		return ret;
> +	}

I was trying this series on linux-next with Srini's eeprom v4 and my
first attempt was to build the eeprom, qfprom and tsens drivers as
built-in.  Unfortunately, the tsens driver probed before the
eeprom/qfprom driver so failed here with the "calibration failed"
message.

Building things as modules worked better, but you might want to take a
look at possibly using -EPROBE_DEFER here?

Kevin
