From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Tue, 15 Sep 2015 13:24:31 +0530
Message-ID: <20150915075431.GB6350@linux>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
 <11470100.cEo24Tpcgr@vostro.rjw.lan>
 <20150910012222.GN5266@linux>
 <2356290.e2ZV0EUun6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2356290.e2ZV0EUun6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 10-09-15, 23:59, Rafael J. Wysocki wrote:
> Adding Mark and Srinivas who may be interested in this to CC.

         Mike ? :)

> Why don't we start with listing all of the cpufreq's shortcomings we'd like
> to address, then try to sort out conflicting items and come up with a list
> of tasks to complete?

Yeah, sounds like a good plan.

> To me, the most painful thing ATM is that cpufreq cannot use timer functions
> to carry out state transitions even if the underlying driver could request
> state to be changed from interrupt context.  IMO, we should utilize the
> capabilities of the hardware where possible and only add overhead where it
> is necessary.

Absolutely right.

> Speaking of which I'm concerned that we're adding overhead for systems that
> don't need software synchronization of state transitions (the "one CPU per
> policy" case).  I'm not sure how much of that is really happening, but it
> would be review the code from that angle and streamline things where
> policy objects are not shared.

Maybe, maybe not.. Probably we need to look at exact code paths for
that and then decide.. But we should get this simplified if we can.

> The locking is overdesigned and overkill (and you know that already), but
> if we do the above, it'll be more strarightforward to simplify it IMO.

Locking is really bad today.. I wrote lots of patches for that, but
never got them upstreamed. I should try doing that after pushing the
remaining govenor patches ..

> Finally, the initialization is questionable and in particular the fact that we
> need to call the driver's ->init at least once to get policy->cpus populated.
> This shouldn't be necessary, as that information reflects the topology of
> the system and shouldn't depend on which driver is in use really.

I am not sure how feasible it will be get the topology information in
a generic way, but if we can, we should.

> Please let me know what your pain points are. :-)

There were few minor things as well, I already have some code for
them:
- Dividing the really large cpufreq.[h|c] files into better, more
  readable blocks. For example, one file for sysfs stuff alone..
- Some sort of test suite for cpufreq. I wrote one, which contains
  most of the cases, which helped us fixing governor races:

  https://git.linaro.org/people/viresh.kumar/cpufreq-tests.git

  But, these are plain bash scripts. Not really tied to any kernel
  internal test suite. Which suite should I adapt them for ?

-- 
viresh
