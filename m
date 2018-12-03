From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date: Mon, 3 Dec 2018 08:23:56 -0800
Message-ID: <001a01d48b24$9aa38c00$cfeaa400$@net>
References: <42865872.dmYH3PmblP@aspire.rjw.lan> T62Cgz3BqpqCWT62HgcJvj
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: T62Cgz3BqpqCWT62HgcJvj
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Giovanni,

Perhaps I should go off-list for this, not sure.

I had the thought that I should be able to get similar
results as your "8x-SKYLAKE-UMA" on my test computer,
i7-2600K. Or that at least it was worth trying, just
to see. I couldn't find the same or similar test
on Phoronix, and my attempts to do similar, for example,
with iperf, didn't show differences between the baseline
kernel and one with the teov6 patch.

So I tried the test set you referenced [1]:

On 2018.12.01 06:18 Giovanni Gherdovich wrote:
...
> * netperf on loopback over TCP
>    * global-dhp__network-netperf-unbound

I assume this means that I am supposed to do:

cp config-global-dhp__network-netperf-unbound config

from the configs directory. Anyway that config file
looks correct. Then:

./run-mmtests.sh --no-monitor 3.0-nomonitor

...

> * sockperf on loopback over UDP, mode "throughput"
>    * global-dhp__network-sockperf-unbound

Similarly (from the appropriate directories): 

cp config-global-dhp__network-sockperf-unbound config
./run-mmtests.sh --no-monitor 3.0-nomonitor

My issue is that I do not understand the output or how it
might correlate with your tables.

I get, for example:

   3    1   1     0.13s     0.68s     0.80s  1003894.302 1003779.613
   3    1   1     0.16s     0.64s     0.80s  1008900.053 1008215.336
   3    1   1     0.14s     0.66s     0.80s  1009630.439 1008990.265
...

But I don't know what that means, nor have I been able to find
a description anywhere.

In the README file, I did see that for reporting I am 
somehow supposed to use compare-kernels.sh, but
I couldn't figure that out.

By the way, I am running these tests as a regular user, but
they seem to want to modify:

/sys/kernel/mm/transparent_hugepage/enabled

which requires root privilege. I don't really want to mess
with that stuff for these tests.
 
> [1] https://github.com/gormanm/mmtests

Can you help me to produce meaningful results to compare with
your results?

... Doug
