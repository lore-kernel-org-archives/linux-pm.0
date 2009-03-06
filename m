From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [v2 PATCH 1/4] timers: framework to identify pinned
	timers.
Date: Fri, 6 Mar 2009 16:03:35 +0100
Message-ID: <20090306150335.GB5828__36989.4468728036$1236352195$gmane$org@redhat.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121456.GB9855@linux.vnet.ibm.com>
	<20090305165340.GA6984@redhat.com>
	<20090306061438.GB9190@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090306061438.GB9190@linux.vnet.ibm.com>
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

On 03/06, Arun R Bharadwaj wrote:
>
> * Oleg Nesterov <oleg@redhat.com> [2009-03-05 17:53:40]:
>
> > > @@ -736,6 +759,7 @@ void add_timer_on(struct timer_list *tim
> > >  	struct tvec_base *base = per_cpu(tvec_bases, cpu);
> > >  	unsigned long flags;
> > >
> > > +	timer_set_pinned(timer);
> >
> > But we never clear TBASE_PINNED_FLAG?
> >
> > If we use mod_timer() next time, the timer remains "pinned". I do not say
> > this is really wrong, but a bit strange imho.
> >
> > Oleg.
> >
>
> The pinned timer would expect to continue firing on the same CPU
> although it does a mod_timer() the next time, right?

Why? Let's suppose we call queue_delayed_work_on(), and next time
we use queue_delayed_work() with the same dwork. The timer is still
pinned, this doesn't look consistent to me.

> Thats why I have not cleared the TBASE_PINNED_FLAG.

Personally, I don't like this flag. I think that "pinned" should
be the argument for mod_timer(), not the "property" of timer_list.

Oleg.
