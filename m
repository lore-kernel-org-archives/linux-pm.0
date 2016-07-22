From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Fri, 22 Jul 2016 08:13:27 -0700
Message-ID: <20160722151327.GP3122@ubuntu>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan>
 <20160721232228.GT27987@graphite.smuckle.net>
 <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com>
 <20160721234558.GX27987@graphite.smuckle.net>
 <CAJZ5v0j1vX+TwjcDxhbfd2ZruxWz7hFfiMUD6NL_+ZHyDqcU5g@mail.gmail.com>
 <20160722000903.GY27987@graphite.smuckle.net>
 <CAJZ5v0iH0J5JK+PUMsDN3K7aJNKiBt=5p5N3mry=KEL+=ZM94w@mail.gmail.com>
 <20160722003405.GZ27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160722003405.GZ27987@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 21-07-16, 17:34, Steve Muckle wrote:
> On Fri, Jul 22, 2016 at 02:18:54AM +0200, Rafael J. Wysocki wrote:
> > > My thinking was that one of these two would be preferable:
> > >
> > > - Forcing ->target() drivers to install a ->resolve_freq callback,
> > >   enforcing this at cpufreq driver init time.
> > 
> > That would have been possible, but your series didn't do that.
> > 
> > >   My understanding is
> > >   ->target() drivers are deprecated anyway
> > 
> > No, they aren't.
> 
> Ok. I didn't follow Documentation/cpu-freq/cpu-drivers.txt section 1.5
> then - it suggests something about target() is deprecated, perhaps it's
> out of date.

They are kind of deprecated for the new uesrs, but we still have
handful of users of it.

> Sorry, that should've been "check that either ->target_index() or
> ->resolve_freq() is implemented." 
> 
> Implementing resolve_freq for the target() drivers and requiring it at
> driver init time is probably the better way to go though. Perhaps I can
> work on this at some point.

As I said earlier as well in one of the emails, if you are worried
about the extra 'if' check in the hot path, then wouldn't this fix it
for you?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3dd4884c6f9e..91d8ec4c8eb7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -517,7 +517,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
                return policy->freq_table[idx].frequency;
        }
 
-       if (cpufreq_driver->resolve_freq)
+       if (likely(cpufreq_driver->resolve_freq))
                return cpufreq_driver->resolve_freq(policy, target_freq);
 
        return target_freq;

-- 
viresh
