From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Wed, 07 Nov 2012 17:09:16 +0100
Message-ID: <2385996.Tx2Do9TUNJ@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1211071032070.1859-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60662 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2KGQFF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Nov 2012 11:05:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211071032070.1859-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, November 07, 2012 10:49:04 AM Alan Stern wrote:
> On Wed, 7 Nov 2012, Huang Ying wrote:
> 
> > > > Devices will be disabled if the PCI driver is unbound from the PCI
> > > > device.
> > > 
> > > Yes.  But without a PCI driver, nothing will call 
> > > pm_runtime_set_suspended.
> > 
> > pm_runtime_set_suspended will be called in pci_device_remove or error
> > path of local_pci_probe.
> 
> Yes, okay.  But that's what we want.  Unused, driverless PCI devices
> shouldn't force their parents to remain at full power.
> 
> > >   And even if something does call 
> > > pm_runtime_set_suspended, it's still not a problem -- the device can't 
> > > be used without a driver.
> > 
> > The VGA device can be used without a driver.
> 
> Ah, right, that's your _real_ problem.  You should have mentioned this 
> in the original Changelog for the patch.
> 
> Rafael, this does need to be fixed.

Yup.

> The PCI subsystem assumes that 
> driverless devices are not in use, so they are disabled for runtime PM 
> and marked as suspended.  This is not appropriate for VGA devices, 
> which can indeed be used without a driver.
> 
> I'm not sure what the best solution is.  Maybe we should Ying's 
> proposal a step farther:
> 
> 	Make pm_runtime_set_suspended() fail if runtime PM is 
> 	forbidden.
>
> 	Make pm_runtime_forbid() call pm_runtime_set_active()
> 	(and do a runtime resume of the parent) if disable_depth > 0.

I'd prefer this one.  The callers of pm_runtime_forbid() may actually
reasonably expect something like this to happen.

> 	Make the PCI runtime-idle routine call 
> 	pm_runtime_set_suspended() if disable_depth > 0.  Or maybe
> 	do this for all devices, in the runtime PM core.

That would mean calling it on every call to pm_runtime_put() and friends
which seems to be a bit wasteful.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
