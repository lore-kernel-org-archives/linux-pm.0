From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Mon, 10 Dec 2007 12:28:32 +0100
Message-ID: <20071210112832.GA20189__29800.4007818692$1197286226$gmane$org@elte.hu>
References: <475A629C.7010408@gmail.com> <20071208152447.GA30270@elte.hu>
	<475B24F4.3090904@gmail.com> <20071209074647.GE22981@elte.hu>
	<20071210081952.GA7215@in.ibm.com> <475CFF01.2090502@gmail.com>
	<20071210091052.GA14487@elte.hu>
	<20071210101500.GB12880@in.ibm.com>
	<20071210102157.GB31103@elte.hu>
	<20071210110818.GC12880@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071210110818.GC12880@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> > say we've got 100 CPUs, so we've got 100 watchdog tasks running - 
> > one for each CPU. Checking for hung tasks is a global operation not 
> > a per-CPU operation (we iterate over the global tasklist), hence 
> > only one CPU should really be calling this function. That 
> > online-cpus logic achieves this by picking a single CPU. Perhaps it 
> > would be better to keep a hung_task_checker_cpu variable that is 
> > driven from a CPU-hotplug-down notifier? That way if a CPU is 
> > brought down we can update hung_task_checker_cpu to another, 
> > still-online CPU. (this would also be faster, because event-driven)
> 
> Do you mean something like this?

yeah, thanks - queued it up.

one question:

> +static int check_cpu = -1;

>  	case CPU_ONLINE:
>  	case CPU_ONLINE_FROZEN:
> +		check_cpu = any_online_cpu(cpu_online_map);
>  		wake_up_process(per_cpu(watchdog_task, hotcpu));
>  		break;

do we bring the boot CPU online too - i.e. will check_cpu be properly 
initialized on UP too?

	Ingo
