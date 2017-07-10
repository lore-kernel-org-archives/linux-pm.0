From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Mon, 10 Jul 2017 11:30:51 +0200
Message-ID: <20170710093051.axnd7drdnsxgiu6f@hirez.programming.kicks-ass.net>
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
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 08, 2017 at 02:09:37PM +0200, Rafael J. Wysocki wrote:
> Anyway, if everyone agrees that doing it in the core is the way to go (Peter?),
> why don't you introduce a __weak function for setting policy->cur and
> override it from your arch so as to call arch_set_freq_scale() from there?
> 

So I'm terminally backlogged and my recent break didn't help any with
that.

I'm at a total loss as to what is proposed here and why we need it. I
tried reading both the Changelog and patch but came up empty.
