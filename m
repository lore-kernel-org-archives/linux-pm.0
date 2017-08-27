From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/2][RFC] ACPI / PM: Disable MSR T-state after resumed
Date: Sun, 27 Aug 2017 11:52:02 -0700
Message-ID: <000301d31f65$936dc940$ba495bc0$@net>
References: <001b01d31dea$c116dc50$434494f0$@net> <000701d31e77$49676250$dc3626f0$@net> ldamdH5BMWJpbldaodG7sa
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: ldamdH5BMWJpbldaodG7sa
Content-Language: en-ca
Sender: linux-acpi-owner@vger.kernel.org
To: 'Chen Yu' <yu.c.chen@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Len Brown' <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Yu,
On 2017.08.26 09:07 Chen Yu wrote:
> On Sat, Aug 26, 2017 at 07:26:18AM -0700, Doug Smythies wrote:
>> On 2017.08.25 23:08 Chen Yu wrote:
>>> Hi Doug,
>>> On Fri, Aug 25, 2017 at 02:40:19PM -0700, Doug Smythies wrote:
>>>> On 2017.08.25 09:43 Chen Yu wrote:
>>>> 
>>>>> There is a growing number of reports that the MSR throttling has
>>>>> been enabled after resumed back from suspend to ram, which impacts
>>>>> the system performance. This patchset tries to address this issue
>>>>> by turning off the T-state after resumed back.
>>>>>
>>>>> Chen Yu (2):
>>>>>  ACPI / PM: Reuse the acpi_sleep_syscore_ops for future requirement
>>>>>  ACPI / PM: Disable the MSR T-state during CPU online
>>>>>
>>>>> drivers/acpi/sleep.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>>> 1 file changed, 58 insertions(+), 2 deletions(-)
>>>> 
>>>> Hi Chen,
>>>> 
>>>> I'll just copy and paste what I wrote in a couple of the bug reports
>>>> ([1] for example) a couple of days ago:
>>>> 
>>>>> I believe that pending changes to the intel-pstate CPU frequency scaling driver,
>>>>> proposed by Rafael, I think for kernel 4.14-rc1, will eliminate the ongoing
>>>>> troubles with Clock Modulation and the driver.
>>>>>
>>>>> I'm saying that the issue will no longer exist, and that the intel_pstate
>>>>> CPU frequency scaling driver will respond "properly" to Clock Modulation events.
>>>>> Of course, I'll check when kernel 4.14-rc1 becomes available, or before if I can
>>>>> apply all the patches.
>>>>>
>>>>> For reference see the patch set related to:
>>>>>
>>>>> [PATCH 0/2] cpufreq: intel_pstate: Eliminate the PID controller
>>>>> 2017.07.24 03:22 (or 10:22 UTC, I think)
>>>>>
>>>>> https://marc.info/?l=linux-pm&m=150093486908759&w=2
>>>>> https://marc.info/?l=linux-pm&m=150093484308751&w=2
>>>>> https://marc.info/?l=linux-pm&m=150093486808758&w=2
>>>> 
>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=189861
>>>> 
>>>> 
>>> I did not quite catup with the relationship between the intel_pstate
>>> patch and the tstate patch here, if the Clock Modulation is enabled,
>>> will the 'performance' governor be able to reach the maximum freq?
>> 
>> No, it'll only reach the max * modulation %.
>> However, I submit that has never been the problem.
>> The problem, and why the complaints started, is with the intel_pstate
>> "powersave" governor and the "get_target_pstate_use_performance" path
>> therein.
>> 
> Ok, I think I get the point now: The current PID prediction algorithom
> does not take tstate into consideration, so it might behave wrong.

There is no "might" about it. It does behave wrong. We went through
all of this almost 2 years ago. The CPU frequency will basically
freeze at the minimum * the modulation setting.

What does this mean? Let's say, for example, the processor minimum
pstate is 8 and the maximum pstate is 37. At 75% Clock Modulation
the system will lock at 600 MHz, whereas it would normally be expected
to still be able to get to 2.7 GHz. Another way to say it is that the
performance becomes limited to 16.2% of the normal maximum instead of
the expected 75%.

> And according to my understanding, the problem in PID does not
> involve with the suspend/resume process. However my concern is
> that, why did the BIOS enable the tstate during S3?

I'm saying that in some cases (some Dell LapTops, in particular),
it is changed on purpose and as a function of emerging from S3 on
AC power or DC power.

However, and having reviewed all the notes and e-mails from almost
2 years ago, I do now recall that you had a case, where the Clock
Modulation was set to an undefined value, with different results on
different processors. At the time we (O.K. I) concluded (from [1]):

"Yu's specific example is special, because the Clock Modulation
percent is undefined (reserved), and thus clearly unintentional,
or just plain wrong if it is intentional."

> And if the
> BIOS has enabled the tstate, does the kernel have a chance to
> adjust it? 
>
> bugzilla 189861 and 90041(also reported on another server) have shown
> that the kernel failed to re-evaluate the tstate after resumed, and
> keep it throttled all the time. Actually in current code there is a
> chance the kernel could re-evaluate the tstate once resumed back, but
> due to the insufficient ACPI information provided by the BIOS on these
> platforms, the tstate keeps un-touched after resumed back.
>
> Thus this appears to be BIOS issue.

Is it?
I am saying that sometimes the manufacturer has done it on purpose.

> To work around the BIOS issue, we can manipulate the MSR by msr-tools,
> but it might not be a robusty solution, instead we can clear the tstate
> after resumed back, that is to say, we do not trust the modification during
> S3 by the BIOS, and let the OS decide if it wants the throttling or not.

If indeed, we do not want to trust the change, then O.K I'll stop bothering
you about it.

>> Recall 1: At one time the "get_target_pstate_use_performance" path was
>> the only path through the driver, and that many of the complaints date
>> back to then. i.e. for many users that would now use the
>> "get_target_pstate_use_cpu_load" path by default, their reason for complaining
>> has already been solved.
>> 
>> Recall 2: The "get_target_pstate_use_performance" path in the intel_pstate
>> CPU scaling driver is fundamentally incompatible with Clock Modulation and will
>> never, under any conditions, raise the CPU frequency above the minimum * the
>> modulation %. This is where the complaining came from.
>> 
>>> Besides, what if the user is using acpi-freq rather than intel_pstate?
>> 
>> As with any "load" based algorithm, it works fine with Clock Modulation,
>> resulting in desired frequency * modulation percent.
>> I submit that this is what the various manufacturers (Dell, in particular)
>> that mess with Clock Modulation want. 
>> 
>> Conclusion:
>> Since the above referenced Rafael patch set removes the
>> "get_target_pstate_use_performance" path entirely, there is no longer
>> a problem that needs to be solved.
>> 
> Well, it's hard to say that if our customers would be happy if the throttling
> is enabled wrongly by the BIOS,

Wrongly or because that is what the manufacturer wants?
And should we override that?

> and they don't know why they can not get good
> performance : )

Keep in mind how dramatic the reduction in performance was with
the "get_target_pstate_use_performance" algorithm verses the others.
The difference is enormous.

[1] https://marc.info/?l=linux-kernel&m=144441695612734&w=2

... Doug


