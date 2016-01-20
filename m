From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Wed, 20 Jan 2016 10:25:48 +0000
Message-ID: <20160120102548.GO8573@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <20160119150551.GI6344@twins.programming.kicks-ass.net>
 <20160119175038.GS6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119175038.GS6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 19/01/16 17:50, Mark Brown wrote:
> On Tue, Jan 19, 2016 at 04:05:51PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 08, 2016 at 02:09:28PM +0000, Juri Lelli wrote:
> 
> > >     cons: - not easy to come up with a clean solution, as it seems interaction
> > >             with several subsystems (e.g., cpufreq) is required
> > >           - not easy to agree upon a single benchmark (that has to be both
> > >             representative and simple enough to run at boot)
> > >           - numbers might (and do) vary from boot to boot
> 
> > This last point is a total pain for benchmarking, it means nothing is
> > every reproducible.
> 
> > Therefore, I would always augment the above (2) with the below (3), such
> > that you can overwrite the results with a known stable set of numbers:
> 
> The suggestion when the previous version was being discussed was that
> there are supposed to be some other knobs one uses for tuning and one
> was never supposed to use these numbers.

Right, DT solution might live without a sysfs interface, as you want to
use those other knobs for runtime tuning. Dynamic solution instead, and
I think this is what Peter was also pointing out, will most probably
require a sysfs interface for cases in which variation of default values
from boot to boot is not acceptable.
