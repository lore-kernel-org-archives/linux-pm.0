From: Tejun Heo <teheo@suse.de>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on	resume
Date: Mon, 16 Nov 2009 20:01:33 +0900
Message-ID: <4B01310D.3020609__5241.82261801815$1258389789$gmane$org@suse.de>
References: <200911091250.31626.rjw@sisk.pl> <200911092145.27485.rjw@sisk.pl>
	<alpine.LFD.2.01.0911091339290.31845@localhost.localdomain>
	<200911100119.38019.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
	<4AFA70FB.60706@kernel.org> <20091111181349.GA30638@redhat.com>
	<4AFB9595.1030002@kernel.org> <20091112183508.GA14661@redhat.com>
	<4AFC5E96.1020609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AFC5E96.1020609@kernel.org>
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
Cc: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

11/13/2009 04:14 AM, Tejun Heo wrote:
>>> making flush_work() behave as
>>> flush_work_sync() by default should be doable without too much
>>> overhead.  I'll give it a shot.

Aieee... my estimate for cross cpu work queueing was way off.
Queueing on different cpus is very common - sometimes more so than on
the same cpu, so it looks like this can't be done without adding
significant overhead to queueing path.  Giving up.  :-(

Thanks.

-- 
tejun
