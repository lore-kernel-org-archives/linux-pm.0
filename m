From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 07:24:35 -0700
Message-ID: <20100615072435.5a47d850__33560.9270296574$1276611864$gmane$org@infradead.org>
References: <20100613203352.GA3577@swordfish>
	<1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615061927.GA3312@swordfish>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Jun 2010 09:19:27 +0300
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 1d7b9bc..101e8aa 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -159,10 +159,12 @@ update_ts_time_stats(struct tick_sched *ts,
> ktime_t now, u64 *last_update_time) ktime_t delta;
>  
>  	if (ts->idle_active) {
> +		int cpu = get_cpu();
>  		delta = ktime_sub(now, ts->idle_entrytime);
>  		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime,
> delta);
> -		if (nr_iowait_cpu() > 0)
> +		if (nr_iowait_cpu(cpu) > 0)
>  			ts->iowait_sleeptime =
> ktime_add(ts->iowait_sleeptime, delta);
> +		put_cpu();
>  		ts->idle_entrytime = now;
>  	}


hmm this part is wrong
you pick the current cpu, rather than the one denoted by ts.....

they will normally be the same, except for the case where you get your
warning...
(and this is also why you can't move the get_cpu() inside
nr_iowait_cpu() ... )

>  


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
