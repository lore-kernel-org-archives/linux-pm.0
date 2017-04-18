From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 09:54:01 +0200
Message-ID: <20170418075401.GC18887@pali>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <dffeb42986e84887b2556987925dbf31@ausx13mpc120.AMER.DELL.COM>
 <CALCETrX8W7Zi2NTAm4kJFbW14HVSYanYQ5sGo78FTgitcWfwAw@mail.gmail.com>
 <0d4e6c4562fb4b85ad4c368ae73dbe06@ausx13mpc120.AMER.DELL.COM>
 <20170413170619.GF2064@fury>
 <b729acdb12d046d3a27c754ff02482d6@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34514 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755123AbdDRHyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 03:54:05 -0400
Content-Disposition: inline
In-Reply-To: <b729acdb12d046d3a27c754ff02482d6@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, luto@kernel.org, kernel@kempniu.pl, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday 13 April 2017 17:39:56 Mario.Limonciello@dell.com wrote:
> > > No more than exists today with the dcdbas SMI interface (which
> > > only if you manually run userspace tools that manipulate the same
> > > data you can do that technically).
> > >
> > > We're all reasonable folks, if there is an instance of this that comes
> > > up we can make changes to userspace to fix it.
> > 
> > Right. As Pali pointed out previously, if there is an existing class driver /
> > subsystem which supports this functionality we should use that.
> > 
> > I suppose one risk will be one GUID exposing both types of methods. Those which
> > are used by kernel drivers, and those which have no kernel support. Or worse,
> > methods which have multiple behaviors depending on their input arguments.
> > 
> > --
> 
> Well the "most" interesting to me is the SMBIOS calling interface on the
> regular Dell GUID (WMBA IIRC).  That's what is used to manipulate keyboard
> LED timeouts in dell-laptop (although through direct SMI today).
> 
> It's also what is used for other SMBIOS calls like changing random BIOS settings
> that shouldn't be generically exposed in sysfs but should be controlled by
> manageability tools.
> 
> Example: turning on/off legacy option ROM or changing legacy boot order.

Which basically means that new WMI /dev/ files does not help for Dell.

Kernel needs to manipulate with SMBIOS for implementing rfkill, keyboard
backlight, display brightness and also needs to receive WMI events for
hotkeys. So kernel modules would lock WMI interface for receiving events
& sending SMBIOS calls, and userspace would be blocked from usage of
this WMI GUID.

I do not think that we can solve this problem easily in vendor-neutral
interface. There was argument that WMI API was designed to allow
userspace applications call firmware functions directly... But we are
using WMI in kernel and we should not allow both kernel and userspace to
fight on some WMI API.

So for Dell we need for sure some Dell specific interface which covers
all needed functionality. I'm not sure what everything Dell software
needs, so what about specifying current usage of Dell SMBIOS/WMI
functions from existing userspace applications and also planned usage in
future? Then from this information we can design kernel and userspace
API which can fit for Dell usage.

About other vendor WMI's functions... I'm not sure, but there is again
possibility that rfkill, leds or hotkeys would exists on same WMI GUID
as other maintenance functions (which userspace wants), so export would
be again blocked by kernel module for rfkill/leds/hotkeys.

Therefore I'm not really sure if some /dev/wmi* API would be usefull,
and not always blocked by kernel module which implements rfkill support.

-- 
Pali Rohár
pali.rohar@gmail.com
