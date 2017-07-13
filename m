From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 13:49:27 +0100
Message-ID: <dad6dc77-722e-3f22-7bd8-956dd2325e41@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdGMMtd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jul 2017 08:49:33 -0400
In-Reply-To: <20170712040917.GG17115@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>



On 12/07/17 05:09, Viresh Kumar wrote:
> On 11-07-17, 16:06, Dietmar Eggemann wrote:
>> But in the meantime we're convinced that cpufreq_driver_fast_switch() is
>> not the right place to call arch_set_freq_scale() since for (future)
>> arm/arm64 fast-switch driver, the return value of
>> cpufreq_driver->fast_switch() does not give us the information that the
>> frequency value did actually change.
> 
> Yeah, I saw your discussion with Peter on #linux-rt IRC and TBH I wasn't aware
> that we are going to do fast switching that way. Just trying to get
> understanding of that idea a bit..
> 
> So we will do fast switching from scheduler's point of view, i.e. we wouldn't
> schedule a kthread to change the frequency. But the real hardware still can't do
> that without sleeping, like if we have I2C somewhere in between. AFAIU, we will
> still have some kind of *software* bottom half to do that work, isn't it? And it
> wouldn't be that we have pushed some instructions to the hardware, which it can
> do a bit later.
> 

No the platforms we are considering are only where a standard firmware
interface is provided and the firmware deals with all those I2C/PMIC crap.

> For example, the regulator may be accessed via I2C and we need to program that
> before changing the clock. So, it will be done by some software code only.
> 

Software but just not Linux OSPM but some firmware(remote processors
presumably, can't imagine on the same processor though)

-- 
Regards,
Sudeep
