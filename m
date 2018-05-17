From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Thu, 17 May 2018 12:53:58 +0200
Message-ID: <20180517105358.GB22493@localhost.localdomain>
References: <20180516224518.109891-1-joel@joelfernandes.org>
 <20180517070026.GA22493@localhost.localdomain>
 <20180517102024.s3dxo4uepujh5f65@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517102024.s3dxo4uepujh5f65@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Luca Abeni <luca.abeni@santannapisa.it>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17/05/18 15:50, Viresh Kumar wrote:
> On 17-05-18, 09:00, Juri Lelli wrote:
> > Hi Joel,
> > 
> > On 16/05/18 15:45, Joel Fernandes (Google) wrote:
> > 
> > [...]
> > 
> > > @@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> > >  static void sugov_work(struct kthread_work *work)
> > >  {
> > >  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > > +	unsigned int freq;
> > > +	unsigned long flags;
> > > +
> > > +	/*
> > > +	 * Hold sg_policy->update_lock shortly to handle the case where:
> > > +	 * incase sg_policy->next_freq is read here, and then updated by
> > > +	 * sugov_update_shared just before work_in_progress is set to false
> > > +	 * here, we may miss queueing the new update.
> > > +	 */
> > > +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> > > +	freq = sg_policy->next_freq;
> > > +	sg_policy->work_in_progress = false;
> > > +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
> > 
> > OK, we queue the new request up, but still we need to let this kthread
> > activation complete and then wake it up again to service the request
> > already queued, right? Wasn't what Claudio proposed (service back to
> > back requests all in the same kthread activation) better from an
> > overhead pow?
> 
> We would need more locking stuff in the work handler in that case and
> I think there maybe a chance of missing the request in that solution
> if the request happens right at the end of when sugov_work returns.

Mmm, true. Ideally we might want to use some sort of queue where to
atomically insert requests and then consume until queue is empty from
sugov kthread.

But, I guess that's going to be too much complexity for an (hopefully)
corner case.
