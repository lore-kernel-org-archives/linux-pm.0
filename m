From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Tue, 19 Jun 2018 14:26:32 +0200
Message-ID: <20180619122632.GS2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-6-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 03:25:00PM +0100, Quentin Perret wrote:
> In order to use EAS, the task scheduler has to know about the Energy
> Model (EM) of the platform. This commit extends the scheduler topology
> code to take references on the frequency domains objects of the EM
> framework for all online CPUs. Hence, the availability of the EM for
> those CPUs is guaranteed to the scheduler at runtime without further
> checks in latency sensitive code paths (i.e. task wake-up).

I'm confused by this patch,... what does it do? Why is em_cpu_get()
(after you fix it) not sufficient?
