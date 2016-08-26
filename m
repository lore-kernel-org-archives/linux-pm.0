From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 1/3] cpu/hotplug: Allow suspend/resume CPU to be
 specified
Date: Fri, 26 Aug 2016 11:19:53 +0100
Message-ID: <20160826101952.GF13554@arm.com>
References: <1471438227-8747-1-git-send-email-james.morse@arm.com>
 <1471438227-8747-2-git-send-email-james.morse@arm.com>
 <20160826093241.GC13554@arm.com>
 <alpine.DEB.2.20.1608261207510.5714@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608261207510.5714@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2016 at 12:09:38PM +0200, Thomas Gleixner wrote:
> On Fri, 26 Aug 2016, Will Deacon wrote:
> > On Wed, Aug 17, 2016 at 01:50:25PM +0100, James Morse wrote:
> > > disable_nonboot_cpus() assumes that the lowest numbered online CPU is
> > > the boot CPU, and that this is the correct CPU to run any power
> > > management code on.
> > > 
> > > On x86 this is always correct, as CPU0 cannot (easily) by taken offline.
> > > 
> > > On arm64 CPU0 can be taken offline. For hibernate/resume this means we
> > > may hibernate on a CPU other than CPU0. If the system is rebooted with
> > > kexec 'CPU0' will be assigned to a different physical CPU. This
> > > complicates hibernate/resume as now we can't trust the CPU numbers.
> > > Arch code can find the correct physical CPU, and ensure it is online
> > > before resume from hibernate begins, but also needs to influence
> > > disable_nonboot_cpus()s choice of CPU.
> > > 
> > > Rename disable_nonboot_cpus() as freeze_secondary_cpus() and add an
> > > argument indicating which CPU should be left standing. Follow the logic
> > > in migrate_to_reboot_cpu() to use the lowest numbered online CPU if the
> > > requested CPU is not online.
> > > Add disable_nonboot_cpus() as an inline function that has the existing
> > > behaviour.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > ---
> > > An alternative is to provide two functions calling a common function,
> > > but this would mean spilling the cpu_maps_update_begin() into these two.
> > > 
> > >  include/linux/cpu.h | 6 +++++-
> > >  kernel/cpu.c        | 9 +++++----
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > 
> > Thomas, does this look ok to you? If so, would you prefer to merge this
> > series via -tip, or have us take this one via the arm64 tree?
> 
> You can take it via ARM64. It's not conflicting with the stuff I have in the
> pipeline.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Brill, thanks Thomas.

Will
