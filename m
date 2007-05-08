From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.21-mm1 hwsusp: BUG at workqueue.c:106
Date: Tue, 8 May 2007 17:48:15 +0400
Message-ID: <20070508134815.GA1074__10394.5105839104$1178632164$gmane$org@tv-sign.ru>
References: <46403B7F.1050009@gmail.com>
	<20070508021131.438cee31.akpm@linux-foundation.org>
	<20070508105528.GA86@tv-sign.ru> <46405A67.8020105@gmail.com>
	<46406656.9060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46406656.9060504@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/08, Jiri Slaby wrote:
>
> > Oleg Nesterov napsal(a):
> >>>
> >>>> kernel BUG at /home/l/latest/xxx/kernel/workqueue.c:106!
> >>>> invalid opcode: 0000 [#1]
> >>>> SMP
> >>>> Modules linked in: ipv6 floppy ohci1394 ieee1394 parport_pc parport usbhid
> >>>> ehci_hcd pata_acpi ff_memless sr_mod cdrom
> >>>> CPU:    1
> >>>> EIP:    0060:[<c0132161>]    Not tainted VLI
> >>>> EFLAGS: 00010046   (2.6.21-mm1 #272)
> >>>> EIP is at insert_work+0x6d/0x71
> [...]
> >> --- OLD/kernel/workqueue.c~	2007-05-06 00:01:06.000000000 +0400
> >> +++ OLD/kernel/workqueue.c	2007-05-08 14:50:39.000000000 +0400
> >> @@ -103,7 +103,10 @@ static inline void set_wq_data(struct wo
> >>  {
> >>  	unsigned long new;
> >>  
> >> -	BUG_ON(!work_pending(work));
> >> +	if (!work_pending(work)) {
> >> +		printk(KERN_ERR "BUG: set_wq_data ");
> >> +		print_symbol("%s\n", (unsigned long) work->func);
> >> +	}
> >>  
> >>  	new = (unsigned long) cwq | (1UL << WORK_STRUCT_PENDING);
> >>  	new |= WORK_STRUCT_FLAG_MASK & *work_data_bits(work);
> 
> vmstat_update+0x0/0x2b

Thanks a lot.

I know nothing about hwsusp, to the point I don't even know what it does.
I'll try to do some reading tomorrow.

Right now,

> +static void vmstat_update(struct work_struct *w)
> +{
> +       refresh_cpu_vm_stats(smp_processor_id());
> +       schedule_delayed_work(&__get_cpu_var(vmstat_work),
> +               sysctl_stat_interval);
> +}

This is not precisely correct. We cam schedule the wrong vmstat_work
if this timer/work migrates to another CPU. I'd suggest

	schedule_delayed_work(container_of(w, struct delayed_work, work))

This should not happen because we are doing cancel_rearming_delayed_work()
below, however:

> +       case CPU_DOWN_PREPARE:
> +       case CPU_DOWN_PREPARE_FROZEN:
> +               cancel_rearming_delayed_work(&per_cpu(vmstat_work, cpu));
> +               per_cpu(vmstat_work, cpu).work.func = NULL;
> +       case CPU_DOWN_FAILED:
> +       case CPU_DOWN_FAILED_FROZEN:
> +               start_cpu_timer(cpu);

we need a "break;" before "case CPU_DOWN_FAILED", otherwise we re-start
vmstat_update() immediately.

This is a bug, but I am not sure is this the only problem.

Oleg.
