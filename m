From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.21-mm1 hwsusp: BUG at workqueue.c:106
Date: Tue, 8 May 2007 18:20:25 +0400
Message-ID: <20070508142025.GB1105__28766.3410570987$1178634076$gmane$org@tv-sign.ru>
References: <46403B7F.1050009@gmail.com>
	<20070508021131.438cee31.akpm@linux-foundation.org>
	<20070508105528.GA86@tv-sign.ru> <46405A67.8020105@gmail.com>
	<46406656.9060504@gmail.com> <20070508134815.GA1074@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070508134815.GA1074@tv-sign.ru>
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

On 05/08, Oleg Nesterov wrote:
>
> On 05/08, Jiri Slaby wrote:
> >
> > vmstat_update+0x0/0x2b
> 
> Thanks a lot.
> 
> Right now,
> 
> > +static void vmstat_update(struct work_struct *w)
> > +{
> > +       refresh_cpu_vm_stats(smp_processor_id());
> > +       schedule_delayed_work(&__get_cpu_var(vmstat_work),
> > +               sysctl_stat_interval);
> > +}
> 
> This is not precisely correct. We cam schedule the wrong vmstat_work
> if this timer/work migrates to another CPU. I'd suggest
> 
> 	schedule_delayed_work(container_of(w, struct delayed_work, work))
> 
> This should not happen because we are doing cancel_rearming_delayed_work()
> below, however:
> 
> > +       case CPU_DOWN_PREPARE:
> > +       case CPU_DOWN_PREPARE_FROZEN:
> > +               cancel_rearming_delayed_work(&per_cpu(vmstat_work, cpu));
> > +               per_cpu(vmstat_work, cpu).work.func = NULL;
> > +       case CPU_DOWN_FAILED:
> > +       case CPU_DOWN_FAILED_FROZEN:
> > +               start_cpu_timer(cpu);
> 
> we need a "break;" before "case CPU_DOWN_FAILED", otherwise we re-start
> vmstat_update() immediately.
> 
> This is a bug, but I am not sure is this the only problem.

In case I was not clear, this _can_ explain the problem. Because an extra
start_cpu_timer() (due to missed "break;") re-initializes dwork, and clears
_PENDING.

Oleg.
