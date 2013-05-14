From: "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>
Subject: Re: Kobject_uevent in cpufreq.c
Date: Tue, 14 May 2013 10:50:22 -0400
Message-ID: <20130514145022.GD14462@kroah.com>
References: <4D68720C2E767A4AA6A8796D42C8EB59C8D667@BGSMSX101.gar.corp.intel.com>
 <20130513115801.GA11433@kroah.com>
 <4D68720C2E767A4AA6A8796D42C8EB59C8D936@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59C8D936@BGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linux PM list (linux-pm@vger.kernel.org)" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 13, 2013 at 04:08:19PM +0000, R, Durgadoss wrote:
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Greg KH
> > (gregkh@linuxfoundation.org)
> > Sent: Monday, May 13, 2013 5:28 PM
> > To: R, Durgadoss
> > Cc: linux-kernel@vger.kernel.org; Linux PM list (linux-pm@vger.kernel.org);
> > Wysocki, Rafael J
> > Subject: Re: Kobject_uevent in cpufreq.c
> > 
> > On Mon, May 13, 2013 at 11:31:57AM +0000, R, Durgadoss wrote:
> > > Hi,
> > >
> > > I am observing an UEvent issue in cpufreq.c.
> > > The cpufreq_add_dev() function is called whenever a core is 'onlined'.
> > > we expect the kobject_uevent() method in cpufreq_add_dev() to
> > > send an UEvent with KOBJ_ADD as the action parameter.
> > >
> > > But this call fails because of the 'filter function' inside kobject_uevent_env
> > > inside lib/kobject_uevent.c. The ->filter points to 'dev_uevent_filter' in
> > > drivers/base/core.c, where the check for 'device_ktype' fails.
> > >
> > > Error message:
> > > kobject: 'cpufreq' (e5bbf290): kobject_uevent_env:
> > > filter function caused the event to drop!
> > >
> > > As far as I can see, we need a kset, and associated filter function
> > > inside cpufreq.c to get this working. Is this the right way to go ?
> > > Any other easy/correct ways to get it working ? Please advise.
> > 
> > What exactly are you trying to do, and want the kernel to do?  You
> > already get on/offline events for CPUs, why do you want them for cpufreq
> > devices as well?
> 
> I want to update the permission of a cpufreq sysfs interface (scaling_*)
> of a cpu (say cpu1) when the cpu resumes from suspend (s3).
> I am trying to do this by listening to the uevent (sent by cpufreq.c,
> when a cpu resumes) through udev.
> 
> For example,
> chmod user:user /sys/devices/system/cpu1/cpufreq/scaling_max_freq
> 
> But I am not able to receive this event in udev, because kobject_uevent()
> call fails due to the above-mentioned reason (i.e filter function)
> I am trying to see how to make the kobject_uevent() call succeed,
> so that I can change the permission as mentioned above.
> 
> The on/offline events come only when I manually do a
> echo 0 > /sys/devices/system/cpu/cpu1/online
> They don't come when the cpu resumes from suspend(s3)

Why not fix this?  My kernel log says that the cpu is being taken
offline and then online when resuming.  So fix that and you should be
fine, right?

thanks,

greg k-h
