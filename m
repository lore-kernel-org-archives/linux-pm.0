From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
Date: Sun, 21 Feb 2016 09:04:39 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C632E@shsmsx102.ccr.corp.intel.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
 <20160216201557.GA6526@amd>
 <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
 <56C5B240.40400@arm.com>
 <36DF59CE26D8EE47B0655C516E9CE640286C628C@shsmsx102.ccr.corp.intel.com>
 <20160220195702.GA22120@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160220195702.GA22120@amd>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Sunday, February 21, 2016 3:57 AM
> To: Chen, Yu C
> Cc: James Morse; linux-arm-kernel@lists.infradead.org; Will Deacon; Sudeep
> Holla; Geoff Levand; Catalin Marinas; Lorenzo Pieralisi; Mark Rutland; AKASHI
> Takahiro; Marc Zyngier; Rafael J . Wysocki; linux-pm@vger.kernel.org
> Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
> different kernel version
> 
> On Sat 2016-02-20 19:16:59, Chen, Yu C wrote:
> >
> > > -----Original Message-----
> > > From: James Morse [mailto:james.morse@arm.com]
> > > Sent: Thursday, February 18, 2016 8:00 PM
> > > To: Chen, Yu C
> > > Cc: Pavel Machek; linux-arm-kernel@lists.infradead.org; Will Deacon;
> > > Sudeep Holla; Geoff Levand; Catalin Marinas; Lorenzo Pieralisi; Mark
> > > Rutland; AKASHI Takahiro; Marc Zyngier; Rafael J . Wysocki;
> > > linux-pm@vger.kernel.org
> > > Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from
> > > a different kernel version
> > >
> > > On 17/02/16 02:20, Chen, Yu C wrote:
> > > >> On Tue 2016-02-16 15:49:27, James Morse wrote:
> > > > This reminds me a similar problem I once encountered on x86 : - )
> > > > The efi memory layout should be strictly the same before/after
> > > > hibernation,
> > > right?
> > >
> > > The kernel hopes it is the same, as the page-tables it uses for
> > > runtime services calls are restored along with the rest of memory,
> > > but there is the risk that these don't match the EFI memory map any
> more.
> > >
> > > Even if the amount of memory is the same, the layout might be different.
> > > (Core hibernate code already has a counter of the number of physical
> > > pages.)
> > I've encountered this situation before.
> > >
> > > I'm still digging through the efi code (and spec), but it is fairly
> > > easy to cause the memory map to change before entry to linux. This
> > > doesn't seem to be a problem, as linux happily overwrites most of
> > > the allocated areas, so it may not be as fragile as I thought.
> > If I did some peripherals plug/unplug after suspend to hibernation,
> > then the next time it boots up there would likely be a slightly different efi
> memory map.
> > The efi provides a callback of get_memory_map to Linux for retrieving
> > the initial map, which depends on the bios/bootloader
> > probing/enumeration IMO. The difference of efi map might lead to kernel
> panic during resume sometimes.
> 
> md5hash of the efi map, and complain to bios vendors if it happens?
> Because iirc it is not supposed to.
Yes, it should not happen, at least for ACPI S4,
however after communicating with some people from bios team, it is said
BIOSen  are designed to  dynamically allocate address space for
resources.  Maybe we can register a panic notifier to check the consistence
of efi map md5hash.
