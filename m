From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
Date: Wed, 18 Jul 2018 10:23:52 +0200
Message-ID: <20180718082352.GQ2494@hirez.programming.kicks-ass.net>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan>
 <20180717201323.6rwb4yklq46cmtom@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717201323.6rwb4yklq46cmtom@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 10:13:23PM +0200, Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The firmware interface used by the pcc-cpufreq driver is
> > fundamentally not scalable and using it for dynamic CPU performance
> > scaling on systems with many CPUs leads to degraded performance.
> > 
> > For this reason, disable dynamic CPU performance scaling on systems
> > with pcc-cpufreq where the number of CPUs present at the driver init
> > time is greater than 4.  Also make the driver print corresponding
> > complaints to the kernel log.
> > 
> > Reported-by: Andreas Herrmann <aherrmann@suse.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > -> v2: Rework the messages printed in the problematic case.
> 
> I've tested this patch. Effect is as expected: driver loads but use of
> ondemand governor is not allowed. Sample output:
> 
> [   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
> [   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
> [   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings

BTW, Andreas, is that BIOS option available through the normal BIOS
settings, or it is in the "secret" BIOS menu that HP has? If it is in
the "secret" one (^A IIRC) then we might want to explicitly mention
that.
