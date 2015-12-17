From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Thu, 17 Dec 2015 11:33:33 -0800
Message-ID: <20151217193332.GB7999@localhost.localdomain>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

Sascha,

Yeah, sorry for the long delay. I was planing on applying this patch for
the next merge window, but it just came across one point, see below.

On Mon, Nov 30, 2015 at 12:42:32PM +0100, Sascha Hauer wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> +static const int sensor_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
> +

<big cut>

> +/*
> + * The MT8173 thermal controller has four banks. Each bank can read up to
> + * four temperature sensors simultaneously. The MT8173 has a total of 5
> + * temperature sensors. We use each bank to measure a certain area of the
> + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> + * areas, hence is used in different banks.
> + *
> + * The thermal core only gets the maximum temperature of all banks, so
> + * the bank concept wouldn't be necessary here. However, the SVS (Smart
> + * Voltage Scaling) unit makes its decisions based on the same bank
> + * data, and this indeed needs the temperatures of the individual banks
> + * for making better decisions.
> + */
> +static const struct mtk_thermal_bank_cfg bank_data[] = {
> +	{
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS3 },
> +	}, {
> +		.num_sensors = 2,
> +		.sensors = { MT8173_TS2, MT8173_TS4 },
> +	}, {
> +		.num_sensors = 3,
> +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> +	}, {
> +		.num_sensors = 1,
> +		.sensors = { MT8173_TS2 },
> +	},
> +};

Why can't we expose all these as thermal zones?

That should remove the policy of computing the maximum from this driver.
Please have a look on the work being done [1] to add grouping and
aggregation of thermal zones. With that in place, you should be a matter
of configuring the grouping and selecting max as the aggregation function,
from the thermal core, instead in the driver. Which should give the
system engineer, more flexibility to compose whatever policy based on
the exposed sensors.

BR,

Eduardo Valentin

[1] - https://lkml.org/lkml/2015/11/25/446
