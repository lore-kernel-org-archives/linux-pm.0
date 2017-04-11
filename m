From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent
 transition delays
Date: Tue, 11 Apr 2017 16:01:42 +0200
Message-ID: <CAJZ5v0hSAmXF+Y42iz2h54NoTOf5Pn7HJFWZ=N9bfBH4q9w9zA@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2407280.n9qVSLCrF5@aspire.rjw.lan>
 <71055380.gdY33coAtF@aspire.rjw.lan> <20170411111443.GE13627@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34790 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdDKOBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 10:01:43 -0400
In-Reply-To: <20170411111443.GE13627@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Brendan Jackman <brendan.jackman@arm.com>

On Tue, Apr 11, 2017 at 1:14 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-04-17, 00:20, Rafael J. Wysocki wrote:
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
>>
>> ---
>>  drivers/cpufreq/intel_pstate.c   |    2 ++
>>  include/linux/cpufreq.h          |    7 +++++++
>>  kernel/sched/cpufreq_schedutil.c |   15 ++++++++++-----
>>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> Should we use this new value for the ondemand/conservative governors as well?

We might, but it is mostly for schedutil.

Thanks,
Rafael
