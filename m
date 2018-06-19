From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Tue, 19 Jun 2018 13:40:59 +0100
Message-ID: <20180619124058.GX17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113106.GP2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619113106.GP2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 13:31:06 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> > +	read_lock_irqsave(&em_data_lock, flags);
> > +	for_each_cpu(cpu, cpu_possible_mask) {
> 
> I know we're likely to only use this on small systems, but this pattern
> is a very bad, Please look at alternatives.

Ok, this isn't supposed to be called very often (only once, at boot
time, for Arm for example), but I see your point.
