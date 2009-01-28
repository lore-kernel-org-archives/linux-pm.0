From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] PM: Fix
	suspend_console/resume_console	to use only one semaphore.
Date: Wed, 28 Jan 2009 20:30:47 +0100
Message-ID: <20090128193047.GA1222@ucw.cz>
References: <1231895271-21861-1-git-send-email-arve@android.com>
	<1231895271-21861-2-git-send-email-arve@android.com>
	<1231895271-21861-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1231895271-21861-3-git-send-email-arve@android.com>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-01-13 17:07:51, Arve Hj??nnev??g wrote:
> This fixes a race if another thread acquired the console
> while it was suspended and released it after it was resumed
> the secondary console semaphre would be left locked, and the
> primary semaphore would be released twice. This in turn caused
> the console switch on suspend or resume to hang forever.
> 
> Note that suspend_console does not actually lock the console
> for clients that use acquire_console_sem, it only locks it for
> clients that use try_acquire_console_sem. If we change
> suspend_console to fully lock the console, then the kernel
> may deadlock on suspend.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

This probably needs to go to lkml for proper review. Getting rid of
secondary_console_sem would be nice cleanup in itself...


> ---
>  kernel/printk.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk.c b/kernel/printk.c
> index 7015733..118ee77 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -73,7 +73,6 @@ EXPORT_SYMBOL(oops_in_progress);
>   * driver system.
>   */
>  static DECLARE_MUTEX(console_sem);
> -static DECLARE_MUTEX(secondary_console_sem);
>  struct console *console_drivers;
>  EXPORT_SYMBOL_GPL(console_drivers);
>  
> @@ -896,12 +895,14 @@ void suspend_console(void)
>  	printk("Suspending console(s) (use no_console_suspend to debug)\n");
>  	acquire_console_sem();
>  	console_suspended = 1;
> +	up(&console_sem);
>  }
>  
>  void resume_console(void)
>  {
>  	if (!console_suspend_enabled)
>  		return;
> +	down(&console_sem);
>  	console_suspended = 0;
>  	release_console_sem();
>  }
> @@ -917,11 +918,9 @@ void resume_console(void)
>  void acquire_console_sem(void)
>  {
>  	BUG_ON(in_interrupt());
> -	if (console_suspended) {
> -		down(&secondary_console_sem);
> -		return;
> -	}
>  	down(&console_sem);
> +	if (console_suspended)
> +		return;
>  	console_locked = 1;
>  	console_may_schedule = 1;
>  }
> @@ -931,6 +930,10 @@ int try_acquire_console_sem(void)
>  {
>  	if (down_trylock(&console_sem))
>  		return -1;
> +	if (console_suspended) {
> +		up(&console_sem);
> +		return -1;
> +	}
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	return 0;
> @@ -984,7 +987,7 @@ void release_console_sem(void)
>  	unsigned wake_klogd = 0;
>  
>  	if (console_suspended) {
> -		up(&secondary_console_sem);
> +		up(&console_sem);
>  		return;
>  	}
>  
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
