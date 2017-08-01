From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v3 01/10] drivers base/arch_topology: free cpumask
 cpus_to_visit
Date: Tue, 1 Aug 2017 11:56:55 +0100
Message-ID: <20170801105655.bxfuv7pkvb47notl@e106622-lin>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
 <20170727193312.9849-2-dietmar.eggemann@arm.com>
 <20170728072146.GY352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728072146.GY352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On 28/07/17 12:51, Viresh Kumar wrote:
> On 27-07-17, 20:33, Dietmar Eggemann wrote:
> > Free cpumask cpus_to_visit in case registering
> > init_cpu_capacity_notifier has failed or the parsing of the cpu
> > capacity-dmips-mhz property is done. The cpumask cpus_to_visit is
> > only used inside the notifier call init_cpu_capacity_callback.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Juri Lelli <juri.lelli@arm.com>
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Tested-by: Juri Lelli <juri.lelli@arm.com>
> > Reviewed-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

This is actually a fix/optimization which is orthogonal to the rest of
the set. Would it make sense to take only this for now and keep
reviewing the other patches?

Thanks,

- Juri
