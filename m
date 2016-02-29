From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sun, 28 Feb 2016 22:22:06 -0800
Message-ID: <002801d172b9$845cde50$8d169af0$@net>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>	<87a8mv9ujm.fsf@iki.fi>	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>	<87egc6zc2q.fsf@iki.fi>	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>	<20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:33455 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbcB2GWL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Feb 2016 01:22:11 -0500
In-Reply-To: <87egbwn8lp.fsf@iki.fi>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Arto Jantunen' <viiru@iki.fi>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Rik van Riel' <riel@redhat.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>

On 2016.02.28 07:44 Arto Jantunen wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> On 22-02-16, 18:39, Arto Jantunen wrote:
>>> Viresh Kumar <viresh.kumar@linaro.org> writes: 
>>>> On 21-02-16, 22:33, Arto Jantunen wrote:

> Bisect comes up with this commit:
>
> commit a9ceb78bc75ca47972096372ff3d48648b16317a
>
> I verified the result by reverting
> 9c4b2867ed7c8c8784dd417ffd16e705e81eb145 and
> a9ceb78bc75ca47972096372ff3d48648b16317a from 4.5-rc5, the resulting
> kernel does not have the bug.

Interesting.

I also reverted those two commits, and they made a huge
difference to something else I have been working on, heretofore
not thought to be related.

Recall:

A couple of weeks ago, I was trying Rafael's 3 patch set with the
intel_pstate driver:
"[PATCH 0/3] cpufreq: Replace timers with utilization update callbacks"
And while it solved the long standing issue of potentially incorrectly
driving down the target pstate due to the CPU being idle on jiffy
boundaries but otherwise busy, there were other scenarios (previously
masked by the dominance of the jiffy boundary method).

Example:

CPU 5
Core_busy: 92
Scaled busy: 0
Old target pstate: 18
New target pstate: 16 (minimum for the processor)
mpref: 7181473469
aperf: 6675884860
tsc: 7193569488
freq: 3160539 kHz
load: 99.83
duration: 2108.79 mSec

Assertion: At such a very high CPU load, there should have been
many passes through the intel_pstate driver in that 2.1 second
interval, all driving up the target pstate towards the maximum
of 38 for the processor involved. Instead the target pstate is
driven down, due to the long duration.

So what does this have to do with these commits?

Reverting the commits dramatically reduces, but does not eliminate,
the frequency of the high CPU load long durations situation.

Test results: Each test was 33 minutes, involving 9 incremental
kernel compiles.

Why an incremental kernel compile? Because it just so happens
to demonstrate the issue well.

Kernel 1 = 4.5-rc5 + rjw v10 3 patch set. Called "rjwv10".
Kernel 2 = kernel 2 + above 2 commits reverted. Called "reverted".

Test 1: rjwv10 4056 occurrences
Test 2: reverted 293 occurrences
Test 3: rjwv10 7878 occurrences
Test 4: reverted 259 occurrences
Test 5: rjwv10 3708 occurrences
Test 6: reverted 54 occurrences

Average issue reduction ratio: 26 times better.

... Doug


