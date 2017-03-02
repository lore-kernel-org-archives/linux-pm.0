From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/3] cpufreq: intel_pstate: Do not reinit performance
 limits in ->setpolicy
Date: Thu, 2 Mar 2017 18:22:48 +0100
Message-ID: <CAJZ5v0jt4JrmoU-pr8n3uXnmWyaLb2gvxWWDV=-3Xw4WdyYU=A@mail.gmail.com>
References: <2694426.SgxlQuL17D@aspire.rjw.lan> <2326598.n0dkg1GrdM@aspire.rjw.lan>
 <2188688.SPioTUuSuO@aspire.rjw.lan> <CAJZ5v0h5dWg22Fjb4oMbXTBMX7Rs1NrYyh64rK7RE5nJtu_6-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h5dWg22Fjb4oMbXTBMX7Rs1NrYyh64rK7RE5nJtu_6-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 2, 2017 at 6:18 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 1, 2017 at 12:09 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If the current P-state selection algorithm is set to "performance"
>> in intel_pstate_set_policy(), the limits may be initialized from
>> scratch, but only if no_turbo is not set and the maximum frequency
>> allowed for the given CPU (i.e. the policy object representing it)
>> is at least equal to the max frequency supported by the CPU.  In all
>> of the other cases, the limits will not be updated.
>>
>> For example, the following can happen:
>>
>>  # cat intel_pstate/status
>>  active
>>  # echo performance > cpufreq/policy0/scaling_governor
>>  # cat intel_pstate/min_perf_pct
>>  100
>>  # echo 94 > intel_pstate/min_perf_pct
>>  # cat intel_pstate/min_perf_pct
>>  100
>>  # cat cpufreq/policy0/scaling_max_freq
>>  3100000
>>  echo 3000000 > cpufreq/policy0/scaling_max_freq
>>  # cat intel_pstate/min_perf_pct
>>  94
>>  # echo 95 > intel_pstate/min_perf_pct
>>  # cat intel_pstate/min_perf_pct
>>  95
>>
>> That is confusing for two reasons.  First, the initial attempt to
>> change min_perf_pct to 94 seems to have no effect, even though
>> setting the global limits should always work.  Second, after
>> changing scaling_max_freq for policy0 the global min_perf_pct
>> attribute shows 94, even though it should have not been affected
>> by that operation in principle.
>>
>> Moreover, the final attempt to change min_perf_pct to 95 worked
>> as expected, because scaling_max_freq for the only policy with
>> scaling_governor equal to "performance" was different from the
>> maximum at that time.
>>
>> To make all that confusion go away, modify intel_pstate_set_policy()
>> so that it doesn't reinitialize the limits at all.
>>
>> At the same time, change intel_pstate_set_performance_limits() to
>> set min_sysfs_pct to 100 in the "performance" limits set so that
>> switching the P-state selection algorithm to "performance" causes
>> intel_pstate/min_perf_pct in sysfs to go to 100 (or whatever value
>> min_sysfs_pct in the "performance" limits is set to later).
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: No changes
>>
>> ---
>>  drivers/cpufreq/intel_pstate.c |   10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> @@ -382,6 +382,7 @@ static void intel_pstate_set_performance
>>         intel_pstate_init_limits(limits);
>>         limits->min_perf_pct = 100;
>>         limits->min_perf = int_ext_tofp(1);
>> +       limits->min_sysfs_pct = 100;
>
> This change breaks the per-CPU limits, so the patch is not correct.
>
> Withdrawing.

Actually, it appears to be fixable, so I will send a new version
later, most likely.

Thanks,
Rafael
