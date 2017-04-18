From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 09:56:31 -0700
Message-ID: <20170418165631.GD25405@fury>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <dffeb42986e84887b2556987925dbf31@ausx13mpc120.AMER.DELL.COM>
 <CALCETrX8W7Zi2NTAm4kJFbW14HVSYanYQ5sGo78FTgitcWfwAw@mail.gmail.com>
 <0d4e6c4562fb4b85ad4c368ae73dbe06@ausx13mpc120.AMER.DELL.COM>
 <20170413170619.GF2064@fury>
 <b729acdb12d046d3a27c754ff02482d6@ausx13mpc120.AMER.DELL.COM>
 <20170418075401.GC18887@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbdDRQ4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 12:56:36 -0400
Content-Disposition: inline
In-Reply-To: <20170418075401.GC18887@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario.Limonciello@dell.com, luto@kernel.org, kernel@kempniu.pl, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Apr 18, 2017 at 09:54:01AM +0200, Pali Rohár wrote:
> On Thursday 13 April 2017 17:39:56 Mario.Limonciello@dell.com wrote:
> > > > No more than exists today with the dcdbas SMI interface (which
> > > > only if you manually run userspace tools that manipulate the same
> > > > data you can do that technically).
> > > >
> > > > We're all reasonable folks, if there is an instance of this that comes
> > > > up we can make changes to userspace to fix it.
> > > 
> > > Right. As Pali pointed out previously, if there is an existing class driver /
> > > subsystem which supports this functionality we should use that.
> > > 
> > > I suppose one risk will be one GUID exposing both types of methods. Those which
> > > are used by kernel drivers, and those which have no kernel support. Or worse,
> > > methods which have multiple behaviors depending on their input arguments.
> > > 
> > > --
> > 
> > Well the "most" interesting to me is the SMBIOS calling interface on the
> > regular Dell GUID (WMBA IIRC).  That's what is used to manipulate keyboard
> > LED timeouts in dell-laptop (although through direct SMI today).
> > 
> > It's also what is used for other SMBIOS calls like changing random BIOS settings
> > that shouldn't be generically exposed in sysfs but should be controlled by
> > manageability tools.
> > 
> > Example: turning on/off legacy option ROM or changing legacy boot order.
> 
> Which basically means that new WMI /dev/ files does not help for Dell.
> 
> Kernel needs to manipulate with SMBIOS for implementing rfkill, keyboard
> backlight, display brightness and also needs to receive WMI events for
> hotkeys. So kernel modules would lock WMI interface for receiving events
> & sending SMBIOS calls, and userspace would be blocked from usage of
> this WMI GUID.

This is why we can't rely on a method ID granular filter for which methods are
exported to userspace. In my previous reply to Rafael, I suggested platform
drivers decide which method IDs are exported, and for platforms with
insufficient WMI method ID granularity, we will end up exposing methods we also
use in the kernel. The WMI evaluation will need to be centralized and placed
under mutual exclusion. The optional wmi evaluation filter would allow for
drivers to audit incoming calls from userspace to ensure no conflict.

It's not ideal - but I believe it addresses our reality.

> 
> I do not think that we can solve this problem easily in vendor-neutral
> interface. There was argument that WMI API was designed to allow
> userspace applications call firmware functions directly... But we are
> using WMI in kernel and we should not allow both kernel and userspace to
> fight on some WMI API.

We could drop all the in kernel wmi drivers and rely on userspace daemons per
platform.... but I think we all agree that is not where we want this to go. So
we'll need to find a compromise. Even then, we'd need to avoid competition for
common method IDs across multiple userspace applications.

> 
> So for Dell we need for sure some Dell specific interface which covers
> all needed functionality. I'm not sure what everything Dell software
> needs, so what about specifying current usage of Dell SMBIOS/WMI
> functions from existing userspace applications and also planned usage in
> future? Then from this information we can design kernel and userspace
> API which can fit for Dell usage.

This was my initial response as well. The biggest problem with it is it places
Linux imposed restrictions on the WMI mechanism, which will ultimately stifle
innovation and/or leave Linux as a second class citizen for systems which rely
on WMI for userspace firmware management.

> 
> About other vendor WMI's functions... I'm not sure, but there is again
> possibility that rfkill, leds or hotkeys would exists on same WMI GUID
> as other maintenance functions (which userspace wants), so export would
> be again blocked by kernel module for rfkill/leds/hotkeys.
> 
> Therefore I'm not really sure if some /dev/wmi* API would be usefull,
> and not always blocked by kernel module which implements rfkill support.

I'd like to also point out that the Linux kernel has a minimal and targeted set
of WMI drivers generally aimed at making laptops work as expected through the
only mechanism we had access to. To my knowledge, we never sat down to discuss
how WMI should be implemented in the Linux ecosystem. That leaves us in the
situation we are in today, in which Linux essentially took the most expedient
route to making laptops work - which happened to be WMI, but we didn't consider
the broader implications of that mechanism or how what we implemented would
interact with full set of functionality provided by WMI.

So our challenge now is to look at WMI as a whole. How should it be implemented
to achieve feature parity. And then consider how the existing drivers fit into
that. Please see my proposal in response to Rafael's latest reply. I believe it
outlines a reasonable compromise.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
