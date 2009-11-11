From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on	resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps	related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 21:24:33 +0100
Message-ID: <20091111202433.GA5714__9650.33554607562$1257971617$gmane$org@redhat.com>
References: <200911091250.31626.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
	<20091111161348.GA27394@redhat.com>
	<200911112100.16561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911112100.16561.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-bluetooth@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On 11/11, Rafael J. Wysocki wrote:
>
> On Wednesday 11 November 2009, Oleg Nesterov wrote:
> >
> > Rafael, could you reproduce the problem with the debugging patch below?
> > It tries to detect the case when the pending work was corrupted and
> > prints its work->func (saved in the previous item). It should work
> > if the work_struct was freed and poisoned, or if it was re-initialized.
> > See ck_work().
>
> I applied the patch and this is the result of 'dmesg | grep ERR' after 10-or-so
> consecutive suspend-resume and hibernate-resume cycles:
>
> [  129.008689] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  166.477373] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  203.983665] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  241.636547] ERR!! btusb_waker+0x0/0x27 [btusb]
>
> which kind of confirms my previous observation that the problem was not
> reproducible without Bluetooth.

Great, thanks.

> So, it looks like the bug is in btusb_destruct(), which should call
> cancel_work_sync() on data->waker before freeing 'data'.  I guess it should
> do the same for data->work.

Or. btusb_suspend() and btusb_close() do cancel_work_sync(data->work),
perhaps they should cancel data->waker as well, I dunno.

I added Oliver to cc.

Oleg.
