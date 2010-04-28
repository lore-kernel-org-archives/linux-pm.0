From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/8] PM: suspend_block: Abort task freezing
 if a suspend_blocker is active.
Date: Wed, 28 Apr 2010 07:07:53 +0200
Message-ID: <20100428050753.GA2527__11909.4579284594$1272431434$gmane$org@ucw.cz>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<1272429119-12103-4-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1272429119-12103-4-git-send-email-arve@android.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2010-04-27 21:31:54, Arve Hj??nnev??g wrote:
> If a suspend_blocker is active, suspend will fail anyway. Since
> try_to_freeze_tasks can take up to 20 seconds to complete or fail, aborting
> as soon as someone blocks suspend (e.g. from an interrupt handler) improves
> the worst case wakeup latency.
> 
> On an older kernel where task freezing could fail for processes attached
> to a debugger, this fixed a problem where the device sometimes hung for
> 20 seconds before the screen turned on.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

ack.

> ---
>  kernel/power/process.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 71ae290..d8ebd50 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -15,6 +15,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
>  #include <linux/delay.h>
> +#include <linux/suspend_blocker.h>
>  
>  /* 
>   * Timeout for stopping processes
> @@ -38,6 +39,7 @@ static int try_to_freeze_tasks(bool sig_only)
>  	struct timeval start, end;
>  	u64 elapsed_csecs64;
>  	unsigned int elapsed_csecs;
> +	bool wakeup = false;
>  
>  	do_gettimeofday(&start);
>  
> @@ -63,6 +65,10 @@ static int try_to_freeze_tasks(bool sig_only)
>  				todo++;
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
> +		if (todo && suspend_is_blocked()) {
> +			wakeup = true;
> +			break;
> +		}
>  		if (!todo || time_after(jiffies, end_time))
>  			break;
>  
> @@ -85,13 +91,15 @@ static int try_to_freeze_tasks(bool sig_only)
>  		 * but it cleans up leftover PF_FREEZE requests.
>  		 */
>  		printk("\n");
> -		printk(KERN_ERR "Freezing of tasks failed after %d.%02d seconds "
> +		printk(KERN_ERR "Freezing of tasks %s after %d.%02d seconds "
>  				"(%d tasks refusing to freeze):\n",
> +				wakeup ? "aborted" : "failed",
>  				elapsed_csecs / 100, elapsed_csecs % 100, todo);
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			task_lock(p);
> -			if (freezing(p) && !freezer_should_skip(p))
> +			if (freezing(p) && !freezer_should_skip(p)
> +					&& elapsed_csecs > 100)
>  				sched_show_task(p);
>  			cancel_freezing(p);
>  			task_unlock(p);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
