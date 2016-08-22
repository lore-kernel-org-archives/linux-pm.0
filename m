From: Ashwin Chaugule <ashwinch@google.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Mon, 22 Aug 2016 10:45:35 -0700
Message-ID: <CANYZqRv6pLCK+oaWxyzr3YPxs0VytupWD7oPfX4tA7STxWNGOg@mail.gmail.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
 <20160801203156.GV4605@ubuntu> <872a4dd4-a752-507b-e720-ec2e6003bd8c@redhat.com>
 <406534f5-5e45-237e-cc68-2b57631e26d1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35695 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbcHVRqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 13:46:07 -0400
Received: by mail-yw0-f169.google.com with SMTP id j12so56966683ywb.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2016 10:46:07 -0700 (PDT)
In-Reply-To: <406534f5-5e45-237e-cc68-2b57631e26d1@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahs3@redhat.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Al,

On Mon, Aug 22, 2016 at 10:16 AM, Al Stone <ahs3@redhat.com> wrote:
> Maybe a top-post will get attention....
>
> Yet another ping; this was first submitted on 20 July, and has received
> no comments.  It has now been a month and other architectures are starting
> to use CPPC so they will run into the same errors that this fixes.  Can
> I get an ACK, NAK, or further instructions, please?
>

Apologies for the delay. I thought this patch was merged already.

> Also adding Rafael on the ACPI side, just in case, since he's also reviewing
> the Intel patches on the linux-acpi mailing list that are adding CPPC usage.
>
> On 08/11/2016 12:15 PM, Al Stone wrote:
>> On 08/01/2016 02:31 PM, Viresh Kumar wrote:
>>> [+ Ashwin's new email id..]
>>>
>>> On 20-07-16, 15:10, Al Stone wrote:
>>>> When CPPC is being used by ACPI on arm64, user space tools such as
>>>> cpupower report CPU frequency values from sysfs that are incorrect.
>>>>
>>>> What the driver was doing was reporting the values given by ACPI tables
>>>> in whatever scale was used to provide them.  However, the ACPI spec
>>>> defines the CPPC values as unitless abstract numbers.  Internal kernel
>>>> structures such as struct perf_cap, in contrast, expect these values
>>>> to be in KHz.  When these struct values get reported via sysfs, the
>>>> user space tools also assume they are in KHz, causing them to report
>>>> incorrect values (for example, reporting a CPU frequency of 1MHz when
>>>> it should be 1.8GHz).
>>>>
>>>> The downside is that this approach has some assumptions:
>>>>
>>>>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>>>>    value for a processor is set to a non-zero value.
>>>>
>>>>    (2) It assumes that all processors run at the same speed, or that
>>>>    the CPPC values have all been scaled to reflect relative speed.
>>>>    This patch retrieves the largest CPU Max Frequency from a type 4 DMI
>>>>    record that it can find.  This may not be an issue, however, as a
>>>>    sampling of DMI data on x86 and arm64 indicates there is often only
>>>>    one such record regardless.  Since CPPC is relatively new, it is
>>>>    unclear if the ACPI ASL will always be written to reflect any sort
>>>>    of relative performance of processors of differing speeds.
>>>>
>>>>    (3) It assumes that performance and frequency both scale linearly.
>>>>
>>>> For arm64 servers, this may be sufficient, but it does rely on
>>>> firmware values being set correctly.  Hence, other approaches will
>>>> be considered in the future.
>>>>
>>>> This has been tested on three arm64 servers, with and without DMI, with
>>>> and without CPPC support.
>>>>
>>>> Changes for v5:
>>>>     -- Move code to cpufreq/cppc_cpufreq.c from acpi/cppc_acpi.c to keep
>>>>        frequency-related code together, and keep the CPPC abstract scale
>>>>        in ACPI (Prashanth Prakash)
>>>>     -- Fix the scaling to remove the incorrect assumption that frequency
>>>>        was always a range from zero to max; as a practical matter, it is
>>>>        not (Prasanth Prakash); this also allowed us to remove an over-
>>>>        engineered function to do this math.
>>>>

This addresses my previous feedback. So FWIW, Acked-by: Ashwin
Chaugule <ashwinch@google.com>

Cheers,
Ashwin.
