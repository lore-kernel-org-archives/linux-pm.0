From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date: Sun, 16 Dec 2018 17:53:41 -0800
Message-ID: <000001d495ab$5c16eea0$1444cbe0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: WgY3gAchapqCWWgY4gdfDg
In-Reply-To: WgY3gAchapqCWWgY4gdfDg
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, "'Chen, Hu'" <hu1.chen@intel.com>, 'Quentin Perret' <quentin.perret@arm.com>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.12.11 03:50 Rafael J. Wysocki wrote:

...[snip]...

> With this version of the TEO governor I'm observing slight, but consistent
> performance improvements in some different benchmarks on a few different
> systems with respect to menu

Same here.

> and the corresponding power draw differences
> appear to be in the noise.  The idle power doesn't seem to change either.

Same here.

> Also the "above" and "below" metrics (introduced by a separate patch under
> discussion) indicate changes in the "good" direction.

My graphs now include the "above" and "below" metrics.
In particular see Idle State 1 "above" (was too deep) graphs in the links below.
However, performance is up and power about the same, so O.K.
  
> Overall, I like this one, so I may consider dropping the RFC/RFT tag from the
> next submission. :-)
>
> v7 -> v8:
> * Apply the selection rules to the idle deepest state as well as to
>   the shallower ones (the deepest idle state was treated differently
>   before by mistake).
> * Subtract 1/2 of the exit latency from the measured idle duration
>   in teo_update() (instead of subtracting the entire exit latency).
>   This makes the idle state selection be slightly more performance-
>   oriented.

I cherry picked a couple of the mmtests that Giovanni was doing:

Test kernels:

"stock" kernel 4.20-rc5 + a couple of rjw patches. Specifically:

	    2a110ed cpuidle: poll_state: Disregard disable idle states
	    8f09875 cpuidle: Add 'above' and 'below' idle state metrics
	    d6851a5 Documentation: admin-guide: PM: Add cpuidle document
	    2595646 Linux 4.20-rc5

"teov6" above + teov6 patch
"teov7" above + teov7 patch
"teov8" above + teov8 patch

1.) mmtests - netperf-unbound test (UDP):

                                   4.20-rc5               4.20-rc5               4.20-rc5               4.20-rc5
                                      stock                   teo6                   teo7                   teo8
Hmean     send-64         129.64 (   0.00%)      132.45 *   2.17%*      130.55 *   0.71%*      132.87 *   2.49%*
Hmean     send-128        259.53 (   0.00%)      264.90 *   2.07%*      261.61 *   0.80%*      264.94 *   2.09%*
Hmean     send-256        515.24 (   0.00%)      525.41 *   1.97%*      517.41 *   0.42%*      524.88 *   1.87%*
Hmean     send-1024      2041.01 (   0.00%)     2079.22 *   1.87%*     2045.03 *   0.20%*     2077.25 *   1.78%*
Hmean     send-2048      3980.04 (   0.00%)     4071.09 *   2.29%*     4041.15 *   1.54%*     4057.09 *   1.94%*
Hmean     send-3312      6321.90 (   0.00%)     6460.23 *   2.19%*     6395.71 *   1.17%*     6409.09 *   1.38%*
Hmean     send-4096      7695.18 (   0.00%)     7882.81 *   2.44%*     7813.72 *   1.54%*     7832.77 *   1.79%*
Hmean     send-8192     13920.53 (   0.00%)    14146.47 *   1.62%*    13986.72 *   0.48%*    14079.07 *   1.14%*
Hmean     send-16384    24714.99 (   0.00%)    25225.95 *   2.07%*    24896.10 *   0.73%*    25131.52 *   1.69%*
Hmean     recv-64         129.64 (   0.00%)      132.45 *   2.17%*      130.55 *   0.71%*      132.87 *   2.49%*
Hmean     recv-128        259.53 (   0.00%)      264.90 *   2.07%*      261.61 *   0.80%*      264.94 *   2.09%*
Hmean     recv-256        515.24 (   0.00%)      525.41 *   1.97%*      517.41 *   0.42%*      524.88 *   1.87%*
Hmean     recv-1024      2041.01 (   0.00%)     2079.22 *   1.87%*     2045.03 *   0.20%*     2077.25 *   1.78%*
Hmean     recv-2048      3980.04 (   0.00%)     4071.09 *   2.29%*     4041.15 *   1.54%*     4057.09 *   1.94%*
Hmean     recv-3312      6321.88 (   0.00%)     6460.23 *   2.19%*     6395.71 *   1.17%*     6409.09 *   1.38%*
Hmean     recv-4096      7695.15 (   0.00%)     7882.81 *   2.44%*     7813.72 *   1.54%*     7832.75 *   1.79%*
Hmean     recv-8192     13920.52 (   0.00%)    14146.43 *   1.62%*    13986.72 *   0.48%*    14079.07 *   1.14%*
Hmean     recv-16384    24714.99 (   0.00%)    25225.90 *   2.07%*    24896.07 *   0.73%*    25131.49 *   1.69%*

Graphs: http://www.smythies.com/~doug/linux/idle/teo8/net-pref-udp-unbound/index.html
(note: slow upload speed from my server)

2.) mmtests - sockperf-udp-throughput test:

                            4.20-rc5               4.20-rc5               4.20-rc5               4.20-rc5
                               stock                   teo6                   teo7                   teo8
Hmean     14        24.57 (   0.00%)       25.91 *   5.46%*       25.99 *   5.78%*       25.73 *   4.75%*
Hmean     100      175.37 (   0.00%)      185.09 *   5.54%*      185.89 *   6.00%*      184.48 *   5.19%*
Hmean     300      523.81 (   0.00%)      553.47 *   5.66%*      554.70 *   5.90%*      550.16 *   5.03%*
Hmean     500      870.08 (   0.00%)      918.88 *   5.61%*      924.33 *   6.24%*      914.53 *   5.11%*
Hmean     850     1449.44 (   0.00%)     1530.84 *   5.62%*     1535.40 *   5.93%*     1522.53 *   5.04%*

Graphs: http://www.smythies.com/~doug/linux/idle/teo8/sockperf-udp-throughput/index.html
(note: slow upload speed from my server)

The above results tables are also here:
http://www.smythies.com/~doug/linux/idle/teo8/index.html

I wanted to also do the tbench on loopback test, but have not been able to get it working on my system yet.
I'll supply more test results at a later date.

... Doug
