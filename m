From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] intel_pstate: skip scheduler hook when in
 "performance" mode.
Date: Fri, 16 Jun 2017 21:35:01 -0400
Message-ID: <CAJvTdKnZTese3kiqtQiGn0F+i2p3eQ4KzR6QiCQdwAdqO=JUTQ@mail.gmail.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
 <6542869.y10POnRxLl@aspire.rjw.lan> <CAJvTdKmoV4WbHOCy9WsspcLSNeCxO-egZP_j9XbbTTCTT7OeVA@mail.gmail.com>
 <4318906.Nci2R8jF0d@aspire.rjw.lan> <CAJvTdKnULzQCdwg7vqfSymr+nbS=7UgVPBCqYpqcH8gApUHrxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35878 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbdFQBfD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 21:35:03 -0400
In-Reply-To: <CAJvTdKnULzQCdwg7vqfSymr+nbS=7UgVPBCqYpqcH8gApUHrxQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

sorry, that was a premature send...

>>> > What about update_turbo_pstate()?
>>> >
>>> > In theory MSR_IA32_MISC_ENABLE_TURBO_DISABLE can be set at any time, so
>>> > wouldn't that become problematic after this change?
>>>
>>> yes, the sysfs "no_turbo" attribute can be modified at any time, invoking
>>> update_turbo_state(), which will update MSR_IA32_MISC_ENABLE_TURBO_DISABLE
>>
>> If that was the only way it could change, I wouldn't worry about it, but what
>> about changes by BMCs and similar?  Are they not a concern?
>>
>>> But how is the presence or change in turbo related to the lack of a
>>> need to hook the scheduler callback in "performance" mode?  The hook
>>> literally does nothing in this case, except consume cycles, no?
>>
>> No.
>>
>> It actually sets the P-state to the current maximum (which admittedly is
>> excessive) exactly because the maximum may change on the fly in theory.
>
> There are 2 cases.
>
> If turbo was enabled and were we requesting max turbo
> and "somebody" disabled turbo in an MSR, then the HW would
> simply clip our excessive
request to what the hardware supports.

if turbo was disabled and we were requesting max non-turbo,
and "somebody" enabled turbo in the MSR,
then it is highly likely that current request is already sufficiently
high enough
to enable turbo.  "highly likely" = would work on 100% of the
machines I have ever seen, including those with mis-configured TAR.

ie. it should not matter.

>> If it can't change on the fly (or we don't care), we can do some more
>> simplifications there. :-)
>
> I do not think it is Linux's responsibility to monitor changes to MSRs
> such as Turbo enable/disable done behind its back by a BMC at run-time.
> (if this is even possible)
>
>
> --
> Len Brown, Intel Open Source Technology Center
