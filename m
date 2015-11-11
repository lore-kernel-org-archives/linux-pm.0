From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 11 Nov 2015 09:40:36 +0000
Message-ID: <20151111094036.GB2781@e104805>
References: <1447064013-13026-1-git-send-email-s.hauer@pengutronix.de>
 <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
 <20151110120554.GB3551@e104805>
 <20151110182629.GA5240@localhost.localdomain>
 <20151111072747.GI8526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151111072747.GI8526-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 11, 2015 at 08:27:47AM +0100, Sascha Hauer wrote:
> On Tue, Nov 10, 2015 at 10:26:30AM -0800, Eduardo Valentin wrote:
> > On Tue, Nov 10, 2015 at 12:05:54PM +0000, Javi Merino wrote:
> > > On Mon, Nov 09, 2015 at 11:13:32AM +0100, Sascha Hauer wrote:
> > 
> > <cut>
> > 
> > > > +
> > > > +/*
> > > > + * The MT8173 thermal controller has four banks. Each bank can read up to
> > > > + * four temperature sensors simultaneously. The MT8173 has a total of 5
> > > > + * temperature sensors. We use each bank to measure a certain area of the
> > > > + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> > > > + * areas, hence is used in different banks.
> > > > + */
> > > > +static const struct mtk_thermal_bank_cfg bank_data[] = {
> > > > +	{
> > > > +		.num_sensors = 2,
> > > > +		.sensors = { MT8173_TS2, MT8173_TS3 },
> > > > +	}, {
> > > > +		.num_sensors = 2,
> > > > +		.sensors = { MT8173_TS2, MT8173_TS4 },
> > > > +	}, {
> > > > +		.num_sensors = 3,
> > > > +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> > > > +	}, {
> > > > +		.num_sensors = 1,
> > > > +		.sensors = { MT8173_TS2 },
> > > > +	},
> > > > +};
> > 
> > Would it make sense to simply expose all sensors and let the
> > configuration of their aggregation be done by DT?
> 
> This particular layout has been chosen because there's also the Smart
> Voltage Scaler (SVS) in the SoC. The SVS uses the same banks for
> measuring temperatures. I don't know the details yet, I just asked the
> Mediatek guys.
> 
> > 
> > There is already ongoing effort to get aggregation functions
> > generalized.
> 
> Do you have any pointers? I haven't seen these efforts yet.

Hierarchical thermal zones
http://thread.gmane.org/gmane.linux.power-management.general/67785

You could keep your thermal zones per bank and then use the
hierarchical thermal zone to create a thermal zone that calculates the
maximum of all banks.  You can put the trip points in this thermal
zone.

> > > > +static int mtk_read_temp(void *data, int *temperature)
> > > > +{
> > > > +	struct mtk_thermal *mt = data;
> > > > +	int i;
> > > > +	int tempmax = INT_MIN;
> > > > +
> > > > +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> > > > +		struct mtk_thermal_bank *bank = &mt->banks[i];
> > > > +		int t;
> > > > +
> > > > +		mtk_thermal_get_bank(bank);
> > > > +
> > > > +		t = mtk_thermal_bank_temperature(bank);
> > > 
> > > IIUIC, when you had multiple thermal zones
> > > mtk_thermal_bank_temperature() made sense, but now it looks like
> > > you're just doing the maximum of all sensors.  Why bother with the
> > > banks any more?  Aren't you just calculating the maximum of all
> > > sensors?  As TS2 is present in all banks, there's no point in reading
> > > it four times just to get the maximum of all sensors.
> > > 
> > 
> > Yeah, agreed here. If that is your intention, maybe read each sensor one
> > time, then compute the max of each subset from memory instead.
> 
> I would have done that if there wasn't this SVS engine. I'll ask
> internally what the constraint of this SVS engine actually are and let
> you know.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
