From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent transition delays
Date: Tue, 18 Apr 2017 10:43:12 +0100
Message-ID: <87fuh6rqzd.fsf@arm.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2407280.n9qVSLCrF5@aspire.rjw.lan> <71055380.gdY33coAtF@aspire.rjw.lan> <2817661.LjrBZf7NNr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <2817661.LjrBZf7NNr@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org


Hi Rafael,

On Fri, Apr 14 2017 at 22:51, Rafael J. Wysocki wrote:
> On Tuesday, April 11, 2017 12:20:41 AM Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the schedutil governor take the initial (default) value of the
>> rate_limit_us sysfs attribute from the (new) transition_delay_us
>> policy parameter (to be set by the scaling driver).
>>
>> That will allow scaling drivers to make schedutil use smaller default
>> values of rate_limit_us and reduce the default average time interval
>> between consecutive frequency changes.
>>
>> Make intel_pstate set transition_delay_us to 500.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is a replacement for https://patchwork.kernel.org/patch/9671831/
>
> Any concerns about this one?

Sorry for the delay. This looked good to me.

Cheers
Brendan
