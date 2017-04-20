From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Thu, 20 Apr 2017 07:55:57 -0700
Message-ID: <000a01d2b9e6$393afef0$abb0fcd0$@net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net> <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com> <004801d2b2da$0c65d2a0$253177e0$@net> <003101d2b573$16b28370$44178a50$@net> 0km3dJh6UopZn0km8dR0Pj
Mime-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:40936 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943624AbdDTO4D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Apr 2017 10:56:03 -0400
In-Reply-To: 0km3dJh6UopZn0km8dR0Pj
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Mel Gorman' <mgorman@techsingularity.net>
Cc: 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?iso-8859-1?Q?'J=F6rg_Otte'?= <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>

On 2017.04.19 01:16 Mel Gorman wrote:
> On Fri, Apr 14, 2017 at 04:01:40PM -0700, Doug Smythies wrote:
>> Hi Mel,
>> 
>> Thanks for the "how to" information.
>> This is a very interesting use case.
>> From trace data, I see a lot of minimal durations with
>> virtually no load on the CPU, typically more consistent
>> with some type of light duty periodic (~~100 Hz) work flow
>> (where we would prefer to not ramp up frequencies, or more
>> accurately keep them ramped up).
>
> This broadly matches my expectations in terms of behaviour. It is a
> low duty workload but while I accept that a laptop may not want the
> frequencies to ramp up, it's not universally true.

Agreed.

> Long periods at low
> frequency to complete a workload is not necessarily better than using a
> high frequency to race to idle.

Agreed, but it is processor dependant. For example with my older
i7-2700k processor I get the following package energies for
one loop (after the throw away loop) of the test (method 1):

intel_cpu-freq, powersave (lowest energy reference) 5876 Joules
intel_cpu-freq, conservative 5927 Joules
intel_cpu-freq, ondemand 6525 Joules
intel_cpu_freq, schedutil 6049 Joules
              , performance (highest energy reference) 8105 Joules
intel_pstate, powersave 7044 Joules
intel_pstate, force the load based algorithm 6390 Joules

> Effectively, a low utilisation test suite
> could be considered as a "foreground task of high priority" and not a
> "background task of little interest".

I wouldn't know how to make the distinction.

>> My results (further below) are different than yours, sometimes
>> dramatically, but the trends are similar.
>
> It's inevitable there would be some hardware based differences. The
> machine I have appears to show an extreme case.

Agreed.

