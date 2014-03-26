From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: provide a way for the governors to have private
 data for each thermal zone
Date: Wed, 26 Mar 2014 09:41:49 +0000
Message-ID: <20140326094149.GA2779@e102654-lin.cambridge.arm.com>
References: <1394638735-31540-1-git-send-email-javi.merino@arm.com>
 <20140325161144.GB3953@e102654-lin.cambridge.arm.com>
 <1395802562.2330.21.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48763 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaCZJlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 05:41:55 -0400
In-Reply-To: <1395802562.2330.21.camel@rzhang1-mobl4>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Wei Ni <wni@nvidia.com>

On Wed, Mar 26, 2014 at 02:56:02AM +0000, Zhang Rui wrote:
> On Tue, 2014-03-25 at 16:11 +0000, Javi Merino wrote:
> > On Wed, Mar 12, 2014 at 03:38:55PM +0000, Javi Merino wrote:
> > > A governor may need to store its current state between calls to
> > > throttle().  That state depends on the thermal zone, so store it as
> > > private data in struct thermal_zone_device.
> > > 
> > > The governors may have two new ops: bind_to_tz() and unbind_from_tz().
> > > When provided, these functions allow a governor to do some
> > > initialization when it is bound to a tz and possibly store that
> > > information in the governor_data field of the struct
> > > thermal_zone_device.
> > > 
> > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > 
> > > ---
> > > Hi,
> > > 
> > > We are working[1] on a new governor that has a Proportional Integral
> > > Derivative (PID) controller in it so we need a way to store its
> > > current state.  We're sending this as an RFC as there isn't any user
> > > for this in the kernel yet.  Our plan is to include it as part of the
> > > series of the governor.  This is an RFC to gather comments and see if
> > > this is a valid solution to the problem.
> > > 
> is this an updated version of
> https://patchwork.kernel.org/patch/3474601/ ?

It looks like it's the same idea, yes.  I didn't know about that
patch, thanks for pointing me at it.  I'll have a look and see if we
can use the same interface.

> > > [1] http://article.gmane.org/gmane.linux.power-management.general/43243
> > > 
> > >  drivers/thermal/thermal_core.c |   49 +++++++++++++++++++++++++++++++++-------
> > >  include/linux/thermal.h        |    3 +++
> > >  2 files changed, 44 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > index 71b0ec0..d937083 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -72,6 +72,27 @@ static struct thermal_governor *__find_governor(const char *name)
> > >  	return NULL;
> > >  }
> > >  
> > > +static int thermal_set_governor(struct thermal_zone_device *tz,
> > > +				struct thermal_governor *gov)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (tz->governor && tz->governor->unbind_from_tz)
> > > +		tz->governor->unbind_from_tz(tz);
> > > +
> > > +	if (gov && gov->bind_to_tz) {
> > > +		ret = gov->bind_to_tz(tz);
> > > +		if (ret) {
> > > +			tz->governor = NULL;
> 
> we should keep the original governor if the new governor fails to be
> probed.

Correct.

> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	tz->governor = gov;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  int thermal_register_governor(struct thermal_governor *governor)
> > >  {
> > >  	int err;
> > > @@ -104,8 +125,12 @@ int thermal_register_governor(struct thermal_governor *governor)
> > >  
> > >  		name = pos->tzp->governor_name;
> > >  
> > > -		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
> > > -			pos->governor = governor;
> > > +		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
> > > +			int ret = thermal_set_governor(pos, governor);
> > > +			if (ret)
> > > +				pr_warn("Failed to set governor %s for zone %d: %d\n",
> > > +					governor->name, pos->id, ret);
> > > +		}
> > >  	}
> > >  
> > >  	mutex_unlock(&thermal_list_lock);
> > > @@ -131,7 +156,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
> > >  	list_for_each_entry(pos, &thermal_tz_list, node) {
> > >  		if (!strnicmp(pos->governor->name, governor->name,
> > >  						THERMAL_NAME_LENGTH))
> > > -			pos->governor = NULL;
> > > +			thermal_set_governor(pos, NULL);
> > >  	}
> > >  
> > >  	mutex_unlock(&thermal_list_lock);
> > > @@ -756,8 +781,9 @@ policy_store(struct device *dev, struct device_attribute *attr,
> > >  	if (!gov)
> > >  		goto exit;
> > >  
> > > -	tz->governor = gov;
> > > -	ret = count;
> > > +	ret = thermal_set_governor(tz, gov);
> > > +	if (!ret)
> > > +		ret = count;
> > >  
> > >  exit:
> > >  	mutex_unlock(&thermal_governor_lock);
> > > @@ -1452,6 +1478,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> > >  	int result;
> > >  	int count;
> > >  	int passive = 0;
> > > +	struct thermal_governor *governor;
> > >  
> > >  	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > >  		return ERR_PTR(-EINVAL);
> > > @@ -1542,9 +1569,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> > >  	mutex_lock(&thermal_governor_lock);
> > >  
> > >  	if (tz->tzp)
> > > -		tz->governor = __find_governor(tz->tzp->governor_name);
> > > +		governor = __find_governor(tz->tzp->governor_name);
> > >  	else
> > > -		tz->governor = def_governor;
> > > +		governor = def_governor;
> > > +
> > > +	result = thermal_set_governor(tz, governor);
> > > +	if (result) {
> > > +		mutex_unlock(&thermal_governor_lock);
> > > +		goto unregister;
> > > +	}
> > >  
> > >  	mutex_unlock(&thermal_governor_lock);
> > >  
> > > @@ -1634,7 +1667,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> > >  		device_remove_file(&tz->device, &dev_attr_mode);
> > >  	device_remove_file(&tz->device, &dev_attr_policy);
> > >  	remove_trip_attrs(tz);
> > > -	tz->governor = NULL;
> > > +	thermal_set_governor(tz, NULL);
> > >  
> > >  	thermal_remove_hwmon_sysfs(tz);
> > >  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index f7e11c7..baac212 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -177,6 +177,7 @@ struct thermal_zone_device {
> > >  	struct thermal_zone_device_ops *ops;
> > >  	const struct thermal_zone_params *tzp;
> > >  	struct thermal_governor *governor;
> > > +	void *governor_data;
> 
> I do not see how .governor_data is used in this patch, perhaps it is
> used in .bind_to_tz() callback?

Yes, it's meant to be used in bind_to_tz()

> If yes, the governor_data is registered by platform thermal zone driver,
> and used by the same driver only, right?

No, it's registered by the governor.

> Then it is not necessary to have this in struct thermal_zone_device,
> because we can handle the data in the platform thermal driver entirely,
> right?

You could store it in the governor but as it's different for each
thermal zone you'd have to store all of them in a list and scan it to
find the data for this zone every time ->throttle() is called.  Is
that the preferred way?  I think it's simpler to store the data in the
thermal_zone_device.

Cheers,
Javi

