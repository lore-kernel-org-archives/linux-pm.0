From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Wed, 22 Jul 2015 03:56:21 +0200
Message-ID: <6175136.CkGk6PGZKa@vostro.rjw.lan>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk> <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org> <CAJZ5v0hXkEbRqd1ZWGABxbofQ+Y8yjn_JknVUXPGKy=kkE=Xhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hXkEbRqd1ZWGABxbofQ+Y8yjn_JknVUXPGKy=kkE=Xhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 22, 2015 01:15:01 AM Rafael J. Wysocki wrote:
> Hi VIresh,
> 
> On Mon, Jul 20, 2015 at 11:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Consider a dual core (0/1) system with two CPUs:
> > - sharing clock/voltage rails and hence cpufreq-policy
> > - CPU1 is offline while the cpufreq driver is registered
> >
> > - cpufreq_add_dev() is called from subsys callback for CPU0 and we
> >   create the policy for the CPUs and create link for CPU1.
> > - cpufreq_add_dev() is called from subsys callback for CPU1, we find
> >   that the cpu is offline and we try to create a sysfs link for CPU1.
> 
> So the problem is that the cpu_is_offline(cpu) check in
> cpufreq_add_dev() matches two distinct cases: (1) the CPU was not
> present before and it is just being hot-added and (2) the CPU is
> initially offline, but present, and this is the first time its device
> is registered.  In the first case we can expect that the CPU will
> become online shortly (although that is not guaranteed too), but in
> the second case that very well may not happen.
> 
> We need to be able to distinguish between those two cases and your
> patch does that, but I'm not sure if this really is the most
> straightforward way to do it.

It looks like we need a mask of related CPUs that are present.  Or,
alternatively, a mask of CPUs that would have been related had they
been present.

That's sort of what your patch is adding, but not quite.

Thanks,
Rafael
