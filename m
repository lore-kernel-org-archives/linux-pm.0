From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU offline/online locked
Date: Wed, 25 May 2016 02:00:25 +0200
Message-ID: <1494288.rDJLbL32aZ@vostro.rjw.lan>
References: <19792191.esL3UuyORb@vostro.rjw.lan> <2500818.MtOb9b1ZsB@vostro.rjw.lan> <20160524121717.GY17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524121717.GY17585@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 24, 2016 05:47:17 PM Viresh Kumar wrote:
> On 24-05-16, 14:13, Rafael J. Wysocki wrote:
> > I don't really get it why you don't like get/put_online_cpus() so much.
> 
> Not that I don't like them, I just wanted to see if its possible to
> work without any additional locking.
> 
> Anyway, so the first version of your patch did the get_online_cpus()
> around a bigger section of the code instead of just the
> for_each_online_cpu() loop. Should we change that?

It did that, because locking around the loop alone wouldn't close the
races I'm concerned about.

That said, those same races are possible when the cpufreq driver is
loaded along with the cpufreq_stats module or is unloaded along with
that module.  Again, if ether a CPU goes online or the cpufreq driver
is loaded during cpufreq_stats_init(), the new CPU *or* a new policy
may be missed by it.  Similarly, if either a CPU goes offline or
the cpufreq driver is unloaded during cpufreq_stats_exit(), that
CPU or a policy that has just gone away may be missed by it.

The CPU "hotplug" locking is not sufficient to close the races related
to the cpufreq driver load/unload, so an alternative approach is needed.
IMO, however, changing the way the notifiers work is not the way to go
here, because the problem is specific to the stats module.  Unless there
are other users of the notifiers with the same problem, it should be
addressed in the stats code.

The stats code looks all pants to me now, TBH, and the way it uses notifiers
(both policy notifiers and transition notifiers) is questionable at the very
least.  It looks like it would just be better to redesign it from scratch.

Thanks,
Rafael
