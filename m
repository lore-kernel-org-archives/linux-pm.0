From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 11 Nov 2015 08:27:47 +0100
Message-ID: <20151111072747.GI8526@pengutronix.de>
References: <1447064013-13026-1-git-send-email-s.hauer@pengutronix.de>
 <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
 <20151110120554.GB3551@e104805>
 <20151110182629.GA5240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39125 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbKKH14 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 02:27:56 -0500
Content-Disposition: inline
In-Reply-To: <20151110182629.GA5240@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@arm.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 10, 2015 at 10:26:30AM -0800, Eduardo Valentin wrote:
> On Tue, Nov 10, 2015 at 12:05:54PM +0000, Javi Merino wrote:
> > On Mon, Nov 09, 2015 at 11:13:32AM +0100, Sascha Hauer wrote:
> 
> <cut>
> 
> > > +
> > > +/*
> > > + * The MT8173 thermal controller has four banks. Each bank can read up to
> > > + * four temperature sensors simultaneously. The MT8173 has a total of 5
> > > + * temperature sensors. We use each bank to measure a certain area of the
> > > + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> > > + * areas, hence is used in different banks.
> > > + */
> > > +static const struct mtk_thermal_bank_cfg bank_data[] = {
> > > +	{
> > > +		.num_sensors = 2,
> > > +		.sensors = { MT8173_TS2, MT8173_TS3 },
> > > +	}, {
> > > +		.num_sensors = 2,
> > > +		.sensors = { MT8173_TS2, MT8173_TS4 },
> > > +	}, {
> > > +		.num_sensors = 3,
> > > +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> > > +	}, {
> > > +		.num_sensors = 1,
> > > +		.sensors = { MT8173_TS2 },
> > > +	},
> > > +};
> 
> Would it make sense to simply expose all sensors and let the
> configuration of their aggregation be done by DT?

This particular layout has been chosen because there's also the Smart
Voltage Scaler (SVS) in the SoC. The SVS uses the same banks for
measuring temperatures. I don't know the details yet, I just asked the
Mediatek guys.

> 
> There is already ongoing effort to get aggregation functions
> generalized.

Do you have any pointers? I haven't seen these efforts yet.

> > > +static int mtk_read_temp(void *data, int *temperature)
> > > +{
> > > +	struct mtk_thermal *mt = data;
> > > +	int i;
> > > +	int tempmax = INT_MIN;
> > > +
> > > +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> > > +		struct mtk_thermal_bank *bank = &mt->banks[i];
> > > +		int t;
> > > +
> > > +		mtk_thermal_get_bank(bank);
> > > +
> > > +		t = mtk_thermal_bank_temperature(bank);
> > 
> > IIUIC, when you had multiple thermal zones
> > mtk_thermal_bank_temperature() made sense, but now it looks like
> > you're just doing the maximum of all sensors.  Why bother with the
> > banks any more?  Aren't you just calculating the maximum of all
> > sensors?  As TS2 is present in all banks, there's no point in reading
> > it four times just to get the maximum of all sensors.
> > 
> 
> Yeah, agreed here. If that is your intention, maybe read each sensor one
> time, then compute the max of each subset from memory instead.

I would have done that if there wasn't this SVS engine. I'll ask
internally what the constraint of this SVS engine actually are and let
you know.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
