From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:18:50 +0100
Message-ID: <200911112218.50616.rjw__42594.2877460786$1257974424$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <1257970719.21467.4.camel@violet>
	<alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 November 2009, Linus Torvalds wrote:
> 
> On Wed, 11 Nov 2009, Marcel Holtmann wrote:
> > 
> > As it seems the btusb_close() only cancels the work workqueue and not
> > the waker workqueue. Could that be the problem.
> 
> It's the waker workqueue that Rafael apparently sees with the debug patch 
> from Oleg, so yeah, that sounds possible.
> 
> Rafael, since apparently htusb_close() _is_ called, does the following 
> simpler patch fix it for you? I bet your patch does it too.

Yes and yes.

And in fact this is a post-2.6.31 regression introduced by commit
7bee549e197c9c0e92b89857a409675c1d5e9dff (Bluetooth: Add USB autosuspend
support to btusb driver).

Thanks,
Rafael
