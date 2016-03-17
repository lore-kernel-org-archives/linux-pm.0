From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 6/7][Update] cpufreq: Support for fast frequency switching
Date: Thu, 17 Mar 2016 13:53:22 +0100
Message-ID: <CAJZ5v0jZQxbw=fuQrJUe5rSMXASFQxbJ09XutwZF13wgTFYtbw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<4088601.C2vItRYpQn@vostro.rjw.lan>
	<1711281.bPmSjlBT7c@vostro.rjw.lan>
	<4785370.no59v8qjgi@vostro.rjw.lan>
	<20160317113507.GH18212@e106622-lin>
	<20160317114037.GB6356@twins.programming.kicks-ass.net>
	<20160317114822.GI18212@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160317114822.GI18212@e106622-lin>
Sender: linux-acpi-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 17, 2016 at 12:48 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 17/03/16 12:40, Peter Zijlstra wrote:
>> On Thu, Mar 17, 2016 at 11:35:07AM +0000, Juri Lelli wrote:
>>
>> > > +         pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
>> >
>> > Ultra-minor nit: s/freqnency/frequency/
>> >
>> > Also, is this really a warning or just a debug message? (everything
>> > seems to work fine on Juno even if this is printed :-)).
>>
>> I would consider it a warn; this _should_ not happen. If your platform
>> supports fast_switch, then you really rather want to use it.
>>
>
> Mmm, right. So, something seems not correct here, as I get this warning
> when I select schedutil on Juno (that doesn't support fast_switch).

There is a mistake here.  The message should not be printed if
policy->fast_switch_possible is not set.

Will fix.
