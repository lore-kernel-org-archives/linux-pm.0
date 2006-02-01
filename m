From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 23:19:20 +0100
Message-ID: <200602012319.21701.rjw@sisk.pl>
References: <200602010141.53974.rjw@sisk.pl> <20060201114717.GA1768@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060201114717.GA1768@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 01 February 2006 12:47, Pavel Machek wrote:
> > This is an experimantal patch aimed at the "unable to freeze processes under
> > load" problem.
> > 
> > On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> > "dd if=/dev/hda of=/dev/null" test.
> > 
> > Please have a look.
> 
> It makes it better (well, I used my own, simpler variant, but that
> should not matter; patch is attached). I now can't reproduce hangs
> with simple stress testing,

This means the direction is right ...

> but running kernel make alongside that 
> makes it hang sometimes.

... but there still is a race here.

> Example of non-frozen gcc: 
> 
> gcc           D EEE06A70     0  1750   1749  1751
> (NOTLB)
> df85df38 00000046 bf878130 eee06a70 00004111 eee06a70 eee06a70
> 003d0900
>        00000000 c0137cf5 df85c000 00000000 c058ada2 c012503e ef2c915c
> ef2c9030
>        c1c0b480 7c3b8500 003d0927 df85c000 00000a98 7c3b8500 003d0927
> c0770800
> Call Trace:
>  [<c0137cf5>] attach_pid+0x25/0xb0
>  [<c058ada2>] _write_unlock_irq+0x12/0x30
>  [<c012503e>] copy_process+0xe5e/0x11b0
>  [<c0588f74>] wait_for_completion+0x94/0xd0
>  [<c0121690>] default_wake_function+0x0/0x10
>  [<c01254d9>] do_fork+0x149/0x210
>  [<c0101218>] sys_vfork+0x28/0x30
>  [<c0103231>] syscall_call+0x7/0xb

[I'm trying to understand this trace, but with not much success, so far.
Apparently sys_vfork() calls do_fork() which calls copy_process(),
which calls attach_pid().  But what default_wake_function() and
wait_for_completion() are doing here?  And where it got stuck, actually?]

I think the problem is related to the kernel make using fork() heavily.
Namely, if the parent process uses CLONE_VFORK, it will wait for the
vfork completion.  Now if the child process is frozen _before_
it completes the vfork completion, the parent will be unfreezeable.

> ...maybe solving this would solve journalling problems, too? It is
> similar AFAICT.

There's a chance, I think. ;-)

> diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> index e24446f..90d6c1a 100644
> --- a/kernel/power/disk.c
> +++ b/kernel/power/disk.c
> @@ -87,7 +87,6 @@ static int prepare_processes(void)
>  	int error;
>  
>  	pm_prepare_console();
> -	sys_sync();
>  	disable_nonboot_cpus();
>  
>  	if (freeze_processes()) {
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 02a1b3a..bd16e44 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -16,7 +16,7 @@
>  /* 
>   * Timeout for stopping processes
>   */
> -#define TIMEOUT	(6 * HZ)
> +#define TIMEOUT	(60 * HZ)
>  
>  
>  static inline int freezeable(struct task_struct * p)
> @@ -54,32 +54,53 @@ void refrigerator(void)
>  	current->state = save;
>  }
>  
> +static void freeze_process(struct task_struct *p)
> +{
> +       unsigned long flags;
> +
> +       freeze(p);
> +       spin_lock_irqsave(&p->sighand->siglock, flags);
> +       signal_wake_up(p, 0);
> +       spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +}
> +
>  /* 0 = success, else # of processes that we failed to stop */
>  int freeze_processes(void)
>  {
> -	int todo;
> +	int todo, user_frozen, nr_user;
>  	unsigned long start_time;
>  	struct task_struct *g, *p;
>  	unsigned long flags;
>  
>  	printk( "Stopping tasks: " );
>  	start_time = jiffies;
> +	user_frozen = 0;
>  	do {
> -		todo = 0;
> +		nr_user = todo = 0;
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			if (!freezeable(p))
>  				continue;
>  			if (frozen(p))
>  				continue;
> -
> -			freeze(p);
> -			spin_lock_irqsave(&p->sighand->siglock, flags);
> -			signal_wake_up(p, 0);
> -			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> -			todo++;
> +			if (p->mm) {

This one is too simplistic, it appears.  We should lock the task to check its mm
and there may be kernel threads with non-null mm (they have the
PF_BORROWED_MM flag set though, so we have to check this too).

> +				/* The task is a user-space one. Freeze it */
> +				freeze_process(p);
> +				todo++;

I think you can drop this ...

> +				nr_user++;
> +			} else {
> +				/* Freeze only if the user space is frozen */
> +				if (user_frozen)
> +					freeze_process(p);
> +				todo++;
> +			}
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);

... if you do

 +		todo += nr_user;
> +		if (!user_frozen && !nr_user) {
> +			printk("sync");
> +			sys_sync();
> +		}
> +		user_frozen = !nr_user;
>  		yield();			/* Yield is okay here */
>  		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
>  			printk( "\n" );
}-- debugging stuff snipped --{

Greetings,
Rafael 
