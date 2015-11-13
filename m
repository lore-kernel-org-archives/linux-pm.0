From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Fri, 13 Nov 2015 11:26:37 +0000
Message-ID: <20151113112636.GA12760@e104805>
References: <1447064013-13026-1-git-send-email-s.hauer@pengutronix.de>
 <1447064013-13026-3-git-send-email-s.hauer@pengutronix.de>
 <20151110120554.GB3551@e104805>
 <20151110182629.GA5240@localhost.localdomain>
 <20151111072747.GI8526@pengutronix.de>
 <20151113100912.GE8526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40924 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbbKML0l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Nov 2015 06:26:41 -0500
Content-Disposition: inline
In-Reply-To: <20151113100912.GE8526@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 13, 2015 at 11:09:12AM +0100, Sascha Hauer wrote:
> On Wed, Nov 11, 2015 at 08:27:47AM +0100, Sascha Hauer wrote:
> > On Tue, Nov 10, 2015 at 10:26:30AM -0800, Eduardo Valentin wrote:
> > > On Tue, Nov 10, 2015 at 12:05:54PM +0000, Javi Merino wrote:
> > > > On Mon, Nov 09, 2015 at 11:13:32AM +0100, Sascha Hauer wrote:
> > > 
> > > <cut>
> > > 
> > > > > +
> > > > > +/*
> > > > > + * The MT8173 thermal controller has four banks. Each bank can read up to
> > > > > + * four temperature sensors simultaneously. The MT8173 has a total of 5
> > > > > + * temperature sensors. We use each bank to measure a certain area of the
> > > > > + * SoC. Since TS2 is located centrally in the SoC it is influenced by multiple
> > > > > + * areas, hence is used in different banks.
> > > > > + */
> > > > > +static const struct mtk_thermal_bank_cfg bank_data[] = {
> > > > > +	{
> > > > > +		.num_sensors = 2,
> > > > > +		.sensors = { MT8173_TS2, MT8173_TS3 },
> > > > > +	}, {
> > > > > +		.num_sensors = 2,
> > > > > +		.sensors = { MT8173_TS2, MT8173_TS4 },
> > > > > +	}, {
> > > > > +		.num_sensors = 3,
> > > > > +		.sensors = { MT8173_TS1, MT8173_TS2, MT8173_TSABB },
> > > > > +	}, {
> > > > > +		.num_sensors = 1,
> > > > > +		.sensors = { MT8173_TS2 },
> > > > > +	},
> > > > > +};
> > > 
> > > Would it make sense to simply expose all sensors and let the
> > > configuration of their aggregation be done by DT?
> > 
> > This particular layout has been chosen because there's also the Smart
> > Voltage Scaler (SVS) in the SoC. The SVS uses the same banks for
> > measuring temperatures. I don't know the details yet, I just asked the
> > Mediatek guys.
> 
> Ok, the job of the SVS is to always pick the best voltage for a given
> CPU frequency based on the temperature of the CPU cluster. How I
> understand it the SVS engine automatically reads temperatures from bank0
> for the first CPU cluster and from bank1 for the second CPU cluster. For
> this to work we are not free to assign the sensors to the banks
> arbitrarily.
> 
> I was told that controlling the CPU frequency the performance is better
> if we use the maximum temperature of the whole die rather than the
> temperature of individual clusters.
> 
> I would prefer to keep the sensor/bank association like it currently is
> as it allows for easy SVS engine integration. Also I would prefer to
> expose a single thermal zone for now, it will be easier to add
> additional zones later than it is to remove them later once we have
> exposed them to the device tree.
> 
> Is that ok with you?

Fair enough.  I agree that it's easier to add thermal zones in the
future than to remove it.  Thanks for the explanation.

Cheers,
Javi
