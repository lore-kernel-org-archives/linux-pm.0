From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Mon, 10 Dec 2007 09:55:29 +0100
Message-ID: <475CFF01.2090502__11255.2679413513$1197277116$gmane$org@gmail.com>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu> <475B24F4.3090904@gmail.com>
	<20071209074647.GE22981@elte.hu> <20071210081952.GA7215@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071210081952.GA7215@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ego@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 12/10/2007 09:19 AM, Gautham R Shenoy wrote:
> commit 15bfb662b35c609490185fba2fd4713d230b9374
> Author: Gautham R Shenoy <ego@in.ibm.com>
> Date:   Mon Dec 10 13:41:45 2007 +0530
> 
> softlockup: remove get_online_cpus() which doesn't help here.
> 
> The get_online_cpus() protection seems to be bogus
> in kernel/softlockup.c as cpu cached in check_cpu can go offline
> once we do a put_online_cpus().
> 
> This can also cause deadlock during a cpu offline as follows:
> 
> WATCHDOG_THREAD:		OFFLINE_CPU:
> 				mutex_down(&cpu_hotplug.lock);
> 				/* All subsequent get_online_cpus
> 				 * will be blocked till we're
> 				 * done with this cpu-hotplug
> 				 * operation.
> 				 */
> 
> get_online_cpus();
> /* watchdog is blocked
>    Thus we cannot
>    go further until
>    the cpu-hotplug
>    operation completes
>  */
>  				CPU_DEAD:
>     				kthread_stop(watchdog_thread);
> 
>     				/* we're trying to stop a
>     				 * thread which is blocked
>     				 * waiting for us to finish.
>     				 *
>     				 * Since we cannot finish until
>     				 * the thread stops, we deadlock here!
>     				 */
>     
> Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linuxtronix.de>
> Cc: Arjan van de Van <arjan@linux.intel.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>

Tested-by: Jiri Slaby <jirislaby@gmail.com>

> diff --git a/kernel/softlockup.c b/kernel/softlockup.c
> index e50b44a..576eb9c 100644
> --- a/kernel/softlockup.c
> +++ b/kernel/softlockup.c
> @@ -219,9 +219,7 @@ static int watchdog(void *__bind_cpu)
>  		/*
>  		 * Only do the hung-tasks check on one CPU:
>  		 */
> -		get_online_cpus();
>  		check_cpu = any_online_cpu(cpu_online_map);
> -		put_online_cpus();
>  
>  		if (this_cpu != check_cpu)
>  			continue;
> 
