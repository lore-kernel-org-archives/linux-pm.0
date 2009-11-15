From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on	resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps	related to preempt_count leakage in keventd)
Date: Mon, 16 Nov 2009 00:37:06 +0100
Message-ID: <20091115233703.GA6090__20868.242919869$1258389789$gmane$org@nowhere>
References: <200911091250.31626.rjw@sisk.pl> <200911092145.27485.rjw@sisk.pl>
	<alpine.LFD.2.01.0911091339290.31845@localhost.localdomain>
	<200911100119.38019.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
	<20091111171703.GA28506@redhat.com>
	<alpine.LFD.2.00.0911121821370.24119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911121821370.24119@localhost.localdomain>
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
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 12, 2009 at 06:33:00PM +0100, Thomas Gleixner wrote:
> @@ -145,6 +255,7 @@ static void __queue_work(struct cpu_work
>  {
>  	unsigned long flags;
>  
> +	debug_work_activate(work);
>  	spin_lock_irqsave(&cwq->lock, flags);
>  	insert_work(cwq, work, &cwq->worklist);



Since you are doing that from insert_wq_barrier too, which
endpoint is also insert_work(), why not put debug_work_activate
there instead? Or may be you really prefer to do this outside
the spinlock (which in off-case is zero-overhead). May be that
can sleep or?
