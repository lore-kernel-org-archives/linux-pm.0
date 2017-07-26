From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 11:59:12 +0530
Message-ID: <20170726062912.GA352@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <20170724110122.GX352@vireshk-i7>
 <20170724134752.sejehwa5mjqqc2mq@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724134752.sejehwa5mjqqc2mq@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-07-17, 15:47, Peter Zijlstra wrote:
> I said nothing about the shared locking. That is indeed required. All I
> said is that those two tests you add could be left out.

I was right, I didn't understood your comment at all :(

> > > That would then continue to process the iowait and other accounting
> > > stuff, but stall the moment we call into the actual driver, which will
> > > then drop the request on the floor as per the first few hunks.
> > 
> > I am not sure I understood your comment completely though.
> 
> Since we call cpufreq_update_util(@rq, ...) with @rq->lock held, all
> such calls are in fact serialized for that cpu.

Yes, they are serialized but ..

> Therefore the cpu !=
> current_cpu test you add are pointless.

.. I didn't understand why you said so. This check isn't there to take
care of serialization but remote callbacks.

> Only once we get to the actual cpufreq driver (intel_pstate and others)
> do we run into the fact that we might not be able to service the request
> remotely.

We never check for remote callbacks in drivers.

> But since you also add a test there, that is sufficient.

No.

The diff for intel-pstate that you saw in this patch was for the case
where intel-pstate works directly with the scheduler (i.e. no
schedutil governor). The routine that gets called with schedutil is
intel_cpufreq_target(), which doesn't check for remoteness at all.

-- 
viresh
