From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Wed, 4 Mar 2009 22:22:08 +0530
Message-ID: <20090304165208.GA26432__29652.3602250547$1236185774$gmane$org@linux.vnet.ibm.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
	<1236184389.5937.40.camel@desktop>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1236184389.5937.40.camel@desktop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Daniel Walker <dwalker@fifo99.com> [2009-03-04 08:33:09]:

> On Wed, 2009-03-04 at 17:49 +0530, Arun R Bharadwaj wrote:
> > @@ -649,6 +650,16 @@ __mod_timer(struct timer_list *timer, un
> >  
> >         new_base = __get_cpu_var(tvec_bases);
> >  
> > +       current_cpu = smp_processor_id();
> > +       preferred_cpu = get_nohz_load_balancer();
> > +       if (enable_timer_migration && !tbase_get_pinned(timer->base)
> > &&
> > +                       idle_cpu(current_cpu) && preferred_cpu != -1)
> > {
> > +               new_base = per_cpu(tvec_bases, preferred_cpu);
> > +               timer_set_base(timer, new_base);
> > +               timer->expires = expires;
> > +               internal_add_timer(new_base, timer);
> > +               goto out_unlock;
> > +       }
> 
> Are you sure this compiles w/ CONFIG_SMP=n ? It looks like
> enable_timer_migration wouldn't exist in that case, but the chunks your
> adding in the timer code are still using it.
> 
> Daniel
>

Hi Daniel,

Thanks for pointing this out. I'll clean this up in my next iteration.

--arun
