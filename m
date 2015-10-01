From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] PM / sleep: Kick devices that might have been reset by firmware
Date: Fri, 02 Oct 2015 00:13:14 +0200
Message-ID: <3446407.Q6TTez3Khz@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510011034080.1689-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43576 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750767AbbJAVov (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 17:44:51 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510011034080.1689-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>

On Thursday, October 01, 2015 10:47:26 AM Alan Stern wrote:
> On Wed, 30 Sep 2015, Rafael J. Wysocki wrote:
> 
> > > If that's so then won't this change defeat all the work being done by
> > > people trying to prevent unneeded runtime resumes during system resume?
> > > direct_complete would be useful only on non-ACPI systems.
> > 
> > To me at least the main motivation for direct_complete was to avoid unneeded
> > runtime resumes during system suspend and this patch doesn't change that.
> 
> I always thought that at least part of the motivation was to allow 
> devices to remain in runtime suspend throughout an entire system sleep 
> transition: The device starts out in runtime suspend before the 
> system goes to sleep and it is still in runtime suspend after the 
> system wakes up.

Well, that was part of it, but the real issue was that we were resuming
all PCI devices unconditionally during system suspend.  When we tried to
address this, we noticed that the suspended device actually need not be
resumed at all throughout the whole cycle.

> > Moreover, there is a difference between scheduling an asynchronous runtime
> > resume during system resume and doing a synchrouous runtime resume at that
> > point.  In the latter case the resume process has to wait for the runtime
> > resume to complete, while in the former case we can get to thawing user
> > space while the scheduled runtime resume is in progress (or even still
> > waiting for that matter).
> 
> True.  However, in practice what generally happened (before you
> introduced direct_complete) is that the device would get set back to
> full power during the system resume, just as though it had not been in
> runtime suspend before the system went to sleep.

Right.

> If the device uses async suspend/resume then this is not quite as bad
> as doing a synchronous runtime resume.  But as you say, it's still not
> as good as doing an async runtime resume, so I guess the effects of
> your patch aren't quite as bad as I thought at first.

Plus even if the device uses async suspend/resume, but it happens to be the
slowest device in at least one stage of resume (eg. the "resume" stage), then
the whole resume process needs to wait for it anyway, whereas it doesn't
need to wait at all if an async runtime resume is scheduled at the end of the
"complete" stage.

> > This means that direct_complete would be useful even for S3 transitions
> > with this patch applied.  Not to mention the suspend-to-idle case in which
> > the resume really doesn't go through the firmware.
> 
> Certainly.
> 
> > That said, perhaps the check as proposed is too coarse-grained.  We need to
> > do something like this in the ACPI PM domain code (and we do it already) and
> > for PCI devices that are likely to be affected by the issue at hand.  So
> > what about the appended patch (on top of https://patchwork.kernel.org/patch/7291711/)
> > instead?
> 
> It seems reasonable.  If it turns out that more drivers need to check 
> for firmware interference, we can add them in later on.

OK, let me respin it with a changelog, then.

Thanks,
Rafael

