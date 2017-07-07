From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 1/8] sched/cpufreq_schedutil: make use of DEADLINE
 utilization signal
Date: Fri, 7 Jul 2017 12:50:04 +0530
Message-ID: <20170707072004.GF1523@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-2-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-2-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 05-07-17, 09:58, Juri Lelli wrote:
> SCHED_DEADLINE tracks active utilization signal with a per dl_rq
> variable named running_bw.
> 
> Make use of that to drive cpu frequency selection: add up FAIR and
> DEADLINE contribution to get the required CPU capacity to handle both
> requirements (while RT still selects max frequency).
> 
> Co-authored-by: Claudio Scordino <claudio@evidence.eu.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> ---
> Changes from RFCv0:
> 
>  - use BW_SHIFT (Peter)
>  - add comment about guaranteed and requested freq (Peter)
>  - modify comment about go to max behaviour (Claudio)
> ---
>  include/linux/sched/cpufreq.h    |  2 --
>  kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++----------
>  2 files changed, 15 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
