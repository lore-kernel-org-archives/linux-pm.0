From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v3] x86, hotplug: Use hlt instead of mwait if invoked from disable_nonboot_cpus
Date: Thu, 07 Jul 2016 14:25:22 +0200
Message-ID: <14265008.RukW38MkjF@vostro.rjw.lan>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com> <209704957.TWElLMTLfP@vostro.rjw.lan> <577E14F6.6060706@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63135 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750859AbcGGMUp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 08:20:45 -0400
In-Reply-To: <577E14F6.6060706@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org

On Thursday, July 07, 2016 09:38:14 AM James Morse wrote:
> Hi Rafael,
> 
> On 07/07/16 01:33, Rafael J. Wysocki wrote:
> > Below is my sort of version of this (untested) and I did it this way, because
> > the issue is specific to resume from hibernation (the workaround need not be
> > applied anywhere else) and the hibernate_resume_nonboot_cpu_disable() thing may
> > be useful to arm64 too if I'm not mistaken (James?).
> 
> Yes, we will always need to do something extra (based on data in the
> arch_hibernation_header) to resume if CPU0 was offline, or kexec meant we no
> longer know which CPU the firmware will boot us on.
> 
> 
> > Actually, if arm64 uses it too, the __weak implementation can be dropped,
> > because it will be possible to make it depend on ARCH_HIBERNATION_HEADER
> > (x86 and arm64 are the only users of that).
> 
> Heh, I avoided that as it felt too much like a hack!

OK, let's do as follows, then.

I'll queue up this patch for 4.8 if people don't object.

Then you can implement hibernate_resume_nonboot_cpu_disable() as needed on arm64
and we'll drop the __weak thing next.

Since both users of ARCH_HIBERNATION_HEADER will have their own implementations
of hibernate_resume_nonboot_cpu_disable(), we can just make it a static inline
wrapper around disable_nonboot_cpus() if ARCH_HIBERNATION_HEADER is unset.

That actually makes sense, because when ARCH_HIBERNATION_HEADER is unset, then
(a) the layout of the kernel text and static data during image restoration must
be the same as before hibernation (in which case issues like the MWAIT/MONITOR one
on x86 simply cannot happen) and (b) the restore kernel is unable to handle any
differences between the current (ie. image restoration time) and pre-hibernation
configurations of the system.

Thanks,
Rafael

