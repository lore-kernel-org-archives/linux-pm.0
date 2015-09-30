From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 30 Sep 2015 08:14:59 +0200
Message-ID: <20150930061459.GW7858@pengutronix.de>
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
 <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
 <5602EFF0.8040207@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58905 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbbI3GPZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 02:15:25 -0400
Content-Disposition: inline
In-Reply-To: <5602EFF0.8040207@mentor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org

Hi Vladimir,

On Wed, Sep 23, 2015 at 09:31:12PM +0300, Vladimir Zapolskiy wrote:
> Hi Sascha,
> 
> in case of OF_DYNAMIC enabled of_parse_phandle() requires of_node_put(),
> which is fine to place right here.
> 
> > +	if (auxadc_phys_base == OF_BAD_ADDR) {
> > +		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> [snip]
> 
> > +
> > +	/*
> > +	 * These calibration values should finally be provided by the
> > +	 * firmware or fuses. For now use default values.
> > +	 */
> > +	mt->calib_slope = -123;
> > +	mt->calib_offset = 465124;
> > +
> > +	for (i = 0; i < MT8173_NUM_ZONES; i++)
> > +		mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> > +
> > +	platform_set_drvdata(pdev, mt);
> > +
> > +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> > +		struct mtk_thermal_bank *bank = &mt->banks[i];
> > +
> > +		bank->tzd = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> > +				&mtk_thermal_ops);
> 
> I would propose to add return value checks here, otherwise there might
> be an oops in mtk_thermal_remove(), if something goes wrong.

Thanks for the input. I'll fix that in the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
