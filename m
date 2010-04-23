From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Fri, 23 Apr 2010 14:20:32 +0200
Message-ID: <20100423122032.GA23544__21481.967639602$1272025747$gmane$org@redhat.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
	<4BD1576E.5070401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BD1576E.5070401@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/23, Tejun Heo wrote:
>
> On 04/23/2010 03:08 AM, Arve Hj=F8nnev=E5g wrote:
> > Allow work to be queued that will block suspend while it is pending
> > or executing. To get the same functionality in the calling code often
> > requires a separate suspend_blocker for pending and executing work, or
> > additional state and locking.
>
> Hmm... I think this can be implemented as pure wrapper around
> workqueue instead of injecting a flag and code into workqueue core.
> Adding @fn field to suspend_blocking_work struct and using a custom
> work function to call it and then invoke suspend_unblock() should be
> enough, right?  Oh, dedicated queue functions will be needed too.  I
> don't think it's wise to meddle with workqueue core code for this.

Completely agreed. The patch adds very "strange" hacks into workqueue
code to solve the very specific problems.


Besides, the patch doesn't look right. suspend_unblock() can be called
twice if you use cancel_work(). Perhaps this is not a problem, I dunno.
WORK_STRUCT_SUSPEND_BLOCKING needs to ensure that cpu_workqueue_struct
has a proper alignment. The unblock code in run_workqueue() is racy,
it can unblock after the work was queued on another CPU, cwq->lock can't
help.

Oleg.
