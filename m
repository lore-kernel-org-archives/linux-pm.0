From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Tue, 15 Dec 2015 11:30:16 +0100
Message-ID: <566FEBB8.5090008@linux.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
 <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com>
 <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan>
 <48DF4267-671B-40E2-8C95-CCF5795F8B26@linux.intel.com>
 <001c01d136bc$a4a78a90$edf69fb0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13901 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964803AbbLOK3P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 05:29:15 -0500
In-Reply-To: <001c01d136bc$a4a78a90$edf69fb0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: 'Thomas Renninger' <trenn@suse.de>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Len Brown' <lenb@kernel.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 'Prarit Bhargava' <prarit@redhat.com>, viresh.kumar@linaro.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

Hi Doug,

On 14/12/2015 23:13, Doug Smythies wrote:
> On 2015.12.14 08:15 Stephane Gasparini wrote:
>
>> Here are the results we have on a android release of WW50
>> Note that as of today Android is using Interactive Governor.
> Thanks very much for your test results.
> By "Intel PState CPU Load" I assume you mean using that V6 3 patch
> "cpufreq: intel_pstate: account non C0 time" from Dec 4th, which I also
> tested and sent an off-list reply to Philippe.
> Summary: I like the patch set.
These tests were done on a previous version of my patch done in WW40.
We'll sent an updated version (WW50 with patch V6 3) soon.
> Myself, I would like to see tests comparing the current
> "powersave" governor to your "CPU Load" method, although
> I do always like the reference "performance" test. However,
> I suspect that in your case, there wouldn't be much difference.
> After you moved the setpoint to 60 from 97, the response becomes
> pretty much like performance mode.[1]
In the table sent by stephane, "performance" meant "original algorithm" 
based on average pstate (aperf/mperf).
On Atoms, a setpoint of 60 is not too high. With higher setpoints we'll 
not be able to reach meet some performance KPIs
(some frames are dropped mainly for gaming use cases). However, we are 
working on a more power conservative algorithm).
>
> Also, you provide only power information, and no performance / energy
> trade-off information. Do any of those tests reveal good power use, but
> unbearable performance? What I am saying is that power by itself is not
> a sufficient evaluation criteria, otherwise just lock in the minimum pstate
> and be done with it, which we know isn't the right solution.
Stephane has also some other performance/power figures done with Power 
Lab. We'll see if we can share them.
>    
>> Atom:                              Intel PState   Intel PState     Power
>>                                     Performance    CPU Load      Improvment
>> 50% Load 1 thread                     260 mW         25 mW        -90%
> If I understand correctly, the CPU load is 50% regardless of CPU frequency.
> If yes, then this particular test is grossly unfair and misleading.
> Why?
> Because using your default setpoint of 60, the CPU load method will hold
> the pstate at minimum, whereas performance mode will ask for the maximum.
> The result will be drastic differences in the actual amount of work done
> per unit time.
Yes, you are right, we need to fix that workload or to remove it to the 
list.
Also a fixed load does not correspond to a real use case.
This is why we are not using this test as a KPI.

>
> I think that a more comparable test would be a 50% (or whatever) load
> calibrated to a nominal CPU frequency (I use the max non-turbo CPU
> frequency, but it can be anything.) Meaning that the once the fixed
> packet of work is done, the CPU can go idle sooner or later, depending
> on the CPU frequency.
Are you using an existing tool for doing that or did you developed your 
own tool ?
>
> Note also, that the work/sleep frequency used to attain the 50% load
> can be relevant, particularly at lower sleep/work frequencies where
> the intel_pstate driver response can have higher and higher
> magnitude oscillations. By the way, in my tests, your "CPU Load" method
> lower sleep/work frequency results were phenomenally good.
Yes, that's what we observed also. For many use cases very often used in 
android
(gaming, circular progress bar, audio playback, video playback, etc 
...), using the
load instead of the ratio avg_pstate/current_pstate is a good choice and 
can save
a lot of power!
>
> Here are some results from my test computer, albeit with the wrong processor:
>
> Note 1: I have an older i7-2600K.
> Note 2: Obviously, I forced your code patch to work with my processor ID.
> Note 3: Power is package power measured with turbostat.
> Note 4: one thread.
>
> 1.) 50% load at 3.4GHz 201 hertz work / sleep frequency:
>
> 4.4-rc5 powersave 11.27 watts*
> 4.4-rc5 performance 12.83 watts
> 4.4-rc3 + PL ver 6 3 patch set (default (60)): 10.47 watts
> 4.4-rc3 + PL ver 6 3 patch set (setpoint 40): 12.55 watts
> 4.4-rc3 + PL ver 6 3 patch set (setpoint 70): 9.72 watts**
>
> 2.) 50% load at 3.4GHz 50 hertz work / sleep frequency:
>
> 4.4-rc5 powersave 12.01 watts
> 4.4-rc5 performance 11.90 watts
> 4.4-rc3 + PL ver 6 3 patch set (default (60)): 10.09 watts
> 4.4-rc3 + PL ver 6 3 patch set (setpoint 40): 12.01 watts
> 4.4-rc3 + PL ver 6 3 patch set (setpoint 70): 9.65 watts
>
> *  there were 6 overruns.
> ** there were 3 overruns, meaning the work packet did not
> finish in time before the next one was supposed to start.
> This issue goes to step function load response time. i.e
> How fast does the scaling driver respond to load and ramp up
> the CPU frequency. My test program can catch up, but some
> applications might not like the delay.
>    
> An example of a performance / energy trade-off test:
>
> phoronix ffmpeg test:
> Shorter time is better.
> The ffmpeg test is known to be particularly difficult for
> frequency scaling drivers to handle. The scenario is similar
> to how some games utilize all the CPUs.
>
> Your patch set (an older version) on kernel 4.4-rc1:
> setpoint 60: 17.84 seconds ave. 4324 package Joules. (default)
> setpoint 40: 12.86 seconds ave. 4822 package Joules. (noisey)
>
> or ~30% time improvement at a cost of 12% more energy, which some
> users might think worthwhile.
>
> For reference:
> intel_pstate powersave (normal processor, setpoint 97): 12.06 seconds ave. 4983 package Joules
> I do not have energy numbers for the below:
> Performance mode: 11.16 seconds ave.
> acpi-cpufreq powersave: 24.47 seconds ave.
> acpi-cpufreq ondemand: 13.35 seconds ave.
> acpi-cpufreq conservative: 17.60 seconds ave.
>
> [1] http://marc.info/?l=linux-pm&m=142894256520552&w=2
>
> ... Doug
>
>
Thx for the data,

Philippe
