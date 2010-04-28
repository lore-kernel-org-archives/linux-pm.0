From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 08:44:24 +0200
Message-ID: <4BD7D948.4080406@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<1272429119-12103-4-git-send-email-arve@android.com>
	<1272429119-12103-5-git-send-email-arve@android.com>
	<1272429119-12103-6-git-send-email-arve@android.com>
	<1272429119-12103-7-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

> +static void suspend_blocking_work_complete(struct suspend_blocking_work *work)
> +{
> +	unsigned long flags;
> +
> +	WARN_ON(!work->active);
> +	spin_lock_irqsave(&work->lock, flags);
> +	if (!--work->active)
> +		suspend_unblock(&work->suspend_blocker);
> +	spin_unlock_irqrestore(&work->lock, flags);
> +}

Maybe work->active can be an atomic_t and the lock can be removed?

> +/**
> + * suspend_blocking_work_destroy - Destroy suspend_blocking_work
> + * @work: The work item in question
> + *
> + * If the work was ever queued on more then one workqueue all but the last
> + * workqueue must be flushed before calling suspend_blocking_work_destroy.

As it's calling cancel_work_sync(), the above is not true.  As long as
no one is trying to queue it again, suspend_blocking_work_destroy() is
safe to call regardless of how the work has been used.

> +void suspend_blocking_work_destroy(struct suspend_blocking_work *work)
> +{
> +	cancel_suspend_blocking_work_sync(work);
> +	WARN_ON(work->active);
> +	suspend_blocker_destroy(&work->suspend_blocker);
> +}
> +EXPORT_SYMBOL(suspend_blocking_work_destroy);

Other than the above, it looks good to me.

Thanks.

-- 
tejun
