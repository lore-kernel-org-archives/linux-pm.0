From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/3] Freezer: Measure the time of
	freezing tasks
Date: Wed, 1 Aug 2007 10:28:19 +0200
Message-ID: <20070801082819.GW2087@elf.ucw.cz>
References: <200707251401.48340.rjw@sisk.pl> <20070731100254.GC3462@elf.ucw.cz>
	<200708010025.27018.rjw@sisk.pl> <200708010028.44511.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708010028.44511.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> Measure the time of the freezing of tasks, even if it doesn't fail.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ok, why not.

> @@ -233,10 +243,9 @@ static int try_to_freeze_tasks(int freez
>  		 * but it cleans up leftover PF_FREEZE requests.
>  		 */
>  		printk("\n");
> -		printk(KERN_ERR "Freezing of %s timed out after %d seconds "
> +		printk(KERN_ERR "Freezing of tasks failed after %d.%d seconds "

%d.%02d... or it will report bogus numbers.

>  				"(%d tasks refusing to freeze):\n",
> -				freeze_user_space ? "user space " : "tasks ",
> -				TIMEOUT / HZ, todo);
> +				elapsed_csecs / 100, elapsed_csecs % 100, todo);
>  		show_state();
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
> @@ -247,6 +256,9 @@ static int try_to_freeze_tasks(int freez
>  			task_unlock(p);
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
> +	} else {
> +		printk("(elapsed %d.%d seconds) ", elapsed_csecs / 100,
> +			elapsed_csecs % 100);
>  	}

Same here. You have my ACK with that change.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
