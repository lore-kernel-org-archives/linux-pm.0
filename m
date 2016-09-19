From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Mon, 19 Sep 2016 12:53:05 -0600
Message-ID: <89bc4faf-b1e8-6998-0930-46e8385d8913@redhat.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
 <1638694.s4oPcnuXuT@vostro.rjw.lan>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35704 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbcISSxI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 14:53:08 -0400
Received: by mail-it0-f49.google.com with SMTP id r192so77477576ita.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Sep 2016 11:53:08 -0700 (PDT)
In-Reply-To: <1638694.s4oPcnuXuT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>

On 09/13/2016 07:09 PM, Rafael J. Wysocki wrote:
> On Wednesday, July 20, 2016 03:10:04 PM Al Stone wrote:
>> When CPPC is being used by ACPI on arm64, user space tools such as
>> cpupower report CPU frequency values from sysfs that are incorrect.
>>
>> What the driver was doing was reporting the values given by ACPI tables
>> in whatever scale was used to provide them.  However, the ACPI spec
>> defines the CPPC values as unitless abstract numbers.  Internal kernel
>> structures such as struct perf_cap, in contrast, expect these values
>> to be in KHz.  When these struct values get reported via sysfs, the
>> user space tools also assume they are in KHz, causing them to report
>> incorrect values (for example, reporting a CPU frequency of 1MHz when
>> it should be 1.8GHz).
>>
>> The downside is that this approach has some assumptions:
>>
>>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>>    value for a processor is set to a non-zero value.
>>
>>    (2) It assumes that all processors run at the same speed, or that
>>    the CPPC values have all been scaled to reflect relative speed.
>>    This patch retrieves the largest CPU Max Frequency from a type 4 DMI
>>    record that it can find.  This may not be an issue, however, as a
>>    sampling of DMI data on x86 and arm64 indicates there is often only
>>    one such record regardless.  Since CPPC is relatively new, it is
>>    unclear if the ACPI ASL will always be written to reflect any sort
>>    of relative performance of processors of differing speeds.
>>
>>    (3) It assumes that performance and frequency both scale linearly.
>>
>> For arm64 servers, this may be sufficient, but it does rely on
>> firmware values being set correctly.  Hence, other approaches will
>> be considered in the future.
>>
>> This has been tested on three arm64 servers, with and without DMI, with
>> and without CPPC support.
>>
>> Changes for v5:
>>     -- Move code to cpufreq/cppc_cpufreq.c from acpi/cppc_acpi.c to keep
>>        frequency-related code together, and keep the CPPC abstract scale
>>        in ACPI (Prashanth Prakash)
>>     -- Fix the scaling to remove the incorrect assumption that frequency
>>        was always a range from zero to max; as a practical matter, it is
>>        not (Prasanth Prakash); this also allowed us to remove an over-
>>        engineered function to do this math.
>>
>> Changes for v4:
>>     -- Replaced magic constants with #defines (Rafael Wysocki)
>>     -- Renamed cppc_unitless_to_khz() to cppc_to_khz() (Rafael Wysocki)
>>     -- Replaced hidden initialization with a clearer form (Rafael Wysocki)
>>     -- Instead of picking up the first Max Speed value from DMI, we will
>>        now get the largest Max Speed; still an approximation, but slightly
>>        less subject to error (Rafael Wysocki)
>>     -- Kconfig for cppc_cpufreq now depends on DMI, instead of selecting
>>        it, in order to make sure DMI is set up properly (Rafael Wysocki)
>>
>> Changes for v3:
>>     -- Added clarifying commentary re short-term vs long-term fix (Alexey
>>        Klimov)
>>     -- Added range checking code to ensure proper arithmetic occurs,
>>        especially no division by zero (Alexey Klimov)
>>
>> Changes for v2:
>>     -- Corrected thinko: needed to have DEPENDS on DMI in Kconfig.arm,
>>        not SELECT DMI (found by build daemon)
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> 
> Applied.
> 
> Thanks,
> Rafael
> 

I've been on vacation so just now am seeing this.  Thanks, Rafael!

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
