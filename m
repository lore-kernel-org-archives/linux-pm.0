From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Prevent problems in update_policy_cpu() if
 last_cpu == new_cpu
Date: Thu, 12 Sep 2013 11:39:24 +0530
Message-ID: <CAKohpomgd8X4UwFaVtJ49=CXTg2cyEirvD4_mj5ohqS5fk064Q@mail.gmail.com>
References: <20130911201239.7832.72612.stgit@srivatsabhat.in.ibm.com>
	<20130911201334.7832.49714.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130911201334.7832.49714.stgit@srivatsabhat.in.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 September 2013 01:43, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> If update_policy_cpu() is invoked with the existing policy->cpu itself
> as the new-cpu parameter, then a lot of things can go terribly wrong.
>
> In its present form, update_policy_cpu() always assumes that the new-cpu
> is different from policy->cpu and invokes other functions to perform their
> respective updates. And those functions implement the actual update like
> this:
>
> per_cpu(..., new_cpu) = per_cpu(..., last_cpu);
> per_cpu(..., last_cpu) = NULL;
>
> Thus, when new_cpu == last_cpu, the final NULL assignment makes the per-cpu
> references vanish into thin air! (memory leak). From there, it leads to more
> problems: cpufreq_stats_create_table() now doesn't find the per-cpu reference
> and hence tries to create a new sysfs-group; but sysfs already had created
> the group earlier, so it complains that it cannot create a duplicate filename.
> In short, the repercussions of a rather innocuous invocation of
> update_policy_cpu() can turn out to be pretty nasty.
>
> Ideally update_policy_cpu() should handle this situation (new == last)
> gracefully, and not lead to such severe problems. So fix it by adding an
> appropriate check.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> ---
>
>  drivers/cpufreq/cpufreq.c |    3 +++
>  1 file changed, 3 insertions(+)

We don't need this patch for the reasons that I outlined in other thread.
We should never call this routine when cpu == policy->cpu
