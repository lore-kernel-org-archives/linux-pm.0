From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date: Mon, 8 Oct 2018 15:14:06 -0700
Message-ID: <003801d45f54$3d9b0c50$b8d124f0$@net>
References: <000301d45ecb$4f002a90$ed007fb0$@net> 9QK8gKOqH3psd9QK9g4KPk
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 9QK8gKOqH3psd9QK9g4KPk
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Peter Zijlstra' <peterz@infradead.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.10.08 00:51 Rafael J. Wysocki wrote:
> On Mon, Oct 8, 2018 at 8:02 AM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> On 2018.10.03 23:56 Rafael J. Wysocki wrote:
>>> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> This series fixes a couple of issues with the menu governor, optimizes it
>>>> somewhat and makes a couple of cleanups in it.  Please refer to the
>>>> patch changelogs for details.
>>>>
>>>> All of the changes in the series are straightforward in my view.  The
>>>> first two patches are fixes, the rest is optimizations and cleanups.
>>>
>>> I'm inclined to take this stuff in for 4.20 if nobody has problems
>>> with it, so please have a look if you care (and you should, because
>>> the code in question is run on all tickless systems out there).
>>
>> Hi Rafael,
>>
>> I did tests with kernel 4.19-rc6 as a baseline reference and then
>> with 8 of your patches (&8patches in the graphs legend):
>>
>> cpuidle: menu: Replace data->predicted_us with local variable
>>   . as required to get this set of 6 to then apply.
>> This set of 6 patches.
>> cpuidle: poll_state: Revise loop termination condition
>>
>> Recall I also did some testing in late August [1], with
>> a kernel that was just a few hundred commits before 4.19-rc1.
>> The baseline is now way different. While I don't know why,
>> I bisected the kernel and either made a mistake, or it was:
>>
>> first bad commit: [06e386a1db54ab6a671e103e929b590f7a88f0e3]
>> Merge tag 'fbdev-v4.19' of https://github.com/bzolnier/linux
>>
>> Anyway, and for reference, included on some of the graphs
>> is the old data from late August (legend name "4.18+3rjw
>> (Aug test)")
>>
>> Test 1: A Thomas Ilsche type "powernightmare" test:
>> (forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered threads.
>> Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200 minutes of the test.
>> (note: overheads mean that actual loop times are quite different.)
>> And then from 5 to 50 in steps of 1, for the remaining 100 minutes of the test.
>> (Shortened by 900 minutes from the way the test was done in August.)
>> Each step ran for 2 minutes. The system was idle for 1 minute at the start, and a few
>> minutes at the end of the graphs.
>>
>> The power and idle statistics graphs are here:
>> http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-rjw.htm
>>
>> Observations:
>>
>> While the graphs are pretty and such, the only significant
>> difference is the idle state 0 percentages go down a lot
>> with the 8 patches. However the number of idle state 0
>> entries per minute goes up. To present the same information
>> in a different way a trace was done (at 9 Gigabytes in
>> 2 minutes):
>
> The difference in the idle state 0 usage is a consequence of the "poll
> idle" patch and is expected.
>
>> &8patches
>> Idle State 0: Total Entries: 10091412 : time (seconds): 49.447025
>> Idle State 1: Total Entries: 49332297 : time (seconds): 375.943064
>> Idle State 2: Total Entries: 311810 : time (seconds): 2.626403
>>
>> k4.19-rc6
>> Idle State 0: Total Entries: 9162465 : time (seconds): 70.650566
>> Idle State 1: Total Entries: 47592671 : time (seconds): 373.625083
>> Idle State 2: Total Entries: 266212 : time (seconds): 2.278159
>>
>> Conclusions: Behaves as expected.
>
> Right. :-)

>> Test 2: pipe test 2 CPUs, one core. CPU test:
>>
>> The average loop times graph is here:
>> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.png
>>
>> The power and idle statistics graphs are here:
>> http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.htm
>>
>> Conclusions:
>>
>> Better performance at the cost of more power with
>> the patch set, but late August had both better performance
>> and less power.
>>
>> Overall idle entries and exits are about the same, but way
>> way more idle state 0 entries and exits with the patch set.
>
>Same as above (and expected too).

I Disagree. The significant transfer of idle entries from
idle state 1 with kernel 4.19-rc6 to idle state 0 with the
additional 8 patch set is virtually entirely due to this patch:

"[PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is known"

As far as I can determine from all of this data, in particular the
histogram data below, it seems to me that it now is selecting
idle state 0 whereas before it was selecting idle state 1
is the correct decision for those very short duration idle states
(well, for my processor (older i7-2600K) at least).

Note: I did test my above assertion with kernels compiled with only
the first 2 and then 3 of the 8 patch set.

>
>> Supporting: trace summary (note: such a heavy load on the trace
>> system (~6 gigabytes in 2 minutes) costs about 25% in performance):
>>
>> k4.16-rc6 pipe
>> Idle State 0: Total Entries: 76638 : time (seconds): 0.193166
>> Idle State 1: Total Entries: 37825999 : time (seconds): 23.886772
>> Idle State 2: Total Entries: 49 : time (seconds): 0.007908
>>
>> &8patches
>> Idle State 0: Total Entries: 37632104 : time (seconds): 26.097220
>> Idle State 1: Total Entries: 397 : time (seconds): 0.020021
>> Idle State 2: Total Entries: 208 : time (seconds): 0.031052
>>
>> With rjw 8 patch set (1st col is usecs duration, 2nd col
>> is number of occurrences in 2 minutes):
>>
>> Idle State: 0  Summary:
>> 0 24401500
>> 1 13153259
>> 2 19807
>> 3 32731
>> 4 802
>> 5 346
>> 6 1554
>> 7 20087
>> 8 1849
>> 9 150
>> 10 9
>> 11 10
>>
>> Idle State: 1  Summary:
>> 0 29
>> 1 44
>> 2 15
>> 3 45
>> 4 5
>> 5 26
>> 6 2
>> 7 24

...[snip]...
>>
>> Kernel 4.19-rc6 reference:
>>
>> Idle State: 0  Summary:
>> 0 17212
>> 1 7516
>> 2 34737
>> 3 14763
>> 4 2312
>> 5 74
>> 6 3
>> 7 3
>> 8 3
>> 9 4
>> 10 5
>> 11 5
>> 40 1
>>
>> Idle State: 1  Summary:
>> 0 36073601
>> 1 1662728
>> 2 67985
>> 3 106
>> 4 22
>> 5 8
>> 6 2214
>> 7 11037
>> 8 7110

...[snip]...

... Doug
