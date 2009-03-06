From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Fri, 6 Mar 2009 15:50:02 +0100
Message-ID: <20090306145002.GA5828__2463.34063490412$1236351376$gmane$org@redhat.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
	<20090305162329.GA5294@redhat.com>
	<20090306032122.GA32316@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090306032122.GA32316@in.ibm.com>
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
> On Thu, Mar 05, 2009 at 05:23:29PM +0100, Oleg Nesterov wrote:
> > On 03/04, Arun R Bharadwaj wrote:
> > >
> > > +++ linux.trees.git/kernel/sched.c
> > > @@ -4009,6 +4009,11 @@ static struct {
> > >  	.load_balancer = ATOMIC_INIT(-1),
> > >  };
> > >
> > > +inline int get_nohz_load_balancer(void)
> >
> > inline?
> > 
> > > +{
> > > +	return atomic_read(&nohz.load_balancer);
> > > +}
> >
> > Shouldn't we reset .load_balancer when this CPU is CPU_DOWN'ed ?
> > Otherwise the timer can migrate to the dead CPU.
>
> In the select_nohz_load_balancer() code, we check if this CPU is in the
> cpu_active_map. If no, then this CPU relinquishes being the idle
> load balancer.

I don't understand this code, but I am not sure select_nohz_load_balancer()
is always called on cpu_down() path before migrate_timers/migrate_hrtimers.

If this is true, then there is no problem.

> Also, the timer migration code in the CPU down path would
> migrate any timers queued onto this CPU, right ?

Yes, but if .load_balancer is not cleared before the timer migration,
mod_timer() can move the timer to the dead CPU after migration.

Oleg.
