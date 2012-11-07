From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Wed, 7 Nov 2012 16:56:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211071653140.1188-100000@iolanthe.rowland.org>
References: <5835880.VrlCHNcBeW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5835880.VrlCHNcBeW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2012, Rafael J. Wysocki wrote:

> > Right.  The reasoning behind my proposal goes like this: When there's
> > no driver, the subsystem can let userspace directly control the
> > device's power level through the power/control attribute.
> 
> Well, we might as well just leave the runtime PM of PCI devices enabled, even
> if they have no drivers, but modify the PCI bus type's runtime PM callbacks
> to ignore devices with no drivers.
> 
> IIRC the reason why we decided to disable runtime PM for PCI device with no
> drivers was that some of them refused to work again after being put by the
> core into D3.  By making the PCI bus type's runtime PM callbacks ignore them
> we'd avoid this problem without modifying the core's behavior.

It comes down to a question of the parent.  If a driverless PCI device
isn't being used, shouldn't its parent be allowed to go into runtime
suspend?  As things stand now, we do allow it.

The problem is that we don't disallow it when the driverless device
_is_ being used.

Alan Stern
