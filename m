From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date: Fri, 12 Oct 2018 10:28:12 +0200
Message-ID: <20181012082812.GO9848@hirez.programming.kicks-ass.net>
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 02:04:02PM +0200, Daniel Lezcano wrote:
> The function nr_iowait_cpu() can be used directly by nr_iowait() instead
> of duplicating code.
> 
> Call nr_iowait_cpu() from nr_iowait()
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
