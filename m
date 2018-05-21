From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3 2/2] cpufreq: schedutil: Cleanup and document iowait
 boost
Date: Mon, 21 May 2018 10:46:00 -0700
Message-ID: <20180521174600.GC21678@joelaf.mtv.corp.google.com>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
 <20180521085120.7902-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521085120.7902-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, kernel-team@android.com
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 09:51:20AM +0100, Patrick Bellasi wrote:
> The iowait boosting code has been recently updated to add a progressive
> boosting behavior which allows to be less aggressive in boosting tasks
> doing only sporadic IO operations, thus being more energy efficient for
> example on mobile platforms.
> 
> The current code is now however a bit convoluted. Some functionalities
> (e.g. iowait boost reset) are replicated in different paths and their
> documentation is slightly misaligned.
> 
> Let's cleanup the code by consolidating all the IO wait boosting related
> functionality within within few dedicated functions and better define
> their role:
> 
> - sugov_iowait_boost: set/increase the IO wait boost of a CPU
> - sugov_iowait_apply: apply/reduce the IO wait boost of a CPU
> 
> Both these two function are used at every sugov updated and they makes

makes->make
updated->update

> use of a unified IO wait boost reset policy provided by:
> 
> - sugov_iowait_reset: reset/disable the IO wait boost of a CPU
>      if a CPU is not updated for more then one tick
> 
> This makes possible a cleaner and more self-contained design for the IO
> wait boosting code since the rest of the sugov update routines, both for
> single and shared frequency domains, follow the same template:
> 
>    /* Configure IO boost, if required */
>    sugov_iowait_boost()
> 
>    /* Return here if freq change is in progress or throttled */
> 
>    /* Collect and aggregate utilization information */
>    sugov_get_util()
>    sugov_aggregate_util()
> 
>    /*
>     * Add IO boost, if currently enabled, on top of the aggregated
>     * utilization value
>     */
>    sugov_iowait_apply()
> 
> As a extra bonus, let's also add the documentation for the new
> functions and better align the in-code documentation.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

[..]
 
