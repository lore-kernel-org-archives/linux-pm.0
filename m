From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date: Mon, 03 Sep 2018 08:15:31 -0700
Message-ID: <9d2882f2877e52c611362dc7e3699eca1e715695.camel@linux.intel.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
         <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mgorman@techsingularity.net, currojerez@riseup.net, ggherdovich@suse.cz, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-09-03 at 18:10 +0300, Eero Tamminen wrote:
> Hi,
> 
> On 31.08.2018 20:28, Srinivas Pandruvada wrote:
> ...
> > As per testing Eero Tamminen, the results are comparable to the
> > patchset
> > https://patchwork.kernel.org/patch/10312259/
> > But he has to watch results for several days to check trend.
> 
> It's close, but there is some gap compared to Francisco's version.
> 
> (Because of the large variance on TDP limited devices, and factors 
> causing extra perf differences e.g. between boots, it's hard to give 
> exact number without having trends from several days / weeks.  I
> would 
> also need new version of Fransisco's patch set that applies to
> latest 
> kernel like yours does.)
> 
> 
> > Since here boost is getting limited to turbo and non turbo, we need
> > some
> > ways to adjust the fractions corresponding to max non turbo as
> > well. It
> > is much easier to use the actual P-state limits for boost instead
> > of
> > fractions. So here P-state io boost limit is applied on top of the
> > P-state limit calculated via current algorithm by removing current
> > io_wait boost calculation using fractions.
> > 
> > Since we prefer to use common algorithm for all processor
> > platforms, this
> > change was tested on other client and sever platforms as well. All
> > results
> > were within the margin of errors. Results:
> > https://bugzilla.kernel.org/attachment.cgi?id=278149
> 
> Good.
> 
> Francisco, how well the listed PTS tests cover latency bound cases
> you 
> were concerned about?  [1]
> 
> 
> 	- Eero
> 
> [1] Fransisco was concerned that the patch:
> * trade-off might regress latency bound cases (which I haven't
> tested, I 
> tested only 3D throughput), and
> * that it addressed only other of the sources of energy
> inefficiencies 
> he had identified (which could explain slightly better 3D results
> from 
> his more complex patch set).
It is always possible to submit improvement patch later. Atleast this
patch will reduce the usage of turbo.

Thanks,
Srinivas 
