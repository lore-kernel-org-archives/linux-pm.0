From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 00:02:36 -0700
Message-ID: <i2vd6200be21004280002tde778c02h1586b4c06de2a89a__11014.1374789693$1272438215$gmane$org@mail.gmail.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<1272429119-12103-4-git-send-email-arve@android.com>
	<1272429119-12103-5-git-send-email-arve@android.com>
	<1272429119-12103-6-git-send-email-arve@android.com>
	<1272429119-12103-7-git-send-email-arve@android.com>
	<4BD7D948.4080406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BD7D948.4080406@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2010/4/27 Tejun Heo <tj@kernel.org>:
> Hello,
>
>> +static void suspend_blocking_work_complete(struct suspend_blocking_work=
 *work)
>> +{
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 WARN_ON(!work->active);
>> + =A0 =A0 spin_lock_irqsave(&work->lock, flags);
>> + =A0 =A0 if (!--work->active)
>> + =A0 =A0 =A0 =A0 =A0 =A0 suspend_unblock(&work->suspend_blocker);
>> + =A0 =A0 spin_unlock_irqrestore(&work->lock, flags);
>> +}
>
> Maybe work->active can be an atomic_t and the lock can be removed?
>

I need the spinlock to prevent the work from getting re-queued before
suspend_unblock.

>> +/**
>> + * suspend_blocking_work_destroy - Destroy suspend_blocking_work
>> + * @work: The work item in question
>> + *
>> + * If the work was ever queued on more then one workqueue all but the l=
ast
>> + * workqueue must be flushed before calling suspend_blocking_work_destr=
oy.
>
> As it's calling cancel_work_sync(), the above is not true. =A0As long as
> no one is trying to queue it again, suspend_blocking_work_destroy() is
> safe to call regardless of how the work has been used.
>

I'm not sure what the best terminology is here, but cancel_work_sync()
only waits for work running on all the cpu-workqueues of the last
workqueue. So, if the caller queued the work on more than one
workqueue, suspend_blocking_work_destroy does not ensure that the
suspend_blocking_work structure is not still in use (it should trigger
the WARN_ON though).

>> +void suspend_blocking_work_destroy(struct suspend_blocking_work *work)
>> +{
>> + =A0 =A0 cancel_suspend_blocking_work_sync(work);
>> + =A0 =A0 WARN_ON(work->active);
>> + =A0 =A0 suspend_blocker_destroy(&work->suspend_blocker);
>> +}
>> +EXPORT_SYMBOL(suspend_blocking_work_destroy);
>
> Other than the above, it looks good to me.
>
> Thanks.
>
> --
> tejun
>



-- =

Arve Hj=F8nnev=E5g
