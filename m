From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: provide a way for the governors to have private
 data for each thermal zone
Date: Wed, 26 Mar 2014 14:29:17 +0000
Message-ID: <20140326142917.GD2779@e102654-lin.cambridge.arm.com>
References: <1394638735-31540-1-git-send-email-javi.merino@arm.com>
 <20140325161144.GB3953@e102654-lin.cambridge.arm.com>
 <1395802562.2330.21.camel@rzhang1-mobl4>
 <20140326094149.GA2779@e102654-lin.cambridge.arm.com>
 <744357E9AAD1214791ACBA4B0B9092630122626D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55699 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbaCZO3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 10:29:22 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B9092630122626D@SHSMSX101.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Wei Ni <wni@nvidia.com>

On Wed, Mar 26, 2014 at 02:06:06PM +0000, Zhang, Rui wrote:
> > diff
> > > > > --git a/include/linux/thermal.h b/include/linux/thermal.h index
> > > > > f7e11c7..baac212 100644
> > > > > --- a/include/linux/thermal.h
> > > > > +++ b/include/linux/thermal.h
> > > > > @@ -177,6 +177,7 @@ struct thermal_zone_device {
> > > > >  	struct thermal_zone_device_ops *ops;
> > > > >  	const struct thermal_zone_params *tzp;
> > > > >  	struct thermal_governor *governor;
> > > > > +	void *governor_data;
> > >
> > > I do not see how .governor_data is used in this patch, perhaps it is
> > > used in .bind_to_tz() callback?
> > 
> > Yes, it's meant to be used in bind_to_tz()
> > 
> > > If yes, the governor_data is registered by platform thermal zone
> > > driver, and used by the same driver only, right?
> > 
> > No, it's registered by the governor.
> > 
> When? Tz->governor_data is set in governor->bind_to_tz(tz)?

That's the idea.  The governor can set tz->governor_data if it needs
to and can initialise it in bind_to_tz()

Cheers,
Javi

> > > Then it is not necessary to have this in struct thermal_zone_device,
> > > because we can handle the data in the platform thermal driver
> > > entirely, right?
> > 
> > You could store it in the governor but as it's different for each
> > thermal zone
> 
> Okay, I see. then I have no objection.
> 
> Thanks,
> rui

