From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Date: Tue, 31 Jul 2018 12:07:08 -0700
Message-ID: <41b51613acbdaf59294f436af057753978908470.camel@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
         <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
         <87bmarhqk4.fsf@riseup.net>
         <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
         <e7388bf4-deb1-34b6-97d7-89ced8e78ef1@intel.com>
         <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
         <20180731150438.GE2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731150438.GE2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>, Mel Gorman <mgorman@techsingularity.net>, Francisco Jerez <currojerez@riseup.net>, lenb@kernel.org, rjw@rjwysocki.net, ggherdovich@suse.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-07-31 at 17:04 +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 07:06:21AM -0700, Srinivas Pandruvada wrote:
> > On Mon, 2018-07-30 at 14:16 +0300, Eero Tamminen wrote:
> > > Questions:
> > > 
> > > * Does currently kernel CPU freq management have any idea which
> > > IO
> > >    devices share TDP with the CPU cores?
> > No. The requests we do to hardware is just indication only (HW can
> > ignore it). The HW has a bias register to adjust and distribute
> > power
> > among users.
> > We can have several other active device on servers beside CPU which
> > when runs need extra power. So the HW arbitrates power.
> 
> That's not entirely accurate AFAIK. "No" is accurate for Intel, but
> the
> ARM people have their IPA thing (not a beer):
We also have that for using space programs (E.g. KBL-G).

Thanks,
Srinivas

> 
>   https://developer.arm.com/open-source/intelligent-power-allocation
> 
>   drivers/thermal/power_allocator.c
> 
> which IIUC interacts with their cpufreq driver to disallow certain
> OPP
> states.
> 
> And note that I discourage intel_pstate active mode.
