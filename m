From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 5/5] cpufreq: intel_pstate: Document the current behavior and user interface
Date: Sun, 26 Mar 2017 23:32:37 -0700
Message-ID: <001f01d2a6c3$ef7f0c00$ce7d2400$@net>
References: <2025489.DxMTzKos7o@aspire.rjw.lan> qpybcdyUgZGlLqpydcsQsL
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:37655 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdC0GdA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Mar 2017 02:33:00 -0400
In-Reply-To: qpybcdyUgZGlLqpydcsQsL
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Jonathan Corbet' <corbet@lwn.net>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On 2017.03.22 16:32 Rafael J. Wysocki wrote:

I realize that there is tradeoff between a succinct and brief
document and having to write a full book, but I have a couple of
comments anyhow.

> Add a document describing the current behavior and user space
> interface of the intel_pstate driver in the RST format and
> drop the existing outdated intel_pstate.txt document.

... [cut]...

> +The second variant of the ``powersave`` P-state selection algorithm, used in all
> +of the other cases (generally, on processors from the Core line, so it is
> +referred to as the "Core" algorithm), is based on the values read from the APERF
> +and MPERF feedback registers alone

And target pstate over the last sample interval.

> and it does not really take CPU utilization
> +into account explicitly.  Still, it causes the CPU P-state to ramp up very
> +quickly in response to increased utilization which is generally desirable in
> +server environments.

It will only ramp up quickly if another CPU has already ramped up such that the
effective pstate is much higher than the target, giving a very very high "load"
(actually scaled_busy) see comments further down.

... [cut]...

> +Turbo P-states Support
> +======================
...
> +Some processors allow multiple cores to be in turbo P-states at the same time,
> +but the maximum P-state that can be set for them generally depends on the number
> +of cores running concurrently.  The maximum turbo P-state that can be set for 3
> +cores at the same time usually is lower than the analogous maximum P-state for
> +2 cores, which in turn usually is lower than the maximum turbo P-state that can
> +be set for 1 core.  The one-core maximum turbo P-state is thus the maximum
> +supported one overall.

The above segment was retained because it is relevant to footnote 1 below.

...[cut]...

> +For example, the default values of the PID controller parameters for the Sandy
> +Bridge generation of processors are
> +
> +| ``deadband`` = 0
> +| ``d_gain_pct`` = 0
> +| ``i_gain_pct`` = 0
> +| ``p_gain_pct`` = 20
> +| ``sample_rate_ms`` = 10
> +| ``setpoint`` = 97
> +
> +If the derivative and integral coefficients in the PID algorithm are both equal
> +to 0 (which is the case above), the next P-State value will be equal to:
> +
> +  ``current_pstate`` - ((``setpoint`` - ``current_load``) * ``p_gain_pct``)
> +
> +where ``current_pstate`` is the P-state currently set for the given CPU and
> +``current_load`` is the current load estimate for it based on the current values
> +of feedback registers.

While mentioned earlier, it should be emphasized again here that this
"current_load" might be, and very often is, very very different than
the actual load on the CPU. It can be as high as the ratio of the maximum
P state / minimum P state. I.E. for my older i7 processor it can be
38/16 *100% = 237.5%. For more recent processors, that maximum can be much
higher. This is how this control algorithm can achieve a very rapid ramp
of pstate on a CPU that was previously idle, with these settings, and when
other CPUs were already active and ramped up.

> +
> +If ``current_pstate`` is 8 (in the internal representation used by
> +``intel_pstate``) and ``current_load`` is 100 (in percent), the next P-state
> +value will be:
> +
> +	8 - ((97 - 100) * 0.2) = 8.6
> +
> +which will be rounded up to 9, so the P-state value goes up by 1 in this case.
> +If the load does not change during the next interval between invocations of the
> +driver's utilization update callback for the CPU in question, the P-state value
> +will go up by 1 again and so on, as long as the load exceeds the ``setpoint``
> +value (or until the maximum P-state is reached).

No, only if the "load" exceeds the setpoint by at least 0.5/p_gain+setpoint,
Or for these settings, 99.5. The point being that p_gain and setpoint effect
each other in terms of system response.

Suggest it would be worth a fast ramp up example here. Something like:
Minimum pstate = 16; Maximum pstate = 38.

Current pstate = 16,
Effective pstate over the last interval, due to another CPU = 38
"load" = 237.5%

16 - ((97-237.5) * 0.2) = 44.1, which would be clamped to 38.

Footnote 1: Readers might argue that, due to multiple cores being active
at one time, we would never actually get a "load" of 237.5 in the above example.
That is true, but it can get very very close. For simplicity of the example, the
suggestion is to ignore it.
A real trace data sample fast ramp up example:

mperf: 9806829 cycles
apref: 10936506 cycles
tsc: 99803828 cycles
freq: 3.7916 GHz ; effective pstate 37.9
old target pstate: 16
duration: 29.26 milliseconds
load (actual): 9.83%
"load" (scaled)busy): 236
New target pstate: 38
  
... Doug
