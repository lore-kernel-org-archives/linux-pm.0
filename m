From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Tue, 29 Sep 2015 17:01:34 +0100
Message-ID: <20150929160133.GA11588@e104805>
References: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
 <20150928142902.GA9175@e104805>
 <36DF59CE26D8EE47B0655C516E9CE64026F22641@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026F22641@SHSMSX101.ccr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Yu,

On Mon, Sep 28, 2015 at 06:52:00PM +0100, Chen, Yu C wrote:
> Hi, Javi,
> 
> > -----Original Message-----
> > From: Javi Merino [mailto:javi.merino@arm.com]
> > Sent: Monday, September 28, 2015 10:29 PM
> > To: Chen, Yu C
> > Cc: linux-pm@vger.kernel.org; edubezval@gmail.com; Zhang, Rui; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH 3/3] Thermal: do thermal zone update after a cooling
> > device registered
> > 
> > On Sun, Sep 27, 2015 at 06:48:44AM +0100, Chen Yu wrote:
> > > From: Zhang Rui <rui.zhang@intel.com>
> > >
> > >
> > 
> > I think you need to hold cdev->lock here, to make sure that no thermal zone
> > is added or removed from cdev->thermal_instances while you are looping.
> > 
> Ah right, will add. If I add the cdev ->lock here, will there be a AB-BA lock with 
> thermal_zone_unbind_cooling_device?

You're right, it could lead to a deadlock.  The locks can't be
swapped because that won't work in step_wise.

The best way that I can think of accessing thermal_instances
atomically is by making it RCU protected instead of with mutexes.
What do you think?


> > Why list_for_each_entry_safe() ?  You are not going to remove any entry, so
> > you can just use list_for_each_entry()
> > 
> > 
> > Why is this so complicated?  Can't you just do:
> > 
> > 	list_for_each_entry(pos, &cdev->thermal_instances, cdev_node)
> >         	thermal_zone_device_update(pos->tz);
> > 
> 
> This is an optimization here:
> Ignore thermal instance that refers to the same thermal zone in this loop,
> this works because bind_cdev() always binds the cooling device to one 
> thermal zone first, and then binds to the next thermal zone.

It has taken me a while to understand this optimization.  Please
document both "if"s in the code.  For the first "if" maybe you can use
list_is_last() to make it easier to understand that you're looking for
the last element in the list:

		if (list_is_last(&pos->cdev_node, &cdev->thermal_instances)) {
			thermal_zone_device_update(pos->tz);

For the second "if" you can say that you only need to run
thermal_zone_device_update() once per thermal zone, even though
multiple thermal instances may refer to the same thermal zone.

Cheers,
Javi
