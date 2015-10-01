From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 2/2] PM / sleep: Kick devices that might have been
 reset by firmware
Date: Thu, 1 Oct 2015 10:47:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510011034080.1689-100000@iolanthe.rowland.org>
References: <2877152.vgpvethKO3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2877152.vgpvethKO3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 30 Sep 2015, Rafael J. Wysocki wrote:

> > If that's so then won't this change defeat all the work being done by
> > people trying to prevent unneeded runtime resumes during system resume?
> > direct_complete would be useful only on non-ACPI systems.
> 
> To me at least the main motivation for direct_complete was to avoid unneeded
> runtime resumes during system suspend and this patch doesn't change that.

I always thought that at least part of the motivation was to allow 
devices to remain in runtime suspend throughout an entire system sleep 
transition: The device starts out in runtime suspend before the 
system goes to sleep and it is still in runtime suspend after the 
system wakes up.

> Moreover, there is a difference between scheduling an asynchronous runtime
> resume during system resume and doing a synchrouous runtime resume at that
> point.  In the latter case the resume process has to wait for the runtime
> resume to complete, while in the former case we can get to thawing user
> space while the scheduled runtime resume is in progress (or even still
> waiting for that matter).

True.  However, in practice what generally happened (before you
introduced direct_complete) is that the device would get set back to
full power during the system resume, just as though it had not been in
runtime suspend before the system went to sleep.

If the device uses async suspend/resume then this is not quite as bad
as doing a synchronous runtime resume.  But as you say, it's still not
as good as doing an async runtime resume, so I guess the effects of
your patch aren't quite as bad as I thought at first.

> This means that direct_complete would be useful even for S3 transitions
> with this patch applied.  Not to mention the suspend-to-idle case in which
> the resume really doesn't go through the firmware.

Certainly.

> That said, perhaps the check as proposed is too coarse-grained.  We need to
> do something like this in the ACPI PM domain code (and we do it already) and
> for PCI devices that are likely to be affected by the issue at hand.  So
> what about the appended patch (on top of https://patchwork.kernel.org/patch/7291711/)
> instead?

It seems reasonable.  If it turns out that more drivers need to check 
for firmware interference, we can add them in later on.

Alan Stern

