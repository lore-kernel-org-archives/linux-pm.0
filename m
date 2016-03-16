From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 6/7] cpufreq: Support for fast frequency switching
Date: Wed, 16 Mar 2016 17:58:18 +0100
Message-ID: <CAJZ5v0hsPJWSHbM0=9H5DScW5fLwhOES_-kBtCghXqsj6Y=aUA@mail.gmail.com>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
	<1989596.XAKfhFj1lz@vostro.rjw.lan>
	<20160316154314.GB6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160316154314.GB6344@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 4:43 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 16, 2016 at 03:52:28PM +0100, Rafael J. Wysocki wrote:
>> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
>> +{
>> +     mutex_lock(&cpufreq_fast_switch_lock);
>> +     if (policy->fast_switch_possible && cpufreq_fast_switch_count >= 0) {
>> +             cpufreq_fast_switch_count++;
>> +             policy->fast_switch_enabled = true;
>> +     } else {
>> +             pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
>> +                     policy->cpu);
>
> This happens because there's transition notifiers, right? Would it make
> sense to iterate the notifier here and print the notifier function
> symbol for each? That way we've got a clue as to where to start looking
> when this happens.

OK

>> +     }
>> +     mutex_unlock(&cpufreq_fast_switch_lock);
>> +}
>
>> @@ -1653,8 +1703,18 @@ int cpufreq_register_notifier(struct not
>>
>>       switch (list) {
>>       case CPUFREQ_TRANSITION_NOTIFIER:
>> +             mutex_lock(&cpufreq_fast_switch_lock);
>> +
>> +             if (cpufreq_fast_switch_count > 0) {
>> +                     mutex_unlock(&cpufreq_fast_switch_lock);
>
> So while theoretically (it has a return code)
> cpufreq_register_notifier() could fail, it never actually did. Now we
> do. Do we want to add a WARN here?

Like if (WARN_ON(cpufreq_fast_switch_count > 0)) {

That can be done. :-)
