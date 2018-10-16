From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor for tickless systems
Date: Mon, 15 Oct 2018 20:00:19 -0700
Message-ID: <001101d464fc$65623c60$3026b520$@net>
References: <000e01d4638a$91a20c60$b4e62520$@net> BxfmgI8c1ivIDBxfngUxWV
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: BxfmgI8c1ivIDBxfngUxWV
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.10.15 00:52 Rafael J. Wysocki wrote:
> On Sun, Oct 14, 2018 at 8:53 AM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.10.11 14:02 Rafael J. Wysocki wrote:
>
> ...[cut]...
>
>>> Overall, it selects deeper idle states than menu more often, but
>>> that doesn't seem to make a significant difference in the majority
>>> of cases.
>>
>> Not always, that viscous powernightmare sweep test that I run used
>> way way more processor package power and spent a staggering amount
>> of time in idle state 0. [1].
>
> Can you please remind me what exactly the workload is in that test?

The problem with my main test computer is that I have never had a good
way to make it use idle state 0 and/or idle state 1 a significant amount,
while not setting the need-resched flag. Due to the minimum overheads
involved, in a tight loop c program calling nanosleep with an only 1
nanosecond argument, will result in about 50 (44 to 57 measured)
microseconds, or much too long to invoke idle state 0 or 1 (at least
on my test computer). So, for my 8 CPU older model i7-2600K, the idea
is to spin out 40 threads doing short sleeps in an attempt to pile up
events such that the shallower idle states are invoked more often.

Why 40 threads, one might wonder? This was many months ago now, but
I tested quite a number of threads, and 40 seemed to provide the
most interesting results for this type of work. I have not rechecked
it since (probably should).

For the testing I did in August for this:

"[PATCH] cpuidle: menu: Retain tick when shallow state is selected"
[2].
The thinking was to sweep through a wide range of sleep times,
and see if anything odd shows up. The test description is copied
here:

In [2] Doug wrote:
> Test 1: A Thomas Ilsche type "powernightmare" test:
> (forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered
> threads. Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200
> minutes of the test. (note: overheads mean that actual loop times are quite
> different.) And then from 5 to 500 in steps of 1, for the remaining 1000 minutes of
> the test. Each step ran for 2 minutes. The system was idle for 1 minute at the start,
> and a few minutes at the end of the graphs.
> While called "kernel 4.18", the baseline was actually from mainline at head =
> df2def4, or just after Rafael's linux-pm "pm-4.19-rc1-2" merge.
> (actually after the next acpi merge).
> Reference kernel = df2def4 with the two patches reverted.

However, that description was flawed, because there actually was never
a long sleep (incompetence on my part, but it doesn't really matter).
That test was 1200 minutes, and is worth looking at [3].
Notice how, as the test progresses, a migration through the idle
states can be observed, just as expected.

The next old reference of this test was the 8 patch set on top of
Kernel 4.19-rc6 [4], from a week ago. However, I shortened the test
by 900 minutes. Why? Well, there is only so much time in a day.

So now, back to the test this thread is about [1]. It might be
argued that maybe the TEO governor should be spending more time
in idle state 0 near the start of test, as the test shows. Trace
data does, maybe, support such an argument, but I haven't had
time to dig into it.

I also wonder if some of the weirdness later in the test is
repeatable or not (re: discussion elsewhere on this thread,
now cut, about lack of repeatability). However, I have not
had time to repeat the test.

Hope this helps, and sorry for any confusion and this long e-mail.
 
... Doug

[1] http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-teo.htm
[2] https://marc.info/?l=linux-pm&m=153531591826718&w=2
[3] http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw.htm
[4] http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-rjw.htm
   
