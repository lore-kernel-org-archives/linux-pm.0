From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Tue, 20 Oct 2015 10:47:54 +0100
Message-ID: <20151020094753.GC2681@e104805>
References: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
 <20150928142902.GA9175@e104805>
 <36DF59CE26D8EE47B0655C516E9CE64026F22641@SHSMSX101.ccr.corp.intel.com>
 <20150929160133.GA11588@e104805>
 <36DF59CE26D8EE47B0655C516E9CE6402865B04D@shsmsx102.ccr.corp.intel.com>
 <20151014170739.GB2998@e104805>
 <36DF59CE26D8EE47B0655C516E9CE6402865BCBE@shsmsx102.ccr.corp.intel.com>
 <20151015140517.GC2639@e104805>
 <36DF59CE26D8EE47B0655C516E9CE6402865D45D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54259 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbbJTJr5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Oct 2015 05:47:57 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865D45D@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

Hi Yu,

On Tue, Oct 20, 2015 at 01:44:20AM +0000, Chen, Yu C wrote:
> > -----Original Message-----
> > From: Javi Merino [mailto:javi.merino@arm.com]
> > Sent: Thursday, October 15, 2015 10:05 PM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui; linux- 
> > kernel@vger.kernel.org; stable@vger.kernel.org; Pandruvada, Srinivas
> > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a 
> > cooling device registered
> > 
> > On Wed, Oct 14, 2015 at 07:23:55PM +0000, Chen, Yu C wrote:
> > > > -----Original Message-----
> > > > From: Javi Merino [mailto:javi.merino@arm.com]
> > > > Sent: Thursday, October 15, 2015 1:08 AM
> > > > To: Chen, Yu C
> > > > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui;
> > > > linux- kernel@vger.kernel.org; stable@vger.kernel.org; Pandruvada, 
> > > > Srinivas
> > > > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a 
> > > > cooling device registered
> > > >
> > > > On Mon, Oct 12, 2015 at 09:23:28AM +0000, Chen, Yu C wrote:
> > > > > Hi, Javi
> > > > > Sorry for my late response,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Javi Merino [mailto:javi.merino@arm.com]
> > > > > > Sent: Wednesday, September 30, 2015 12:02 AM
> > > > > > To: Chen, Yu C
> > > > > > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui;
> > > > > > linux- kernel@vger.kernel.org; stable@vger.kernel.org
> > > > > > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after 
> > > > > > a cooling device registered
> > > > > >
> > > > > > Hi Yu,
> > > > > >
> > > > > > On Mon, Sep 28, 2015 at 06:52:00PM +0100, Chen, Yu C wrote:
> > > > > > > Hi, Javi,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Javi Merino [mailto:javi.merino@arm.com]
> > > > > > > > Sent: Monday, September 28, 2015 10:29 PM
> > > > > > > > To: Chen, Yu C
> > > > > > > > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, 
> > > > > > > > Rui;
> > > > > > > > linux- kernel@vger.kernel.org; stable@vger.kernel.org
> > > > > > > > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update 
> > > > > > > > after a cooling device registered
> > > > > > > >
> > > > > > > > On Sun, Sep 27, 2015 at 06:48:44AM +0100, Chen Yu wrote:
> > > > > > > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > I think you need to hold cdev->lock here, to make sure 
> > > > > > > > that no thermal zone is added or removed from
> > > > > > > > cdev->thermal_instances while
> > > > > > you are looping.
> > > > > > > >
> > > > > > > Ah right, will add. If I add the cdev ->lock here, will 
> > > > > > > there be a AB-BA lock with thermal_zone_unbind_cooling_device?
> > > > > >
> > > > > > You're right, it could lead to a deadlock.  The locks can't be 
> > > > > > swapped because that won't work in step_wise.
> > > > > >
> > > > > > The best way that I can think of accessing thermal_instances 
> > > > > > atomically is by making it RCU protected instead of with mutexes.
> > > > > > What do you think?
> > > > > >
> > > > > RCU would need extra spinlocks to protect the list, and need to 
> > > > > sync_rcu after we delete one instance from thermal_instance 
> > > > > list, I think it is too complicated for me to rewrite: ( How 
> > > > > about using
> > > > thermal_list_lock instead of cdev ->lock?
> > > > > This guy should be big enough to protect the 
> > > > > device.thermal_instance
> > list.
> > > >
> > > > thermal_list_lock protects thermal_tz_list and thermal_cdev_list, 
> > > > but it doesn't protect the thermal_instances list.  For example,
> > > > thermal_zone_bind_cooling_device() adds a cooling device to the
> > > > cdev->thermal_instances list without taking thermal_tz_list.
> > > >
> > > Before thermal_zone_bind_cooling_device is invoked, the 
> > > thermal_list_lock will be firstly gripped:
> > >
> > > static void bind_cdev(struct thermal_cooling_device *cdev) { 
> > > mutex_lock(&thermal_list_lock);
> > > either tz->ops->bind    :   thermal_zone_bind_cooling_device
> > > or __bind()  :   thermal_zone_bind_cooling_device
> > > mutex_unlock(&thermal_list_lock);
> > > }
> > >
> > > And it is the same as in  passive_store.
> > > So when code is trying to add/delete thermal_instance of cdev, he 
> > > has already hold thermal_list_lock IMO. Or do I miss anything?
> > 
> > thermal_zone_bind_cooling_device() is exported, so you can't really 
> > rely on the static thermal_list_lock being acquired in every single call.
> > 
> > thermal_list_lock and protects the lists thermal_tz_list and thermal_cdev_list.
> > Making it implicitly protect the cooling device's and thermal zone 
> > device's instances list because no sensible code would call
> > thermal_zone_bind_cooling_device() outside of a bind function is just 
> > asking for trouble.
> > 
> Yes, from this point of view,it is true. 
> 
> > Locking is hard to understand and easy to get wrong so let's keep it simple.
> > 
> How about the following 2 methods:
> 1. avoid accessing device's thermal_instance,
> but access all thermal_zone_device directly,
>  although there might be some redundancy,
>  some thermal zones do not need to be updated, 
> but we can avoid gripping dev->lock:
> 
> 	mutex_lock(&thermal_list_lock);
> 	list_for_each_entry(pos, &thermal_tz_list, node)
> 		thermal_zone_device_update(tz);
> 	mutex_unlock(&thermal_list_lock); 
> 
> or,
> 2. Once we bind the new device with the thermal_zone_device,
>  we can record that thermal_zone_device, 
> and update that thermal_zone_device alone,the the code would be:
> 	
> 	mutex_lock(&thermal_list_lock);
> 	list_for_each_entry(pos, &thermal_tz_list, node){
> 		if (tz->need_update)
> 			thermal_zone_device_update(tz);
> 	}
> 	mutex_unlock(&thermal_list_lock);

This sounds like a better alternative to me.  I was thinking whether
we could add the thremal_zone_device_update() directly in bind_cdev()
to avoid the need_update field but I don't think it's any better: you
would have to put it in two places (for the bind() and tbp.match()
paths).

With the solution you propose above you only have to put it in
__thermal_cooling_device_register(), which is simpler.  I vote for
your solution (2) above.

> BTW, since thermal_zone_device_update is not atomic, 
> we might need another patch to make it into atomic or 
> something like that, but for now, I think these three patches 
> are just for fixing the regressions.

Yeah, we can fix that in another series.

Cheers,
Javi
