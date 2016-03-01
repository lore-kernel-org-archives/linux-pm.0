From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Tue, 1 Mar 2016 11:28:39 -0800
Message-ID: <001601d173f0$8ff83a10$afe8ae30$@net>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>	<87a8mv9ujm.fsf@iki.fi>	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>	<87egc6zc2q.fsf@iki.fi>	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>	<20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi> <002801d172b9$845cde50$8d169af0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta10.telus.net ([209.171.16.83]:58519 "EHLO cmta10.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbcCAT2o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 14:28:44 -0500
In-Reply-To: <002801d172b9$845cde50$8d169af0$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Arto Jantunen' <viiru@iki.fi>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Rik van Riel' <riel@redhat.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Doug Smythies' <dsmythies@telus.net>

Note: Just following up with some energy numbers, that perhaps
should have been included to begin with.

> On 2016.02.28 22:22 Doug Smythies wrote:
>> On 2016.02.28 07:44 Arto Jantunen wrote:

>> Bisect comes up with this commit:
>>
>> commit a9ceb78bc75ca47972096372ff3d48648b16317a
>>
>> I verified the result by reverting
>> 9c4b2867ed7c8c8784dd417ffd16e705e81eb145 and
>> a9ceb78bc75ca47972096372ff3d48648b16317a from 4.5-rc5, the resulting
>> kernel does not have the bug.

...[cut]...

> So what does this have to do with these commits?
>
> Reverting the commits dramatically reduces, but does not eliminate,
> the frequency of the high CPU load long durations situation.
>
> Test results: Each test was 33 minutes, involving 9 incremental
> kernel compiles.
>
> Why an incremental kernel compile? Because it just so happens
> to demonstrate the issue well.

Why 9? Just to have a longer test time for better averaging.

>
> Kernel 1 = 4.5-rc5 + rjw v10 3 patch set. Called "rjwv10".
> Kernel 2 = kernel 1 + above 2 commits reverted. Called "reverted".
>
> Test 1: rjwv10 4056 occurrences
> Test 2: reverted 293 occurrences
> Test 3: rjwv10 7878 occurrences
> Test 4: reverted 259 occurrences
> Test 5: rjwv10 3708 occurrences
> Test 6: reverted 54 occurrences
>
> Average issue reduction ratio: 26 times better.

Turbostat was used for the following:

Test 7: reverted: Package Joules: 47830
Test 8: rjwv10: Package Joules: 54419 (revert saves 12.1% energy)
Test 9: reverted: Package Joules: 49326
Test 10: rjwv10: Package Joules: 55442 (revert saves 11% energy)
Test 11: reverted: acpi-cpufreq ondemand: Package Joules: 49146
Test 12: rjwv10: acpi-cpufreq ondemand: Package Joules: 56302 (revert saves 12.7% energy)

... Doug


