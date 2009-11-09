From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd
Date: Mon, 9 Nov 2009 21:00:58 +0100
Message-ID: <200911092100.58187.rjw__49998.4218310148$1257796880$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <200911091836.30349.rjw@sisk.pl>
	<alpine.LFD.2.00.0911091949500.2725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0911091949500.2725@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2009, Thomas Gleixner wrote:
> On Mon, 9 Nov 2009, Rafael J. Wysocki wrote:
> 
> > On Monday 09 November 2009, Mike Galbraith wrote:
> > > On Mon, 2009-11-09 at 16:47 +0100, Rafael J. Wysocki wrote:
> > > > On Monday 09 November 2009, Mike Galbraith wrote:
> > > 
> > > > > > Very likely.  What did you do to fix it?
> > > > > 
> > > > > You don't really wanna know.  In 31 with newidle enabled, the below
> > > > > fixed it.  It won't fix 32, though it might cure the resume problem.
> > > > 
> > > > OK, I'll give it a try.
> > 
> > It doesn't help.
> > 
> > Also, I can reproduce the issue with current -git and kernel preepmtion
> > disabled.
> > 
> > > I just tried to trigger badness via high speed online/offline combined
> > > with taskset with CONFIG_PREEMPT enabled, and couldn't make it explode.
> > 
> > I'm not able to do it this way too, so resume seems to be necessary to trigger
> > it.  I'm going try with the suspend debug in the "core" mode.
> > 
> > > (damn, wish i could s2ram this box)
> > 
> > That need not suffice.  I have two other boxes that suspend and resume
> > correctly with 2.6.32-rc, AFAICS.
> > 
> > However, there seems to be a systematic error somewhere, since the failure
> > always happens at the same place, ie. list_del_init(cwq->worklist.next); in
> > run_workqueue(), in preemptible as well as in non-preemptible kernels.
> > 
> > Which is kind of strange, given the !list_empty(&cwq->worklist) test right
> > before it.
> 
> Does that happen before or after the secondary CPU has been brought up ?

Way after.  It seems to happen more-or-less during or right after the thawing
of tasks.

Moreover, the call trace I get is (manual transcription):

? autoremove_wake_function+0x0
? worker_thread+0x0
kthread+0x69
child_rip+0xa

where kthread+0x69 is the do_exit(ret); in kthread().  Afterwards it says
that "events/0" exited with preempt_count = 1 (it sometimes is "events/1"
IIRC).

Still, RIP always points to list_del_init(cwq->worklist.next); in
run_workqueue().

Thanks,
Rafael
