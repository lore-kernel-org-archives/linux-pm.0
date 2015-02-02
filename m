From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v4] thermal: Add QPNP PMIC temperature alarm driver
Date: Mon, 02 Feb 2015 17:38:17 +0200
Message-ID: <54CF99E9.10305@mm-sol.com>
References: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:54523 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbbBBPiX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Feb 2015 10:38:23 -0500
In-Reply-To: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>

On 02/02/2015 05:19 PM, Ivan T. Ivanov wrote:
> Add support for the temperature alarm peripheral found inside
> Qualcomm plug-and-play (QPNP) PMIC chips. The temperature alarm
> peripheral outputs a pulse on an interrupt line whenever the
> thermal over temperature stage value changes.
> 
> Register a thermal sensor. The temperature reported by this thermal
> sensor device should reflect the actual PMIC die temperature if an
> ADC is present on the given PMIC. If no ADC is present, then the
> reported temperature should be estimated from the over temperature
> stage value.
> 
> Cc: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
> 

<snip>

> +
> +	ret = qpnp_tm_init(chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "init failed\n");
> +		goto fail;
> +	}
> +
> +	chip->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> +							&qpnp_tm_sensor_ops);
> +	if (IS_ERR(chip->tz_dev)) {
> +		dev_err(&pdev->dev, "failed to register sensor\n");
> +		ret = PTR_ERR(chip->tz_dev);
> +		goto fail;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
> +					IRQF_ONESHOT, node->name, chip);
> +	if (ret < 0)
> +		goto unreg;
> +
> +	return 0;
> +
> +unreg:
> +	thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);

Any problem to request_irq before thermal_zone_of_sensor_register? It
will avoid having thermal sensor unregister call.

> +fail:
> +	if (!IS_ERR(chip->adc))
> +		iio_channel_release(chip->adc);
> +
> +	return ret;
> +}

<snip>

-- 
regards,
Stan
