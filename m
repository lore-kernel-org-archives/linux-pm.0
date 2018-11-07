From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date: Wed, 7 Nov 2018 09:04:12 -0800
Message-ID: <000001d476bb$ec964520$c5c2cf60$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: JLIjge0NMDhAwJLIogChPj
In-Reply-To: JLIjge0NMDhAwJLIogChPj
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.11.04 08:31 Rafael J. Wysocki wrote:

> v2 -> v3:
> * Simplify the pattern detection code and make it return a value
>	lower than the time to the closest timer if the majority of recent
>	idle intervals are below it regardless of their variance (that should
>	cause it to be slightly more aggressive).
> * Do not count wakeups from state 0 due to the time limit in poll_idle()
>    as non-timer.
>
> Note: I will be mostly offline tomorrow, so this goes slightly early.
> I have tested it only very lightly, but it is not so much different from
> the previous one.
> 
> It requires the same additional patches to apply as the previous one too.

Even though this v3 has now been superseded by v4, I completed some test
work in progress for v3 anyhow.

The main reason to complete the work, and write up, was because, and for my
own interest as much as anything, I wanted to specifically test for the
influence of running trace on the system under test.
Reference: https://marc.info/?l=linux-kernel&m=154145580925439&w=2

The Phoronix dbench test was run under the option to run all
the tests, instead of just one number of clients. This was done
with a reference/baseline kernel of 4.20-rc1, and also with this
TEO version 3 patch. The tests were also repeated with trace
enabled for 5000 seconds. Idle information and processor
package power were sampled once per minute in all test runs.

The results are:
http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
http://fast.smythies.com/linux-pm/k420/histo_compare.htm

Conclusion: trace has negligible effect, until the system gets
severely overloaded.

There are some odd long idle durations with TEOv3 for idle
states 1, 2, and 3 that I'll watch for with v4 testing.

Other information:
Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
The kernels were 1000 Hz.
Idle latency/residency info:
STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 80     RESIDENCY: 211
STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 104    RESIDENCY: 345

... Doug
 
