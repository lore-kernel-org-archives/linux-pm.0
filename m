From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] cpufreq: intel_pstate: Document the current behavior and user interface
Date: Thu, 30 Mar 2017 02:19:09 +0200
Message-ID: <1508495.qXATtFiRmu@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan> <001f01d2a6c3$ef7f0c00$ce7d2400$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001f01d2a6c3$ef7f0c00$ce7d2400$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Jonathan Corbet' <corbet@lwn.net>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, March 26, 2017 11:32:37 PM Doug Smythies wrote:
> On 2017.03.22 16:32 Rafael J. Wysocki wrote:
> 
> I realize that there is tradeoff between a succinct and brief
> document and having to write a full book, but I have a couple of
> comments anyhow.
> 
> > Add a document describing the current behavior and user space
> > interface of the intel_pstate driver in the RST format and
> > drop the existing outdated intel_pstate.txt document.
> 
> ... [cut]...
> 
> > +The second variant of the ``powersave`` P-state selection algorithm, used in all
> > +of the other cases (generally, on processors from the Core line, so it is
> > +referred to as the "Core" algorithm), is based on the values read from the APERF
> > +and MPERF feedback registers alone
> 
> And target pstate over the last sample interval.

Fair enough.

> > and it does not really take CPU utilization
> > +into account explicitly.  Still, it causes the CPU P-state to ramp up very
> > +quickly in response to increased utilization which is generally desirable in
> > +server environments.
> 
> It will only ramp up quickly if another CPU has already ramped up such that the
> effective pstate is much higher than the target, giving a very very high "load"
> (actually scaled_busy) see comments further down.

I really wouldn't like to go into too much detail here.

I'm about to write something along these lines:

"It does not really take CPU utilization into account explicitly, but as a rule it
causes the CPU P-state to ramp up [...]".

> ... [cut]...
> 
> > +Turbo P-states Support
> > +======================
> ...
> > +Some processors allow multiple cores to be in turbo P-states at the same time,
> > +but the maximum P-state that can be set for them generally depends on the number
> > +of cores running concurrently.  The maximum turbo P-state that can be set for 3
> > +cores at the same time usually is lower than the analogous maximum P-state for
> > +2 cores, which in turn usually is lower than the maximum turbo P-state that can
> > +be set for 1 core.  The one-core maximum turbo P-state is thus the maximum
> > +supported one overall.
> 
> The above segment was retained because it is relevant to footnote 1 below.
> 
> ...[cut]...
> 
> > +For example, the default values of the PID controller parameters for the Sandy
> > +Bridge generation of processors are
> > +
> > +| ``deadband`` = 0
> > +| ``d_gain_pct`` = 0
> > +| ``i_gain_pct`` = 0
> > +| ``p_gain_pct`` = 20
> > +| ``sample_rate_ms`` = 10
> > +| ``setpoint`` = 97
> > +
> > +If the derivative and integral coefficients in the PID algorithm are both equal
> > +to 0 (which is the case above), the next P-State value will be equal to:
> > +
> > +  ``current_pstate`` - ((``setpoint`` - ``current_load``) * ``p_gain_pct``)
> > +
> > +where ``current_pstate`` is the P-state currently set for the given CPU and
> > +``current_load`` is the current load estimate for it based on the current values
> > +of feedback registers.
> 
> While mentioned earlier, it should be emphasized again here that this
> "current_load" might be, and very often is, very very different than
> the actual load on the CPU. It can be as high as the ratio of the maximum
> P state / minimum P state. I.E. for my older i7 processor it can be
> 38/16 *100% = 237.5%. For more recent processors, that maximum can be much
> higher. This is how this control algorithm can achieve a very rapid ramp
> of pstate on a CPU that was previously idle, with these settings, and when
> other CPUs were already active and ramped up.

I actually copied this part from the existing intel_pstate.txt document and only
edited it somewhat.  Now I realize that it really was not too accurate at all
originally.

I think I'll simply skip the entire example part of this section, as the original
simply doesn't reflect the reality and I don't think it's particularly useful
to try to describe it more accurately here.

Thanks,
Rafael
