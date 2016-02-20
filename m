From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
Date: Sat, 20 Feb 2016 20:57:02 +0100
Message-ID: <20160220195702.GA22120@amd>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
 <20160216201557.GA6526@amd>
 <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
 <56C5B240.40400@arm.com>
 <36DF59CE26D8EE47B0655C516E9CE640286C628C@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37577 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbcBTT5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 14:57:05 -0500
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C628C@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: James Morse <james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat 2016-02-20 19:16:59, Chen, Yu C wrote:
> 
> > -----Original Message-----
> > From: James Morse [mailto:james.morse@arm.com]
> > Sent: Thursday, February 18, 2016 8:00 PM
> > To: Chen, Yu C
> > Cc: Pavel Machek; linux-arm-kernel@lists.infradead.org; Will Deacon; Sudeep
> > Holla; Geoff Levand; Catalin Marinas; Lorenzo Pieralisi; Mark Rutland; AKASHI
> > Takahiro; Marc Zyngier; Rafael J . Wysocki; linux-pm@vger.kernel.org
> > Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
> > different kernel version
> > 
> > On 17/02/16 02:20, Chen, Yu C wrote:
> > >> On Tue 2016-02-16 15:49:27, James Morse wrote:
> > > This reminds me a similar problem I once encountered on x86 : - ) The
> > > efi memory layout should be strictly the same before/after hibernation,
> > right?
> > 
> > The kernel hopes it is the same, as the page-tables it uses for runtime
> > services calls are restored along with the rest of memory, but there is the risk
> > that these don't match the EFI memory map any more.
> > 
> > Even if the amount of memory is the same, the layout might be different.
> > (Core hibernate code already has a counter of the number of physical pages.)
> I've encountered this situation before.
> > 
> > I'm still digging through the efi code (and spec), but it is fairly easy to cause
> > the memory map to change before entry to linux. This doesn't seem to be a
> > problem, as linux happily overwrites most of the allocated areas, so it may
> > not be as fragile as I thought.
> If I did some peripherals plug/unplug after suspend to hibernation,
> then the next time it boots up there would likely be a slightly different efi memory map.
> The efi provides a callback of get_memory_map to Linux for retrieving the initial map,
> which depends on the bios/bootloader probing/enumeration IMO. The difference of efi
> map might lead to kernel panic during resume sometimes.

md5hash of the efi map, and complain to bios vendors if it happens?
Because iirc it is not supposed to.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
