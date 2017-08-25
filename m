From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 2/4] thermal: mediatek: add Mediatek thermal driver
 for mt2712
Date: Fri, 25 Aug 2017 10:30:45 +0800
Message-ID: <1503628245.2774.8.camel@intel.com>
References: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
         <1501572513-7958-3-git-send-email-louis.yu@mediatek.com>
         <1502198610.4296.58.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:13408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754191AbdHYCaa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Aug 2017 22:30:30 -0400
In-Reply-To: <1502198610.4296.58.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Louis Yu <louis.yu@mediatek.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, hanyi.wu@mediatek.com, s.hauer@pengutronix.de, dawei.chien@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com

On Tue, 2017-08-08 at 21:23 +0800, Zhang Rui wrote:
> On Tue, 2017-08-01 at 15:28 +0800, Louis Yu wrote:
> > 
> > This patch adds support for mt2712 chip to mtk_thermal,
> > and integrate mt2712 into the same mediatek thermal driver.
> > MT2712 has only 1 bank and 4 sensors.
> > 
> > Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 70
> > ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 66 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c
> > b/drivers/thermal/mtk_thermal.c
> > index 7737f14..e35d28d 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -3,6 +3,7 @@
> >   * Author: Hanyi Wu <hanyi.wu@mediatek.com>
> >   *         Sascha Hauer <s.hauer@pengutronix.de>
> >   *         Dawei Chien <dawei.chien@mediatek.com>
> > + *         Louis Yu <louis.yu@mediatek.com>
> I need the feedback from the previous authors for the changes in all
> this patch set.
> 
Hanyi, Sascha and Dawei,

can you please review this patch and let me know your opinion?

thanks,
rui
> > 
> >   *
> >   * This program is free software; you can redistribute it and/or
> > modify
> >   * it under the terms of the GNU General Public License version 2
> > as
> > @@ -111,9 +112,10 @@
> >  
> >  /*
> >   * Layout of the fuses providing the calibration data
> > - * These macros could be used for both MT8173 and MT2701.
> > + * These macros could be used for both MT8173, MT2701, and MT2712.
> >   * MT8173 has five sensors and need five VTS calibration data,
> > - * and MT2701 has three sensors and need three VTS calibration
> > data.
> > + * and MT2701 has three sensors and need three VTS calibration
> > data,
> > + * and MT2712 has four sensors and need four VTS calibration data.
> >   */
> why bother change these comments again in patch 3/4?
> 
> thanks,
> rui
> > 
> >  #define MT8173_CALIB_BUF0_VALID		BIT(0)
> >  #define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
> > @@ -136,11 +138,26 @@
> >  /* The total number of temperature sensors in the MT2701 */
> >  #define MT2701_NUM_SENSORS	3
> >  
> > -#define THERMAL_NAME    "mtk-thermal"
> > -
> >  /* The number of sensing points per bank */
> >  #define MT2701_NUM_SENSORS_PER_ZONE	3
> >  
> > +/* MT2712 thermal sensors */
> > +#define MT2712_TS1	0
> > +#define MT2712_TS2	1
> > +#define MT2712_TS3	2
> > +#define MT2712_TS4	3
> > +
> > +/* AUXADC channel 11 is used for the temperature sensors */
> > +#define MT2712_TEMP_AUXADC_CHANNEL	11
> > +
> > +/* The total number of temperature sensors in the MT2712 */
> > +#define MT2712_NUM_SENSORS	4
> > +
> > +/* The number of sensing points per bank */
> > +#define MT2712_NUM_SENSORS_PER_ZONE	4
> > +
> > +#define THERMAL_NAME    "mtk-thermal"
> > +
> >  struct mtk_thermal;
> >  
> >  struct thermal_bank_cfg {
> > @@ -215,6 +232,21 @@ struct mtk_thermal {
> >  
> >  static const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1,
> > 16
> > };
> >  
> > +/* MT2712 thermal sensor data */
> > +static const int mt2712_bank_data[MT2712_NUM_SENSORS] = {
> > +	MT2712_TS1, MT2712_TS2, MT2712_TS3, MT2712_TS4
> > +};
> > +
> > +static const int mt2712_msr[MT2712_NUM_SENSORS_PER_ZONE] = {
> > +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR3
> > +};
> > +
> > +static const int mt2712_adcpnp[MT2712_NUM_SENSORS_PER_ZONE] = {
> > +	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2, TEMP_ADCPNP3
> > +};
> > +
> > +static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1,
> > 2,
> > 3 };
> > +
> >  /**
> >   * The MT8173 thermal controller has four banks. Each bank can
> > read
> > up to
> >   * four temperature sensors simultaneously. The MT8173 has a total
> > of 5
> > @@ -278,6 +310,31 @@ struct mtk_thermal {
> >  };
> >  
> >  /**
> > + * The MT2712 thermal controller has one bank, which can read up
> > to
> > + * four temperature sensors simultaneously. The MT2712 has a total
> > of 4
> > + * temperature sensors.
> > + *
> > + * The thermal core only gets the maximum temperature of this one
> > bank,
> > + * so the bank concept wouldn't be necessary here. However, the
> > SVS
> > (Smart
> > + * Voltage Scaling) unit makes its decisions based on the same
> > bank
> > + * data.
> > + */
> > +static const struct mtk_thermal_data mt2712_thermal_data = {
> > +	.auxadc_channel = MT2712_TEMP_AUXADC_CHANNEL,
> > +	.num_banks = 1,
> > +	.num_sensors = MT2712_NUM_SENSORS,
> > +	.bank_data = {
> > +		{
> > +			.num_sensors = 4,
> > +			.sensors = mt2712_bank_data,
> > +		},
> > +	},
> > +	.msr = mt2712_msr,
> > +	.adcpnp = mt2712_adcpnp,
> > +	.sensor_mux_values = mt2712_mux_values,
> > +};
> > +
> > +/**
> >   * raw_to_mcelsius - convert a raw ADC value to mcelsius
> >   * @mt:		The thermal controller
> >   * @raw:	raw ADC value
> > @@ -571,6 +628,10 @@ static int
> > mtk_thermal_get_calibration_data(struct device *dev,
> >  	{
> >  		.compatible = "mediatek,mt2701-thermal",
> >  		.data = (void *)&mt2701_thermal_data,
> > +	},
> > +	{
> > +		.compatible = "mediatek,mt2712-thermal",
> > +		.data = (void *)&mt2712_thermal_data,
> >  	}, {
> >  	},
> >  };
> > @@ -705,6 +766,7 @@ static int mtk_thermal_remove(struct
> > platform_device *pdev)
> >  
> >  module_platform_driver(mtk_thermal_driver);
> >  
> > +MODULE_AUTHOR("Louis Yu <louis.yu@mediatek.com>");
> >  MODULE_AUTHOR("Dawei Chien <dawei.chien@mediatek.com>");
> >  MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> >  MODULE_AUTHOR("Hanyi Wu <hanyi.wu@mediatek.com>");
