From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] thermal: add imx thermal driver support
Date: Mon, 24 Jun 2013 14:22:00 +0800
Message-ID: <20130624062158.GA26254@S2101-09.ap.freescale.net>
References: <1371816567-22821-1-git-send-email-shawn.guo@linaro.org>
 <51C48342.2060303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:47200
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751902Ab3FXGVs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2013 02:21:48 -0400
Content-Disposition: inline
In-Reply-To: <51C48342.2060303@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jun 21, 2013 at 12:45:54PM -0400, Eduardo Valentin wrote:
> > +struct imx_thermal_data {
> > +	struct thermal_zone_device *tz;
> > +	struct thermal_cooling_device *cdev;
> > +	enum thermal_device_mode mode;
> > +	struct regmap *tempmon;
> > +	int c1, c2; /* See forumla in imx_get_sensor_data() */
> 
> s/forumla/formula/g (there are more occurrences of same typo)
> 
Thanks for spotting it.

<snip>

> > +static int imx_bind(struct thermal_zone_device *tz,
> > +		    struct thermal_cooling_device *cdev)
> > +{
> > +	int ret;
> > +
> > +	ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
> > +					       THERMAL_NO_LIMIT,
> > +					       THERMAL_NO_LIMIT);
> 
> Remember that if you ever add another cdev in your system, you will be
> blindly bind it to your tz.
> 
Yes.  If someday we add another cooling device, we need a little surgery
on the driver anyway.

<snip>

> > +	/*
> > +	 * Sensor data layout:
> > +	 *   [31:20] - sensor value @ 25C
> > +	 *    [19:8] - sensor value of hot
> > +	 *     [7:0] - hot temperature value
> > +	 */
> > +	n1 = val >> 20;
> > +	n2 = (val & 0xfff00) >> 8;
> > +	t2 = val & 0xff;
> > +	t1 = 25; /* t1 always 25C */
> 
> don't the above constants deserve #define macros?
> 
Hmm, with the constants being used only once here and the comment put
right above the code, I think we're fine.

<snip>

> > +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> > +MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
> > +MODULE_LICENSE("GPL");
> 
> GPLv2, accordingly to your header.
> 
Okay, will change it.

Shawn

