From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Wed, 16 Sep 2015 03:42:02 +0200
Message-ID: <1885573.3GF8XYjT7P@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <2356290.e2ZV0EUun6@vostro.rjw.lan> <20150915075431.GB6350@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46801 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752364AbbIPBOE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 21:14:04 -0400
In-Reply-To: <20150915075431.GB6350@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Turquette <mturquette@baylibre.com>

On Tuesday, September 15, 2015 01:24:31 PM Viresh Kumar wrote:
> On 10-09-15, 23:59, Rafael J. Wysocki wrote:
> > Adding Mark and Srinivas who may be interested in this to CC.
> 
>          Mike ? :)
> 
> > Why don't we start with listing all of the cpufreq's shortcomings we'd like
> > to address, then try to sort out conflicting items and come up with a list
> > of tasks to complete?
> 
> Yeah, sounds like a good plan.
> 
> > To me, the most painful thing ATM is that cpufreq cannot use timer functions
> > to carry out state transitions even if the underlying driver could request
> > state to be changed from interrupt context.  IMO, we should utilize the
> > capabilities of the hardware where possible and only add overhead where it
> > is necessary.
> 
> Absolutely right.
> 
> > Speaking of which I'm concerned that we're adding overhead for systems that
> > don't need software synchronization of state transitions (the "one CPU per
> > policy" case).  I'm not sure how much of that is really happening, but it
> > would be review the code from that angle and streamline things where
> > policy objects are not shared.
> 
> Maybe, maybe not.. Probably we need to look at exact code paths for
> that and then decide.. But we should get this simplified if we can.
> 
> > The locking is overdesigned and overkill (and you know that already), but
> > if we do the above, it'll be more strarightforward to simplify it IMO.
> 
> Locking is really bad today.. I wrote lots of patches for that, but
> never got them upstreamed. I should try doing that after pushing the
> remaining govenor patches ..
> 
> > Finally, the initialization is questionable and in particular the fact that we
> > need to call the driver's ->init at least once to get policy->cpus populated.
> > This shouldn't be necessary, as that information reflects the topology of
> > the system and shouldn't depend on which driver is in use really.
> 
> I am not sure how feasible it will be get the topology information in
> a generic way, but if we can, we should.

That depends on what you mean by "generic".  I don't think there's one that
will work for all platforms, but I don't see a reason why it should depend
on the cpufreq driver.

cpufreq drivers can use DT or ACPI or OPPs provided by the platform for
that and all of those things can be accessed by the cpufreq core itself
just as well.

> > Please let me know what your pain points are. :-)
> 
> There were few minor things as well, I already have some code for
> them:
> - Dividing the really large cpufreq.[h|c] files into better, more
>   readable blocks. For example, one file for sysfs stuff alone..

Yeah, that's worth doing, but maybe in the process of re-working things
to avoid making significant changes depend on cleanups.

Speaking of sysfs, that's one more item for my list.  The structure of
the sysfs interface used by cpufreq today is confusing to put it lightly.

For example, we need to make the information that multiple CPUs share the
same cpufreq settings more explicit and I really don't think we should
fail sysfs accesses for offline CPUs when it is not necessary.  At least,
we should fail it for all of them or for none of them, but we don't do
that.

> - Some sort of test suite for cpufreq. I wrote one, which contains
>   most of the cases, which helped us fixing governor races:
> 
>   https://git.linaro.org/people/viresh.kumar/cpufreq-tests.git
> 
>   But, these are plain bash scripts. Not really tied to any kernel
>   internal test suite. Which suite should I adapt them for ?

kselftest seems to be a reasonable target to me.

Thanks,
Rafael

