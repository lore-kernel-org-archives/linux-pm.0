From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Tue, 19 Jun 2018 15:23:51 +0100
Message-ID: <20180619142351.GA29374@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
 <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
 <20180619132338.GF2476@hirez.programming.kicks-ass.net>
 <20180619133844.GB17720@e108498-lin.cambridge.arm.com>
 <20180619141642.GE2494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619141642.GE2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 16:16:42 (+0200), Peter Zijlstra wrote:
> On Tue, Jun 19, 2018 at 02:38:45PM +0100, Quentin Perret wrote:
> > But maybe I could use something simpler than a lock in this case ?
> > Would WRITE_ONCE/READ_ONCE be enough to ensure that atomicity for
> > example ?
> 
> Yes, since its a single pointer, smp_store_release() + READ_ONCE()
> should be sufficient (these are the foundations of RCU).

OK, good, I'll get rid of the spinlock in v4 (and read more about RCU
foundations then :-))

Thanks,
Quentin
