From: Pavel Machek <pavel@ucw.cz>
Subject: Re: freezer: should barriers be smp ?
Date: Wed, 13 Apr 2011 23:05:46 +0200
Message-ID: <20110413210546.GC16830__5937.64864975146$1302728941$gmane$org@elf.ucw.cz>
References: <BANLkTi=F-C-vwX4PGGfbkdTBw3OWL-twfg@mail.gmail.com>
	<201104132258.17705.rjw@sisk.pl>
	<BANLkTiknfeTj6GD0t-ekMoaS1QYQBVyBjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTiknfeTj6GD0t-ekMoaS1QYQBVyBjQ@mail.gmail.com>
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

On Wed 2011-04-13 17:02:45, Mike Frysinger wrote:
> On Wed, Apr 13, 2011 at 16:58, Rafael J. Wysocki wrote:
> > On Wednesday, April 13, 2011, Mike Frysinger wrote:
> >> when we suspend/resume Blackfin SMP systems, we notice that the
> >> freezer code runs on multiple cores. =A0this is of course what you want
> >> -- freeze processes in parallel. =A0however, the code only uses non-smp
> >> based barriers which causes us problems ... our cores need software
> >> support to keep caches in sync, so our smp barriers do just that. =A0b=
ut
> >> the non-smp barriers do not, and so the frozen/thawed processes
> >> randomly get stuck in the wrong task state.
> >>
> >> thinking about it, shouldnt the freezer code be using smp barriers ?
> >
> > Yes, it should, but rmb() and wmb() are supposed to be SMP barriers.
> >
> > Or do you mean something different?
> =

> then what's the diff between smp_rmb() and rmb() ?
> =

> this is what i'm proposing:
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -17,7 +17,7 @@ static inline void frozen_process(void)
>  {
>     if (!unlikely(current->flags & PF_NOFREEZE)) {
>         current->flags |=3D PF_FROZEN;
> -       wmb();
> +       smp_wmb();
>     }
>     clear_freeze_flag(current);
>  }
> @@ -93,7 +93,7 @@ bool freeze_task(struct task_struct *p, bool sig_only)
>      * the task as frozen and next clears its TIF_FREEZE.
>      */
>     if (!freezing(p)) {
> -       rmb();
> +       smp_rmb();
>         if (frozen(p))
>             return false;

smp_rmb() is NOP on uniprocessor.

I believe the code is correct as is.
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
