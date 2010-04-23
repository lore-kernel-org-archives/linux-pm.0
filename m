From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Fri, 23 Apr 2010 15:49:56 -0700
Message-ID: <y2ud6200be21004231549q8e52c9c0z441d82b5a15e177d__10623.9727967933$1272063086$gmane$org@mail.gmail.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
	<4BD1576E.5070401@kernel.org> <20100423122032.GA23544@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100423122032.GA23544@redhat.com>
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
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 23, 2010 at 5:20 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/23, Tejun Heo wrote:
>>
>> On 04/23/2010 03:08 AM, Arve Hj=F8nnev=E5g wrote:
>> > Allow work to be queued that will block suspend while it is pending
>> > or executing. To get the same functionality in the calling code often
>> > requires a separate suspend_blocker for pending and executing work, or
>> > additional state and locking.
>>
>> Hmm... I think this can be implemented as pure wrapper around
>> workqueue instead of injecting a flag and code into workqueue core.
>> Adding @fn field to suspend_blocking_work struct and using a custom
>> work function to call it and then invoke suspend_unblock() should be
>> enough, right? =A0Oh, dedicated queue functions will be needed too. =A0I
>> don't think it's wise to meddle with workqueue core code for this.
>
> Completely agreed. The patch adds very "strange" hacks into workqueue
> code to solve the very specific problems.
>

I want the suspend blocker active when the work is pending or running.
I did not see a way to do this on top of the workqueue api without
adding additional locking.

>
> Besides, the patch doesn't look right. suspend_unblock() can be called
> twice if you use cancel_work(). Perhaps this is not a problem, I dunno.

Calling suspend_unblock() twice is not a problem as long as
"unblocked" is the expected final state.

> WORK_STRUCT_SUSPEND_BLOCKING needs to ensure that cpu_workqueue_struct
> has a proper alignment.

OK.

> The unblock code in run_workqueue() is racy,
> it can unblock after the work was queued on another CPU, cwq->lock can't
> help.

If the work is both queued and starts running on another workqueue
between "get_wq_data(work) =3D=3D cwq" and "!work_pending(work)", then
suspend_unblock will be called when it shouldn't. It should work fine
if I change to it check pending first though, since it cannot move
back to the current workqueue without locking cwq->lock first.

Or are you talking about the race when the callback is running on
multiple (cpu) workqueues at the same time. In that case the suspend
blocker is released when the callback returns from the last workqueue
is was queued on, not when all the callbacks have returned. On that
note, is it ever safe to use flush_work and cancel_work_sync for work
queues on anything other than a single single threaded workqueue?

-- =

Arve Hj=F8nnev=E5g
