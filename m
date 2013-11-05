From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2 1/3] thermal: bcm281xx: Add Temperature Monitor driver
Date: Tue, 05 Nov 2013 12:15:29 -0800
Message-ID: <1383682529.4387.37.camel@joe-AO722>
References: <1383681284-17643-1-git-send-email-wendy.ng@broadcom.com>
	 <1383681284-17643-2-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383681284-17643-2-git-send-email-wendy.ng@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wendy Ng <wendy.ng@broadcom.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eduardo Valentin <eduardo.valentin@ti.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Christian Daudt <bcm@fixthebug.org>, Markus Mayer <mmayer@broadcom.com>, Tim Kryger <tim.kryger@linaro.org>, Matt Porter <matt.porter@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-11-05 at 11:54 -0800, Wendy Ng wrote:
> This adds the support for Temperature Monitor (TMON) driver for
> Broadcom bcm281xx SoCs. This driver plugs into the Thermal Framework.

trivia:

> diff --git a/drivers/thermal/bcm_kona_tmon.c b/drivers/thermal/bcm_kona_tmon.c

Please add
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any #include to prefix the pr_<level> dmesg output.

If you _really_ want __func__ with each output, you could use
#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
though I think __func__ isn't particularly useful.

> +#include <linux/clk.h>
> +#include <linux/err.h>
[]
> +static int bcm_get_temp(void *sensor_data, long *temp)
> +{
> +	u32 raw;
> +	long mcelsius;
> +	struct bcm_tmon_data_priv *priv = sensor_data;
> +
> +	if (!priv) {
> +		pr_err("%s: input sensor_data not initialized.\n", __func__);

then this could become
		pr_err("input sensor_data not initialized\n");

Also, there's no real need to terminate messages with sentence
ending ".".  dmesg output generally isn't a sentence.

> +		return -EINVAL;
> +	}
> +
> +	raw = (readl(priv->base + TMON_TEMP_VAL_OFFSET)
> +		& TMON_TEMP_VAL_TEMP_VAL_MASK) >> TMON_TEMP_VAL_TEMP_VAL_SHIFT;
> +
> +	pr_debug("%s: raw temp 0x%x\n", __func__, raw);

also consider:

	pr_debug("raw temp: %#x\n", raw);


> +static int bcm_kona_tmon_probe(struct platform_device *pdev)
> +{
[]
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&pdev->dev, "Failed to malloc priv.\n");
> +		return -ENOMEM;
> +	}

Generic OOM messages are already emitted by devm_kzalloc.
This could be written as:

	priv = devm_kzalloc(etc...)
	if (!priv)
		return -ENOMEM;
