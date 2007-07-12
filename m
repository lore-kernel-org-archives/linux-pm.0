From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 14:46:13 +0200
Message-ID: <200707121446.14170.rjw__46463.4282434874$1184243979$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<4695C096.5080400@goop.org>
	<Pine.LNX.4.64.0707112319550.28090@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707112319550.28090@asgard.lang.hm>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 July 2007 08:43, david@lang.hm wrote:
> On Wed, 11 Jul 2007, Jeremy Fitzhardinge wrote:
> 
> > Andrew Morton wrote:
> >>  On Wed, 11 Jul 2007 15:30:31 +0000
> >>  "Huang, Ying" <ying.huang@intel.com> wrote:
> >> 
> >> >  1. Boot a kernel A
> >> >  2. Work under kernel A
> >> >  3. Kexec another kernel B in kernel A
> >> >  4. Work under kernel B
> >> >  5. Jump from kernel B to kernel A
> >> >  6. Continue work under kernel A
> >> > 
> >> >  This is the first step to implement kexec based hibernation. If the
> >> >  memory image of kernel A is written to or read from a permanent media
> >> >  in step 4, a preliminary version of kexec based hibernation can be
> >> >  implemented.
> >> > 
> >> >  The kernel B is run as a crashdump kernel in reserved memory
> >> >  region. This is the biggest constrains of the patch. It is planed to
> >> >  be eliminated in the next version. That is, instead of reserving memory
> >> >  region previously, the needed memory region is backuped before kexec
> >> >  and restored after jumping back.
> >> > 
> >> >  Another constrains of the patch is that the CONFIG_ACPI must be turned
> >> >  off to make kexec jump work. Because ACPI will put devices into low
> >> >  power state, the kexeced kernel can not be booted properly under
> >> >  it. This constrains can be eliminated by separating the suspend method
> >> >  and hibernation method of the devices as proposed earlier in the LKML.
> >> > 
> >> >  The kexec jump is implemented in the framework of software suspend. In
> >> >  fact, the kexec based hibernation can be seen as just implementing the
> >> >  image writing and reading method of software suspend with a kexeced
> >> >  Linux kernel.
> >> > 
> >
> > I guess I'm (still) confused by the terminology here.  Do you mean that it 
> > fits into suspend-to-disk as a disk-writing mechanism, or in suspend-to-ram 
> > as a way of going to sleep?
> 
> Suspend-to-ram involves stopping the system and shutting down devices to 
> go into low-power mode, then on wakeup restarting devices and resuming 
> operation
> 
> so the steps would be.
> 
> 1. stop userspace
> 
> 2. walk the system device tree and put devices to sleep
> 
> 3. go into the lowest power mode available and wait for a wakeup signal
> 
> later
> 
> 4. walk the system device tree and wake up devices
> 
> 5. resume userspace scheduling.

Note that we are going to phase out steps 1 and 5.

> note that what devices get put to sleep could be configurable, potentially 
> to the extreme of things like the OLPC (that have hardware designed for 
> cheap sleeping) going into a light suspend-to-ram state between keystrokes 
> if nothing else has a timer event scheduled before that.
> 
> Suspend-do-disk (Hibernate) involves stopping the system, makeing a 
> snapshot of ram, writing the snapshot to somewhere and powering off the 
> box. on wakeup (power-on) a helper kernel boots, loads the snapshot into 
> ram and jumps to the kernel in the snapshot to resume operation.
> 
> as I understand the proposal the thought is to do the following
> 
> 1. system kernel does suspend-to-ram to put the devices into a known safe 
> state.

Not necessarily suspend-to-RAM.  I'd much prefer it if devices were not put
into low power states but quiesced (ie. no DMA, no interrupts).

> 2. system kernel uses kexec to start hibernate kernel
> 
> 3. hibernate kernel wakes up devices it needs as if it was doing a 
> resume-from-ram

I think that the devices should be initialized from scratch in this step.

> 4. hibernate kernel copies ram image somewhere

In this step some userland may be involved (started from the "hibernate"
kernel).
 
> 5. hibernate kernel shuts down the box
> 
> later
> 
> 6. hibernate kernel boots
> 
> 7. hibernate kernel copies ram image from somewhere
> 
> 8. hibernate kernel does syspend-to-ram to put the devices into a known 
> safe state.

Again, the devices should be quiesced rather then suspended in this step.

> 9. hibernate kernel uses kexec to start system kernel
> 
> 10. system kernel wakes up devices it needs as if it was doing a 
> resume-from-ram.

I think it should reconfigure devices from scratch (ie. reprobe).

> >> >  Now, only the i386 architecture is supported. The patch is based on
> >> >  Linux kernel 2.6.22, and has been tested on my IBM T42.
> >> > 
> >>
> >>  This sounds awesome.  Am I correct in expecting that ultimately the
> >>  existing hibernation implementation just goes away and we reuse (and hence
> >>  strengthen) the existing kexec (and kdump?) infrastructure?
> >>
> >>  And that we get hibernation support almost for free on all kexec (and
> >>  relocatable-kernel?) capable architectures?
> >>
> >>  And that all the management of hibernation and resume happens in
> >>  userspace?
> 
> this is the thought.
> 
> >>  I didn't understand the ACPI problem.  Does this mean that CONFIG_ACPI
> >>  must
> >>  be disabled in the to-be-hibernated kernel, or in the little transient
> >>  kexec kernel?
> >> 
> >
> > I think the point is that if kernel A says "I'm suspending" and calls the 
> > suspend method on all its devices, then kernel B finds that it has no powered 
> > on devices to work with.  But then couldn't it turn on the ones it wants 
> > anyway?  And don't you want to suspend them, to make sure they're not still 
> > DMAing memory while B is trying to shuffle everything off to disk?
> 
> I don't understand the ACPI problem so I can't try to clarify it.
> 
> > It does sound pretty cool.
> 
> re-useing existing components in new ways, making it so that particular 
> problems only have to be solved once and that solution is used repeatedly. 
> there's a lot to like about this approach.
> 
> very cool.

Well, I'm not a big fan of it right now, but well, it looks doable in general.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
