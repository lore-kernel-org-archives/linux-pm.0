From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 1/2] Freezer: Introduce PF_FREEZER_NOSIG
Date: Wed, 7 May 2008 11:36:21 +0200
Message-ID: <20080507093621.GF13858__6547.05256824872$1210153135$gmane$org@elf.ucw.cz>
References: <200805070003.56387.rjw@sisk.pl> <200805070005.20403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805070005.20403.rjw@sisk.pl>
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
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The freezer currently attempts to distinguish kernel threads from
> user space tasks by checking if their mm pointer is unset and it
> does not send fake signals to kernel threads.  However, there are
> kernel threads, mostly related to networking, that behave like
> user space tasks and may want to be sent a fake signal to be frozen.
> 
> Introduce the new process flag PF_FREEZER_NOSIG that will be set
> by default for all kernel threads and make the freezer only send
> fake signals to the tasks having PF_FREEZER_NOSIG unset.  Provide
> the set_freezable_with_signal() function to be called by the kernel
> threads that want to be sent a fake signal for freezing.
> 
> This patch should not change the freezer's observable behavior.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.


> -static int has_mm(struct task_struct *p)
> +static inline bool should_send_signal(struct task_struct *p)
>  {
> -	return (p->mm && !(p->flags & PF_BORROWED_MM));
> +	return !(current->flags & PF_FREEZER_NOSIG);
>  }
>

Note that we used to tell kernel threads by ->mm, and now you assume
that anything created by ktrheadd is kernel thread, ->mm or not.

I'm not sure if those can differ (->mm = NULL somewhere? Or ->mm =
something somewhere else?). I guess this should go to -mm for a long
test...

> @@ -234,7 +234,7 @@ int kthreadd(void *unused)
>  	set_user_nice(tsk, KTHREAD_NICE_LEVEL);
>  	set_cpus_allowed(tsk, CPU_MASK_ALL);
>  
> -	current->flags |= PF_NOFREEZE;
> +	current->flags |= PF_NOFREEZE | PF_FREEZER_NOSIG;
>  
>  	for (;;) {
>  		set_current_state(TASK_INTERRUPTIBLE);

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
