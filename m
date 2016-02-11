From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 10:52:20 -0800
Message-ID: <56BCD864.6030207@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <56BCBF7C.2080404@linaro.org>
 <20160211173033.GP6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211173033.GP6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 02/11/2016 09:30 AM, Peter Zijlstra wrote:
>> My concern above is that pokes are guaranteed to keep occurring when
>> > there is only RT or DL activity so nothing breaks.
>
> The hook in their respective tick handler should ensure stuff is called
> sporadically and isn't stalled.

But that's only true if the RT/DL tasks happen to be running when the
tick arrives right?

Couldn't we have RT/DL activity which doesn't overlap with the tick? And
if no CFS tasks happen to be executing on that CPU, we'll never trigger
the cpufreq update. This could go on for an arbitrarily long time
depending on the periodicity of the work.
