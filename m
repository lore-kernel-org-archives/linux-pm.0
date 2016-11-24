From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 3/4] cpufreq: schedutil: move slow path from workqueue to SCHED_FIFO task
Date: Thu, 24 Nov 2016 02:19:03 +0100
Message-ID: <1627825.eiM24BDMdD@vostro.rjw.lan>
References: <cover.1479197311.git.viresh.kumar@linaro.org> <09f8fe694b4491bfd20272e8c7dc0f13f35eb34e.1479197311.git.viresh.kumar@linaro.org> <20161116152605.GU3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51927 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935292AbcKXBLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:11:16 -0500
In-Reply-To: <20161116152605.GU3142@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>

On Wednesday, November 16, 2016 04:26:05 PM Peter Zijlstra wrote:
> On Tue, Nov 15, 2016 at 01:53:22PM +0530, Viresh Kumar wrote:
> > @@ -308,7 +313,21 @@ static void sugov_irq_work(struct irq_work *irq_work)
> >  	struct sugov_policy *sg_policy;
> >  
> >  	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> > +
> > +	/*
> > +	 * For Real Time and Deadline tasks, schedutil governor shoots the
> > +	 * frequency to maximum. And special care must be taken to ensure that
> > +	 * this kthread doesn't result in that.
> > +	 *
> > +	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
> > +	 * updated only at the end of the sugov_work() and before that schedutil
> > +	 * rejects all other frequency scaling requests.
> > +	 *
> > +	 * Though there is a very rare case where the RT thread yields right
> > +	 * after the work_in_progress flag is cleared. The effects of that are
> > +	 * neglected for now.
> > +	 */
> > +	kthread_queue_work(&sg_policy->worker, &sg_policy->work);
> >  }
> 
> 
> Right, so that's a wee bit icky, but its also entirely pre-existing
> code.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Whole series applied.

Thanks,
Rafael

