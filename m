From: Tejun Heo <tj@kernel.org>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on resume
Date: Fri, 13 Nov 2009 04:17:02 +0900
Message-ID: <4AFC5F2E.9040709__966.450878377323$1258053878$gmane$org@kernel.org>
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
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

11/13/2009 02:33 AM, Thomas Gleixner wrote:
> Subject: workqueue: Add debugobjects support
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 12 Nov 2009 16:25:34 +0100
> 
> Add debugobject support to track the life time of work_structs.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This looks great.  I'm about to create a wq tree for concurrency
managed workqueue patches.  Do you mind if I route this patch through
there?

Thanks.

-- 
tejun
