From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date: Wed, 28 Nov 2018 15:20:07 -0800
Message-ID: <002c01d48770$eba6efa0$c2f4cee0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: Q8oEgsq1aDhAwQ8oJg8ZUI
In-Reply-To: Q8oEgsq1aDhAwQ8oJg8ZUI
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.11.23 02:36 Rafael J. Wysocki wrote:

v5 -> v6:
 * Avoid applying poll_time_limit to non-polling idle states by mistake.
 * Use idle duration measured by the governor for everything (as it likely is
   more accurate than the one measured by the core).

-- above missing-- (see follow up e-mail from Rafael)

 * Rename SPIKE to PULSE.
 * Do not run pattern detection upfront.  Instead, use recent idle duration
   values to refine the state selection after finding a candidate idle state.
 * Do not use the expected idle duration as an extra latency constraint
   (exit latency is less than the target residency for all of the idle states
   known to me anyway, so this doesn't change anything in practice).

Hi Rafael,

I did some minimal testing on teov6, using kernel 4.20-rc3 as my baseline
reference kernel.

Test 1: Phoronix bdench test, all options: 1, 6, 12, 48, 128, 256 clients.

Note: because it uses the disk, the dbench test is somewhat non-repeatable.
However, if particular attention is paid to not doing anything else with
the disk between tests, then it seems to be repeatable to within about 6%.

Anyway no significant difference observed between kernel 4.20-rc3 and the
same with the teov6 patch.

Test 2: Pipe test, non cross core. (And idle state 0 test, really)
I ran 4 pipe tests, 1 for each of my 4 cores, @2 CPUs per core.
Thus, pretty much only idle state 0 was ever used.
Processor package power was similar for both kernels.
teov6 entered/exited idle state 0 about 60,984 times/second/cpu.
-rc3 entered/exited idle state 0 about 62,806 times/second/cpu.
There was a difference in percentage time spent in idle state 0,
with kernel 4.20-rc3 spending 0.2441% in idle state 0 verses
teov6 at 0.0641%.

For throughput, teov6 was 1.4% faster.

Test 3: was an attempt to sweep through a preference for
all idle states.

40 threads were launched with nothing to do except sleep
for a variable duration of 1 to 500 uSec, each step was
run for 1 minute. With 1 minute idle before the test and a few
minutes idle after, the total test duration was about 505 minutes.
Recall that when one asks for a short sleep of 1 uSec, they actually
get about 50 uSec, due to overheads. So I use 40 threads in an attempt
to get the average time between wakeup events per CPU down somewhat.

The results are here:
http://fast.smythies.com/linux-pm/k420/k420-pn-sweep-teo6-2.htm

I might try to get some histogram information at a later date.

... Doug
