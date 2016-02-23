From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 19:58:47 -0800
Message-ID: <56CBD8F7.3090502@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <1455900129.7375.231.camel@linux.intel.com> <56C750B7.6090701@linaro.org>
 <1797575.PjqbkdCLyN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1797575.PjqbkdCLyN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 02/19/2016 02:35 PM, Rafael J. Wysocki wrote:
>> The scheduler hooks for utilization-based cpufreq operation deserve a
>> lot more debate I think. They could quite possibly have different
>> requirements than hooks which are chosen just to guarantee periodic
>> callbacks into sampling-based governors.
> 
> Yes, they could.
> 
> The point here, though, is that even the sampling-based governors may 
> benefit from using the numbers provided by the scheduler instead of trying
> to come up with analogous numbers themselves.

It seems premature to me to merge supporting infrastructure (the
utilization hooks) before we have changes, be it modifications to the
sampling based governors to use utilization or a scheduler-guided
governor, which are well tested and proven to yield reasonable
performance and power across various platforms and workloads.

Perhaps I'm a pessimist but I think it's going to be a challenge to get
utilization-based cpufreq on par, and I think getting the hooks right
will be part of that challenge.

>> For my part I think it would be best if the util/max parameters are
>> omitted
> 
> OK, so please see the patch I've just sent to Juri:
> 
> https://patchwork.kernel.org/patch/8364621/

Looked good to me.

thanks,
Steve
