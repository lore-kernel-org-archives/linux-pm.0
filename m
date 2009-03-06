From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 1/4] timers: framework to identify pinned
	timers.
Date: Fri, 6 Mar 2009 11:44:38 +0530
Message-ID: <20090306061438.GB9190__26792.3071318821$1236320372$gmane$org@linux.vnet.ibm.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121456.GB9855@linux.vnet.ibm.com>
	<20090305165340.GA6984@redhat.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090305165340.GA6984@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Oleg Nesterov <oleg@redhat.com> [2009-03-05 17:53:40]:

> On 03/04, Arun R Bharadwaj wrote:
> >
> > +static inline unsigned long tbase_get_flag_bits(struct timer_list *timer)
> > +{
> > +	return tbase_get_deferrable(timer->base) |
> > +				tbase_get_pinned(timer->base);
> > +}
> 
> I'd say this looks a bit strange. Hopefully compiler can optimize this code
> to return (unsigned long)base & (TBASE_DEFERRABLE_FLAG | TBASE_PINNED_FLAG).
>

Yes, it does.

> > @@ -736,6 +759,7 @@ void add_timer_on(struct timer_list *tim
> >  	struct tvec_base *base = per_cpu(tvec_bases, cpu);
> >  	unsigned long flags;
> >
> > +	timer_set_pinned(timer);
> 
> But we never clear TBASE_PINNED_FLAG?
> 
> If we use mod_timer() next time, the timer remains "pinned". I do not say
> this is really wrong, but a bit strange imho.
> 
> Oleg.
>

The pinned timer would expect to continue firing on the same CPU
although it does a mod_timer() the next time, right?
Thats why I have not cleared the TBASE_PINNED_FLAG.

--arun
