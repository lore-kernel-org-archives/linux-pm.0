From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Thu, 5 Mar 2009 17:23:29 +0100
Message-ID: <20090305162329.GA5294__10284.3657289215$1236270606$gmane$org@redhat.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090304121937.GE9855@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On 03/04, Arun R Bharadwaj wrote:
>
> +++ linux.trees.git/kernel/sched.c
> @@ -4009,6 +4009,11 @@ static struct {
>  	.load_balancer = ATOMIC_INIT(-1),
>  };
>
> +inline int get_nohz_load_balancer(void)

inline?

> +{
> +	return atomic_read(&nohz.load_balancer);
> +}

Shouldn't we reset .load_balancer when this CPU is CPU_DOWN'ed ?
Otherwise the timer can migrate to the dead CPU.

Oleg.
