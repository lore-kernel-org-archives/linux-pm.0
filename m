From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/3] cpufreq: acpi-cpufreq: add resolve_freq callback
Date: Tue, 31 May 2016 17:08:15 +0530
Message-ID: <20160531113815.GG9463@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-3-git-send-email-smuckle@linaro.org>
 <20160526064341.GV17585@vireshk-i7>
 <20160530162027.GF9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160530162027.GF9864@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 30-05-16, 09:20, Steve Muckle wrote:
> A couple concerns... One is that if we do the lookup in
> cpufreq_driver_resolve_freq() for drivers which implement target_index()
> then it means using cpufreq_frequency_table_target() there.  This is a
> heavier weight function that can't take advantage of driver-specific
> knowledge that the freq table is sorted a particular way.

I completely agree.

> So for
> acpi-cpufreq we'd now be having to walk the whole table for every
> fast_switch.

I have just tried to address that with following set:

[PATCH 0/2] cpufreq: Use sorted frequency tables

Lets see what Rafael has to say about that.

> Another is that it'll be a a bit odd that the logic used to lookup the
> driver frequency will be different in the cached and uncached
> fast_switch cases. In the cached case it will have been determined by
> code in cpufreq_driver_resolve_freq() whereas in the uncached case it
> will be logic in the driver, in its fast_switch routine.

We can make both of them refer the above code then. Lets see.

-- 
viresh
