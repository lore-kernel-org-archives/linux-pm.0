From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] freezer vs stopped or traced
Date: Tue, 4 Mar 2008 23:19:20 +0100
Message-ID: <20080304221920.GB7646__14313.5230210193$1204669260$gmane$org@elf.ucw.cz>
References: <20080304042205.4DA9F2700FB@magilla.localdomain>
	<200803042302.44828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803042302.44828.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > This changes the "freezer" code used by suspend/hibernate in its treatment
> > of tasks in TASK_STOPPED (job control stop) and TASK_TRACED (ptrace) states.
> > 
> > As I understand it, the intent of the "freezer" is to hold all tasks
> > from doing anything significant.  For this purpose, TASK_STOPPED and
> > TASK_TRACED are "frozen enough".  It's possible the tasks might resume
> > from ptrace calls (if the tracer were unfrozen) or from signals
> > (including ones that could come via timer interrupts, etc).  But this
> > doesn't matter as long as they quickly block again while "freezing" is
> > in effect.  Some minor adjustments to the signal.c code make sure that
> > try_to_freeze() very shortly follows all wakeups from both kinds of
> > stop.  This lets the freezer code safely leave stopped tasks unmolested.
> > 
> > Changing this fixes the longstanding bug of seeing after resuming from
> > suspend/hibernate your shell report "[1] Stopped" and the like for all
> > your jobs stopped by ^Z et al, as if you had freshly fg'd and ^Z'd them.
> > It also removes from the freezer the arcane special case treatment for
> > ptrace'd tasks, which relied on intimate knowledge of ptrace
> > internals.

I'm glad someone who actually understands signal code got to look at
this ;-). The patch looks okay to me, but I can't say I'm too
qualified in this area.

...but this is 2.6.26 material, right?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
