From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Tue, 23 Aug 2016 10:14:36 -0600
Message-ID: <8012e614-885a-0445-44aa-63d92de5cd1f@redhat.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
 <20160801203156.GV4605@ubuntu>
 <872a4dd4-a752-507b-e720-ec2e6003bd8c@redhat.com>
 <406534f5-5e45-237e-cc68-2b57631e26d1@redhat.com>
 <CANYZqRv6pLCK+oaWxyzr3YPxs0VytupWD7oPfX4tA7STxWNGOg@mail.gmail.com>
 <6a0079da-2f81-a58b-0a71-3564d79ad61b@redhat.com>
 <1471926684.5747.13.camel@intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38259 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbcHWQOj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 12:14:39 -0400
Received: by mail-it0-f44.google.com with SMTP id n128so144070615ith.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 09:14:39 -0700 (PDT)
In-Reply-To: <1471926684.5747.13.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "ashwinch@google.com" <ashwinch@google.com>
Cc: "pprakash@codeaurora.org" <pprakash@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>

On 08/22/2016 10:31 PM, Pandruvada, Srinivas wrote:
> On Mon, 2016-08-22 at 12:12 -0600, Al Stone wrote:
>> On 08/22/2016 11:45 AM, Ashwin Chaugule wrote:
>>>
>>> Hi Al,
>>>
>>> On Mon, Aug 22, 2016 at 10:16 AM, Al Stone <ahs3@redhat.com> wrote:
>>>>
>>>> Maybe a top-post will get attention....
>>>>
>>>> Yet another ping; this was first submitted on 20 July, and has
>>>> received
>>>> no comments.  It has now been a month and other architectures are
>>>> starting
>>>> to use CPPC so they will run into the same errors that this
>>>> fixes.  Can
>>>> I get an ACK, NAK, or further instructions, please?
>>>>
>>>
>>> Apologies for the delay. I thought this patch was merged already.
>>
>> I've looked in linux-next and linux-pm; I could have missed it, but I
>> didn't
>> see it...my bad, if I did.
>>
>>>
>>>>
>>>> Also adding Rafael on the ACPI side, just in case, since he's
>>>> also reviewing
>>>> the Intel patches on the linux-acpi mailing list that are adding
>>>> CPPC usage.
>>>>
>>>> On 08/11/2016 12:15 PM, Al Stone wrote:
>>>>>
>>>>> On 08/01/2016 02:31 PM, Viresh Kumar wrote:
>>>>>>
>>>>>> [+ Ashwin's new email id..]
>>>>>>
>>>>>> On 20-07-16, 15:10, Al Stone wrote:
>>>>>>>
>>>>>>> When CPPC is being used by ACPI on arm64, user space tools
>>>>>>> such as
>>>>>>> cpupower report CPU frequency values from sysfs that are
>>>>>>> incorrect.
>>>>>>>
>>>>>>> What the driver was doing was reporting the values given by
>>>>>>> ACPI tables
>>>>>>> in whatever scale was used to provide them.  However, the
>>>>>>> ACPI spec
>>>>>>> defines the CPPC values as unitless abstract
>>>>>>> numbers.  Internal kernel
>>>>>>> structures such as struct perf_cap, in contrast, expect
>>>>>>> these values
>>>>>>> to be in KHz.  When these struct values get reported via
>>>>>>> sysfs, the
>>>>>>> user space tools also assume they are in KHz, causing them
>>>>>>> to report
>>>>>>> incorrect values (for example, reporting a CPU frequency of
>>>>>>> 1MHz when
>>>>>>> it should be 1.8GHz).
>>>>>>>
>>>>>>> The downside is that this approach has some assumptions:
>>>>>>>
>>>>>>>    (1) It relies on SMBIOS3 being used, *and* that the Max
>>>>>>> Frequency
>>>>>>>    value for a processor is set to a non-zero value.
>>>>>>>
>>>>>>>    (2) It assumes that all processors run at the same
>>>>>>> speed, or that
>>>>>>>    the CPPC values have all been scaled to reflect relative
>>>>>>> speed.
>>>>>>>    This patch retrieves the largest CPU Max Frequency from
>>>>>>> a type 4 DMI
>>>>>>>    record that it can find.  This may not be an issue,
>>>>>>> however, as a
>>>>>>>    sampling of DMI data on x86 and arm64 indicates there is
>>>>>>> often only
>>>>>>>    one such record regardless.  Since CPPC is relatively
>>>>>>> new, it is
>>>>>>>    unclear if the ACPI ASL will always be written to
>>>>>>> reflect any sort
>>>>>>>    of relative performance of processors of differing
>>>>>>> speeds.
>>>>>>>
>>>>>>>    (3) It assumes that performance and frequency both scale
>>>>>>> linearly.
>>>>>>>
>>>>>>> For arm64 servers, this may be sufficient, but it does rely
>>>>>>> on
>>>>>>> firmware values being set correctly.  Hence, other
>>>>>>> approaches will
>>>>>>> be considered in the future.
>>>>>>>
>>>>>>> This has been tested on three arm64 servers, with and
>>>>>>> without DMI, with
>>>>>>> and without CPPC support.
>>>>>>>
>>>>>>> Changes for v5:
>>>>>>>     -- Move code to cpufreq/cppc_cpufreq.c from
>>>>>>> acpi/cppc_acpi.c to keep
>>>>>>>        frequency-related code together, and keep the CPPC
>>>>>>> abstract scale
>>>>>>>        in ACPI (Prashanth Prakash)
>>>>>>>     -- Fix the scaling to remove the incorrect assumption
>>>>>>> that frequency
>>>>>>>        was always a range from zero to max; as a practical
>>>>>>> matter, it is
>>>>>>>        not (Prasanth Prakash); this also allowed us to
>>>>>>> remove an over-
>>>>>>>        engineered function to do this math.
>>>>>>>
> 
> In x86 when CPPC is used, the unit is really unit-less in CPPC tables.
> This means that cpu->perf_caps.highest_perf can be just 0xff, instead
> of some scaled cppc max performance corresponding to max MHZ the
> processor can support. This allows the processor to cap at max which it
> can deliver.
> Is this case not possible for ARM SoCs?
> 
> Thanks,
> Srinivas
> 

If I understand the question properly, I don't think it matters, and I don't
think that will work for x86 either.

This patch is meant to allow CPPC to continue operating solely based on the
abstract scale provided by the ACPI tables; this should be true regardless
of architecture.  Any actual processor performance changes are still guided
solely by the CPPC scale provided in the tables, and not the values in the
cpu->perf_caps struct.

Assuming I understand the kernel code, the values in cpu->perf_caps -- in this
case -- are really just for reporting to user space via sysfs, which is the
root of the problem: user space expects frequencies, and we have none when using
CPPC so we have to provide an approximation.  In those circumstances, I think a
value of 0xff would be kind of confusing in sysfs, since it's basically saying
the CPU is operating at a frequency equal to the largest integer value.

To be fair, this is how the ARM processor implements CPPC; I have not examined
in detail the newly submitted x86 patches to use CPPC so I cannot comment on
those.  This patch was written well before those showed up.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
