From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Date: Tue, 23 Apr 2019 14:12:15 +0530
Message-ID: <20190423084215.hygce3d66wyncqig@vireshk-i7>
References: <38900622.ao2n2t5aPS@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38900622.ao2n2t5aPS@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-04-19, 16:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are problems with running time_cpufreq_notifier() on SMP
> systems.
> 
> First off, the rdtsc() called from there runs on the CPU executing
> that code and not necessarily on the CPU whose sched_clock() rate is
> updated which is questionable at best.
> 
> Second, in the cases when the frequencies of all CPUs in an SMP
> system are always in sync, it is not sufficient to update just
> one of them or the set associated with a given cpufreq policy on
> frequency changes - all CPUs in the system should be updated and
> that would require more than a simple transition notifier.
> 
> Note, however, that the underlying issue (the TSC rate depending on
> the CPU frequency) has not been present in hardware shipping for the
> last few years and in quite a few relevant cases (acpi-cpufreq in
> particular) running time_cpufreq_notifier() will cause the TSC to
> be marked as unstable anyway.
> 
> For this reason, make time_cpufreq_notifier() simply mark the TSC
> as unstable and give up when run on SMP and only try to carry out
> any adjustments otherwise.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/tsc.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
