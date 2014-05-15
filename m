From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH 1/5] thermal: let governors have private data for
 each thermal zone
Date: Thu, 15 May 2014 11:10:25 -0400
Message-ID: <20140515151025.GD27690@developer>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
 <1399377998-14870-2-git-send-email-javi.merino@arm.com>
 <CAC-25o_gfoXQ5AaeF=huDPFP5F9hoR9Rjjxctv7+kj=aaDjr2Q@mail.gmail.com>
 <20140515143053.GA3964@e102654-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:61046 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbaEOPKq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 11:10:46 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so3189760yha.27
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2014 08:10:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140515143053.GA3964@e102654-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>

Javi,

On Thu, May 15, 2014 at 03:30:53PM +0100, Javi Merino wrote:
> On Tue, May 13, 2014 at 03:31:08PM +0100, edubezval@gmail.com wrote:
> > Hello Javi,
> > 
> > Thanks for your patch. Find some comment inline.
> > 

[cut]

> 
> Will do, but I find that the other governor op (throttle) is not
> documented.  Where do you suggest we should put it?
> 

The main entry for thermal Documentation is Documentation/thermal/. The
sysfs-api.txt file has major info about the thermal framework. But for
this case, I agree with you, we deserve a better explanation. I think
the fact that the governor API is becoming more interesting is a hint
that we need better documentation. I suggest having another file
describing the governor API and how it deals with other entities such
as sensor inputs and cooling actions.

Rui, any suggestion here?


> > > + if (tz->governor && tz->governor->bind_to_tz) {
> > > + if (tz->governor->bind_to_tz(tz))
> > > + /*
> > > + * The new governor failed to register
> > > + * and the previous one failed as well
> > > + */
> > 
> > I suggest having a dev_warn here to notify that a zone is now orphan due to
> > switching from one governor to another.
> 
> Done
> 
> > > + tz->governor = NULL;
> > > + }
> > > +
> > > + return ret;
> > > + }
> > > + }
> > > +
> > > + tz->governor = new_gov;
> > > +
> > > + return ret;
> > > +}
> > > +
> > >  int thermal_register_governor(struct thermal_governor *governor)
> > >  {
> > >   int err;
> > > @@ -104,8 +143,12 @@ int thermal_register_governor(struct thermal_governor *governor)
> > >
> > >   name = pos->tzp->governor_name;
> > >
> > > - if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
> > > - pos->governor = governor;
> > > + if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
> > > + int ret = thermal_set_governor(pos, governor);
> > 
> > nip: add a blank line between declarations and first statement.
> 
> Ok
> 
> > > + if (ret)
> > > + pr_warn("Failed to set governor %s for zone %d: %d\n",
> > > + governor->name, pos->id, ret);
> > 
> > dev_* family of logging functions is preferred in this file.
> 
> Done
> 
> > > + }
> > >   }
> > >
> > >   mutex_unlock(&thermal_list_lock);
> > > @@ -131,7 +174,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
> > >   list_for_each_entry(pos, &thermal_tz_list, node) {
> > >   if (!strnicmp(pos->governor->name, governor->name,
> > >   THERMAL_NAME_LENGTH))
> > > - pos->governor = NULL;
> > > + thermal_set_governor(pos, NULL);
> > >   }
> > >
> > >   mutex_unlock(&thermal_list_lock);
> > > @@ -756,8 +799,9 @@ policy_store(struct device *dev, struct device_attribute *attr,
> > >   if (!gov)
> > >   goto exit;
> > >
> > > - tz->governor = gov;
> > > - ret = count;
> > > + ret = thermal_set_governor(tz, gov);
> > > + if (!ret)
> > > + ret = count;
> > >
> > >  exit:
> > >   mutex_unlock(&thermal_governor_lock);
> > > @@ -1452,6 +1496,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> > >   int result;
> > >   int count;
> > >   int passive = 0;
> > > + struct thermal_governor *governor;
> > >
> > >   if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > >   return ERR_PTR(-EINVAL);
> > > @@ -1542,9 +1587,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> > >   mutex_lock(&thermal_governor_lock);
> > >
> > >   if (tz->tzp)
> > > - tz->governor = __find_governor(tz->tzp->governor_name);
> > > + governor = __find_governor(tz->tzp->governor_name);
> > >   else
> > > - tz->governor = def_governor;
> > > + governor = def_governor;
> > > +
> > > + result = thermal_set_governor(tz, governor);
> > > + if (result) {
> > > + mutex_unlock(&thermal_governor_lock);
> > > + goto unregister;
> > > + }
> > >
> > >   mutex_unlock(&thermal_governor_lock);
> > >
> > > @@ -1634,7 +1685,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> > >   device_remove_file(&tz->device, &dev_attr_mode);
> > >   device_remove_file(&tz->device, &dev_attr_policy);
> > >   remove_trip_attrs(tz);
> > > - tz->governor = NULL;
> > > + thermal_set_governor(tz, NULL);
> > >
> > >   thermal_remove_hwmon_sysfs(tz);
> > >   release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index f7e11c7ea7d9..baac212f815e 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -177,6 +177,7 @@ struct thermal_zone_device {
> > >   struct thermal_zone_device_ops *ops;
> > >   const struct thermal_zone_params *tzp;
> > >   struct thermal_governor *governor;
> > > + void *governor_data;
> > 
> > Please document this entry.
> 
> Where?  None of these entries are documented.  I guess I'll have to
> add a patch that describes each one of them and then add ours.
> 
> > >   struct list_head thermal_instances;
> > >   struct idr idr;
> > >   struct mutex lock; /* protect thermal_instances list */
> > > @@ -187,6 +188,8 @@ struct thermal_zone_device {
> > >  /* Structure that holds thermal governor information */
> > >  struct thermal_governor {
> > >   char name[THERMAL_NAME_LENGTH];
> > > + int (*bind_to_tz)(struct thermal_zone_device *tz);
> > > + void (*unbind_from_tz)(struct thermal_zone_device *tz);
> > 
> > a governor cannot prevent unbinding?
> 
> To me it's like open()/close() or malloc()/free().  You generally can
> fail to bind, but not fail to unbind.  I can change it to an int if
> you think it is something that we may need.
> 
> > Please, document the proposed operations.
> 
> Same as before, none of the entries in this struct are documented so
> I'll submit a patch that describes the current ones and then add our
> new ones in our patch.
> 
> > >   int (*throttle)(struct thermal_zone_device *tz, int trip);
> > >   struct list_head governor_list;
> > >  };
> > > --
> > > 1.7.9.5
> > 
> > I request that you update Documentation/thermal/sysfs-api.txt too.
> 
> Will do.
> 
> Cheers,
> Javi
> 
