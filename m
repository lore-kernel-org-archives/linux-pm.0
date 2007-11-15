From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] Freezer: Make freezing failures less
	verbose by default
Date: Thu, 15 Nov 2007 00:25:31 +0000
Message-ID: <20071115002531.GA2343__40192.5751510591$1195082967$gmane$org@ucw.cz>
References: <200711150038.07538.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711150038.07538.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Arkadiusz Miskiewicz <arekm@maven.pl>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently freezing failures are extremely verbose which sometimes is
> unnecessary and prevents the user from seeing which task could not be frozen.
> 
> Make them less verbose by default (ie. if CONFIG_PM_VERBOSE is unset).
> 

I don't think compile time option is right thing to do.

Dump just the stacks of the non-frozen tasks?

acpi_sleep=verbose?

Reorder dmesg so that you get backtraces, and _then_ list of the
tasks?

							Pavel

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/process.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/kernel/power/process.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/process.c
> +++ linux-2.6/kernel/power/process.c
> @@ -163,6 +163,15 @@ static void cancel_freezing(struct task_
>  	}
>  }
>  
> +#ifdef CONFIG_PM_VERBOSE
> +static inline void freezer_show_state(void)
> +{
> +	show_state();
> +}
> +#else /* !CONFIG_PM_VERBOSE */
> +static inline void freezer_show_state(void) {}
> +#endif /* !CONFIG_PM_VERBOSE */
> +
>  static int try_to_freeze_tasks(int freeze_user_space)
>  {
>  	struct task_struct *g, *p;
> @@ -214,7 +223,7 @@ static int try_to_freeze_tasks(int freez
>  		printk(KERN_ERR "Freezing of tasks failed after %d.%02d seconds "
>  				"(%d tasks refusing to freeze):\n",
>  				elapsed_csecs / 100, elapsed_csecs % 100, todo);
> -		show_state();
> +		freezer_show_state();
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			task_lock(p);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
