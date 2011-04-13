From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be smp
	?
Date: Wed, 13 Apr 2011 23:53:09 +0200
Message-ID: <201104132353.09282.rjw__31333.7819105529$1302731621$gmane$org@sisk.pl>
References: <BANLkTi=F-C-vwX4PGGfbkdTBw3OWL-twfg@mail.gmail.com>
	<20110413210546.GC16830@elf.ucw.cz>
	<BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 13, 2011, Mike Frysinger wrote:
> On Wed, Apr 13, 2011 at 17:05, Pavel Machek wrote:
> > On Wed 2011-04-13 17:02:45, Mike Frysinger wrote:
> >> On Wed, Apr 13, 2011 at 16:58, Rafael J. Wysocki wrote:
> >> > On Wednesday, April 13, 2011, Mike Frysinger wrote:
> >> >> when we suspend/resume Blackfin SMP systems, we notice that the
> >> >> freezer code runs on multiple cores.  this is of course what you want
> >> >> -- freeze processes in parallel.  however, the code only uses non-smp
> >> >> based barriers which causes us problems ... our cores need software
> >> >> support to keep caches in sync, so our smp barriers do just that.  but
> >> >> the non-smp barriers do not, and so the frozen/thawed processes
> >> >> randomly get stuck in the wrong task state.
> >> >>
> >> >> thinking about it, shouldnt the freezer code be using smp barriers ?
> >> >
> >> > Yes, it should, but rmb() and wmb() are supposed to be SMP barriers.
> >> >
> >> > Or do you mean something different?
> >>
> >> then what's the diff between smp_rmb() and rmb() ?
> >>
> >> this is what i'm proposing:
> >> --- a/kernel/freezer.c
> >> +++ b/kernel/freezer.c
> >> @@ -17,7 +17,7 @@ static inline void frozen_process(void)
> >>  {
> >>     if (!unlikely(current->flags & PF_NOFREEZE)) {
> >>         current->flags |= PF_FROZEN;
> >> -       wmb();
> >> +       smp_wmb();
> >>     }
> >>     clear_freeze_flag(current);
> >>  }
> >> @@ -93,7 +93,7 @@ bool freeze_task(struct task_struct *p, bool sig_only)
> >>      * the task as frozen and next clears its TIF_FREEZE.
> >>      */
> >>     if (!freezing(p)) {
> >> -       rmb();
> >> +       smp_rmb();
> >>         if (frozen(p))
> >>             return false;
> >
> > smp_rmb() is NOP on uniprocessor.
> >
> > I believe the code is correct as is.
> 
> that isnt what the code / documentation says.  unless i'm reading them
> wrong, both seem to indicate that the proposed patch is what we
> actually want.

Not really.

> include/linux/compiler-gcc.h:
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> include/asm-generic/system.h:
> #define mb()    asm volatile ("": : :"memory")
> #define rmb()   mb()
> #define wmb()   asm volatile ("": : :"memory")
> 
> #ifdef CONFIG_SMP
> #define smp_mb()    mb()
> #define smp_rmb()   rmb()
> #define smp_wmb()   wmb()
> #else
> #define smp_mb()    barrier()
> #define smp_rmb()   barrier()
> #define smp_wmb()   barrier()
> #endif

The above means that smp_*mb() are defined as *mb() if CONFIG_SMP is set,
which basically means that *mb() are more restrictive than the corresponding
smp_*mb().  More precisely, they also cover the cases in which the CPU
reorders instructions on uniprocessor, which we definitely want to cover.

IOW, your patch would break things on uniprocessor where the CPU reorders
instructions.

> Documentation/memory-barriers.txt:
> SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
> systems because it is assumed that a CPU will appear to be self-consistent,
> and will order overlapping accesses correctly with respect to itself.

Exactly, which is not guaranteed in general (e.g. on Alpha).  That is, some
CPUs can reorder instructions in such a way that a compiler barrier is not
sufficient to prevent breakage.

The code _may_ be wrong for a different reason, though.  I need to check.

Thanks,
Rafael
