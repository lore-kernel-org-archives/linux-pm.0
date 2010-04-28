From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 08:06:59 +0200
Message-ID: <20100428060659.GC3721@ucw.cz>
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
To: Arve Hj??nnev??g <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Allow work to be queued that will block suspend while it is pending
> or executing. To get the same functionality in the calling code often
> requires a separate suspend_blocker for pending and executing work, or
> additional state and locking. This implementation does add additional
> state and locking, but this can be removed later if we add support for
> suspend blocking work to the core workqueue code.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

Seems sane. ACK.

> +struct suspend_blocking_work {
> +	struct work_struct work;
> +#ifdef CONFIG_OPPORTUNISTIC_SUSPEND

Cound we name it C_AUTO_SUSPEND... to reduce length and typo
potential?

> +	struct suspend_blocker suspend_blocker;
> +	work_func_t func;
> +	spinlock_t lock;
> +	int active;

Is the lock internal-use, or is API user allowed to use it?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
