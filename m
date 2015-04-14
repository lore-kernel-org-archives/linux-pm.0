From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 09/13] thermal: of: always set sensor related callbacks
Date: Tue, 14 Apr 2015 12:54:19 +0200
Message-ID: <20150414105419.GK4946@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-10-git-send-email-s.hauer@pengutronix.de>
 <20150407032522.GL4648@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50385 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbbDNKyW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 06:54:22 -0400
Content-Disposition: inline
In-Reply-To: <20150407032522.GL4648@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 06, 2015 at 08:25:23PM -0700, Eduardo Valentin wrote:
> On Thu, Mar 26, 2015 at 04:53:56PM +0100, Sascha Hauer wrote:
> > Now that the thermal core treats -ENOSYS like the callbacks were
> > not present at all we no longer have to overwrite the ops during
> > runtime but instead can always set them and return -ENOSYS if no
> > sensor is registered.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/thermal/of-thermal.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > index b39e22f..df14fdd 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -91,7 +91,7 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
> >  {
> >  	struct __thermal_zone *data = tz->devdata;
> >  
> > -	if (!data->ops->get_temp)
> > +	if (!data->ops)
> >  		return -EINVAL;
> >  
> >  	return data->ops->get_temp(data->sensor_data, temp);
> > @@ -178,7 +178,7 @@ static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
> >  	struct __thermal_zone *data = tz->devdata;
> >  
> >  	if (!data->ops || !data->ops->set_emul_temp)
> > -		return -EINVAL;
> > +		return -ENOSYS;
> >  
> >  	return data->ops->set_emul_temp(data->sensor_data, temp);
> >  }
> > @@ -189,8 +189,8 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
> >  	struct __thermal_zone *data = tz->devdata;
> >  	int r;
> >  
> > -	if (!data->ops->get_trend)
> > -		return -EINVAL;
> > +	if (!data->ops || !data->ops->get_trend)
> > +		return -ENOSYS;
> >  
> >  	r = data->ops->get_trend(data->sensor_data, trip, trend);
> >  	if (r)
> > @@ -366,6 +366,10 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
> >  }
> >  
> >  static struct thermal_zone_device_ops of_thermal_ops = {
> > +	.get_temp = of_thermal_get_temp,
> > +	.get_trend = of_thermal_get_trend,
> > +	.set_emul_temp = of_thermal_set_emul_temp,
> > +
> >  	.get_mode = of_thermal_get_mode,
> >  	.set_mode = of_thermal_set_mode,
> >  
> > @@ -399,13 +403,13 @@ thermal_zone_of_add_sensor(struct device_node *zone,
> >  	if (!ops)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (!ops->get_temp)
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	mutex_lock(&tzd->lock);
> >  	tz->ops = ops;
> >  	tz->sensor_data = data;
> >  
> > -	tzd->ops->get_temp = of_thermal_get_temp;
> > -	tzd->ops->get_trend = of_thermal_get_trend;
> > -	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
> 
> You may want to update the thermal_zone_of_sensor_unregister too.

Ups, indeed. That hunk accidently went into a later patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
