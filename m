From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Mon, 10 Dec 2007 11:21:57 +0100
Message-ID: <20071210102157.GB31103__23008.623722899$1197282360$gmane$org@elte.hu>
References: <475A5188.6070809@gmail.com> <20071208083939.GD30997@elte.hu>
	<475A629C.7010408@gmail.com> <20071208152447.GA30270@elte.hu>
	<475B24F4.3090904@gmail.com> <20071209074647.GE22981@elte.hu>
	<20071210081952.GA7215@in.ibm.com> <475CFF01.2090502@gmail.com>
	<20071210091052.GA14487@elte.hu>
	<20071210101500.GB12880@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071210101500.GB12880@in.ibm.com>
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

> > i'm wondering, what's the proper CPU-hotplug safe sequence here 
> > then? I'm picking a CPU number from cpu_online_map, and that CPU 
> > could go away while i'm still using it, right? What's saving us 
> > here?
> 
> In this particular case, we are trying to see if any task on a 
> particular cpu has not been scheduled for a really long time. If we do 
> this check on a cpu which has gone offline, then a) If the tasks have 
> not been migrated on to another cpu yet, we will still perform that 
> check and yell if something has been holding any task for a 
> sufficiently long time. b) If the tasks have been migrated off, then 
> we have nothing to check.

say we've got 100 CPUs, so we've got 100 watchdog tasks running - one 
for each CPU. Checking for hung tasks is a global operation not a 
per-CPU operation (we iterate over the global tasklist), hence only one 
CPU should really be calling this function. That online-cpus logic 
achieves this by picking a single CPU. Perhaps it would be better to 
keep a hung_task_checker_cpu variable that is driven from a 
CPU-hotplug-down notifier? That way if a CPU is brought down we can 
update hung_task_checker_cpu to another, still-online CPU. (this would 
also be faster, because event-driven)

	Ingo
