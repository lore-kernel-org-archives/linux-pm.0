From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 9 Mar 2016 15:45:40 -0800
Message-ID: <003701d17a5d$cab287a0$601796e0$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>	<87si087tsr.fsf@iki.fi>	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>	<87a8m74mcc.fsf@iki.fi>	<002d01d17a57$ec417030$c4c45090$@net> <CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:56303 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934607AbcCIXpo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Mar 2016 18:45:44 -0500
In-Reply-To: <CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2016.03.09 15:18 Rafael J. Wysocki wrote:
> On Thu, Mar 10, 2016 at 12:03 AM, Doug Smythies <dsmythies@telus.net> wrote:
>> Does the direction that this thread has taken mean that those two
>> commits that Arto identified might now not be reverted?
>
> Yes.
>
>> Commits:
>> 9c4b2867ed7c8c8784dd417ffd16e705e81eb145
>> a9ceb78bc75ca47972096372ff3d48648b16317a
>>
>> Recall that increased energy consumption was also isolated to those
>> two commits for some types of workflow. The suggestion is that the
>> commits should be reverted anyhow.
>>
>> What seems to be happening is that CPUs are deciding to stay in idle
>> state 0 a lot more, when they actually could / should be in a deeper
>> idle state.
>>
>> Test time is always: 33 minutes and 20 seconds test (8 CPUs), and there
>> is never any noticeable difference in execution times for the work:
>>
>> Example 1: kernel 4.5-rc5 with the rjw 3 patch set version 10
>> "Replace timers with utilization update callbacks":
>> Aggregate times in each idle state:
>
> You need to say what workload that is too.

Sorry, it had been on other e-mails, anyway I do this
(compile the kernel, a few times):

#!/bin/dash

# compile_9 Smythies 2016.03.02
#       Add some idle stats.
#
# compile_9 Smythies 2016.02.28
#       Do 9 incremental compiles.
#       Just trying to be consistent between kernels.
#

cat /sys/devices/system/cpu/cpu*/cpuidle/*/time > ~/temp-doug/begin.txt

LOOPS=0
while [ $LOOPS -lt 9 ];
do
  time make -j9 olddefconfig bindeb-pkg LOCALVERSION=-test
  sleep 1
  LOOPS=$((LOOPS+1))
done

cat /sys/devices/system/cpu/cpu*/cpuidle/*/time > ~/temp-doug/end.txt

_________________________

No files have been touched since a previous compile.
The first compile takes about 8 or 9 minutes, and the rest
take about 2 minutes and 45 seconds, due to caching.
Total about 30 or 31 minutes.

Note that a clean compile takes about 20 minutes, but
that is not what I am doing.

Meanwhile, the following command is being run on
another SSH session (for 33 minutes and 20 seconds):

sudo turbostat -S -J --debug sleep 2000

>> rjwv10 (minutes)        reverted (minutes)      Idle State
>> 27.0654211              2.617325533                     0
>> 12.92451315             24.53266672                     1
>> 3.668558467             3.780482633                     2
>> 1.2727832               1.61352195                      3
>> 130.8342596             141.2234947                     4
>>
>> 175.7655355             173.7674915                     total
>>
>> Example 2: kernel 4.5-rc7 stock:
>> Aggregate times in each idle state:
>>
>> k45rc7 (minutes)        reverted (minutes)      Idle State
>> 20.1771917              2.638311483                     0
>> 13.02770225             21.81474838                     1
>> 3.428136783             3.951405                        2
>> 1.4540243               1.552488167                     3
>> 134.9057413             143.5533                        4
>>
>> 172.9927963             173.5102531                     total
>>
>> Energy (restated from a previous e-mail):
>>
>> Test 7: reverted: Package Joules: 47830
>> Test 8: rjwv10: Package Joules: 54419 (revert saves 12.1% energy)
>>
>> Test 9: reverted: Package Joules: 49326
>> Test 10: rjwv10: Package Joules: 55442 (revert saves 11% energy)
>>
>> Test 11: reverted: acpi-cpufreq ondemand: Package Joules: 49146
>> Test 12: rjwv10: acpi-cpufreq ondemand: Package Joules: 56302 (revert saves 12.7% energy)
>>
>> Energy (not in any previous e-mail):
>>
>> Reverted: 56178 Joules
>> Kernel 4.5-rc7: 63269 Joules (revert saves 12.6% energy)

> So the claim in commit a9ceb78bc75ca47972096372ff3d48648b16317a is
> that the change should not really affect systems with low C1
> latencies.
>
> I wonder what's the C1 latency on your test system?

>From that script from a Rik van Riel e-mail:

state 0 latency: 0
state 1 latency: 2
state 2 latency: 10
state 3 latency: 80
state 4 latency: 104


