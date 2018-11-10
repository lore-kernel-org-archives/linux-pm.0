From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date: Sat, 10 Nov 2018 13:47:33 -0800
Message-ID: <001001d4793f$020a7f90$061f7eb0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: JLIjge0NMDhAwJLIogChPj KR9ogVaVz6DhgKRFdgxgYz
In-Reply-To: KR9ogVaVz6DhgKRFdgxgYz
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Doug Smythies' <dsmythies@telus.net>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

On 2018.11.07 09:04 Doug Smythies wrote:

> The Phoronix dbench test was run under the option to run all
> the tests, instead of just one number of clients. This was done
> with a reference/baseline kernel of 4.20-rc1, and also with this
> TEO version 3 patch. The tests were also repeated with trace
> enabled for 5000 seconds. Idle information and processor
> package power were sampled once per minute in all test runs.
>
> The results are:
> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
> http://fast.smythies.com/linux-pm/k420/histo_compare.htm

Another observation from the data, and for the reference/
baseline 4.20-rc1 kernel, idle state 0 histogram plots
is that there are several (280) long idle durations.

For unknown reasons, these are consistently dominated by
CPU 5 on my system (264 of the 280, in this case).

No other test that I have tried shows this issue,
But other tests also tend to set the need_resched
flag whereas the dbench test doesn't.

Older kernels also have the issue. I tried: 4.19, 4.18
4.17, 4.16+"V9" idle re-work patch set of the time.
There is no use going back further, because "V9" was
to address excessively long durations in shallow idle states.

I have not made progress towards determining the root issue.

... Doug
