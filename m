From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/13] PM: wakelock: Abort task freezing if a
	wake lock	is held.
Date: Thu, 5 Feb 2009 09:55:31 +0100
Message-ID: <20090205085531.GC2077@elf.ucw.cz>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Arve Hj??nnev??g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Avoids a problem where the device sometimes hangs for 20 seconds
> before the screen is turned on.

Fix the problem rather than working around it.

> @@ -62,6 +64,10 @@ static int try_to_freeze_tasks(bool sig_only)
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
>  		yield();			/* Yield is okay here */
> +		if (todo && has_wake_lock(WAKE_LOCK_SUSPEND)) {
> +			wakeup = 1;
> +			break;
> +		}
>  		if (time_after(jiffies, end_time))
>  			break;
>  	} while (todo);

I do not see why wakelocks should change refrigerator behaviour.

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

Please find why the refrigerator fails for you. Yes, we want quiescent
state at least for hibernation resume.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
