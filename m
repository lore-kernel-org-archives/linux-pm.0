From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 10 Sep 2015 23:59:07 +0200
Message-ID: <2356290.e2ZV0EUun6@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <11470100.cEo24Tpcgr@vostro.rjw.lan> <20150910012222.GN5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60408 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751007AbbIJVbP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 17:31:15 -0400
In-Reply-To: <20150910012222.GN5266@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michael Turquette <mturquette@baylibre.com>

On Thursday, September 10, 2015 06:52:22 AM Viresh Kumar wrote:
> On 10-09-15, 03:41, Rafael J. Wysocki wrote:

[cut]

> 
> > Overall, we need to talk about the design aspect of cpufreq, because there
> > are much more significant issues in it than things like this one.
> 
> I agree.

OK

Adding Mark and Srinivas who may be interested in this to CC.

Why don't we start with listing all of the cpufreq's shortcomings we'd like
to address, then try to sort out conflicting items and come up with a list
of tasks to complete?

To me, the most painful thing ATM is that cpufreq cannot use timer functions
to carry out state transitions even if the underlying driver could request
state to be changed from interrupt context.  IMO, we should utilize the
capabilities of the hardware where possible and only add overhead where it
is necessary.

Speaking of which I'm concerned that we're adding overhead for systems that
don't need software synchronization of state transitions (the "one CPU per
policy" case).  I'm not sure how much of that is really happening, but it
would be review the code from that angle and streamline things where
policy objects are not shared.

The locking is overdesigned and overkill (and you know that already), but
if we do the above, it'll be more strarightforward to simplify it IMO.

Finally, the initialization is questionable and in particular the fact that we
need to call the driver's ->init at least once to get policy->cpus populated.
This shouldn't be necessary, as that information reflects the topology of
the system and shouldn't depend on which driver is in use really.

Please let me know what your pain points are. :-)

Thanks,
Rafael

