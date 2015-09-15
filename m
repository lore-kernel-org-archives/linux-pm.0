From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 15 Sep 2015 10:23:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509151020030.1420-100000@iolanthe.rowland.org>
References: <CAJZ5v0ip4yOWxYXy6Qq8xViTYWvFvHOHcjjDAc-2Aj75rkfjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ip4yOWxYXy6Qq8xViTYWvFvHOHcjjDAc-2Aj75rkfjcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Sep 2015, Rafael J. Wysocki wrote:

> Hi Alan,

Hi.

> On Sat, Sep 12, 2015 at 7:40 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sat, 12 Sep 2015, Rafael J. Wysocki wrote:
> >
> >> On Friday, September 11, 2015 03:01:14 PM Alan Stern wrote:
> >
> >> > There's also an issue about other types of dependencies.  For instance,
> >> > it's conceivable that device B might be discovered and depend on device
> >> > A, even before A has been bound to a driver.  (B might be discovered by
> >> > A's subsystem rather than A's driver.)  In that case, moving A to the
> >> > end of the list would cause B to come before A even though B depends on
> >> > A.  Of course, deferred probing already has this problem.
> >>
> >> That may actually happen for PCIe ports and devices below them AFAICS.
> >>
> >> Devices below PCIe ports are discovered by the PCI subsystem and the PCIe
> >> ports need not be probed before those devices are probed.
> >
> > Is it possible to change this?  Make it so that devices below PCIe
> > ports are discovered by the port driver rather than by the PCI
> > subsystem?  Or would that be far too difficult?
> 
> I don't think it would be really useful.
> 
> PCIe ports are PCI bridges from the resource allocation and basic
> functionality perspective, so they are handled accordingly.
> 
> The PCIe port driver provides additional services (such as PME/hotplug
> interrupt handling and advanced error reporting) that aren't necessary
> for probing devices below the ports.
> 
> I guess the ordering of PCIe ports probing might be changed to happen
> at the "right" time, but care needs to be taken in that case too.

Does suspending a PCIe port do anything significant?  In particular, 
does it cut off normal communication with anything attached through 
the port?

If it does then we better not move the port device to the end of the 
dpm_list after any descendant devices have been probed.

> >> > An easy way to check for this sort of thing would be to verify that a
> >> > device about to be probed doesn't have any children.  This wouldn't
> >> > catch all the potential dependencies, but it would be a reasonable
> >> > start.
> >>
> >> That would address the PCIe ports issue.
> >
> > Well, it would _detect_ the PCIe ports issue.
> 
> That's what I meant. :-)
> 
> >  It might also detect other things.
> 
> Right.

All right, I'll try writing a test patch to report these things.

Alan Stern
