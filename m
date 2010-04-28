From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 21:40:28 +0200
Message-ID: <20100428194028.GA16389__42174.6100685143$1272483902$gmane$org@redhat.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<1272429119-12103-4-git-send-email-arve@android.com>
	<1272429119-12103-5-git-send-email-arve@android.com>
	<1272429119-12103-6-git-send-email-arve@android.com>
	<1272429119-12103-7-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1272429119-12103-7-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 04/27, Arve Hj=F8nnev=E5g wrote:
>
> Allow work to be queued that will block suspend while it is pending
> or executing. To get the same functionality in the calling code often
> requires a separate suspend_blocker for pending and executing work, or
> additional state and locking. This implementation does add additional
> state and locking, but this can be removed later if we add support for
> suspend blocking work to the core workqueue code.

I think this patch is fine.

Just one silly question,

> +int queue_suspend_blocking_work(struct workqueue_struct *wq,
> +				struct suspend_blocking_work *work)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&work->lock, flags);
> +	suspend_block(&work->suspend_blocker);
> +	ret =3D queue_work(wq, &work->work);
> +	if (ret)
> +		work->active++;

why not

	ret =3D queue_work(wq, &work->work);
	if (ret) {
		suspend_block(&work->suspend_blocker);
		work->active++;
	}

?

Afaics, we can't race with work->func() doing unblock, we hold work-lock.
And this way the code looks more clear.

Sorry, I had no chance to read the previous patches. After the quick look
at 1/8 I think it is OK to call suspend_block() twice, but still...

Or I missed something? Just curious.


Hmm... actually, queue_work() can also fail if we race with cancel_ which
temporary sets WORK_STRUCT_PENDING. In that case suspend_block() won't
be paired by unblock ?


> +int schedule_suspend_blocking_work(struct suspend_blocking_work *work)
> +{
> ...
> +	ret =3D schedule_work(&work->work);

Off-topic. We should probably export keventd_wq to avoid the duplications
like this.

Oleg.
