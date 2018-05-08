From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Date: Tue, 8 May 2018 15:15:26 +0530
Message-ID: <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Pavan Kondeti <pkondeti@codeaurora.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Quentin Perret <quentin.perret@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08-05-18, 11:09, Dietmar Eggemann wrote:
> This would make sure that the kthreads are bound to the correct set of cpus
> for platforms with those cpufreq drivers (cpufreq-dt (h960), scmi-cpufreq,
> scpi-cpufreq) but it will also change the logic (e.g.
> sugov_should_update_freq() -> cpufreq_can_do_remote_dvfs()).

Yeah, I misunderstood your patch a bit. So you are not disabling
remote updates but only limiting the CPUs where the kthread runs.

That still looks to be a big little specific problem to me right now
and I am not sure why should we specially handle these kthreads ?
Isn't the same true for any other threads/tasks in the kernel which
may end up running on big CPUs ? And this problem still occurs with
the EAS patches applied ? As I thought we may end up keeping such
small tasks on little cores then.

> I'm still struggling to understand when a driver/platform should set
> dvfs_possible_from_any_cpu to true and what the actual benefit would be.

Ideally it should be set by default for all ARM platforms at least
which have more than one cpufreq policy, as there is no hardware
limitation for changing frequency from other CPUs. If you look at the
commit logs of patches which added remote updates, you will see
interesting cases where this can be very useful.

commit 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")

-- 
viresh
