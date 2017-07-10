From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Mon, 10 Jul 2017 12:24:43 +0530
Message-ID: <20170710065443.GG2928@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12829054.TWIodSo4bb@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08-07-17, 14:09, Rafael J. Wysocki wrote:
> I'm sort of wondering how many is "a lot" really.  For instance, do you really
> want all of the existing ARM platforms to use the new stuff even though
> it may regress things there in principle?

That's a valid question and we must (maybe we already have) have a policy for
such changes. I thought that such changes (which are so closely bound to the
scheduler) must be at least done at the architecture level and not really at
platform level. And so doing it widely (like done in this patch) maybe the right
thing to do.

> Anyway, if everyone agrees that doing it in the core is the way to go (Peter?),
> why don't you introduce a __weak function for setting policy->cur and
> override it from your arch so as to call arch_set_freq_scale() from there?

I agree. I wanted to suggest that earlier but somehow forgot to mention this.

-- 
viresh
