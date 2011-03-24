From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Thu, 24 Mar 2011 19:49:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103241929450.16085__13564.5169452348$1301010741$gmane$org@x980>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<20110324083959.GE30812@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110324083959.GE30812@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

> > Microsoft was able to delete APM from Windows in 2006
> > with the release of Windows Vista. [...]
> 
> Does Windows XP still support it?

yes, and so does Red Hat Linux 9.

> Is weird as there's no such CONFIG_APM entry upstream, and never was. Which 
> tree is this entry included in?

It is a menuconfig option in arch/x86/Kconfig.
APM is available only for X86_32 kernels.

> While i'm not a fan of APM at all, this removal is a tad fast IMHO.
>
> Beyond the lack of a upstream-visible feature-removal-schedule entry, we still 
> have an Arcnet driver which hardware was obsoleted by Ethernet in the late 80s, 
> and we still have i486 support and those are *much* older than APM.

How would you like to write i486 specific code for the latest kernel
and test it on i486 hardware, honestly?

> If you look at the diffstat:
> 
> >  Documentation/feature-removal-schedule.txt |    9 -
> >  MAINTAINERS                                |    8 -
> >  arch/x86/Kconfig                           |  125 --
> >  arch/x86/boot/Makefile                     |    1 -
> >  arch/x86/boot/apm.c                        |   75 -
> >  arch/x86/boot/main.c                       |    5 -
> >  arch/x86/include/asm/bootparam.h           |    3 +-
> >  arch/x86/kernel/Makefile                   |    2 -
> >  arch/x86/kernel/apm_32.c                   | 2463 ----------------------------
> >  arch/x86/kernel/process.c                  |    3 -
> >  arch/x86/kernel/reboot.c                   |    3 -
> >  arch/x86/kernel/setup.c                    |    4 -
> >  12 files changed, 1 insertions(+), 2700 deletions(-)
> 
> You see that the kernel implementation is nicely modularized and its 
> cross-section to the rest of arch/x86/ is minimal. To arch/x86/ it's little 
> more than an obscure driver.

If you look at the hooks in the the diffstat you may be be less
impressed about how modular APM is.  Start with the use of pm_idle
from a module, or pm_flags.  The hackery is not a large number of lines,
but it is still hackery.

> Thus from a maintenance POV APM has not been much of a drag on the x86 
> maintainer side. Sure, we do not test it, but that's the case with most of the 
> obsolete drivers in the kernel.
> 
> The principle is that as long as there's no ongoing drag, the cost of carrying 
> obsolete drivers is minimal - and the unknown cost of screwing someone in a big 
> way by removing hardware support is hard to measure reliably. So we are 
> cautious and err on the side of supporting too much hardware.

I think this reasoning would apply in 2006, but that was 5 years ago.

> Removal could be prepared by:
> 
>  - moving CONFIG_APM to under CONFIG_EXPERT though, and keep it there for a few 
>    releases, and see whether anyone complains
> 
>  - we could emit a WARN() with a "APM support will be obsoleted, please report 
>    this if you depend on this feature" text or so, and see what happens for a 
>    couple of releases.

Okay, I can delay this way:

2.6.39:
	feature-removal.txt targets 2.6.42 removal
	depend on CONFIG_EXPERT

2.6.40, 2.6.41:
	WARN once on run-time access

2.6.42:
	remove.

How does that look?

thanks,
-Len
