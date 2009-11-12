From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: GPF in
 run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help
 needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd)
Date: Thu, 12 Nov 2009 21:55:50 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911122153320.24119__13432.3392798708$1258059529$gmane$org@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl>
	<20091111171703.GA28506@redhat.com>
	<alpine.LFD.2.00.0911121821370.24119@localhost.localdomain>
	<200911122153.12419.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911122153.12419.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Nov 2009, Rafael J. Wysocki wrote:

> On Thursday 12 November 2009, Thomas Gleixner wrote:
> > On Wed, 11 Nov 2009, Oleg Nesterov wrote:
> > > Well, yes. Because any buggy user can easily kill the system, and we
> > > constantly have the bugs like this one.
> > > 
> > > I think we should teach workqueue.c to use debugobjects.c at least.
> > 
> > Here you go. Would be interesting to know whether it catches the
> > problem at hand.
> 
> How would I tell if it did?

Apply the patch, enable debugobjects and try to reproduce the failure
- w/o the fix patch of course :)

debugobjects should catch the attempt to free the memory which holds
the work_struct, cancel it and print a backtrace where this happened.

Thanks,

	tglx
