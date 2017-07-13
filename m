From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 16:00:14 +0100
Message-ID: <460911b5-f700-4656-a383-5a74d30aca38@arm.com>
References: <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
 <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
 <20170712092755.GD1679@vireshk-i7>
 <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
 <a7b74ee0-24ef-5cc8-89e6-50c705a594f4@arm.com>
 <20170713144205.sv5wtoadazk65p5n@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170713144205.sv5wtoadazk65p5n@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org



On 13/07/17 15:42, Peter Zijlstra wrote:
> On Thu, Jul 13, 2017 at 03:04:09PM +0100, Sudeep Holla wrote:
> 
>> The question is whether we *need* to know the completion of frequency
>> transition. What is the impact of absence of it ? I am considering
>> platforms which may take up to a ms or more to do the actual transition
>> in the firmware.
> 
> So on x86 we can recover from not knowing by means of the APERF/MPERF
> thing, which gives us the average effective frequency over the last
> period.
> 

Understood, and I agree we *must* head in that direction.

> If you lack that you need something to update the actual effective
> frequency.
> 
> Changing the effective frequency at request time might confuse things --
> esp. if the request might not be honoured at all or can take a
> significant time to complete. Not to mention that _IF_ you rely on the
> effective frequency to set other clocks things can come unstuck.
> 
> So unless you go the whole distance and do APERF/MPERF like things, I
> think it would be very good to have a notification of completion (and
> possibly a read-back of the effective frequency that is now set).
>

Yes I agree, but sadly/unfortunately the new SCMI specification I keep
referring makes these notification optional. We even have statistics
collected by the firmware to get the effective frequency, but again
optional and may get updated at slower rate than what we would expect as
they are typically running on slower processors. But IMO it's still
worth exploring the feasibility of fast switch on system with such
standard interface.

I completely agree with you on the old system which Linux has to deal
with I2C and other slow paths. I was under the assumption that we had
already eliminated the use of fast switch on such systems. When Dietmar
referred fast switching, I think he was referring to only systems with
std. firmware interface.

-- 
Regards,
Sudeep
