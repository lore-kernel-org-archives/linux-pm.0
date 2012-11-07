From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Wed, 07 Nov 2012 22:44:16 +0100
Message-ID: <5835880.VrlCHNcBeW@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1211071544110.1188-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1211071544110.1188-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 07, 2012 03:47:02 PM Alan Stern wrote:
> On Wed, 7 Nov 2012, Rafael J. Wysocki wrote:
> 
> > On Wednesday, November 07, 2012 12:17:02 PM Alan Stern wrote:
> > > On Wed, 7 Nov 2012, Rafael J. Wysocki wrote:
> > > 
> > > > > The PCI subsystem assumes that 
> > > > > driverless devices are not in use, so they are disabled for runtime PM 
> > > > > and marked as suspended.  This is not appropriate for VGA devices, 
> > > > > which can indeed be used without a driver.
> > > > > 
> > > > > I'm not sure what the best solution is.  Maybe we should Ying's 
> > > > > proposal a step farther:
> > > > > 
> > > > > 	Make pm_runtime_set_suspended() fail if runtime PM is 
> > > > > 	forbidden.
> > > > >
> > > > > 	Make pm_runtime_forbid() call pm_runtime_set_active()
> > > > > 	(and do a runtime resume of the parent) if disable_depth > 0.
> > > > 
> > > > I'd prefer this one.
> > > 
> > > That wasn't meant to be a choice.  The first item is close to what the 
> > > original patch did; I was suggesting that we should adopt all three 
> > > items.
> > 
> > OK, I need to think about this a bit more, then.
> > 
> > The problem seems to be that our initial assumption, ie. that driverless
> > devices won't be in use, is not satisfied in the relevant case.  It may
> > not be satisfied in more cases like this, I suppose, but so far we  don't
> > really know.
> 
> Right.  The reasoning behind my proposal goes like this: When there's
> no driver, the subsystem can let userspace directly control the
> device's power level through the power/control attribute.

Well, we might as well just leave the runtime PM of PCI devices enabled, even
if they have no drivers, but modify the PCI bus type's runtime PM callbacks
to ignore devices with no drivers.

IIRC the reason why we decided to disable runtime PM for PCI device with no
drivers was that some of them refused to work again after being put by the
core into D3.  By making the PCI bus type's runtime PM callbacks ignore them
we'd avoid this problem without modifying the core's behavior.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
