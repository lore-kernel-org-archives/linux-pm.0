From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Wed, 7 Nov 2012 15:47:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211071544110.1188-100000@iolanthe.rowland.org>
References: <4585176.YTc0KTJLfO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51096 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751727Ab2KGUrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Nov 2012 15:47:03 -0500
In-Reply-To: <4585176.YTc0KTJLfO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 7 Nov 2012, Rafael J. Wysocki wrote:

> On Wednesday, November 07, 2012 12:17:02 PM Alan Stern wrote:
> > On Wed, 7 Nov 2012, Rafael J. Wysocki wrote:
> > 
> > > > The PCI subsystem assumes that 
> > > > driverless devices are not in use, so they are disabled for runtime PM 
> > > > and marked as suspended.  This is not appropriate for VGA devices, 
> > > > which can indeed be used without a driver.
> > > > 
> > > > I'm not sure what the best solution is.  Maybe we should Ying's 
> > > > proposal a step farther:
> > > > 
> > > > 	Make pm_runtime_set_suspended() fail if runtime PM is 
> > > > 	forbidden.
> > > >
> > > > 	Make pm_runtime_forbid() call pm_runtime_set_active()
> > > > 	(and do a runtime resume of the parent) if disable_depth > 0.
> > > 
> > > I'd prefer this one.
> > 
> > That wasn't meant to be a choice.  The first item is close to what the 
> > original patch did; I was suggesting that we should adopt all three 
> > items.
> 
> OK, I need to think about this a bit more, then.
> 
> The problem seems to be that our initial assumption, ie. that driverless
> devices won't be in use, is not satisfied in the relevant case.  It may
> not be satisfied in more cases like this, I suppose, but so far we  don't
> really know.

Right.  The reasoning behind my proposal goes like this: When there's
no driver, the subsystem can let userspace directly control the
device's power level through the power/control attribute.

Alan Stern

