From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 6 May 2016 13:46:27 +0200
Message-ID: <20160506114627.GX3430@twins.programming.kicks-ass.net>
References: <20160505234922.GA14673@sky.smuckle.net>
 <1961527.dEtpL4HAvs@vostro.rjw.lan>
 <1953902.drhraqW2It@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56449 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcEFLqa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 07:46:30 -0400
Content-Disposition: inline
In-Reply-To: <1953902.drhraqW2It@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, May 06, 2016 at 02:25:16AM +0200, Rafael J. Wysocki wrote:
> On Friday, May 06, 2016 02:09:07 AM Rafael J. Wysocki wrote:
> > On Thursday, May 05, 2016 04:49:22 PM Steve Muckle wrote:
> > > While working on a few patches for schedutil I noticed that the CFS
> > > cpufreq hooks depend on PELT, which depends on CONFIG_SMP.

> > For governors other than schedutil fixing that would be a matter of
> > adding a !CONFIG_SMP variant of update_load_avg() that will call
> > cpufreq_update_util() and do nothing else.  It doesn't matter what
> > is passed via util and max then.
> 
> Maybe something like the below, FWIW, as a quick fix for 4.6?

Right; I suppose that'll have to do for 4.6.

> ---
>  kernel/sched/fair.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/fair.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/fair.c
> +++ linux-pm/kernel/sched/fair.c
> @@ -3030,7 +3030,14 @@ static int idle_balance(struct rq *this_
>  
>  #else /* CONFIG_SMP */
>  
> -static inline void update_load_avg(struct sched_entity *se, int update_tg) {}
> +static inline void update_load_avg(struct sched_entity *se, int not_used)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +	struct rq *rq = rq_of(cfs_rq);
> +
> +	cpufreq_trigger_update(rq_clock(rq));
> +}
> +
>  static inline void
>  enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  static inline void
> 
