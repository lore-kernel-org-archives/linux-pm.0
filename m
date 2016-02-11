From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 16:58:03 +0100
Message-ID: <CAJZ5v0jRuWK6A7ZEM6M9-TxDmO7n4Sn6jKcqKDc-TvzrUx8hhw@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<20160211115157.GH6357@twins.programming.kicks-ass.net>
	<CAJZ5v0ju1vSf4moYmpPZu2dyhPaLpn++P6PBwCVN1tupp1_jFg@mail.gmail.com>
	<20160211152935.GN6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211152935.GN6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 11, 2016 at 4:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 11, 2016 at 01:08:28PM +0100, Rafael J. Wysocki wrote:
>> > Not really pretty though. It blows a bit that you require this callback
>> > to be periodic (in order to replace a timer).
>>
>> We need it for now, but that's because of how things work on the cpufreq side.
>
> Right, maybe stick a big comment on cpufreq_trigger_update() noting its
> a big ugly hack and will go away 'soon'.

I will.

>> The last version is here:
>>
>> https://patchwork.kernel.org/patch/8275271/
>>
>> but it has the additional hooks for RT/DL which you seem to be
>> thinking are a mistake.
>
> As long as we make sure everbody knows they're a band-aid and will be
> taken out back and shot that should be fine for a little while I
> suppose.

Great, thanks!

Yes, I'm treating those as a band-aid for replacement.

Let me update the patch with a comment to explain that.

Thanks,
Rafael
