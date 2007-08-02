From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH -mm 2/3] Freezer: Use wait queue instead of
	busy looping (updated)
Date: Thu, 2 Aug 2007 22:40:02 +0400
Message-ID: <20070802184002.GA283__17772.2498694949$1186088231$gmane$org@tv-sign.ru>
References: <200708012328.23939.rjw@sisk.pl>
	<20070801164831.ed40546d.akpm@linux-foundation.org>
	<200708021315.18851.rjw@sisk.pl> <200708021938.37547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708021938.37547.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 08/02, Rafael J. Wysocki wrote:
>
> @@ -171,6 +186,10 @@ static int try_to_freeze_tasks(int freez
>  
>  	end_time = jiffies + TIMEOUT;
>  	do {
> +		DEFINE_WAIT(wait);
> +
> +		add_wait_queue(&refrigerator_waitq, &wait);

Hmm. In that case I'd sugest to use prepare_to_wait(). This means that
multiple wakeups from refrigerator() won't do unnecessary work, and

> +
>  		todo = 0;
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
> @@ -189,7 +208,12 @@ static int try_to_freeze_tasks(int freez
>  				todo++;
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);
> -		yield();			/* Yield is okay here */
> +
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (todo && !list_empty_careful(&wait.task_list))
> +			schedule_timeout(WAIT_TIME);

we don't need to check list_empty_careful() before schedule, prepare_to_wait()
sets TASK_UNINTERRUPTIBLE under wait_queue_head_t->lock.

Still, I personally agree with Pavel. Perhaps it is better to just replace
yield() with schedule_timeout(a_bit).

Oleg.
