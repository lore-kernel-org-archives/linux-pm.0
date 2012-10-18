From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: Subject: [PATCH] drivers-core: move device_pm_remove behind
 bus_remove_device
Date: Thu, 18 Oct 2012 08:21:37 +0800
Message-ID: <1350519697.2207.9.camel@ymzhang.sh.intel.com>
References: <F7B8FD780A346D46A0042F5C63B06AE775B2B0@SHSMSX102.ccr.corp.intel.com>
	 <1350286789.2207.6.camel@ymzhang.sh.intel.com>
	 <2338561.PDRRozbqko@vostro.rjw.lan>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2338561.PDRRozbqko@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Zhang, LongX" <longx.zhang@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2012-10-15 at 22:59 +0200, Rafael J. Wysocki wrote:
> On Monday 15 of October 2012 15:39:49 Yanmin Zhang wrote:
> > On Fri, 2012-09-21 at 01:58 +0000, Zhang, LongX wrote:
> > > From: LongX Zhang <longx.zhang@intel.com>
> > > 
> > > device_pm_remove will call pm_runtime_remove which would disable
> > > runtime PM of the device. After that pm_runtime_get* or
> > > pm_runtime_put* will be ingored. So if we disable the runtime PM
> > > before device really be removed, drivers' _remove callback may
> > > access HW even pm_runtime_get* fails. That is bad.
> > The background about the patch: We hit an hang issue when removing a mmc
> > device on Medfield Android phone by sysfs interface.
> > 
> > Consider below call sequence when removing a device:
> > device_del => device_pm_remove
> >            => class_intf->remove_dev(dev, class_intf)  => pm_runtime_get_sync/put_sync
> >            => bus_remove_device => device_release_driver => pm_runtime_get_sync/put_sync
> > 
> > remove_dev might call pm_runtime_get_sync/put_sync.
> > Then, generic device_release_driver also calls pm_runtime_get_sync/put_sync.
> > Since device_del => device_pm_remove firstly, later _get_sync wouldn't really
> > wake up the device.
> > 
> > I git log -p to find the patch which moves the calling to device_pm_remove ahead.
> > It's below patch:
> > 
> > commit 775b64d2b6ca37697de925f70799c710aab5849a
> > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > Date:   Sat Jan 12 20:40:46 2008 +0100
> > 
> >     PM: Acquire device locks on suspend
> >     
> >     This patch reorganizes the way suspend and resume notifications are
> >     sent to drivers.  The major changes are that now the PM core acquires
> >     every device semaphore before calling the methods, and calls to
> >     device_add() during suspends will fail, while calls to device_del()
> >     during suspends will block.
> >     
> >     It also provides a way to safely remove a suspended device with the
> >     help of the PM core, by using the device_pm_schedule_removal() callback
> >     introduced specifically for this purpose, and updates two drivers (msr
> >     and cpuid) that need to use it.
> > 
> > 
> > As device_pm_schedule_removal is deleted by another patch, we need also revert
> > other parts of the patch, i.e. move the calling of device_pm_remove after
> > the calling to bus_remove_device.
> > 
> > > 
> > > Signed-off-by: LongX Zhang <longx.zhang@intel.com>
> 
> Can you please resend the patch?  I lost the track of it unfortunately.
Long sent V2 out. See https://lkml.org/lkml/2012/10/16/594.
