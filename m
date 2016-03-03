From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/6] cpufreq: Support for fast frequency switching
Date: Thu, 3 Mar 2016 20:39:02 +0100
Message-ID: <CAJZ5v0jU8EY16qSDuRFih0LMjpw=5jPe0aY-MAYJk=6iFdXX_Q@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<26020775.9hJG2SHiH2@vostro.rjw.lan>
	<20160303111858.GM6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160303111858.GM6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 3, 2016 at 12:18 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 02, 2016 at 03:12:33AM +0100, Rafael J. Wysocki wrote:
>> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>> +                             unsigned int target_freq, unsigned int relation)
>> +{
>> +     unsigned int freq;
>> +
>> +     if (target_freq == policy->cur)
>> +             return;
>
> But what if relation is different from last time? ;-)

Doh

Never mind, I'll drop this check (that said this mistake is present
elsewhere too IIRC).
