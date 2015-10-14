From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Wed, 14 Oct 2015 18:07:39 +0100
Message-ID: <20151014170739.GB2998@e104805>
References: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
 <20150928142902.GA9175@e104805>
 <36DF59CE26D8EE47B0655C516E9CE64026F22641@SHSMSX101.ccr.corp.intel.com>
 <20150929160133.GA11588@e104805>
 <36DF59CE26D8EE47B0655C516E9CE6402865B04D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59703 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbbJNRHn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 13:07:43 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865B04D@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

On Mon, Oct 12, 2015 at 09:23:28AM +0000, Chen, Yu C wrote:
> Hi, Javi
> Sorry for my late response,
> 
> > -----Original Message-----
> > From: Javi Merino [mailto:javi.merino@arm.com]
> > Sent: Wednesday, September 30, 2015 12:02 AM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
> > device registered
> > 
> > Hi Yu,
> > 
> > On Mon, Sep 28, 2015 at 06:52:00PM +0100, Chen, Yu C wrote:
> > > Hi, Javi,
> > >
> > > > -----Original Message-----
> > > > From: Javi Merino [mailto:javi.merino@arm.com]
> > > > Sent: Monday, September 28, 2015 10:29 PM
> > > > To: Chen, Yu C
> > > > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui;
> > > > linux- kernel@vger.kernel.org; stable@vger.kernel.org
> > > > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a
> > > > cooling device registered
> > > >
> > > > On Sun, Sep 27, 2015 at 06:48:44AM +0100, Chen Yu wrote:
> > > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > >
> > > > >
> > > >
> > > > I think you need to hold cdev->lock here, to make sure that no
> > > > thermal zone is added or removed from cdev->thermal_instances while
> > you are looping.
> > > >
> > > Ah right, will add. If I add the cdev ->lock here, will there be a
> > > AB-BA lock with thermal_zone_unbind_cooling_device?
> > 
> > You're right, it could lead to a deadlock.  The locks can't be swapped because
> > that won't work in step_wise.
> > 
> > The best way that I can think of accessing thermal_instances atomically is by
> > making it RCU protected instead of with mutexes.
> > What do you think?
> > 
> RCU would need extra spinlocks to protect the list, and need to sync_rcu after we delete
> one instance from thermal_instance list,  I think it is too complicated for me to rewrite: (
> How about using thermal_list_lock instead of cdev ->lock?
> This guy should be big enough to protect the device.thermal_instance list.

thermal_list_lock protects thermal_tz_list and thermal_cdev_list, but
it doesn't protect the thermal_instances list.  For example,
thermal_zone_bind_cooling_device() adds a cooling device to the
cdev->thermal_instances list without taking thermal_tz_list.

To sum up, you have to protect accessing the cdev->thermal_instances
list but with the current locking scheme, you would create an AB-BA
deadlock.  As I see it you would have to change the locking scheme to
either RCU or add a new mutex that protects the
cdev->thermal_instances and tz->thermal_instances lists and change all
accesses to them to make sure they comply with the new locking scheme.

Is there a better way of solving this?  Cheers,
Javi


