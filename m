From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Date: Tue, 31 Jul 2018 17:04:38 +0200
Message-ID: <20180731150438.GE2458@hirez.programming.kicks-ass.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
 <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
 <87bmarhqk4.fsf@riseup.net>
 <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
 <e7388bf4-deb1-34b6-97d7-89ced8e78ef1@intel.com>
 <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Eero Tamminen <eero.t.tamminen@intel.com>, Mel Gorman <mgorman@techsingularity.net>, Francisco Jerez <currojerez@riseup.net>, lenb@kernel.org, rjw@rjwysocki.net, ggherdovich@suse.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 30, 2018 at 07:06:21AM -0700, Srinivas Pandruvada wrote:
> On Mon, 2018-07-30 at 14:16 +0300, Eero Tamminen wrote:
> > Questions:
> > 
> > * Does currently kernel CPU freq management have any idea which IO
> >    devices share TDP with the CPU cores?

> No. The requests we do to hardware is just indication only (HW can
> ignore it). The HW has a bias register to adjust and distribute power
> among users.
> We can have several other active device on servers beside CPU which
> when runs need extra power. So the HW arbitrates power.

That's not entirely accurate AFAIK. "No" is accurate for Intel, but the
ARM people have their IPA thing (not a beer):

  https://developer.arm.com/open-source/intelligent-power-allocation

  drivers/thermal/power_allocator.c

which IIUC interacts with their cpufreq driver to disallow certain OPP
states.

And note that I discourage intel_pstate active mode.
