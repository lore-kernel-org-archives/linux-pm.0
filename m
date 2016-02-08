From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization
 update callbacks
Date: Mon, 8 Feb 2016 13:52:28 +0100
Message-ID: <CAJZ5v0gVffRb33CJcrTY5KEPY04MQNp=uqsGFwMevZAEuYBGfg@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<20160207091040.GA6112@vireshk>
	<1855005.ZFAA5ekheo@vostro.rjw.lan>
	<2172360.cldhrkXzeh@vostro.rjw.lan>
	<20160208115248.GC8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208115248.GC8294@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 8, 2016 at 12:52 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-02-16, 03:08, Rafael J. Wysocki wrote:
>> Moreover, update_sampling_rate() doesn't need to walk the cpu_dbs_infos,
>> it may walk policies instead.  Like after the (untested) appended patch.
>>
>> Then, if we have a governor_data_lock in struct policy, we can use that
>> to protect policy_dbs while it is being access there and we're done.
>>
>> I'll try to prototype something along these lines tomorrow.
>
> I have solved that in a different way, and dropped the lock from
> update_sampling_rate(). Please see if that looks good.

Well, almost.

I like the list approach, but you need to be careful about it.  Let me
comment more on the patches in the series.

I have a gut feeling that my idea of walking policies will end up
being simpler in the end, but let's see. :-)

Thanks,
Rafael
