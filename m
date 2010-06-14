From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Mon, 14 Jun 2010 16:23:31 +0200
Message-ID: <201006141623.31429.rjw__10246.0344126031$1276525625$gmane$org@sisk.pl>
References: <20100613203352.GA3577@swordfish> <201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100614140941.GA3581@swordfish.minsk.epam.com>
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
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 14, 2010, Sergey Senozhatsky wrote:
> Hello,
> Not sure if this simple solution is the correct one.

Well, let's ask the scheduler people.

Ingo, Peter, what do you think of the patch below?

Rafael


> ---
> 
> diff --git a/kernel/sched.c b/kernel/sched.c
> index f8b8996..cfb262b 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2866,7 +2866,10 @@ unsigned long nr_iowait(void)
>  
>  unsigned long nr_iowait_cpu(void)
>  {
> -	struct rq *this = this_rq();
> +	int cpu = get_cpu();
> +	struct rq *this = cpu_rq(cpu);
> +	put_cpu();
> +	
>  	return atomic_read(&this->nr_iowait);
>  }
>  
