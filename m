From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 09/13] PM: wakelock: Abort task freezing if	a
	wake lock is held.
Date: Thu, 5 Feb 2009 16:35:52 -0800
Message-ID: <20090206003552.GE19577@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-10-git-send-email-arve@android.com>
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
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 04, 2009 at 06:50:22PM -0800, Arve Hj=F8nnev=E5g wrote:
> Avoids a problem where the device sometimes hangs for 20 seconds
> before the screen is turned on.
>

wouldn't it be better to find out what freeze_task call is blocking and
fix that?

 =

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  kernel/power/process.c |   22 +++++++++++++++++-----
>  1 files changed, 17 insertions(+), 5 deletions(-)
> =

> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index ca63401..8388d01 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
> +#include <linux/wakelock.h>
>  =

>  /* =

>   * Timeout for stopping processes
> @@ -36,6 +37,7 @@ static int try_to_freeze_tasks(bool sig_only)
>  	struct timeval start, end;
>  	u64 elapsed_csecs64;
>  	unsigned int elapsed_csecs;
> +	unsigned int wakeup =3D 0;
>  =

>  	do_gettimeofday(&start);
>  =

> @@ -62,6 +64,10 @@ static int try_to_freeze_tasks(bool sig_only)
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
>  		yield();			/* Yield is okay here */
> +		if (todo && has_wake_lock(WAKE_LOCK_SUSPEND)) {
> +			wakeup =3D 1;
> +			break;
> +		}

this effectivey give the freezing algorithm one shot at putting threads
into a suspend safe state.  arn't you risking bugs on resume by doing
this?

>  		if (time_after(jiffies, end_time))
>  			break;
>  	} while (todo);
> @@ -77,11 +83,17 @@ static int try_to_freeze_tasks(bool sig_only)
>  		 * and caller must call thaw_processes() if something fails),
>  		 * but it cleans up leftover PF_FREEZE requests.
>  		 */
> -		printk("\n");
> -		printk(KERN_ERR "Freezing of tasks failed after %d.%02d seconds "
> -				"(%d tasks refusing to freeze):\n",
> -				elapsed_csecs / 100, elapsed_csecs % 100, todo);
> -		show_state();
> +		if (wakeup) {
> +			printk("\n");
> +			printk(KERN_ERR "Freezing of %s aborted\n",
> +					sig_only ? "user space " : "tasks ");
> +		} else {
> +			printk("\n");
> +			printk(KERN_ERR "Freezing of tasks failed after %d.%02d seconds "
> +					"(%d tasks refusing to freeze):\n",
> +					elapsed_csecs / 100, elapsed_csecs % 100, todo);
> +			show_state();
> +		}
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			task_lock(p);
> -- =

> 1.6.1
> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