>> I have nothing to add about the control algorithm over what
>> Rafael already said.
>> 
>> On 2017.04.11 09:42 Mel Gorman wrote:
>>> On Tue, Apr 11, 2017 at 08:41:09AM -0700, Doug Smythies wrote:
>>>> On 2017.04.11 03:03 Mel Gorman wrote:
>>>>>On Mon, Apr 10, 2017 at 10:51:38PM +0200, Rafael J. Wysocki wrote:
>>>>>> On Mon, Apr 10, 2017 at 10:41 AM, Mel Gorman wrote:
>>>>>>>
>>>>>>> It's far more obvious when looking at the git test suite and the length
>>>>>>> of time it takes to run. This is a shellscript and git intensive workload
>>>>>>> whose CPU utilisatiion is very low but is less sensitive to multiple
>>>>>>> factors than netperf and sockperf.
>>>>>> 
>>>> 
>>>> I would like to repeat your tests on my test computer (i7-2600K).
>>>> I am not familiar with, and have not been able to find,
>>>> "the git test suite" shellscript. Could you point me to it?
>>>>
>>>
>>> If you want to use git source directly do a checkout from
>>> https://github.com/git/git and build it. The core "benchmark" is make
>>> test and timing it.
>> 
>> Because I had troubles with your method further below, I also did
>> this method. I did 5 runs, after a throw away run, similar to what
>> you do (and I could see the need for a throw away pass).
>> 
>
> Yeah, at the very least IO effects should be eliminated.
>
>> Results (there is something wrong with user and system times and CPU%
>> in kernel 4.5, so I only calculated Elapsed differences):
>> 
>
> In case it matters, the User and System CPU times are reported as standard
> for these classes of workload by mmtests even though it's not necessarily
> universally interesting. Generally, I consider the elapsed time to
> be the most important but often, a major change in system CPU time is
> interesting. That's not universally true as there have been changes in how
> system CPU is calculated in the past and it's sensitive to Kconfig options
> with VIRT_CPU_ACCOUNTING_GEN being a notable source of confusion in the past.
>
>> Linux s15 4.5.0-stock #232 SMP Tue Apr 11 23:54:49 PDT 2017 x86_64 x86_64 x86_64 GNU/Linux
>> ... test_run: start 5 runs ...
>> 327.04user 122.08system 33:57.81elapsed (2037.81 : reference) 22%CPU
>> ... test_run: done ...
>> 
>> Linux s15 4.11.0-rc6-stock #231 SMP Mon Apr 10 08:29:29 PDT 2017 x86_64 x86_64 x86_64 GNU/Linux
>> 
>> intel_pstate - powersave
>> ... test_run: start 5 runs ...
>> 1518.71user 552.87system 39:24.45elapsed (2364.45 : -16.03%) 87%CPU
>> ... test_run: done ...
>> 
>> intel_pstate - performance (fast reference)
>> ... test_run: start 5 runs ...
>> 1160.52user 291.33system 29:36.05elapsed (1776.05 : 12.85%) 81%CPU
>> ... test_run: done ...
>> 
>> intel_cpufreq - powersave (slow reference)
>> ... test_run: start 5 runs ...
>> 2165.72user 1049.18system 57:12.77elapsed (3432.77 : -68.45%) 93%CPU
>> ... test_run: done ...
>> 
>> intel_cpufreq - ondemand
>> ... test_run: start 5 runs ...
>> 1776.79user 808.65system 47:14.74elapsed (2834.74 : -39.11%) 91%CPU
>> 
>
> Nothing overly surprising there. It's been my observation that pstate is
> generally better than acpi_cpufreq which somewhat amuses me when I still
> see suggestions of disabling intel_pstate entirely being used despite the
> advice being based on much older kernels.
>
>> intel_cpufreq - schedutil
>> ... test_run: start 5 runs ...
>> 2049.28user 1028.70system 54:57.82elapsed (3297.82 : -61.83%) 93%CPU
>> ... test_run: done ...
>>
>
> I'm mildly surprised at this. I had observed that schedutil is not great
> but I don't recall seeing a result this bad.
>
>> Linux s15 4.11.0-rc6-revert #233 SMP Wed Apr 12 15:30:19 PDT 2017 x86_64 x86_64 x86_64 GNU/Linux
>> ... test_run: start 5 runs ...
>> 1295.30user 365.98system 32:50.15elapsed (1970.15 : 3.32%) 84%CPU
>> ... test_run: done ...
>> 
>
> And the revert does help albeit not being an option for reasons Rafael
> covered.

New data point: Kernel 4.11-rc7  intel_pstate, powersave forcing the
load based algorithm: Elapsed 3178 seconds.

If I understand your data correctly, my load based results are the opposite of yours.

Mel: 4.11-rc5 vanilla: Elapsed mean: 3750.20 Seconds
Mel: 4.11-rc5 load based: Elapsed mean: 2503.27 Seconds
Or: 33.25%

Doug: 4.11-rc6 stock: Elapsed total (5 runs): 2364.45 Seconds
Doug: 4.11-rc7 force load based: Elapsed total (5 runs): 3178 Seconds
Or: -34.4%

