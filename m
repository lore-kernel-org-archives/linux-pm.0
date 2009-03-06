From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Fri, 6 Mar 2009 18:08:34 +0100
Message-ID: <20090306170834.GA11271__39182.0178636864$1236359680$gmane$org@redhat.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
	<20090305162329.GA5294@redhat.com>
	<20090306032122.GA32316@in.ibm.com>
	<20090306145002.GA5828@redhat.com>
	<20090306154933.GA12494@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090306154933.GA12494@in.ibm.com>
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
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, tglx@linutronix.de, Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On 03/06, Gautham R Shenoy wrote:
>
> .load_balancer is the idle load balancer CPU which performs
> load balancing on behalf of all the idle cpus in the system.
> It's the only idle CPU which doesn't turn off it's ticks.
>
> This CPU relinquishes it's role as the idle load balancer when
> a) it finds a runnable task in it's runqueue, i.e before exiting idle
>    state.
> OR
> b) all the CPUs in the system go idle.
>
> Since it doesn't turn off it's ticks, it calls
> select_nohz_load_balancer() every scheduler tick, and thus can observe
> that it's no longer set in cpu_active_map within a tick or two.
>
> Also, the cpu_down() path calls migrate_timers() in CPU_DEAD:,i.e after
> the CPU has gone down. But to take the CPU down, we would have invoked
> the stop_machine_run() code on that CPU, which by itself would make the
> CPU relinquish it's role as the idle load balancer owing to condition (a).
>
> Thus I believe, mod_timer() can never migrate a timer on to a DEAD CPU,
> during/_after_ we invoke migrate_timers() from the CPU_DEAD callpath.

OK, thanks a lot for your explanation!

Oleg.
