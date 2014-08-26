From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 07/35] [PATCH 07/36] drivers/cpuidle: Replace
 __get_cpu_var uses for address calculation
Date: Tue, 26 Aug 2014 14:07:32 -0400
Message-ID: <20140826180732.GP31659@mtj.dyndns.org>
References: <20140817173023.439660246@linux.com>
 <20140817173034.022788940@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140817173034.022788940@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: akpm@linuxfoundation.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 17, 2014 at 12:30:30PM -0500, Christoph Lameter wrote:
> All of these are for address calculation. Replace with
> this_cpu_ptr().
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> [cpufreq changes]
> Signed-off-by: Christoph Lameter <cl@linux.com>

(Please disregard the ones I posted for v1 of the patch series)

Applied to percpu/for-3.18-consistent-ops.  Please let me know if this
patch should be routed differently.  Note that this patch was to be
applied to percpu/for-3.17 but delayed due to build issues caused by
cpumask_var_t.

Thanks.

-- 
tejun
