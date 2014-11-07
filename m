From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 01/21] thermal: of: Extend of-thermal.c to provide number
 of trip points
Date: Fri, 07 Nov 2014 10:14:55 +0100
Message-ID: <20141107101455.6099c90d@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-2-git-send-email-l.majewski@samsung.com>
 <20141107013405.GB10180@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65479 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaKGJPE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 04:15:04 -0500
In-reply-to: <20141107013405.GB10180@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo,

> Hello Lukasz,
> 
> On Thu, Oct 09, 2014 at 06:38:37PM +0200, Lukasz Majewski wrote:
> > This patch extends the of-thermal.c to provide information about
> > number of available trip points.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/thermal/of-thermal.c   | 6 ++++++
> >  drivers/thermal/thermal_core.h | 5 +++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/thermal/of-thermal.c
> > b/drivers/thermal/of-thermal.c index f8eb625..b2390d9 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -113,6 +113,12 @@ static int of_thermal_get_temp(struct
> > thermal_zone_device *tz, return data->get_temp(data->sensor_data,
> > temp); }
> >  
> > +int of_thermal_get_ntrips(struct thermal_zone_device *tz)
> > +{
> > +	struct __thermal_zone *data = tz->devdata;
> > +	return data->ntrips;
> > +}
> 
> I am not against this addition. I just request you to document it
> accordingly.

OK, no problem.

> 
> > +
> >  static int of_thermal_get_trend(struct thermal_zone_device *tz,
> > int trip, enum thermal_trend *trend)
> >  {
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h index 3db339f..587ca5c 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -81,9 +81,14 @@ static inline void
> > thermal_gov_user_space_unregister(void) {} #ifdef CONFIG_THERMAL_OF
> >  int of_parse_thermal_zones(void);
> >  void of_thermal_destroy_zones(void);
> > +int of_thermal_get_ntrips(struct thermal_zone_device *);
> >  #else
> >  static inline int of_parse_thermal_zones(void) { return 0; }
> >  static inline void of_thermal_destroy_zones(void) { }
> > +static inline int of_thermal_get_ntrips(struct thermal_zone_device
> > *) +{
> > +	return 0;
> > +}
> >  #endif
> >  
> >  #endif /* __THERMAL_CORE_H__ */
> > -- 
> > 2.0.0.rc2
> > 


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
