From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Sat, 12 Sep 2015 13:40:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509121338090.13622-100000@netrider.rowland.org>
References: <5347923.qphJvWEeRm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:33525 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752004AbbILRk4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2015 13:40:56 -0400
In-Reply-To: <5347923.qphJvWEeRm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 12 Sep 2015, Rafael J. Wysocki wrote:

> On Friday, September 11, 2015 03:01:14 PM Alan Stern wrote:

> > There's also an issue about other types of dependencies.  For instance,
> > it's conceivable that device B might be discovered and depend on device
> > A, even before A has been bound to a driver.  (B might be discovered by 
> > A's subsystem rather than A's driver.)  In that case, moving A to the 
> > end of the list would cause B to come before A even though B depends on 
> > A.  Of course, deferred probing already has this problem.
> 
> That may actually happen for PCIe ports and devices below them AFAICS.
> 
> Devices below PCIe ports are discovered by the PCI subsystem and the PCIe
> ports need not be probed before those devices are probed.

Is it possible to change this?  Make it so that devices below PCIe 
ports are discovered by the port driver rather than by the PCI 
subsystem?  Or would that be far too difficult?

> > An easy way to check for this sort of thing would be to verify that a 
> > device about to be probed doesn't have any children.  This wouldn't 
> > catch all the potential dependencies, but it would be a reasonable 
> > start.
> 
> That would address the PCIe ports issue.

Well, it would _detect_ the PCIe ports issue.  It might also detect 
other things.

Alan Stern