>>> The way I'm doing it is via mmtests so
>>>
>>> git clone https://github.com/gormanm/mmtests
>>> cd mmtests
>>> ./run-mmtests --no-monitor --config configs/config-global-dhp__workload_shellscripts test-run-1
>>> cd work/log
>>> ../../compare-kernels.sh | less
>>>
>>> and it'll generate a similar report to what I posted in this email
>>> thread. If you do multiple tests with different kernels then change the
>>> name of "test-run-1" to preserve the old data. compare-kernel.sh will
>>> compare whatever results you have.
>> 
>>          k4.5    k4.11-rc6         k4.11-rc6         k4.11-rc6          k4.11-rc6         k4.11-rc6         k4.11-rc6
>>                                    performance       pass-ps            pass-od           pass-su           revert
>> E min    388.71  456.51 (-17.44%)  342.81 ( 11.81%)  668.79 (-72.05%)   552.85 (-42.23%)  646.96 (-66.44%)  375.08 (  3.51%)
>> E mean   389.74  458.52 (-17.65%)  343.81 ( 11.78%)  669.42 (-71.76%)   553.45 (-42.01%)  647.95 (-66.25%)  375.98 (  3.53%)
>> E stddev   0.85    1.64 (-92.78%)    0.67 ( 20.83%)    0.41 ( 52.25%)     0.31 ( 64.00%)    0.68 ( 20.35%)    0.46 ( 46.00%)
>> E coeffvar 0.22    0.36 (-63.86%)    0.20 ( 10.25%)    0.06 ( 72.20%)     0.06 ( 74.65%)    0.10 ( 52.09%)    0.12 ( 44.03%)
>> E max    390.90  461.47 (-18.05%)  344.83 ( 11.79%)  669.91 (-71.38%)   553.68 (-41.64%)  648.75 (-65.96%)  376.37 (  3.72%)
>> 
>> E = Elapsed (squished in an attempt to prevent line length wrapping when I send)
>> 
>>            k4.5   k4.11-rc6   k4.11-rc6   k4.11-rc6   k4.11-rc6   k4.11-rc6   k4.11-rc6
>>                             performance     pass-ps     pass-od     pass-su      revert
>> User     347.26     1801.56     1398.76     2540.67     2106.30     2434.06     1536.80
>> System   139.01      701.87      366.59     1346.75     1026.67     1322.39      449.81
>> Elapsed 2346.77     2761.20     2062.12     4017.47     3321.10     3887.19     2268.90
>> 
>> Legend:
>> blank  = active mode: intel_pstate - powersave
>> performance = active mode: intel_pstate - performance (fast reference)
>> pass-ps = passive mode: intel_cpufreq - powersave (slow reference)
>> pass-od = passive mode: intel_cpufreq - ondemand
>> pass-su = passive mode: intel_cpufreq - schedutil
>> revert = active mode: intel_pstate - powersave with commit ffb810563c0c reverted.
>> 
>> I deleted the user, system, and CPU rows, because they don't make any sense.
>>
>
> User is particularly misleading. System can be very misleading between
> kernel versions due to accounting differences so I'm ok with that.
>
>> I do not know why the tests run overall so much faster on my computer,
>
> Differences in CPU I imagine. I know the machine I'm reporting on is a
> particularly bad example. I've seen other machines where the effect is
> less severe.

No, I meant that my overall run time was on the order of 3/4 of an hour,
whereas your tests were on the order of 3 hours. As far as I could tell,
our CPUs had similar capabilities.

>
>> I can only assume I have something wrong in my installation of your mmtests.
>
> No, I've seen results broadly similar to yours on other machines so I
> don't think you have a methodology error.
>
>> I do see mmtests looking for some packages which it can not find.
>> 
>
> That's not too unusual. The package names are based on opensuse naming
> and that doesn't translate to other distributions. If you open
> bin/install-depends, you'll see a hashmap near the top that maps some of
> the names for redhat-based distributions and debian. It's not actively
> maintained. You can either install the packages manaually before the
> test or update the mappings.

>> Mel wrote:
>>> The results show that it's not the only source as a revert (last column)
>>> doesn't fix the damage although it goes from 3750 seconds (4.11-rc5 vanilla)
>>> to 2919 seconds (with a revert).
>> 
>> In my case, the reverted code ran faster than the kernel 4.5 code.
>> 
>> The other big difference is between Kernel 4.5 and 4.11-rc5 you got
>> -102.28% elapsed time, whereas I got -16.03% with method 1 and
>> -17.65% with method 2 (well, between 4.5 and 4.11-rc6 in my case).
>> I only get -93.28% and -94.82% difference between my fast and slow reference
>> tests (albeit on the same kernel).
>> 
>
> I have no reason to believe this is a methodology error and is due to a
> difference in CPU. Consider the following reports
>
>
http://beta.suse.com/private/mgorman/results/home/marvin/openSUSE-LEAP-42.2/global-dhp__workload_shellscripts-xfs/delboy/#gitsource
> http://beta.suse.com/private/mgorman/results/home/marvin/openSUSE-LEAP-42.2/global-dhp__workload_shellscripts-xfs/ivy/#gitsource
>
> The first one (delboy) shows a gain of 1.35% and it's only for 4.11
> (kernel shown is 4.11-rc1 with vmscan-related patches on top that do not
> affect this test case) of -17.51% which is very similar to yours. The
> CPU there is a Xeon E3-1230 v5.
>
> The second report (ivy) is the machine I'm based the original complain
> on and shows the large regression in elapsed time.
>
> So, different CPUs have different behaviours which is no surprise at all
> considering that at the very least, exit latencies will be different.
> While there may not be a universally correct answer to how to do this
> automatically, is it possible to tune intel_pstate such that it ramps up
> quickly regardless of recent utilisation and reduces relatively slowly?
> That would be better from a power consumption perspective than setting the
> "performance" governor.

As mentioned above, I don't know how to make the distinction in the use
cases.

... Doug
