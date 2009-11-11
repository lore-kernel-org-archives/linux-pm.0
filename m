From: Oliver Neukum <oliver@neukum.org>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 22:15:08 +0100
Message-ID: <200911112215.08126.oliver__4106.29343609816$1257974086$gmane$org@neukum.org>
References: <200911091250.31626.rjw@sisk.pl> <200911112100.16561.rjw@sisk.pl>
	<20091111202433.GA5714@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111202433.GA5714@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-bluetooth@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 11. November 2009 21:24:33 schrieb Oleg Nesterov:
> > So, it looks like the bug is in btusb_destruct(), which should call
> > cancel_work_sync() on data->waker before freeing 'data'.  I guess it
> > should do the same for data->work.
> 
> Or. btusb_suspend() and btusb_close() do cancel_work_sync(data->work),
> perhaps they should cancel data->waker as well, I dunno.
> 
> I added Oliver to cc.

btusb_close() must do it. btusb_suspend() must not do it.

	Regards
		Oliver
